return {
	Play926011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926011001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 3.933,
			ja = 4.833
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
				arg_1_0:Play926011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST10"

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
				local var_4_5 = arg_1_1.bgs_.ST10

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
					if iter_4_0 ~= "ST10" then
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

			local var_4_24 = "10102"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10102")

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

			local var_4_28 = arg_1_1.actors_["10102"]
			local var_4_29 = 1.63333333333333

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10102 == nil then
				arg_1_1.var_.actorSpriteComps10102 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10102 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10102 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10102 = nil
			end

			local var_4_36 = arg_1_1.actors_["10102"].transform
			local var_4_37 = 1.63333333333333

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10102 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10102", 3)

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
				local var_4_42 = Vector3.New(-69, -354.2, -425.9)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10102, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_4_43 = arg_1_1.actors_["10102"]
			local var_4_44 = 1.63333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10102 = var_4_45.alpha
					arg_1_1.var_.characterEffect10102 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10102 = 0
			end

			local var_4_46 = 0.2

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10102, 1, var_4_47)

				if arg_1_1.var_.characterEffect10102 then
					arg_1_1.var_.characterEffect10102.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10102 then
				arg_1_1.var_.characterEffect10102.alpha = 1
			end

			local var_4_49 = 0.166666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_4_53 = 0
			local var_4_54 = 0.3

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 0.500666666666667
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_4_64 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_64 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_64

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_64
						arg_1_1.bgmTxt2_.text = var_4_64
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

			local var_4_65 = 2
			local var_4_66 = 0.25

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_67 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_67:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(926011001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 10
				local var_4_72 = utf8.len(var_4_70)
				local var_4_73 = var_4_71 <= 0 and var_4_66 or var_4_66 * (var_4_72 / var_4_71)

				if var_4_73 > 0 and var_4_66 < var_4_73 then
					arg_1_1.talkMaxDuration = var_4_73
					var_4_65 = var_4_65 + 0.3

					if var_4_73 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_73 + var_4_65
					end
				end

				arg_1_1.text_.text = var_4_70
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011001", "story_v_out_926011.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_926011", "926011001", "story_v_out_926011.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_926011", "926011001", "story_v_out_926011.awb")

						arg_1_1:RecordAudio("926011001", var_4_75)
						arg_1_1:RecordAudio("926011001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926011", "926011001", "story_v_out_926011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926011", "926011001", "story_v_out_926011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_76 = var_4_65 + 0.3
			local var_4_77 = math.max(var_4_66, arg_1_1.talkMaxDuration)

			if var_4_76 <= arg_1_1.time_ and arg_1_1.time_ < var_4_76 + var_4_77 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_76) / var_4_77

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_76 + var_4_77 and arg_1_1.time_ < var_4_76 + var_4_77 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926011002
		arg_9_1.duration_ = 8.3

		local var_9_0 = {
			zh = 5.9,
			ja = 8.3
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
				arg_9_0:Play926011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.775

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(926011002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011002", "story_v_out_926011.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011002", "story_v_out_926011.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_926011", "926011002", "story_v_out_926011.awb")

						arg_9_1:RecordAudio("926011002", var_12_9)
						arg_9_1:RecordAudio("926011002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926011", "926011002", "story_v_out_926011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926011", "926011002", "story_v_out_926011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play926011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play926011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10102"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10102 == nil then
				arg_13_1.var_.actorSpriteComps10102 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10102 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 0.5, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10102 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10102 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.45

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(926011003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 18
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926011004
		arg_17_1.duration_ = 4.1

		local var_17_0 = {
			zh = 4.1,
			ja = 3.966
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
				arg_17_0:Play926011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10102"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10102 == nil then
				arg_17_1.var_.actorSpriteComps10102 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10102 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10102 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10102 = nil
			end

			local var_20_8 = arg_17_1.actors_["10102"].transform
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10102", 3)

				local var_20_10 = var_20_8.childCount

				for iter_20_4 = 0, var_20_10 - 1 do
					local var_20_11 = var_20_8:GetChild(iter_20_4)

					if var_20_11.name == "split_4" or not string.find(var_20_11.name, "split") then
						var_20_11.gameObject:SetActive(true)
					else
						var_20_11.gameObject:SetActive(false)
					end
				end
			end

			local var_20_12 = 0.001

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_12 then
				local var_20_13 = (arg_17_1.time_ - var_20_9) / var_20_12
				local var_20_14 = Vector3.New(-69, -354.2, -425.9)

				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102, var_20_14, var_20_13)
			end

			if arg_17_1.time_ >= var_20_9 + var_20_12 and arg_17_1.time_ < var_20_9 + var_20_12 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_20_15 = 0
			local var_20_16 = 0.5

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(926011004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 20
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011004", "story_v_out_926011.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011004", "story_v_out_926011.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_926011", "926011004", "story_v_out_926011.awb")

						arg_17_1:RecordAudio("926011004", var_20_24)
						arg_17_1:RecordAudio("926011004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926011", "926011004", "story_v_out_926011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926011", "926011004", "story_v_out_926011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10102"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10102 == nil then
				arg_21_1.var_.actorSpriteComps10102 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10102 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10102 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10102 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.975

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_11 = arg_21_1:GetWordFromCfg(926011005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 39
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play926011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10102"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10102", 7)

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
				local var_28_6 = Vector3.New(0, -2000, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_7 = 0.125
			local var_28_8 = 1

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				local var_28_9 = "play"
				local var_28_10 = "effect"

				arg_25_1:AudioAction(var_28_9, var_28_10, "se_story_143", "se_story_143_foley_cloth01", "")
			end

			local var_28_11 = 0
			local var_28_12 = 1.125

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(926011006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 45
				local var_28_16 = utf8.len(var_28_14)
				local var_28_17 = var_28_15 <= 0 and var_28_12 or var_28_12 * (var_28_16 / var_28_15)

				if var_28_17 > 0 and var_28_12 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_18 and arg_25_1.time_ < var_28_11 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926011007
		arg_29_1.duration_ = 9.7

		local var_29_0 = {
			zh = 9.7,
			ja = 9.5
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
				arg_29_0:Play926011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10102"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10102 == nil then
				arg_29_1.var_.actorSpriteComps10102 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10102 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10102 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10102 = nil
			end

			local var_32_8 = arg_29_1.actors_["10102"].transform
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10102", 3)

				local var_32_10 = var_32_8.childCount

				for iter_32_4 = 0, var_32_10 - 1 do
					local var_32_11 = var_32_8:GetChild(iter_32_4)

					if var_32_11.name == "split_4" or not string.find(var_32_11.name, "split") then
						var_32_11.gameObject:SetActive(true)
					else
						var_32_11.gameObject:SetActive(false)
					end
				end
			end

			local var_32_12 = 0.001

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_12 then
				local var_32_13 = (arg_29_1.time_ - var_32_9) / var_32_12
				local var_32_14 = Vector3.New(-69, -354.2, -425.9)

				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102, var_32_14, var_32_13)
			end

			if arg_29_1.time_ >= var_32_9 + var_32_12 and arg_29_1.time_ < var_32_9 + var_32_12 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_32_15 = 0
			local var_32_16 = 0.725

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(926011007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011007", "story_v_out_926011.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011007", "story_v_out_926011.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_926011", "926011007", "story_v_out_926011.awb")

						arg_29_1:RecordAudio("926011007", var_32_24)
						arg_29_1:RecordAudio("926011007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926011", "926011007", "story_v_out_926011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926011", "926011007", "story_v_out_926011.awb")
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
				actorName = "10102",
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
	Play926011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10102"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10102 == nil then
				arg_33_1.var_.actorSpriteComps10102 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10102 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10102 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10102 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.925

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_11 = arg_33_1:GetWordFromCfg(926011008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 37
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_9 or var_36_9 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_9 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play926011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.325

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(926011009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 13
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play926011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926011010
		arg_41_1.duration_ = 10.3

		local var_41_0 = {
			zh = 6.5,
			ja = 10.3
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
				arg_41_0:Play926011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10102"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10102 == nil then
				arg_41_1.var_.actorSpriteComps10102 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10102 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10102 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10102 = nil
			end

			local var_44_8 = arg_41_1.actors_["10102"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos10102 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10102", 3)

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
				local var_44_14 = Vector3.New(-69, -354.2, -425.9)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10102, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_44_15 = 0
			local var_44_16 = 0.85

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(926011010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 34
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011010", "story_v_out_926011.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011010", "story_v_out_926011.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_926011", "926011010", "story_v_out_926011.awb")

						arg_41_1:RecordAudio("926011010", var_44_24)
						arg_41_1:RecordAudio("926011010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926011", "926011010", "story_v_out_926011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926011", "926011010", "story_v_out_926011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926011011
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"

			SetActive(arg_45_1.choicesGo_, true)

			for iter_46_0, iter_46_1 in ipairs(arg_45_1.choices_) do
				local var_46_0 = iter_46_0 <= 1

				SetActive(iter_46_1.go, var_46_0)
			end

			arg_45_1.choices_[1].txt.text = arg_45_1:FormatText(StoryChoiceCfg[1303].name)
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926011012(arg_45_1)
			end

			arg_45_1:RecordChoiceLog(926011011, 1303)
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10102"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10102 == nil then
				arg_45_1.var_.actorSpriteComps10102 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10102 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10102 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10102 = nil
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play926011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926011012
		arg_49_1.duration_ = 2.2

		local var_49_0 = {
			zh = 2.2,
			ja = 1.833
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
				arg_49_0:Play926011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10102"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10102 == nil then
				arg_49_1.var_.actorSpriteComps10102 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10102 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10102 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10102 = nil
			end

			local var_52_8 = arg_49_1.actors_["10102"].transform
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10102", 3)

				local var_52_10 = var_52_8.childCount

				for iter_52_4 = 0, var_52_10 - 1 do
					local var_52_11 = var_52_8:GetChild(iter_52_4)

					if var_52_11.name == "split_4" or not string.find(var_52_11.name, "split") then
						var_52_11.gameObject:SetActive(true)
					else
						var_52_11.gameObject:SetActive(false)
					end
				end
			end

			local var_52_12 = 0.001

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_9) / var_52_12
				local var_52_14 = Vector3.New(-69, -354.2, -425.9)

				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102, var_52_14, var_52_13)
			end

			if arg_49_1.time_ >= var_52_9 + var_52_12 and arg_49_1.time_ < var_52_9 + var_52_12 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_52_15 = 0
			local var_52_16 = 0.15

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(926011012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 6
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011012", "story_v_out_926011.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011012", "story_v_out_926011.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_926011", "926011012", "story_v_out_926011.awb")

						arg_49_1:RecordAudio("926011012", var_52_24)
						arg_49_1:RecordAudio("926011012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926011", "926011012", "story_v_out_926011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926011", "926011012", "story_v_out_926011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10102"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10102 == nil then
				arg_53_1.var_.actorSpriteComps10102 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10102 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10102 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10102 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.8

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(926011013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 32
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_9 or var_56_9 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_9 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_15 and arg_53_1.time_ < var_56_8 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.85

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(926011014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 34
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926011015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			zh = 4.466,
			ja = 5.833
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
				arg_61_0:Play926011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10102"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10102 == nil then
				arg_61_1.var_.actorSpriteComps10102 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10102 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10102 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10102 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.5

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(926011015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 20
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011015", "story_v_out_926011.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011015", "story_v_out_926011.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_926011", "926011015", "story_v_out_926011.awb")

						arg_61_1:RecordAudio("926011015", var_64_17)
						arg_61_1:RecordAudio("926011015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926011", "926011015", "story_v_out_926011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926011", "926011015", "story_v_out_926011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play926011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10102"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10102 == nil then
				arg_65_1.var_.actorSpriteComps10102 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10102 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10102 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10102 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.875

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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_11 = arg_65_1:GetWordFromCfg(926011016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 35
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
	Play926011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926011017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play926011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.675

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(926011017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 27
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926011018
		arg_73_1.duration_ = 2.7

		local var_73_0 = {
			zh = 1.9,
			ja = 2.7
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
				arg_73_0:Play926011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10102"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10102 == nil then
				arg_73_1.var_.actorSpriteComps10102 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10102 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10102 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10102 = nil
			end

			local var_76_8 = arg_73_1.actors_["10102"].transform
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.var_.moveOldPos10102 = var_76_8.localPosition
				var_76_8.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10102", 3)

				local var_76_10 = var_76_8.childCount

				for iter_76_4 = 0, var_76_10 - 1 do
					local var_76_11 = var_76_8:GetChild(iter_76_4)

					if var_76_11.name == "split_6" or not string.find(var_76_11.name, "split") then
						var_76_11.gameObject:SetActive(true)
					else
						var_76_11.gameObject:SetActive(false)
					end
				end
			end

			local var_76_12 = 0.001

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_9) / var_76_12
				local var_76_14 = Vector3.New(-69, -354.2, -425.9)

				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10102, var_76_14, var_76_13)
			end

			if arg_73_1.time_ >= var_76_9 + var_76_12 and arg_73_1.time_ < var_76_9 + var_76_12 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_76_15 = 0
			local var_76_16 = 0.15

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(926011018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 6
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011018", "story_v_out_926011.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011018", "story_v_out_926011.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_926011", "926011018", "story_v_out_926011.awb")

						arg_73_1:RecordAudio("926011018", var_76_24)
						arg_73_1:RecordAudio("926011018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926011", "926011018", "story_v_out_926011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926011", "926011018", "story_v_out_926011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926011019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play926011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10102"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10102 == nil then
				arg_77_1.var_.actorSpriteComps10102 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10102 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10102 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10102 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.85

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(926011019)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 34
				local var_80_14 = utf8.len(var_80_12)
				local var_80_15 = var_80_13 <= 0 and var_80_9 or var_80_9 * (var_80_14 / var_80_13)

				if var_80_15 > 0 and var_80_9 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play926011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926011020
		arg_81_1.duration_ = 8.83

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "ST12a"

			if arg_81_1.bgs_[var_84_0] == nil then
				local var_84_1 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_0)
				var_84_1.name = var_84_0
				var_84_1.transform.parent = arg_81_1.stage_.transform
				var_84_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_0] = var_84_1
			end

			local var_84_2 = 1.999999999999

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				local var_84_3 = manager.ui.mainCamera.transform.localPosition
				local var_84_4 = Vector3.New(0, 0, 10) + Vector3.New(var_84_3.x, var_84_3.y, 0)
				local var_84_5 = arg_81_1.bgs_.ST12a

				var_84_5.transform.localPosition = var_84_4
				var_84_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_6 = var_84_5:GetComponent("SpriteRenderer")

				if var_84_6 and var_84_6.sprite then
					local var_84_7 = (var_84_5.transform.localPosition - var_84_3).z
					local var_84_8 = manager.ui.mainCameraCom_
					local var_84_9 = 2 * var_84_7 * Mathf.Tan(var_84_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_10 = var_84_9 * var_84_8.aspect
					local var_84_11 = var_84_6.sprite.bounds.size.x
					local var_84_12 = var_84_6.sprite.bounds.size.y
					local var_84_13 = var_84_10 / var_84_11
					local var_84_14 = var_84_9 / var_84_12
					local var_84_15 = var_84_14 < var_84_13 and var_84_13 or var_84_14

					var_84_5.transform.localScale = Vector3.New(var_84_15, var_84_15, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "ST12a" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_16 = 1.999999999999

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_17 = 0.3

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_19 = 2

			if var_84_18 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_18) / var_84_19
				local var_84_21 = Color.New(0, 0, 0)

				var_84_21.a = Mathf.Lerp(0, 1, var_84_20)
				arg_81_1.mask_.color = var_84_21
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = 1
				arg_81_1.mask_.color = var_84_22
			end

			local var_84_23 = 1.999999999999

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Color.New(0, 0, 0)

				var_84_26.a = Mathf.Lerp(1, 0, var_84_25)
				arg_81_1.mask_.color = var_84_26
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				local var_84_27 = Color.New(0, 0, 0)
				local var_84_28 = 0

				arg_81_1.mask_.enabled = false
				var_84_27.a = var_84_28
				arg_81_1.mask_.color = var_84_27
			end

			local var_84_29 = arg_81_1.actors_["10102"].transform
			local var_84_30 = 1.999999999999

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.var_.moveOldPos10102 = var_84_29.localPosition
				var_84_29.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10102", 7)

				local var_84_31 = var_84_29.childCount

				for iter_84_2 = 0, var_84_31 - 1 do
					local var_84_32 = var_84_29:GetChild(iter_84_2)

					if var_84_32.name == "" or not string.find(var_84_32.name, "split") then
						var_84_32.gameObject:SetActive(true)
					else
						var_84_32.gameObject:SetActive(false)
					end
				end
			end

			local var_84_33 = 0.001

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_33 then
				local var_84_34 = (arg_81_1.time_ - var_84_30) / var_84_33
				local var_84_35 = Vector3.New(0, -2000, 0)

				var_84_29.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10102, var_84_35, var_84_34)
			end

			if arg_81_1.time_ >= var_84_30 + var_84_33 and arg_81_1.time_ < var_84_30 + var_84_33 + arg_84_0 then
				var_84_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_36 = 1.50066666666667
			local var_84_37 = 1

			if var_84_36 < arg_81_1.time_ and arg_81_1.time_ <= var_84_36 + arg_84_0 then
				local var_84_38 = "play"
				local var_84_39 = "effect"

				arg_81_1:AudioAction(var_84_38, var_84_39, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_84_40 = 0
			local var_84_41 = 0.3

			if var_84_40 < arg_81_1.time_ and arg_81_1.time_ <= var_84_40 + arg_84_0 then
				local var_84_42 = "play"
				local var_84_43 = "music"

				arg_81_1:AudioAction(var_84_42, var_84_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_84_44 = ""
				local var_84_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_84_45 ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_45 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_45

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_45
						arg_81_1.bgmTxt2_.text = var_84_45
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_84_46 = 0.500666666666667
			local var_84_47 = 1

			if var_84_46 < arg_81_1.time_ and arg_81_1.time_ <= var_84_46 + arg_84_0 then
				local var_84_48 = "play"
				local var_84_49 = "music"

				arg_81_1:AudioAction(var_84_48, var_84_49, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_84_50 = ""
				local var_84_51 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_84_51 ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_51 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_51

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_51
						arg_81_1.bgmTxt2_.text = var_84_51
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_84_52 = 0.3
			local var_84_53 = 1

			if var_84_52 < arg_81_1.time_ and arg_81_1.time_ <= var_84_52 + arg_84_0 then
				local var_84_54 = "stop"
				local var_84_55 = "effect"

				arg_81_1:AudioAction(var_84_54, var_84_55, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_56 = 3.83333333333333
			local var_84_57 = 0.425

			if var_84_56 < arg_81_1.time_ and arg_81_1.time_ <= var_84_56 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_58 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_58:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_81_1.dialogCg_.alpha = arg_87_0
				end))
				var_84_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_59 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_60 = arg_81_1:GetWordFromCfg(926011020)
				local var_84_61 = arg_81_1:FormatText(var_84_60.content)

				arg_81_1.text_.text = var_84_61

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_62 = 17
				local var_84_63 = utf8.len(var_84_61)
				local var_84_64 = var_84_62 <= 0 and var_84_57 or var_84_57 * (var_84_63 / var_84_62)

				if var_84_64 > 0 and var_84_57 < var_84_64 then
					arg_81_1.talkMaxDuration = var_84_64
					var_84_56 = var_84_56 + 0.3

					if var_84_64 + var_84_56 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_64 + var_84_56
					end
				end

				arg_81_1.text_.text = var_84_61
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_65 = var_84_56 + 0.3
			local var_84_66 = math.max(var_84_57, arg_81_1.talkMaxDuration)

			if var_84_65 <= arg_81_1.time_ and arg_81_1.time_ < var_84_65 + var_84_66 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_65) / var_84_66

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_65 + var_84_66 and arg_81_1.time_ < var_84_65 + var_84_66 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play926011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926011021
		arg_89_1.duration_ = 2.5

		local var_89_0 = {
			zh = 2.366,
			ja = 2.5
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
				arg_89_0:Play926011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.2

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[36].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(926011021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 8
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011021", "story_v_out_926011.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011021", "story_v_out_926011.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_926011", "926011021", "story_v_out_926011.awb")

						arg_89_1:RecordAudio("926011021", var_92_9)
						arg_89_1:RecordAudio("926011021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926011", "926011021", "story_v_out_926011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926011", "926011021", "story_v_out_926011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play926011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926011022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play926011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.5

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(926011022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 60
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play926011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926011023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.3

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(926011023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 12
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
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play926011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926011024
		arg_101_1.duration_ = 7.37

		local var_101_0 = {
			zh = 5.7,
			ja = 7.366
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
				arg_101_0:Play926011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "1047"

			if arg_101_1.actors_[var_104_0] == nil then
				local var_104_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

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

			local var_104_4 = arg_101_1.actors_["1047"]
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.actorSpriteComps1047 == nil then
				arg_101_1.var_.actorSpriteComps1047 = var_104_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.2

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 and not isNil(var_104_4) then
				local var_104_7 = (arg_101_1.time_ - var_104_5) / var_104_6

				if arg_101_1.var_.actorSpriteComps1047 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								local var_104_8 = Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, var_104_7)
								local var_104_9 = Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, var_104_7)
								local var_104_10 = Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, var_104_7)

								iter_104_3.color = Color.New(var_104_8, var_104_9, var_104_10)
							else
								local var_104_11 = Mathf.Lerp(iter_104_3.color.r, 1, var_104_7)

								iter_104_3.color = Color.New(var_104_11, var_104_11, var_104_11)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.actorSpriteComps1047 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_104_5 then
						if arg_101_1.isInRecall_ then
							iter_104_5.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1047 = nil
			end

			local var_104_12 = arg_101_1.actors_["1047"].transform
			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1.var_.moveOldPos1047 = var_104_12.localPosition
				var_104_12.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1047", 3)

				local var_104_14 = var_104_12.childCount

				for iter_104_6 = 0, var_104_14 - 1 do
					local var_104_15 = var_104_12:GetChild(iter_104_6)

					if var_104_15.name == "" or not string.find(var_104_15.name, "split") then
						var_104_15.gameObject:SetActive(true)
					else
						var_104_15.gameObject:SetActive(false)
					end
				end
			end

			local var_104_16 = 0.001

			if var_104_13 <= arg_101_1.time_ and arg_101_1.time_ < var_104_13 + var_104_16 then
				local var_104_17 = (arg_101_1.time_ - var_104_13) / var_104_16
				local var_104_18 = Vector3.New(-38.9, -360, -319.3)

				var_104_12.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1047, var_104_18, var_104_17)
			end

			if arg_101_1.time_ >= var_104_13 + var_104_16 and arg_101_1.time_ < var_104_13 + var_104_16 + arg_104_0 then
				var_104_12.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_104_19 = 0
			local var_104_20 = 0.55

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_21 = arg_101_1:FormatText(StoryNameCfg[1296].name)

				arg_101_1.leftNameTxt_.text = var_104_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_22 = arg_101_1:GetWordFromCfg(926011024)
				local var_104_23 = arg_101_1:FormatText(var_104_22.content)

				arg_101_1.text_.text = var_104_23

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_24 = 22
				local var_104_25 = utf8.len(var_104_23)
				local var_104_26 = var_104_24 <= 0 and var_104_20 or var_104_20 * (var_104_25 / var_104_24)

				if var_104_26 > 0 and var_104_20 < var_104_26 then
					arg_101_1.talkMaxDuration = var_104_26

					if var_104_26 + var_104_19 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_26 + var_104_19
					end
				end

				arg_101_1.text_.text = var_104_23
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011024", "story_v_out_926011.awb") ~= 0 then
					local var_104_27 = manager.audio:GetVoiceLength("story_v_out_926011", "926011024", "story_v_out_926011.awb") / 1000

					if var_104_27 + var_104_19 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_27 + var_104_19
					end

					if var_104_22.prefab_name ~= "" and arg_101_1.actors_[var_104_22.prefab_name] ~= nil then
						local var_104_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_22.prefab_name].transform, "story_v_out_926011", "926011024", "story_v_out_926011.awb")

						arg_101_1:RecordAudio("926011024", var_104_28)
						arg_101_1:RecordAudio("926011024", var_104_28)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926011", "926011024", "story_v_out_926011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926011", "926011024", "story_v_out_926011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_29 = math.max(var_104_20, arg_101_1.talkMaxDuration)

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_29 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_19) / var_104_29

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_19 + var_104_29 and arg_101_1.time_ < var_104_19 + var_104_29 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play926011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926011025
		arg_105_1.duration_ = 1

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"

			SetActive(arg_105_1.choicesGo_, true)

			for iter_106_0, iter_106_1 in ipairs(arg_105_1.choices_) do
				local var_106_0 = iter_106_0 <= 2

				SetActive(iter_106_1.go, var_106_0)
			end

			arg_105_1.choices_[1].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1304].name)
			arg_105_1.choices_[2].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1305].name)
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926011026(arg_105_1)
			end

			if arg_107_0 == 2 then
				arg_105_0:Play926011026(arg_105_1)
			end

			arg_105_1:RecordChoiceLog(926011025, 1304, 1305)
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1047"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1047 == nil then
				arg_105_1.var_.actorSpriteComps1047 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1047 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 0.5, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1047 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926011026
		arg_109_1.duration_ = 5.77

		local var_109_0 = {
			zh = 3.166,
			ja = 5.766
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
				arg_109_0:Play926011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1047"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1047 == nil then
				arg_109_1.var_.actorSpriteComps1047 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1047 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 1, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1047 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1047 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.35

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_10 = arg_109_1:FormatText(StoryNameCfg[1296].name)

				arg_109_1.leftNameTxt_.text = var_112_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_11 = arg_109_1:GetWordFromCfg(926011026)
				local var_112_12 = arg_109_1:FormatText(var_112_11.content)

				arg_109_1.text_.text = var_112_12

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 14
				local var_112_14 = utf8.len(var_112_12)
				local var_112_15 = var_112_13 <= 0 and var_112_9 or var_112_9 * (var_112_14 / var_112_13)

				if var_112_15 > 0 and var_112_9 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_12
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011026", "story_v_out_926011.awb") ~= 0 then
					local var_112_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011026", "story_v_out_926011.awb") / 1000

					if var_112_16 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_8
					end

					if var_112_11.prefab_name ~= "" and arg_109_1.actors_[var_112_11.prefab_name] ~= nil then
						local var_112_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_11.prefab_name].transform, "story_v_out_926011", "926011026", "story_v_out_926011.awb")

						arg_109_1:RecordAudio("926011026", var_112_17)
						arg_109_1:RecordAudio("926011026", var_112_17)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926011", "926011026", "story_v_out_926011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926011", "926011026", "story_v_out_926011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_18 and arg_109_1.time_ < var_112_8 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926011027
		arg_113_1.duration_ = 13

		local var_113_0 = {
			zh = 9.866,
			ja = 13
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
				arg_113_0:Play926011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.25

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[1296].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(926011027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 50
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011027", "story_v_out_926011.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011027", "story_v_out_926011.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_926011", "926011027", "story_v_out_926011.awb")

						arg_113_1:RecordAudio("926011027", var_116_9)
						arg_113_1:RecordAudio("926011027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926011", "926011027", "story_v_out_926011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926011", "926011027", "story_v_out_926011.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play926011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926011028
		arg_117_1.duration_ = 12.43

		local var_117_0 = {
			zh = 8.266,
			ja = 12.433
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
				arg_117_0:Play926011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1047"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1047 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1047", 3)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_1" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(-38.9, -360, -319.3)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1047, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_120_7 = 0
			local var_120_8 = 0.925

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_9 = arg_117_1:FormatText(StoryNameCfg[1296].name)

				arg_117_1.leftNameTxt_.text = var_120_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(926011028)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 37
				local var_120_13 = utf8.len(var_120_11)
				local var_120_14 = var_120_12 <= 0 and var_120_8 or var_120_8 * (var_120_13 / var_120_12)

				if var_120_14 > 0 and var_120_8 < var_120_14 then
					arg_117_1.talkMaxDuration = var_120_14

					if var_120_14 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_7
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011028", "story_v_out_926011.awb") ~= 0 then
					local var_120_15 = manager.audio:GetVoiceLength("story_v_out_926011", "926011028", "story_v_out_926011.awb") / 1000

					if var_120_15 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_7
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_926011", "926011028", "story_v_out_926011.awb")

						arg_117_1:RecordAudio("926011028", var_120_16)
						arg_117_1:RecordAudio("926011028", var_120_16)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926011", "926011028", "story_v_out_926011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926011", "926011028", "story_v_out_926011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_17 = math.max(var_120_8, arg_117_1.talkMaxDuration)

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_17 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_7) / var_120_17

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_7 + var_120_17 and arg_117_1.time_ < var_120_7 + var_120_17 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play926011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926011029
		arg_121_1.duration_ = 2.93

		local var_121_0 = {
			zh = 2.1,
			ja = 2.933
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
				arg_121_0:Play926011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10102"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10102 == nil then
				arg_121_1.var_.actorSpriteComps10102 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10102 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10102 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10102 = nil
			end

			local var_124_8 = arg_121_1.actors_["1047"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1047 == nil then
				arg_121_1.var_.actorSpriteComps1047 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_10 = 0.2

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 and not isNil(var_124_8) then
				local var_124_11 = (arg_121_1.time_ - var_124_9) / var_124_10

				if arg_121_1.var_.actorSpriteComps1047 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								local var_124_12 = Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor2.r, var_124_11)
								local var_124_13 = Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor2.g, var_124_11)
								local var_124_14 = Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor2.b, var_124_11)

								iter_124_5.color = Color.New(var_124_12, var_124_13, var_124_14)
							else
								local var_124_15 = Mathf.Lerp(iter_124_5.color.r, 0.5, var_124_11)

								iter_124_5.color = Color.New(var_124_15, var_124_15, var_124_15)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1047 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_124_7 then
						if arg_121_1.isInRecall_ then
							iter_124_7.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1047 = nil
			end

			local var_124_16 = arg_121_1.actors_["1047"].transform
			local var_124_17 = 0

			if var_124_17 < arg_121_1.time_ and arg_121_1.time_ <= var_124_17 + arg_124_0 then
				arg_121_1.var_.moveOldPos1047 = var_124_16.localPosition
				var_124_16.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1047", 7)

				local var_124_18 = var_124_16.childCount

				for iter_124_8 = 0, var_124_18 - 1 do
					local var_124_19 = var_124_16:GetChild(iter_124_8)

					if var_124_19.name == "" or not string.find(var_124_19.name, "split") then
						var_124_19.gameObject:SetActive(true)
					else
						var_124_19.gameObject:SetActive(false)
					end
				end
			end

			local var_124_20 = 0.001

			if var_124_17 <= arg_121_1.time_ and arg_121_1.time_ < var_124_17 + var_124_20 then
				local var_124_21 = (arg_121_1.time_ - var_124_17) / var_124_20
				local var_124_22 = Vector3.New(0, -2000, 0)

				var_124_16.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1047, var_124_22, var_124_21)
			end

			if arg_121_1.time_ >= var_124_17 + var_124_20 and arg_121_1.time_ < var_124_17 + var_124_20 + arg_124_0 then
				var_124_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_23 = arg_121_1.actors_["10102"].transform
			local var_124_24 = 0

			if var_124_24 < arg_121_1.time_ and arg_121_1.time_ <= var_124_24 + arg_124_0 then
				arg_121_1.var_.moveOldPos10102 = var_124_23.localPosition
				var_124_23.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10102", 3)

				local var_124_25 = var_124_23.childCount

				for iter_124_9 = 0, var_124_25 - 1 do
					local var_124_26 = var_124_23:GetChild(iter_124_9)

					if var_124_26.name == "" or not string.find(var_124_26.name, "split") then
						var_124_26.gameObject:SetActive(true)
					else
						var_124_26.gameObject:SetActive(false)
					end
				end
			end

			local var_124_27 = 0.001

			if var_124_24 <= arg_121_1.time_ and arg_121_1.time_ < var_124_24 + var_124_27 then
				local var_124_28 = (arg_121_1.time_ - var_124_24) / var_124_27
				local var_124_29 = Vector3.New(-69, -354.2, -425.9)

				var_124_23.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10102, var_124_29, var_124_28)
			end

			if arg_121_1.time_ >= var_124_24 + var_124_27 and arg_121_1.time_ < var_124_24 + var_124_27 + arg_124_0 then
				var_124_23.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_124_30 = 0
			local var_124_31 = 0.175

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(926011029)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 7
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011029", "story_v_out_926011.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_926011", "926011029", "story_v_out_926011.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_926011", "926011029", "story_v_out_926011.awb")

						arg_121_1:RecordAudio("926011029", var_124_39)
						arg_121_1:RecordAudio("926011029", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_926011", "926011029", "story_v_out_926011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_926011", "926011029", "story_v_out_926011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926011030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10102"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10102 == nil then
				arg_125_1.var_.actorSpriteComps10102 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10102 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10102 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10102 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 0.2

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_10 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_11 = arg_125_1:GetWordFromCfg(926011030)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 8
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_9 or var_128_9 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_9 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926011031
		arg_129_1.duration_ = 19.57

		local var_129_0 = {
			zh = 9.966,
			ja = 19.566
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
				arg_129_0:Play926011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1047"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1047 == nil then
				arg_129_1.var_.actorSpriteComps1047 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps1047 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1047 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1047 = nil
			end

			local var_132_8 = arg_129_1.actors_["10102"].transform
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.var_.moveOldPos10102 = var_132_8.localPosition
				var_132_8.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10102", 7)

				local var_132_10 = var_132_8.childCount

				for iter_132_4 = 0, var_132_10 - 1 do
					local var_132_11 = var_132_8:GetChild(iter_132_4)

					if var_132_11.name == "" or not string.find(var_132_11.name, "split") then
						var_132_11.gameObject:SetActive(true)
					else
						var_132_11.gameObject:SetActive(false)
					end
				end
			end

			local var_132_12 = 0.001

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_12 then
				local var_132_13 = (arg_129_1.time_ - var_132_9) / var_132_12
				local var_132_14 = Vector3.New(0, -2000, 0)

				var_132_8.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10102, var_132_14, var_132_13)
			end

			if arg_129_1.time_ >= var_132_9 + var_132_12 and arg_129_1.time_ < var_132_9 + var_132_12 + arg_132_0 then
				var_132_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_15 = arg_129_1.actors_["1047"].transform
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.var_.moveOldPos1047 = var_132_15.localPosition
				var_132_15.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1047", 3)

				local var_132_17 = var_132_15.childCount

				for iter_132_5 = 0, var_132_17 - 1 do
					local var_132_18 = var_132_15:GetChild(iter_132_5)

					if var_132_18.name == "split_2" or not string.find(var_132_18.name, "split") then
						var_132_18.gameObject:SetActive(true)
					else
						var_132_18.gameObject:SetActive(false)
					end
				end
			end

			local var_132_19 = 0.001

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_19 then
				local var_132_20 = (arg_129_1.time_ - var_132_16) / var_132_19
				local var_132_21 = Vector3.New(-38.9, -360, -319.3)

				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1047, var_132_21, var_132_20)
			end

			if arg_129_1.time_ >= var_132_16 + var_132_19 and arg_129_1.time_ < var_132_16 + var_132_19 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_132_22 = 0
			local var_132_23 = 1.275

			if var_132_22 < arg_129_1.time_ and arg_129_1.time_ <= var_132_22 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_24 = arg_129_1:FormatText(StoryNameCfg[1296].name)

				arg_129_1.leftNameTxt_.text = var_132_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_25 = arg_129_1:GetWordFromCfg(926011031)
				local var_132_26 = arg_129_1:FormatText(var_132_25.content)

				arg_129_1.text_.text = var_132_26

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_27 = 51
				local var_132_28 = utf8.len(var_132_26)
				local var_132_29 = var_132_27 <= 0 and var_132_23 or var_132_23 * (var_132_28 / var_132_27)

				if var_132_29 > 0 and var_132_23 < var_132_29 then
					arg_129_1.talkMaxDuration = var_132_29

					if var_132_29 + var_132_22 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_29 + var_132_22
					end
				end

				arg_129_1.text_.text = var_132_26
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011031", "story_v_out_926011.awb") ~= 0 then
					local var_132_30 = manager.audio:GetVoiceLength("story_v_out_926011", "926011031", "story_v_out_926011.awb") / 1000

					if var_132_30 + var_132_22 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_30 + var_132_22
					end

					if var_132_25.prefab_name ~= "" and arg_129_1.actors_[var_132_25.prefab_name] ~= nil then
						local var_132_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_25.prefab_name].transform, "story_v_out_926011", "926011031", "story_v_out_926011.awb")

						arg_129_1:RecordAudio("926011031", var_132_31)
						arg_129_1:RecordAudio("926011031", var_132_31)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926011", "926011031", "story_v_out_926011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926011", "926011031", "story_v_out_926011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_32 = math.max(var_132_23, arg_129_1.talkMaxDuration)

			if var_132_22 <= arg_129_1.time_ and arg_129_1.time_ < var_132_22 + var_132_32 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_22) / var_132_32

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_22 + var_132_32 and arg_129_1.time_ < var_132_22 + var_132_32 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_129_1:InitPlayNodeList()
	end,
	Play926011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926011032
		arg_133_1.duration_ = 7.1

		local var_133_0 = {
			zh = 5.766,
			ja = 7.1
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
				arg_133_0:Play926011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.65

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1296].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(926011032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011032", "story_v_out_926011.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011032", "story_v_out_926011.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_926011", "926011032", "story_v_out_926011.awb")

						arg_133_1:RecordAudio("926011032", var_136_9)
						arg_133_1:RecordAudio("926011032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926011", "926011032", "story_v_out_926011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926011", "926011032", "story_v_out_926011.awb")
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
	Play926011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926011033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play926011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1047"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1047 == nil then
				arg_137_1.var_.actorSpriteComps1047 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1047 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 0.5, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1047 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1047 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.5

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_11 = arg_137_1:GetWordFromCfg(926011033)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 20
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
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play926011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926011034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.75

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(926011034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 30
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
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play926011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926011035
		arg_145_1.duration_ = 4.27

		local var_145_0 = {
			zh = 3.566,
			ja = 4.266
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
				arg_145_0:Play926011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1047"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1047 == nil then
				arg_145_1.var_.actorSpriteComps1047 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1047 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1047 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1047 = nil
			end

			local var_148_8 = arg_145_1.actors_["1047"].transform
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos1047 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1047", 3)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "" or not string.find(var_148_11.name, "split") then
						var_148_11.gameObject:SetActive(true)
					else
						var_148_11.gameObject:SetActive(false)
					end
				end
			end

			local var_148_12 = 0.001

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(-38.9, -360, -319.3)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1047, var_148_14, var_148_13)
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_148_15 = 0
			local var_148_16 = 0.45

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[1296].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(926011035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 18
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011035", "story_v_out_926011.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011035", "story_v_out_926011.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_926011", "926011035", "story_v_out_926011.awb")

						arg_145_1:RecordAudio("926011035", var_148_24)
						arg_145_1:RecordAudio("926011035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926011", "926011035", "story_v_out_926011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926011", "926011035", "story_v_out_926011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play926011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926011036
		arg_149_1.duration_ = 1

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"

			SetActive(arg_149_1.choicesGo_, true)

			for iter_150_0, iter_150_1 in ipairs(arg_149_1.choices_) do
				local var_150_0 = iter_150_0 <= 1

				SetActive(iter_150_1.go, var_150_0)
			end

			arg_149_1.choices_[1].txt.text = arg_149_1:FormatText(StoryChoiceCfg[1306].name)
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926011037(arg_149_1)
			end

			arg_149_1:RecordChoiceLog(926011036, 1306)
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1047"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1047 == nil then
				arg_149_1.var_.actorSpriteComps1047 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1047 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1047 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926011037
		arg_153_1.duration_ = 7.37

		local var_153_0 = {
			zh = 4.533,
			ja = 7.366
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
				arg_153_0:Play926011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1047"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1047 == nil then
				arg_153_1.var_.actorSpriteComps1047 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1047 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1047 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1047 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.575

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[1296].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_11 = arg_153_1:GetWordFromCfg(926011037)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011037", "story_v_out_926011.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011037", "story_v_out_926011.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_926011", "926011037", "story_v_out_926011.awb")

						arg_153_1:RecordAudio("926011037", var_156_17)
						arg_153_1:RecordAudio("926011037", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926011", "926011037", "story_v_out_926011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926011", "926011037", "story_v_out_926011.awb")
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
	Play926011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926011038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1047"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1047 == nil then
				arg_157_1.var_.actorSpriteComps1047 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1047 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1047 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1047 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.425

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_10 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_11 = arg_157_1:GetWordFromCfg(926011038)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 17
				local var_160_14 = utf8.len(var_160_12)
				local var_160_15 = var_160_13 <= 0 and var_160_9 or var_160_9 * (var_160_14 / var_160_13)

				if var_160_15 > 0 and var_160_9 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play926011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926011039
		arg_161_1.duration_ = 13.3

		local var_161_0 = {
			zh = 9.733,
			ja = 13.3
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
				arg_161_0:Play926011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1047"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1047 == nil then
				arg_161_1.var_.actorSpriteComps1047 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1047 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 1, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1047 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1047 = nil
			end

			local var_164_8 = 0
			local var_164_9 = 1.175

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_10 = arg_161_1:FormatText(StoryNameCfg[1296].name)

				arg_161_1.leftNameTxt_.text = var_164_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_11 = arg_161_1:GetWordFromCfg(926011039)
				local var_164_12 = arg_161_1:FormatText(var_164_11.content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011039", "story_v_out_926011.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011039", "story_v_out_926011.awb") / 1000

					if var_164_16 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_8
					end

					if var_164_11.prefab_name ~= "" and arg_161_1.actors_[var_164_11.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_11.prefab_name].transform, "story_v_out_926011", "926011039", "story_v_out_926011.awb")

						arg_161_1:RecordAudio("926011039", var_164_17)
						arg_161_1:RecordAudio("926011039", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_926011", "926011039", "story_v_out_926011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_926011", "926011039", "story_v_out_926011.awb")
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
	Play926011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926011040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play926011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1047"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1047 == nil then
				arg_165_1.var_.actorSpriteComps1047 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps1047 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1047 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1047 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.55

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_10 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_11 = arg_165_1:GetWordFromCfg(926011040)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 22
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
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play926011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926011041
		arg_169_1.duration_ = 9.8

		local var_169_0 = {
			zh = 5.533,
			ja = 9.8
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
				arg_169_0:Play926011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1047"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1047 == nil then
				arg_169_1.var_.actorSpriteComps1047 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps1047 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 1, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1047 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1047 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.6

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[1296].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(926011041)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 24
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_9 or var_172_9 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_9 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011041", "story_v_out_926011.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011041", "story_v_out_926011.awb") / 1000

					if var_172_16 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_8
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_926011", "926011041", "story_v_out_926011.awb")

						arg_169_1:RecordAudio("926011041", var_172_17)
						arg_169_1:RecordAudio("926011041", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_926011", "926011041", "story_v_out_926011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_926011", "926011041", "story_v_out_926011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_18 and arg_169_1.time_ < var_172_8 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926011042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play926011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1047"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1047 == nil then
				arg_173_1.var_.actorSpriteComps1047 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1047 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1047 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1047 = nil
			end

			local var_176_8 = arg_173_1.actors_["1047"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047 = var_176_8.localPosition
				var_176_8.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1047", 7)

				local var_176_10 = var_176_8.childCount

				for iter_176_4 = 0, var_176_10 - 1 do
					local var_176_11 = var_176_8:GetChild(iter_176_4)

					if var_176_11.name == "" or not string.find(var_176_11.name, "split") then
						var_176_11.gameObject:SetActive(true)
					else
						var_176_11.gameObject:SetActive(false)
					end
				end
			end

			local var_176_12 = 0.001

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_12 then
				local var_176_13 = (arg_173_1.time_ - var_176_9) / var_176_12
				local var_176_14 = Vector3.New(0, -2000, 0)

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047, var_176_14, var_176_13)
			end

			if arg_173_1.time_ >= var_176_9 + var_176_12 and arg_173_1.time_ < var_176_9 + var_176_12 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_176_15 = 0
			local var_176_16 = 0.8

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_17 = arg_173_1:GetWordFromCfg(926011042)
				local var_176_18 = arg_173_1:FormatText(var_176_17.content)

				arg_173_1.text_.text = var_176_18

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_19 = 32
				local var_176_20 = utf8.len(var_176_18)
				local var_176_21 = var_176_19 <= 0 and var_176_16 or var_176_16 * (var_176_20 / var_176_19)

				if var_176_21 > 0 and var_176_16 < var_176_21 then
					arg_173_1.talkMaxDuration = var_176_21

					if var_176_21 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_21 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_18
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_22 and arg_173_1.time_ < var_176_15 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play926011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926011043
		arg_177_1.duration_ = 14.9

		local var_177_0 = {
			zh = 10.133,
			ja = 14.9
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
				arg_177_0:Play926011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1047"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1047 == nil then
				arg_177_1.var_.actorSpriteComps1047 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1047 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1047 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1047 = nil
			end

			local var_180_8 = arg_177_1.actors_["1047"].transform
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047 = var_180_8.localPosition
				var_180_8.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1047", 3)

				local var_180_10 = var_180_8.childCount

				for iter_180_4 = 0, var_180_10 - 1 do
					local var_180_11 = var_180_8:GetChild(iter_180_4)

					if var_180_11.name == "split_6" or not string.find(var_180_11.name, "split") then
						var_180_11.gameObject:SetActive(true)
					else
						var_180_11.gameObject:SetActive(false)
					end
				end
			end

			local var_180_12 = 0.001

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_12 then
				local var_180_13 = (arg_177_1.time_ - var_180_9) / var_180_12
				local var_180_14 = Vector3.New(-38.9, -360, -319.3)

				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047, var_180_14, var_180_13)
			end

			if arg_177_1.time_ >= var_180_9 + var_180_12 and arg_177_1.time_ < var_180_9 + var_180_12 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_180_15 = 0
			local var_180_16 = 1.25

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[1296].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(926011043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 50
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011043", "story_v_out_926011.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011043", "story_v_out_926011.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_926011", "926011043", "story_v_out_926011.awb")

						arg_177_1:RecordAudio("926011043", var_180_24)
						arg_177_1:RecordAudio("926011043", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926011", "926011043", "story_v_out_926011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926011", "926011043", "story_v_out_926011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play926011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926011044
		arg_181_1.duration_ = 13.4

		local var_181_0 = {
			zh = 12.266,
			ja = 13.4
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
				arg_181_0:Play926011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.35

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[1296].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(926011044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 54
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011044", "story_v_out_926011.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011044", "story_v_out_926011.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_926011", "926011044", "story_v_out_926011.awb")

						arg_181_1:RecordAudio("926011044", var_184_9)
						arg_181_1:RecordAudio("926011044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926011", "926011044", "story_v_out_926011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926011", "926011044", "story_v_out_926011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926011045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1047"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1047 == nil then
				arg_185_1.var_.actorSpriteComps1047 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps1047 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 0.5, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1047 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1047 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.075

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_10 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_11 = arg_185_1:GetWordFromCfg(926011045)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 3
				local var_188_14 = utf8.len(var_188_12)
				local var_188_15 = var_188_13 <= 0 and var_188_9 or var_188_9 * (var_188_14 / var_188_13)

				if var_188_15 > 0 and var_188_9 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926011046
		arg_189_1.duration_ = 10.37

		local var_189_0 = {
			zh = 6.2,
			ja = 10.366
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
				arg_189_0:Play926011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1047"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1047 == nil then
				arg_189_1.var_.actorSpriteComps1047 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps1047 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 1, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1047 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1047 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.75

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_10 = arg_189_1:FormatText(StoryNameCfg[1296].name)

				arg_189_1.leftNameTxt_.text = var_192_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(926011046)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 30
				local var_192_14 = utf8.len(var_192_12)
				local var_192_15 = var_192_13 <= 0 and var_192_9 or var_192_9 * (var_192_14 / var_192_13)

				if var_192_15 > 0 and var_192_9 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011046", "story_v_out_926011.awb") ~= 0 then
					local var_192_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011046", "story_v_out_926011.awb") / 1000

					if var_192_16 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_8
					end

					if var_192_11.prefab_name ~= "" and arg_189_1.actors_[var_192_11.prefab_name] ~= nil then
						local var_192_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_11.prefab_name].transform, "story_v_out_926011", "926011046", "story_v_out_926011.awb")

						arg_189_1:RecordAudio("926011046", var_192_17)
						arg_189_1:RecordAudio("926011046", var_192_17)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_926011", "926011046", "story_v_out_926011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_926011", "926011046", "story_v_out_926011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_18 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_18 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_18

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_18 and arg_189_1.time_ < var_192_8 + var_192_18 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play926011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926011047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play926011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1047"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1047 == nil then
				arg_193_1.var_.actorSpriteComps1047 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1047 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1047 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1047 = nil
			end

			local var_196_8 = arg_193_1.actors_["1047"].transform
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.var_.moveOldPos1047 = var_196_8.localPosition
				var_196_8.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1047", 7)

				local var_196_10 = var_196_8.childCount

				for iter_196_4 = 0, var_196_10 - 1 do
					local var_196_11 = var_196_8:GetChild(iter_196_4)

					if var_196_11.name == "" or not string.find(var_196_11.name, "split") then
						var_196_11.gameObject:SetActive(true)
					else
						var_196_11.gameObject:SetActive(false)
					end
				end
			end

			local var_196_12 = 0.001

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_12 then
				local var_196_13 = (arg_193_1.time_ - var_196_9) / var_196_12
				local var_196_14 = Vector3.New(0, -2000, 0)

				var_196_8.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1047, var_196_14, var_196_13)
			end

			if arg_193_1.time_ >= var_196_9 + var_196_12 and arg_193_1.time_ < var_196_9 + var_196_12 + arg_196_0 then
				var_196_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_15 = 0
			local var_196_16 = 1.125

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_17 = arg_193_1:GetWordFromCfg(926011047)
				local var_196_18 = arg_193_1:FormatText(var_196_17.content)

				arg_193_1.text_.text = var_196_18

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_19 = 45
				local var_196_20 = utf8.len(var_196_18)
				local var_196_21 = var_196_19 <= 0 and var_196_16 or var_196_16 * (var_196_20 / var_196_19)

				if var_196_21 > 0 and var_196_16 < var_196_21 then
					arg_193_1.talkMaxDuration = var_196_21

					if var_196_21 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_21 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_18
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_22 and arg_193_1.time_ < var_196_15 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play926011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926011048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play926011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.575

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(926011048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 23
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play926011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926011049
		arg_201_1.duration_ = 7.37

		local var_201_0 = {
			zh = 5.066,
			ja = 7.366
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
				arg_201_0:Play926011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1047"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1047 == nil then
				arg_201_1.var_.actorSpriteComps1047 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1047 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 1, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1047 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1047 = nil
			end

			local var_204_8 = arg_201_1.actors_["1047"].transform
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.var_.moveOldPos1047 = var_204_8.localPosition
				var_204_8.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1047", 2)

				local var_204_10 = var_204_8.childCount

				for iter_204_4 = 0, var_204_10 - 1 do
					local var_204_11 = var_204_8:GetChild(iter_204_4)

					if var_204_11.name == "" or not string.find(var_204_11.name, "split") then
						var_204_11.gameObject:SetActive(true)
					else
						var_204_11.gameObject:SetActive(false)
					end
				end
			end

			local var_204_12 = 0.001

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_12 then
				local var_204_13 = (arg_201_1.time_ - var_204_9) / var_204_12
				local var_204_14 = Vector3.New(-489.8, -360, -319.3)

				var_204_8.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1047, var_204_14, var_204_13)
			end

			if arg_201_1.time_ >= var_204_9 + var_204_12 and arg_201_1.time_ < var_204_9 + var_204_12 + arg_204_0 then
				var_204_8.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_204_15 = 0
			local var_204_16 = 0.45

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_17 = arg_201_1:FormatText(StoryNameCfg[1296].name)

				arg_201_1.leftNameTxt_.text = var_204_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_18 = arg_201_1:GetWordFromCfg(926011049)
				local var_204_19 = arg_201_1:FormatText(var_204_18.content)

				arg_201_1.text_.text = var_204_19

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 18
				local var_204_21 = utf8.len(var_204_19)
				local var_204_22 = var_204_20 <= 0 and var_204_16 or var_204_16 * (var_204_21 / var_204_20)

				if var_204_22 > 0 and var_204_16 < var_204_22 then
					arg_201_1.talkMaxDuration = var_204_22

					if var_204_22 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_22 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_19
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011049", "story_v_out_926011.awb") ~= 0 then
					local var_204_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011049", "story_v_out_926011.awb") / 1000

					if var_204_23 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_15
					end

					if var_204_18.prefab_name ~= "" and arg_201_1.actors_[var_204_18.prefab_name] ~= nil then
						local var_204_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_18.prefab_name].transform, "story_v_out_926011", "926011049", "story_v_out_926011.awb")

						arg_201_1:RecordAudio("926011049", var_204_24)
						arg_201_1:RecordAudio("926011049", var_204_24)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926011", "926011049", "story_v_out_926011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926011", "926011049", "story_v_out_926011.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_25 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_25 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_25

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_25 and arg_201_1.time_ < var_204_15 + var_204_25 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play926011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926011050
		arg_205_1.duration_ = 4.5

		local var_205_0 = {
			zh = 4.5,
			ja = 4.433
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
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play926011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10102"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10102 == nil then
				arg_205_1.var_.actorSpriteComps10102 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10102 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 1, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10102 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10102 = nil
			end

			local var_208_8 = arg_205_1.actors_["1047"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1047 == nil then
				arg_205_1.var_.actorSpriteComps1047 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 0.2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps1047 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_12 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, var_208_11)
								local var_208_13 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, var_208_11)
								local var_208_14 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, var_208_11)

								iter_208_5.color = Color.New(var_208_12, var_208_13, var_208_14)
							else
								local var_208_15 = Mathf.Lerp(iter_208_5.color.r, 0.5, var_208_11)

								iter_208_5.color = Color.New(var_208_15, var_208_15, var_208_15)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1047 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1047 = nil
			end

			local var_208_16 = arg_205_1.actors_["10102"].transform
			local var_208_17 = 0

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.var_.moveOldPos10102 = var_208_16.localPosition
				var_208_16.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10102", 4)

				local var_208_18 = var_208_16.childCount

				for iter_208_8 = 0, var_208_18 - 1 do
					local var_208_19 = var_208_16:GetChild(iter_208_8)

					if var_208_19.name == "" or not string.find(var_208_19.name, "split") then
						var_208_19.gameObject:SetActive(true)
					else
						var_208_19.gameObject:SetActive(false)
					end
				end
			end

			local var_208_20 = 0.001

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_20 then
				local var_208_21 = (arg_205_1.time_ - var_208_17) / var_208_20
				local var_208_22 = Vector3.New(369, -354.2, -425.9)

				var_208_16.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10102, var_208_22, var_208_21)
			end

			if arg_205_1.time_ >= var_208_17 + var_208_20 and arg_205_1.time_ < var_208_17 + var_208_20 + arg_208_0 then
				var_208_16.localPosition = Vector3.New(369, -354.2, -425.9)
			end

			local var_208_23 = 0
			local var_208_24 = 0.375

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[6].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(926011050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 15
				local var_208_29 = utf8.len(var_208_27)
				local var_208_30 = var_208_28 <= 0 and var_208_24 or var_208_24 * (var_208_29 / var_208_28)

				if var_208_30 > 0 and var_208_24 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30

					if var_208_30 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_23
					end
				end

				arg_205_1.text_.text = var_208_27
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011050", "story_v_out_926011.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_926011", "926011050", "story_v_out_926011.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_926011", "926011050", "story_v_out_926011.awb")

						arg_205_1:RecordAudio("926011050", var_208_32)
						arg_205_1:RecordAudio("926011050", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926011", "926011050", "story_v_out_926011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926011", "926011050", "story_v_out_926011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = math.max(var_208_24, arg_205_1.talkMaxDuration)

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_33 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_33

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_33 and arg_205_1.time_ < var_208_23 + var_208_33 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926011051
		arg_209_1.duration_ = 14.7

		local var_209_0 = {
			zh = 12.4,
			ja = 14.7
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
				arg_209_0:Play926011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1047"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1047 == nil then
				arg_209_1.var_.actorSpriteComps1047 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1047 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1047 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1047 = nil
			end

			local var_212_8 = arg_209_1.actors_["10102"]
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10102 == nil then
				arg_209_1.var_.actorSpriteComps10102 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_10 = 0.2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 and not isNil(var_212_8) then
				local var_212_11 = (arg_209_1.time_ - var_212_9) / var_212_10

				if arg_209_1.var_.actorSpriteComps10102 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								local var_212_12 = Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, var_212_11)
								local var_212_13 = Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, var_212_11)
								local var_212_14 = Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, var_212_11)

								iter_212_5.color = Color.New(var_212_12, var_212_13, var_212_14)
							else
								local var_212_15 = Mathf.Lerp(iter_212_5.color.r, 0.5, var_212_11)

								iter_212_5.color = Color.New(var_212_15, var_212_15, var_212_15)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10102 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10102 = nil
			end

			local var_212_16 = 0
			local var_212_17 = 1.725

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_18 = arg_209_1:FormatText(StoryNameCfg[1296].name)

				arg_209_1.leftNameTxt_.text = var_212_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_19 = arg_209_1:GetWordFromCfg(926011051)
				local var_212_20 = arg_209_1:FormatText(var_212_19.content)

				arg_209_1.text_.text = var_212_20

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_21 = 69
				local var_212_22 = utf8.len(var_212_20)
				local var_212_23 = var_212_21 <= 0 and var_212_17 or var_212_17 * (var_212_22 / var_212_21)

				if var_212_23 > 0 and var_212_17 < var_212_23 then
					arg_209_1.talkMaxDuration = var_212_23

					if var_212_23 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_20
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011051", "story_v_out_926011.awb") ~= 0 then
					local var_212_24 = manager.audio:GetVoiceLength("story_v_out_926011", "926011051", "story_v_out_926011.awb") / 1000

					if var_212_24 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_16
					end

					if var_212_19.prefab_name ~= "" and arg_209_1.actors_[var_212_19.prefab_name] ~= nil then
						local var_212_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_19.prefab_name].transform, "story_v_out_926011", "926011051", "story_v_out_926011.awb")

						arg_209_1:RecordAudio("926011051", var_212_25)
						arg_209_1:RecordAudio("926011051", var_212_25)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_926011", "926011051", "story_v_out_926011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_926011", "926011051", "story_v_out_926011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_26 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_26 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_26

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_26 and arg_209_1.time_ < var_212_16 + var_212_26 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play926011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926011052
		arg_213_1.duration_ = 1

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"

			SetActive(arg_213_1.choicesGo_, true)

			for iter_214_0, iter_214_1 in ipairs(arg_213_1.choices_) do
				local var_214_0 = iter_214_0 <= 2

				SetActive(iter_214_1.go, var_214_0)
			end

			arg_213_1.choices_[1].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1307].name)
			arg_213_1.choices_[2].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1308].name)
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play926011053(arg_213_1)
			end

			if arg_215_0 == 2 then
				arg_213_0:Play926011053(arg_213_1)
			end

			arg_213_1:RecordChoiceLog(926011052, 1307, 1308)
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1047"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1047 == nil then
				arg_213_1.var_.actorSpriteComps1047 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps1047 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 0.5, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1047 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play926011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926011053
		arg_217_1.duration_ = 8.33

		local var_217_0 = {
			zh = 6.4,
			ja = 8.333
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
				arg_217_0:Play926011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1047"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1047 == nil then
				arg_217_1.var_.actorSpriteComps1047 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps1047 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 1, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1047 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1047 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.75

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_10 = arg_217_1:FormatText(StoryNameCfg[1296].name)

				arg_217_1.leftNameTxt_.text = var_220_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_11 = arg_217_1:GetWordFromCfg(926011053)
				local var_220_12 = arg_217_1:FormatText(var_220_11.content)

				arg_217_1.text_.text = var_220_12

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 30
				local var_220_14 = utf8.len(var_220_12)
				local var_220_15 = var_220_13 <= 0 and var_220_9 or var_220_9 * (var_220_14 / var_220_13)

				if var_220_15 > 0 and var_220_9 < var_220_15 then
					arg_217_1.talkMaxDuration = var_220_15

					if var_220_15 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_15 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_12
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011053", "story_v_out_926011.awb") ~= 0 then
					local var_220_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011053", "story_v_out_926011.awb") / 1000

					if var_220_16 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_16 + var_220_8
					end

					if var_220_11.prefab_name ~= "" and arg_217_1.actors_[var_220_11.prefab_name] ~= nil then
						local var_220_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_11.prefab_name].transform, "story_v_out_926011", "926011053", "story_v_out_926011.awb")

						arg_217_1:RecordAudio("926011053", var_220_17)
						arg_217_1:RecordAudio("926011053", var_220_17)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926011", "926011053", "story_v_out_926011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926011", "926011053", "story_v_out_926011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_18 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_18 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_18

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_18 and arg_217_1.time_ < var_220_8 + var_220_18 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play926011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926011054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play926011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1047"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1047 == nil then
				arg_221_1.var_.actorSpriteComps1047 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1047 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1047 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1047 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.175

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_10 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_11 = arg_221_1:GetWordFromCfg(926011054)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 7
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_9 or var_224_9 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_9 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926011055
		arg_225_1.duration_ = 4.37

		local var_225_0 = {
			zh = 3.333,
			ja = 4.366
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
				arg_225_0:Play926011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10102"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10102 == nil then
				arg_225_1.var_.actorSpriteComps10102 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10102 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10102 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10102 = nil
			end

			local var_228_8 = 0
			local var_228_9 = 0.3

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_10 = arg_225_1:FormatText(StoryNameCfg[6].name)

				arg_225_1.leftNameTxt_.text = var_228_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_11 = arg_225_1:GetWordFromCfg(926011055)
				local var_228_12 = arg_225_1:FormatText(var_228_11.content)

				arg_225_1.text_.text = var_228_12

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 12
				local var_228_14 = utf8.len(var_228_12)
				local var_228_15 = var_228_13 <= 0 and var_228_9 or var_228_9 * (var_228_14 / var_228_13)

				if var_228_15 > 0 and var_228_9 < var_228_15 then
					arg_225_1.talkMaxDuration = var_228_15

					if var_228_15 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_15 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_12
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011055", "story_v_out_926011.awb") ~= 0 then
					local var_228_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011055", "story_v_out_926011.awb") / 1000

					if var_228_16 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_16 + var_228_8
					end

					if var_228_11.prefab_name ~= "" and arg_225_1.actors_[var_228_11.prefab_name] ~= nil then
						local var_228_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_11.prefab_name].transform, "story_v_out_926011", "926011055", "story_v_out_926011.awb")

						arg_225_1:RecordAudio("926011055", var_228_17)
						arg_225_1:RecordAudio("926011055", var_228_17)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926011", "926011055", "story_v_out_926011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926011", "926011055", "story_v_out_926011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_18 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_18 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_18

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_18 and arg_225_1.time_ < var_228_8 + var_228_18 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play926011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926011056
		arg_229_1.duration_ = 12

		local var_229_0 = {
			zh = 8.533,
			ja = 12
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
				arg_229_0:Play926011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1047"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1047 == nil then
				arg_229_1.var_.actorSpriteComps1047 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1047 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 1, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1047 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1047 = nil
			end

			local var_232_8 = arg_229_1.actors_["10102"]
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10102 == nil then
				arg_229_1.var_.actorSpriteComps10102 = var_232_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_10 = 0.2

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 and not isNil(var_232_8) then
				local var_232_11 = (arg_229_1.time_ - var_232_9) / var_232_10

				if arg_229_1.var_.actorSpriteComps10102 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_232_5 then
							if arg_229_1.isInRecall_ then
								local var_232_12 = Mathf.Lerp(iter_232_5.color.r, arg_229_1.hightColor2.r, var_232_11)
								local var_232_13 = Mathf.Lerp(iter_232_5.color.g, arg_229_1.hightColor2.g, var_232_11)
								local var_232_14 = Mathf.Lerp(iter_232_5.color.b, arg_229_1.hightColor2.b, var_232_11)

								iter_232_5.color = Color.New(var_232_12, var_232_13, var_232_14)
							else
								local var_232_15 = Mathf.Lerp(iter_232_5.color.r, 0.5, var_232_11)

								iter_232_5.color = Color.New(var_232_15, var_232_15, var_232_15)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10102 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_232_7 then
						if arg_229_1.isInRecall_ then
							iter_232_7.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10102 = nil
			end

			local var_232_16 = arg_229_1.actors_["1047"].transform
			local var_232_17 = 0

			if var_232_17 < arg_229_1.time_ and arg_229_1.time_ <= var_232_17 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047 = var_232_16.localPosition
				var_232_16.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1047", 2)

				local var_232_18 = var_232_16.childCount

				for iter_232_8 = 0, var_232_18 - 1 do
					local var_232_19 = var_232_16:GetChild(iter_232_8)

					if var_232_19.name == "split_2" or not string.find(var_232_19.name, "split") then
						var_232_19.gameObject:SetActive(true)
					else
						var_232_19.gameObject:SetActive(false)
					end
				end
			end

			local var_232_20 = 0.001

			if var_232_17 <= arg_229_1.time_ and arg_229_1.time_ < var_232_17 + var_232_20 then
				local var_232_21 = (arg_229_1.time_ - var_232_17) / var_232_20
				local var_232_22 = Vector3.New(-489.8, -360, -319.3)

				var_232_16.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047, var_232_22, var_232_21)
			end

			if arg_229_1.time_ >= var_232_17 + var_232_20 and arg_229_1.time_ < var_232_17 + var_232_20 + arg_232_0 then
				var_232_16.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_232_23 = 0
			local var_232_24 = 0.9

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_25 = arg_229_1:FormatText(StoryNameCfg[1296].name)

				arg_229_1.leftNameTxt_.text = var_232_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_26 = arg_229_1:GetWordFromCfg(926011056)
				local var_232_27 = arg_229_1:FormatText(var_232_26.content)

				arg_229_1.text_.text = var_232_27

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_28 = 36
				local var_232_29 = utf8.len(var_232_27)
				local var_232_30 = var_232_28 <= 0 and var_232_24 or var_232_24 * (var_232_29 / var_232_28)

				if var_232_30 > 0 and var_232_24 < var_232_30 then
					arg_229_1.talkMaxDuration = var_232_30

					if var_232_30 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_30 + var_232_23
					end
				end

				arg_229_1.text_.text = var_232_27
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011056", "story_v_out_926011.awb") ~= 0 then
					local var_232_31 = manager.audio:GetVoiceLength("story_v_out_926011", "926011056", "story_v_out_926011.awb") / 1000

					if var_232_31 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_31 + var_232_23
					end

					if var_232_26.prefab_name ~= "" and arg_229_1.actors_[var_232_26.prefab_name] ~= nil then
						local var_232_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_26.prefab_name].transform, "story_v_out_926011", "926011056", "story_v_out_926011.awb")

						arg_229_1:RecordAudio("926011056", var_232_32)
						arg_229_1:RecordAudio("926011056", var_232_32)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_926011", "926011056", "story_v_out_926011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_926011", "926011056", "story_v_out_926011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_33 = math.max(var_232_24, arg_229_1.talkMaxDuration)

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_33 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_23) / var_232_33

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_23 + var_232_33 and arg_229_1.time_ < var_232_23 + var_232_33 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play926011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926011057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play926011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1047"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1047 == nil then
				arg_233_1.var_.actorSpriteComps1047 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps1047 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 0.5, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1047 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1047 = nil
			end

			local var_236_8 = arg_233_1.actors_["1047"].transform
			local var_236_9 = 0

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047 = var_236_8.localPosition
				var_236_8.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1047", 7)

				local var_236_10 = var_236_8.childCount

				for iter_236_4 = 0, var_236_10 - 1 do
					local var_236_11 = var_236_8:GetChild(iter_236_4)

					if var_236_11.name == "" or not string.find(var_236_11.name, "split") then
						var_236_11.gameObject:SetActive(true)
					else
						var_236_11.gameObject:SetActive(false)
					end
				end
			end

			local var_236_12 = 0.001

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_12 then
				local var_236_13 = (arg_233_1.time_ - var_236_9) / var_236_12
				local var_236_14 = Vector3.New(0, -2000, 0)

				var_236_8.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047, var_236_14, var_236_13)
			end

			if arg_233_1.time_ >= var_236_9 + var_236_12 and arg_233_1.time_ < var_236_9 + var_236_12 + arg_236_0 then
				var_236_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_236_15 = arg_233_1.actors_["10102"].transform
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.var_.moveOldPos10102 = var_236_15.localPosition
				var_236_15.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10102", 7)

				local var_236_17 = var_236_15.childCount

				for iter_236_5 = 0, var_236_17 - 1 do
					local var_236_18 = var_236_15:GetChild(iter_236_5)

					if var_236_18.name == "" or not string.find(var_236_18.name, "split") then
						var_236_18.gameObject:SetActive(true)
					else
						var_236_18.gameObject:SetActive(false)
					end
				end
			end

			local var_236_19 = 0.001

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_19 then
				local var_236_20 = (arg_233_1.time_ - var_236_16) / var_236_19
				local var_236_21 = Vector3.New(0, -2000, 0)

				var_236_15.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10102, var_236_21, var_236_20)
			end

			if arg_233_1.time_ >= var_236_16 + var_236_19 and arg_233_1.time_ < var_236_16 + var_236_19 + arg_236_0 then
				var_236_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_236_22 = 0
			local var_236_23 = 0.95

			if var_236_22 < arg_233_1.time_ and arg_233_1.time_ <= var_236_22 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_24 = arg_233_1:GetWordFromCfg(926011057)
				local var_236_25 = arg_233_1:FormatText(var_236_24.content)

				arg_233_1.text_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_26 = 38
				local var_236_27 = utf8.len(var_236_25)
				local var_236_28 = var_236_26 <= 0 and var_236_23 or var_236_23 * (var_236_27 / var_236_26)

				if var_236_28 > 0 and var_236_23 < var_236_28 then
					arg_233_1.talkMaxDuration = var_236_28

					if var_236_28 + var_236_22 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_28 + var_236_22
					end
				end

				arg_233_1.text_.text = var_236_25
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_29 = math.max(var_236_23, arg_233_1.talkMaxDuration)

			if var_236_22 <= arg_233_1.time_ and arg_233_1.time_ < var_236_22 + var_236_29 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_22) / var_236_29

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_22 + var_236_29 and arg_233_1.time_ < var_236_22 + var_236_29 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play926011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926011058
		arg_237_1.duration_ = 4.87

		local var_237_0 = {
			zh = 4.866,
			ja = 4.7
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play926011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1047"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps1047 == nil then
				arg_237_1.var_.actorSpriteComps1047 = var_240_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.actorSpriteComps1047 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								local var_240_4 = Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor1.r, var_240_3)
								local var_240_5 = Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor1.g, var_240_3)
								local var_240_6 = Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor1.b, var_240_3)

								iter_240_1.color = Color.New(var_240_4, var_240_5, var_240_6)
							else
								local var_240_7 = Mathf.Lerp(iter_240_1.color.r, 1, var_240_3)

								iter_240_1.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps1047 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_240_3 then
						if arg_237_1.isInRecall_ then
							iter_240_3.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1047 = nil
			end

			local var_240_8 = arg_237_1.actors_["1047"].transform
			local var_240_9 = 0

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.var_.moveOldPos1047 = var_240_8.localPosition
				var_240_8.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1047", 3)

				local var_240_10 = var_240_8.childCount

				for iter_240_4 = 0, var_240_10 - 1 do
					local var_240_11 = var_240_8:GetChild(iter_240_4)

					if var_240_11.name == "" or not string.find(var_240_11.name, "split") then
						var_240_11.gameObject:SetActive(true)
					else
						var_240_11.gameObject:SetActive(false)
					end
				end
			end

			local var_240_12 = 0.001

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_12 then
				local var_240_13 = (arg_237_1.time_ - var_240_9) / var_240_12
				local var_240_14 = Vector3.New(-38.9, -360, -319.3)

				var_240_8.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1047, var_240_14, var_240_13)
			end

			if arg_237_1.time_ >= var_240_9 + var_240_12 and arg_237_1.time_ < var_240_9 + var_240_12 + arg_240_0 then
				var_240_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_240_15 = 0
			local var_240_16 = 0.6

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[1296].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(926011058)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 24
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011058", "story_v_out_926011.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011058", "story_v_out_926011.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_out_926011", "926011058", "story_v_out_926011.awb")

						arg_237_1:RecordAudio("926011058", var_240_24)
						arg_237_1:RecordAudio("926011058", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_926011", "926011058", "story_v_out_926011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_926011", "926011058", "story_v_out_926011.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play926011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926011059
		arg_241_1.duration_ = 10.63

		local var_241_0 = {
			zh = 7.066,
			ja = 10.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play926011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.8

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[1296].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(926011059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 32
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011059", "story_v_out_926011.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011059", "story_v_out_926011.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_926011", "926011059", "story_v_out_926011.awb")

						arg_241_1:RecordAudio("926011059", var_244_9)
						arg_241_1:RecordAudio("926011059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926011", "926011059", "story_v_out_926011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926011", "926011059", "story_v_out_926011.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play926011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926011060
		arg_245_1.duration_ = 8.25

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play926011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = "STblack"

			if arg_245_1.bgs_[var_248_0] == nil then
				local var_248_1 = Object.Instantiate(arg_245_1.paintGo_)

				var_248_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_248_0)
				var_248_1.name = var_248_0
				var_248_1.transform.parent = arg_245_1.stage_.transform
				var_248_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.bgs_[var_248_0] = var_248_1
			end

			local var_248_2 = 1.3

			if var_248_2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				local var_248_3 = manager.ui.mainCamera.transform.localPosition
				local var_248_4 = Vector3.New(0, 0, 10) + Vector3.New(var_248_3.x, var_248_3.y, 0)
				local var_248_5 = arg_245_1.bgs_.STblack

				var_248_5.transform.localPosition = var_248_4
				var_248_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_6 = var_248_5:GetComponent("SpriteRenderer")

				if var_248_6 and var_248_6.sprite then
					local var_248_7 = (var_248_5.transform.localPosition - var_248_3).z
					local var_248_8 = manager.ui.mainCameraCom_
					local var_248_9 = 2 * var_248_7 * Mathf.Tan(var_248_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_248_10 = var_248_9 * var_248_8.aspect
					local var_248_11 = var_248_6.sprite.bounds.size.x
					local var_248_12 = var_248_6.sprite.bounds.size.y
					local var_248_13 = var_248_10 / var_248_11
					local var_248_14 = var_248_9 / var_248_12
					local var_248_15 = var_248_14 < var_248_13 and var_248_13 or var_248_14

					var_248_5.transform.localScale = Vector3.New(var_248_15, var_248_15, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "STblack" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_16 = 1.3

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			local var_248_17 = 0.3

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_18 = 0

			if var_248_18 < arg_245_1.time_ and arg_245_1.time_ <= var_248_18 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_19 = 1.3

			if var_248_18 <= arg_245_1.time_ and arg_245_1.time_ < var_248_18 + var_248_19 then
				local var_248_20 = (arg_245_1.time_ - var_248_18) / var_248_19
				local var_248_21 = Color.New(0, 0, 0)

				var_248_21.a = Mathf.Lerp(0, 1, var_248_20)
				arg_245_1.mask_.color = var_248_21
			end

			if arg_245_1.time_ >= var_248_18 + var_248_19 and arg_245_1.time_ < var_248_18 + var_248_19 + arg_248_0 then
				local var_248_22 = Color.New(0, 0, 0)

				var_248_22.a = 1
				arg_245_1.mask_.color = var_248_22
			end

			local var_248_23 = 1.3

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_24 = 2

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_24 then
				local var_248_25 = (arg_245_1.time_ - var_248_23) / var_248_24
				local var_248_26 = Color.New(0, 0, 0)

				var_248_26.a = Mathf.Lerp(1, 0, var_248_25)
				arg_245_1.mask_.color = var_248_26
			end

			if arg_245_1.time_ >= var_248_23 + var_248_24 and arg_245_1.time_ < var_248_23 + var_248_24 + arg_248_0 then
				local var_248_27 = Color.New(0, 0, 0)
				local var_248_28 = 0

				arg_245_1.mask_.enabled = false
				var_248_27.a = var_248_28
				arg_245_1.mask_.color = var_248_27
			end

			local var_248_29 = arg_245_1.actors_["1047"]
			local var_248_30 = 1.3

			if var_248_30 < arg_245_1.time_ and arg_245_1.time_ <= var_248_30 + arg_248_0 and not isNil(var_248_29) and arg_245_1.var_.actorSpriteComps1047 == nil then
				arg_245_1.var_.actorSpriteComps1047 = var_248_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_31 = 0.2

			if var_248_30 <= arg_245_1.time_ and arg_245_1.time_ < var_248_30 + var_248_31 and not isNil(var_248_29) then
				local var_248_32 = (arg_245_1.time_ - var_248_30) / var_248_31

				if arg_245_1.var_.actorSpriteComps1047 then
					for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_248_3 then
							if arg_245_1.isInRecall_ then
								local var_248_33 = Mathf.Lerp(iter_248_3.color.r, arg_245_1.hightColor2.r, var_248_32)
								local var_248_34 = Mathf.Lerp(iter_248_3.color.g, arg_245_1.hightColor2.g, var_248_32)
								local var_248_35 = Mathf.Lerp(iter_248_3.color.b, arg_245_1.hightColor2.b, var_248_32)

								iter_248_3.color = Color.New(var_248_33, var_248_34, var_248_35)
							else
								local var_248_36 = Mathf.Lerp(iter_248_3.color.r, 0.5, var_248_32)

								iter_248_3.color = Color.New(var_248_36, var_248_36, var_248_36)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_30 + var_248_31 and arg_245_1.time_ < var_248_30 + var_248_31 + arg_248_0 and not isNil(var_248_29) and arg_245_1.var_.actorSpriteComps1047 then
				for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_248_5 then
						if arg_245_1.isInRecall_ then
							iter_248_5.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1047 = nil
			end

			local var_248_37 = arg_245_1.actors_["1047"].transform
			local var_248_38 = 1.3

			if var_248_38 < arg_245_1.time_ and arg_245_1.time_ <= var_248_38 + arg_248_0 then
				arg_245_1.var_.moveOldPos1047 = var_248_37.localPosition
				var_248_37.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1047", 7)

				local var_248_39 = var_248_37.childCount

				for iter_248_6 = 0, var_248_39 - 1 do
					local var_248_40 = var_248_37:GetChild(iter_248_6)

					if var_248_40.name == "" or not string.find(var_248_40.name, "split") then
						var_248_40.gameObject:SetActive(true)
					else
						var_248_40.gameObject:SetActive(false)
					end
				end
			end

			local var_248_41 = 0.001

			if var_248_38 <= arg_245_1.time_ and arg_245_1.time_ < var_248_38 + var_248_41 then
				local var_248_42 = (arg_245_1.time_ - var_248_38) / var_248_41
				local var_248_43 = Vector3.New(0, -2000, 0)

				var_248_37.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1047, var_248_43, var_248_42)
			end

			if arg_245_1.time_ >= var_248_38 + var_248_41 and arg_245_1.time_ < var_248_38 + var_248_41 + arg_248_0 then
				var_248_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_248_44 = 0
			local var_248_45 = 0.3

			if var_248_44 < arg_245_1.time_ and arg_245_1.time_ <= var_248_44 + arg_248_0 then
				local var_248_46 = "play"
				local var_248_47 = "music"

				arg_245_1:AudioAction(var_248_46, var_248_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_248_48 = ""
				local var_248_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_248_49 ~= "" then
					if arg_245_1.bgmTxt_.text ~= var_248_49 and arg_245_1.bgmTxt_.text ~= "" then
						if arg_245_1.bgmTxt2_.text ~= "" then
							arg_245_1.bgmTxt_.text = arg_245_1.bgmTxt2_.text
						end

						arg_245_1.bgmTxt2_.text = var_248_49

						arg_245_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_245_1.bgmTxt_.text = var_248_49
						arg_245_1.bgmTxt2_.text = var_248_49
					end

					if arg_245_1.bgmTimer then
						arg_245_1.bgmTimer:Stop()

						arg_245_1.bgmTimer = nil
					end

					if arg_245_1.settingData.show_music_name == 1 then
						arg_245_1.musicController:SetSelectedState("show")
						arg_245_1.musicAnimator_:Play("open", 0, 0)

						if arg_245_1.settingData.music_time ~= 0 then
							arg_245_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_245_1.settingData.music_time), function()
								if arg_245_1 == nil or isNil(arg_245_1.bgmTxt_) then
									return
								end

								arg_245_1.musicController:SetSelectedState("hide")
								arg_245_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_248_50 = 1.334
			local var_248_51 = 1

			if var_248_50 < arg_245_1.time_ and arg_245_1.time_ <= var_248_50 + arg_248_0 then
				local var_248_52 = "play"
				local var_248_53 = "effect"

				arg_245_1:AudioAction(var_248_52, var_248_53, "se_story_143", "se_story_143_hungry01", "")
			end

			local var_248_54 = 0.166666666666667
			local var_248_55 = 1

			if var_248_54 < arg_245_1.time_ and arg_245_1.time_ <= var_248_54 + arg_248_0 then
				local var_248_56 = "stop"
				local var_248_57 = "effect"

				arg_245_1:AudioAction(var_248_56, var_248_57, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_248_58 = 0.966666666666667
			local var_248_59 = 1

			if var_248_58 < arg_245_1.time_ and arg_245_1.time_ <= var_248_58 + arg_248_0 then
				local var_248_60 = "play"
				local var_248_61 = "effect"

				arg_245_1:AudioAction(var_248_60, var_248_61, "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_62 = 3.25
			local var_248_63 = 0.05

			if var_248_62 < arg_245_1.time_ and arg_245_1.time_ <= var_248_62 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_64 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_64:setOnUpdate(LuaHelper.FloatAction(function(arg_250_0)
					arg_245_1.dialogCg_.alpha = arg_250_0
				end))
				var_248_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_65 = arg_245_1:GetWordFromCfg(926011060)
				local var_248_66 = arg_245_1:FormatText(var_248_65.content)

				arg_245_1.text_.text = var_248_66

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_67 = 2
				local var_248_68 = utf8.len(var_248_66)
				local var_248_69 = var_248_67 <= 0 and var_248_63 or var_248_63 * (var_248_68 / var_248_67)

				if var_248_69 > 0 and var_248_63 < var_248_69 then
					arg_245_1.talkMaxDuration = var_248_69
					var_248_62 = var_248_62 + 0.3

					if var_248_69 + var_248_62 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_69 + var_248_62
					end
				end

				arg_245_1.text_.text = var_248_66
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_70 = var_248_62 + 0.3
			local var_248_71 = math.max(var_248_63, arg_245_1.talkMaxDuration)

			if var_248_70 <= arg_245_1.time_ and arg_245_1.time_ < var_248_70 + var_248_71 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_70) / var_248_71

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_70 + var_248_71 and arg_245_1.time_ < var_248_70 + var_248_71 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play926011061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 926011061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play926011062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 1

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				local var_255_2 = "play"
				local var_255_3 = "effect"

				arg_252_1:AudioAction(var_255_2, var_255_3, "se_story_143", "se_story_143_hungry02", "")
			end

			local var_255_4 = 0
			local var_255_5 = 0.1

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_6 = arg_252_1:GetWordFromCfg(926011061)
				local var_255_7 = arg_252_1:FormatText(var_255_6.content)

				arg_252_1.text_.text = var_255_7

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_8 = 4
				local var_255_9 = utf8.len(var_255_7)
				local var_255_10 = var_255_8 <= 0 and var_255_5 or var_255_5 * (var_255_9 / var_255_8)

				if var_255_10 > 0 and var_255_5 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_7
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_11 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_11 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_11

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_11 and arg_252_1.time_ < var_255_4 + var_255_11 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play926011062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 926011062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play926011063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.15

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(926011062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 6
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_8 and arg_256_1.time_ < var_259_0 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play926011063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 926011063
		arg_260_1.duration_ = 8.43

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play926011064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "I22f"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 1.43333333333333

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.I22f

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "I22f" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = 1.43333333333333

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_17 = 0.3

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_18 = 0

			if var_263_18 < arg_260_1.time_ and arg_260_1.time_ <= var_263_18 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_19 = 1.43333333333333

			if var_263_18 <= arg_260_1.time_ and arg_260_1.time_ < var_263_18 + var_263_19 then
				local var_263_20 = (arg_260_1.time_ - var_263_18) / var_263_19
				local var_263_21 = Color.New(0, 0, 0)

				var_263_21.a = Mathf.Lerp(0, 1, var_263_20)
				arg_260_1.mask_.color = var_263_21
			end

			if arg_260_1.time_ >= var_263_18 + var_263_19 and arg_260_1.time_ < var_263_18 + var_263_19 + arg_263_0 then
				local var_263_22 = Color.New(0, 0, 0)

				var_263_22.a = 1
				arg_260_1.mask_.color = var_263_22
			end

			local var_263_23 = 1.43333333333333

			if var_263_23 < arg_260_1.time_ and arg_260_1.time_ <= var_263_23 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_24 = 1.23333333333333

			if var_263_23 <= arg_260_1.time_ and arg_260_1.time_ < var_263_23 + var_263_24 then
				local var_263_25 = (arg_260_1.time_ - var_263_23) / var_263_24
				local var_263_26 = Color.New(1, 1, 1)

				var_263_26.a = Mathf.Lerp(1, 0, var_263_25)
				arg_260_1.mask_.color = var_263_26
			end

			if arg_260_1.time_ >= var_263_23 + var_263_24 and arg_260_1.time_ < var_263_23 + var_263_24 + arg_263_0 then
				local var_263_27 = Color.New(1, 1, 1)
				local var_263_28 = 0

				arg_260_1.mask_.enabled = false
				var_263_27.a = var_263_28
				arg_260_1.mask_.color = var_263_27
			end

			local var_263_29 = manager.ui.mainCamera.transform
			local var_263_30 = 1.96666666666667

			if var_263_30 < arg_260_1.time_ and arg_260_1.time_ <= var_263_30 + arg_263_0 then
				local var_263_31 = arg_260_1.var_.effect333
				local var_263_32
				local var_263_33 = var_263_29

				if not var_263_31 then
					var_263_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_263_33)
					var_263_31.name = "333"
					arg_260_1.var_.effect333 = var_263_31
				else
					var_263_31.transform:SetParent(var_263_33)
				end

				var_263_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_263_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_263_34 = manager.ui.mainCameraCom_
				local var_263_35 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_263_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_263_36 = var_263_31.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_263_37 = 15
				local var_263_38 = 2 * var_263_37 * Mathf.Tan(var_263_34.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_263_34.aspect
				local var_263_39 = 1
				local var_263_40 = 1.7777777777777777

				if var_263_40 < var_263_34.aspect then
					var_263_39 = var_263_38 / (2 * var_263_37 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_263_40)
				end

				for iter_263_2, iter_263_3 in ipairs(var_263_36) do
					local var_263_41 = iter_263_3.transform.localScale

					iter_263_3.transform.localScale = Vector3.New(var_263_41.x / var_263_35 * var_263_39, var_263_41.y / var_263_35, var_263_41.z)
				end
			end

			local var_263_42 = 1.33333333333333
			local var_263_43 = 1

			if var_263_42 < arg_260_1.time_ and arg_260_1.time_ <= var_263_42 + arg_263_0 then
				local var_263_44 = "play"
				local var_263_45 = "effect"

				arg_260_1:AudioAction(var_263_44, var_263_45, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			local var_263_46 = 0
			local var_263_47 = 1

			if var_263_46 < arg_260_1.time_ and arg_260_1.time_ <= var_263_46 + arg_263_0 then
				local var_263_48 = "stop"
				local var_263_49 = "effect"

				arg_260_1:AudioAction(var_263_48, var_263_49, "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_50 = 3.43333333333333
			local var_263_51 = 1.35

			if var_263_50 < arg_260_1.time_ and arg_260_1.time_ <= var_263_50 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_52 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_52:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_53 = arg_260_1:GetWordFromCfg(926011063)
				local var_263_54 = arg_260_1:FormatText(var_263_53.content)

				arg_260_1.text_.text = var_263_54

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_55 = 54
				local var_263_56 = utf8.len(var_263_54)
				local var_263_57 = var_263_55 <= 0 and var_263_51 or var_263_51 * (var_263_56 / var_263_55)

				if var_263_57 > 0 and var_263_51 < var_263_57 then
					arg_260_1.talkMaxDuration = var_263_57
					var_263_50 = var_263_50 + 0.3

					if var_263_57 + var_263_50 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_57 + var_263_50
					end
				end

				arg_260_1.text_.text = var_263_54
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_58 = var_263_50 + 0.3
			local var_263_59 = math.max(var_263_51, arg_260_1.talkMaxDuration)

			if var_263_58 <= arg_260_1.time_ and arg_260_1.time_ < var_263_58 + var_263_59 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_58) / var_263_59

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_58 + var_263_59 and arg_260_1.time_ < var_263_58 + var_263_59 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play926011064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 926011064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play926011065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.35

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

				local var_269_3 = arg_266_1:GetWordFromCfg(926011064)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 14
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
	Play926011065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 926011065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play926011066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.275

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(926011065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 11
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
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play926011066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 926011066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play926011067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 1.05

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(926011066)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 42
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play926011067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 926011067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play926011068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.5

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(926011067)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 20
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play926011068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 926011068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play926011069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.55

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:GetWordFromCfg(926011068)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 22
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play926011069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 926011069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play926011070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 1

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_2 = "play"
				local var_289_3 = "effect"

				arg_286_1:AudioAction(var_289_2, var_289_3, "se_story_143", "se_story_143_hungry01", "")
			end

			local var_289_4 = 0
			local var_289_5 = 1.225

			if var_289_4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(926011069)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_8 = 49
				local var_289_9 = utf8.len(var_289_7)
				local var_289_10 = var_289_8 <= 0 and var_289_5 or var_289_5 * (var_289_9 / var_289_8)

				if var_289_10 > 0 and var_289_5 < var_289_10 then
					arg_286_1.talkMaxDuration = var_289_10

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_11 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_11 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_11

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_11 and arg_286_1.time_ < var_289_4 + var_289_11 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play926011070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 926011070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play926011071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.85

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(926011070)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 34
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play926011071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 926011071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play926011072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.825

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(926011071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 33
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
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_8 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_8 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_8

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_8 and arg_294_1.time_ < var_297_0 + var_297_8 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play926011072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 926011072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play926011073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.35

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(926011072)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 14
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play926011073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 926011073
		arg_302_1.duration_ = 6

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play926011074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				local var_305_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_2 then
					var_305_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_2.radialBlurScale = 0.687
					var_305_2.radialBlurGradient = 1
					var_305_2.radialBlurIntensity = 1

					if var_305_0 then
						var_305_2.radialBlurTarget = var_305_0.transform
					end
				end
			end

			local var_305_3 = 1

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_3 then
				local var_305_4 = (arg_302_1.time_ - var_305_1) / var_305_3
				local var_305_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_5 then
					var_305_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_5.radialBlurScale = Mathf.Lerp(0.687, 0, var_305_4)
					var_305_5.radialBlurGradient = Mathf.Lerp(1, 1, var_305_4)
					var_305_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_305_4)
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_3 and arg_302_1.time_ < var_305_1 + var_305_3 + arg_305_0 then
				local var_305_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_6 then
					var_305_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_6.radialBlurScale = 0
					var_305_6.radialBlurGradient = 1
					var_305_6.radialBlurIntensity = 1
				end
			end

			local var_305_7
			local var_305_8 = 1.7

			if var_305_8 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				local var_305_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_9 then
					var_305_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_9.radialBlurScale = 0
					var_305_9.radialBlurGradient = 1
					var_305_9.radialBlurIntensity = 1

					if var_305_7 then
						var_305_9.radialBlurTarget = var_305_7.transform
					end
				end
			end

			local var_305_10 = 0.8

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_10 then
				local var_305_11 = (arg_302_1.time_ - var_305_8) / var_305_10
				local var_305_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_12 then
					var_305_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_12.radialBlurScale = Mathf.Lerp(0, 0, var_305_11)
					var_305_12.radialBlurGradient = Mathf.Lerp(1, 1, var_305_11)
					var_305_12.radialBlurIntensity = Mathf.Lerp(1, 1, var_305_11)
				end
			end

			if arg_302_1.time_ >= var_305_8 + var_305_10 and arg_302_1.time_ < var_305_8 + var_305_10 + arg_305_0 then
				local var_305_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_13 then
					var_305_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_13.radialBlurScale = 0
					var_305_13.radialBlurGradient = 1
					var_305_13.radialBlurIntensity = 1
				end
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			local var_305_15 = 2.1

			if arg_302_1.time_ >= var_305_14 + var_305_15 and arg_302_1.time_ < var_305_14 + var_305_15 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_16 = "128404"

			if arg_302_1.actors_[var_305_16] == nil then
				local var_305_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_305_17) then
					local var_305_18 = Object.Instantiate(var_305_17, arg_302_1.canvasGo_.transform)

					var_305_18.transform:SetSiblingIndex(1)

					var_305_18.name = var_305_16
					var_305_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_302_1.actors_[var_305_16] = var_305_18

					local var_305_19 = var_305_18:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_302_1.isInRecall_ then
						for iter_305_0, iter_305_1 in ipairs(var_305_19) do
							iter_305_1.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_305_20 = arg_302_1.actors_["128404"].transform
			local var_305_21 = 0

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1.var_.moveOldPos128404 = var_305_20.localPosition
				var_305_20.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("128404", 7)

				local var_305_22 = var_305_20.childCount

				for iter_305_2 = 0, var_305_22 - 1 do
					local var_305_23 = var_305_20:GetChild(iter_305_2)

					if var_305_23.name == "split_4" or not string.find(var_305_23.name, "split") then
						var_305_23.gameObject:SetActive(true)
					else
						var_305_23.gameObject:SetActive(false)
					end
				end
			end

			local var_305_24 = 0.001

			if var_305_21 <= arg_302_1.time_ and arg_302_1.time_ < var_305_21 + var_305_24 then
				local var_305_25 = (arg_302_1.time_ - var_305_21) / var_305_24
				local var_305_26 = Vector3.New(0, -2000, 0)

				var_305_20.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos128404, var_305_26, var_305_25)
			end

			if arg_302_1.time_ >= var_305_21 + var_305_24 and arg_302_1.time_ < var_305_21 + var_305_24 + arg_305_0 then
				var_305_20.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_27 = 1
			local var_305_28 = 0.95

			if var_305_27 < arg_302_1.time_ and arg_302_1.time_ <= var_305_27 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_29 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_29:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_30 = arg_302_1:GetWordFromCfg(926011073)
				local var_305_31 = arg_302_1:FormatText(var_305_30.content)

				arg_302_1.text_.text = var_305_31

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_32 = 38
				local var_305_33 = utf8.len(var_305_31)
				local var_305_34 = var_305_32 <= 0 and var_305_28 or var_305_28 * (var_305_33 / var_305_32)

				if var_305_34 > 0 and var_305_28 < var_305_34 then
					arg_302_1.talkMaxDuration = var_305_34
					var_305_27 = var_305_27 + 0.3

					if var_305_34 + var_305_27 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_34 + var_305_27
					end
				end

				arg_302_1.text_.text = var_305_31
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_35 = var_305_27 + 0.3
			local var_305_36 = math.max(var_305_28, arg_302_1.talkMaxDuration)

			if var_305_35 <= arg_302_1.time_ and arg_302_1.time_ < var_305_35 + var_305_36 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_35) / var_305_36

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_35 + var_305_36 and arg_302_1.time_ < var_305_35 + var_305_36 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play926011074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 926011074
		arg_308_1.duration_ = 2.33

		local var_308_0 = {
			zh = 1.881526200798,
			ja = 2.33333333333333
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play926011075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["128404"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps128404 == nil then
				arg_308_1.var_.actorSpriteComps128404 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps128404 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps128404 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps128404 = nil
			end

			local var_311_8 = arg_308_1.actors_["128404"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos128404 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("128404", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_5" or not string.find(var_311_11.name, "split") then
						var_311_11.gameObject:SetActive(true)
					else
						var_311_11.gameObject:SetActive(false)
					end
				end
			end

			local var_311_12 = 0.233333333333333

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(-31.8, -406.9, -1238)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos128404, var_311_14, var_311_13)
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(-31.8, -406.9, -1238)
			end

			local var_311_15
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				local var_311_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_17 then
					var_311_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_17.radialBlurScale = 0.687
					var_311_17.radialBlurGradient = 1
					var_311_17.radialBlurIntensity = 1

					if var_311_15 then
						var_311_17.radialBlurTarget = var_311_15.transform
					end
				end
			end

			local var_311_18 = 1

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_18 then
				local var_311_19 = (arg_308_1.time_ - var_311_16) / var_311_18
				local var_311_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_20 then
					var_311_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_20.radialBlurScale = Mathf.Lerp(0.687, 0, var_311_19)
					var_311_20.radialBlurGradient = Mathf.Lerp(1, 1, var_311_19)
					var_311_20.radialBlurIntensity = Mathf.Lerp(1, 1, var_311_19)
				end
			end

			if arg_308_1.time_ >= var_311_16 + var_311_18 and arg_308_1.time_ < var_311_16 + var_311_18 + arg_311_0 then
				local var_311_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_21 then
					var_311_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_21.radialBlurScale = 0
					var_311_21.radialBlurGradient = 1
					var_311_21.radialBlurIntensity = 1
				end
			end

			local var_311_22
			local var_311_23 = 1.08152620079927

			if var_311_23 < arg_308_1.time_ and arg_308_1.time_ <= var_311_23 + arg_311_0 then
				local var_311_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_24 then
					var_311_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_24.radialBlurScale = 0
					var_311_24.radialBlurGradient = 1
					var_311_24.radialBlurIntensity = 1

					if var_311_22 then
						var_311_24.radialBlurTarget = var_311_22.transform
					end
				end
			end

			local var_311_25 = 0.8

			if var_311_23 <= arg_308_1.time_ and arg_308_1.time_ < var_311_23 + var_311_25 then
				local var_311_26 = (arg_308_1.time_ - var_311_23) / var_311_25
				local var_311_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_27 then
					var_311_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_27.radialBlurScale = Mathf.Lerp(0, 0, var_311_26)
					var_311_27.radialBlurGradient = Mathf.Lerp(1, 1, var_311_26)
					var_311_27.radialBlurIntensity = Mathf.Lerp(1, 1, var_311_26)
				end
			end

			if arg_308_1.time_ >= var_311_23 + var_311_25 and arg_308_1.time_ < var_311_23 + var_311_25 + arg_311_0 then
				local var_311_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_28 then
					var_311_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_28.radialBlurScale = 0
					var_311_28.radialBlurGradient = 1
					var_311_28.radialBlurIntensity = 1
				end
			end

			local var_311_29 = 0

			if var_311_29 < arg_308_1.time_ and arg_308_1.time_ <= var_311_29 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			local var_311_30 = 0.8

			if arg_308_1.time_ >= var_311_29 + var_311_30 and arg_308_1.time_ < var_311_29 + var_311_30 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_31 = manager.ui.mainCamera.transform
			local var_311_32 = 0.0666666666666667

			if var_311_32 < arg_308_1.time_ and arg_308_1.time_ <= var_311_32 + arg_311_0 then
				local var_311_33 = arg_308_1.var_.effect1234
				local var_311_34
				local var_311_35 = var_311_31

				if not var_311_33 then
					var_311_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_311_35)
					var_311_33.name = "1234"
					arg_308_1.var_.effect1234 = var_311_33
				else
					var_311_33.transform:SetParent(var_311_35)
				end

				var_311_33.transform.localPosition = Vector3.New(0, 0, -1.05)
				var_311_33.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_311_36 = manager.ui.mainCameraCom_
				local var_311_37 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_311_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_311_38 = var_311_33.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_311_39 = 15
				local var_311_40 = 2 * var_311_39 * Mathf.Tan(var_311_36.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_311_36.aspect
				local var_311_41 = 1
				local var_311_42 = 1.7777777777777777

				if var_311_42 < var_311_36.aspect then
					var_311_41 = var_311_40 / (2 * var_311_39 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_311_42)
				end

				for iter_311_5, iter_311_6 in ipairs(var_311_38) do
					local var_311_43 = iter_311_6.transform.localScale

					iter_311_6.transform.localScale = Vector3.New(var_311_43.x / var_311_37 * var_311_41, var_311_43.y / var_311_37, var_311_43.z)
				end
			end

			local var_311_44 = 0
			local var_311_45 = 1

			if var_311_44 < arg_308_1.time_ and arg_308_1.time_ <= var_311_44 + arg_311_0 then
				local var_311_46 = "play"
				local var_311_47 = "effect"

				arg_308_1:AudioAction(var_311_46, var_311_47, "se_story_143", "se_story_143_foley_cloth02", "")
			end

			local var_311_48 = 0.433333333333333
			local var_311_49 = 0.1

			if var_311_48 < arg_308_1.time_ and arg_308_1.time_ <= var_311_48 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_50 = arg_308_1:FormatText(StoryNameCfg[6].name)

				arg_308_1.leftNameTxt_.text = var_311_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_51 = arg_308_1:GetWordFromCfg(926011074)
				local var_311_52 = arg_308_1:FormatText(var_311_51.content)

				arg_308_1.text_.text = var_311_52

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_53 = 4
				local var_311_54 = utf8.len(var_311_52)
				local var_311_55 = var_311_53 <= 0 and var_311_49 or var_311_49 * (var_311_54 / var_311_53)

				if var_311_55 > 0 and var_311_49 < var_311_55 then
					arg_308_1.talkMaxDuration = var_311_55

					if var_311_55 + var_311_48 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_55 + var_311_48
					end
				end

				arg_308_1.text_.text = var_311_52
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011074", "story_v_out_926011.awb") ~= 0 then
					local var_311_56 = manager.audio:GetVoiceLength("story_v_out_926011", "926011074", "story_v_out_926011.awb") / 1000

					if var_311_56 + var_311_48 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_56 + var_311_48
					end

					if var_311_51.prefab_name ~= "" and arg_308_1.actors_[var_311_51.prefab_name] ~= nil then
						local var_311_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_51.prefab_name].transform, "story_v_out_926011", "926011074", "story_v_out_926011.awb")

						arg_308_1:RecordAudio("926011074", var_311_57)
						arg_308_1:RecordAudio("926011074", var_311_57)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_926011", "926011074", "story_v_out_926011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_926011", "926011074", "story_v_out_926011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_58 = math.max(var_311_49, arg_308_1.talkMaxDuration)

			if var_311_48 <= arg_308_1.time_ and arg_308_1.time_ < var_311_48 + var_311_58 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_48) / var_311_58

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_48 + var_311_58 and arg_308_1.time_ < var_311_48 + var_311_58 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.233333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.469,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -500, 6000),
					endPos = Vector3.New(-31.8, -406.9, -1238),
					easeType = LeanTweenType.easeInOutBack
				}
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play926011075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 926011075
		arg_312_1.duration_ = 7.53

		local var_312_0 = {
			zh = 7.233,
			ja = 7.533
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play926011076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 1.76666666666667

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				local var_315_1 = manager.ui.mainCamera.transform.localPosition
				local var_315_2 = Vector3.New(0, 0, 10) + Vector3.New(var_315_1.x, var_315_1.y, 0)
				local var_315_3 = arg_312_1.bgs_.I22f

				var_315_3.transform.localPosition = var_315_2
				var_315_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_4 = var_315_3:GetComponent("SpriteRenderer")

				if var_315_4 and var_315_4.sprite then
					local var_315_5 = (var_315_3.transform.localPosition - var_315_1).z
					local var_315_6 = manager.ui.mainCameraCom_
					local var_315_7 = 2 * var_315_5 * Mathf.Tan(var_315_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_315_8 = var_315_7 * var_315_6.aspect
					local var_315_9 = var_315_4.sprite.bounds.size.x
					local var_315_10 = var_315_4.sprite.bounds.size.y
					local var_315_11 = var_315_8 / var_315_9
					local var_315_12 = var_315_7 / var_315_10
					local var_315_13 = var_315_12 < var_315_11 and var_315_11 or var_315_12

					var_315_3.transform.localScale = Vector3.New(var_315_13, var_315_13, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "I22f" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_14 = 1.76666666666667

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			local var_315_15 = 0.3

			if arg_312_1.time_ >= var_315_14 + var_315_15 and arg_312_1.time_ < var_315_14 + var_315_15 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_17 = 1.76666666666667

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Color.New(0, 0, 0)

				var_315_19.a = Mathf.Lerp(0, 1, var_315_18)
				arg_312_1.mask_.color = var_315_19
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				local var_315_20 = Color.New(0, 0, 0)

				var_315_20.a = 1
				arg_312_1.mask_.color = var_315_20
			end

			local var_315_21 = 1.76666666666667

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_22 = 1.83333333333333

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				local var_315_23 = (arg_312_1.time_ - var_315_21) / var_315_22
				local var_315_24 = Color.New(0, 0, 0)

				var_315_24.a = Mathf.Lerp(1, 0, var_315_23)
				arg_312_1.mask_.color = var_315_24
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				local var_315_25 = Color.New(0, 0, 0)
				local var_315_26 = 0

				arg_312_1.mask_.enabled = false
				var_315_25.a = var_315_26
				arg_312_1.mask_.color = var_315_25
			end

			local var_315_27 = arg_312_1.actors_["128404"].transform
			local var_315_28 = 3.16666666666667

			if var_315_28 < arg_312_1.time_ and arg_312_1.time_ <= var_315_28 + arg_315_0 then
				arg_312_1.var_.moveOldPos128404 = var_315_27.localPosition
				var_315_27.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("128404", 3)

				local var_315_29 = var_315_27.childCount

				for iter_315_2 = 0, var_315_29 - 1 do
					local var_315_30 = var_315_27:GetChild(iter_315_2)

					if var_315_30.name == "split_4" or not string.find(var_315_30.name, "split") then
						var_315_30.gameObject:SetActive(true)
					else
						var_315_30.gameObject:SetActive(false)
					end
				end
			end

			local var_315_31 = 0.001

			if var_315_28 <= arg_312_1.time_ and arg_312_1.time_ < var_315_28 + var_315_31 then
				local var_315_32 = (arg_312_1.time_ - var_315_28) / var_315_31
				local var_315_33 = Vector3.New(-16.1, -362, -375)

				var_315_27.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos128404, var_315_33, var_315_32)
			end

			if arg_312_1.time_ >= var_315_28 + var_315_31 and arg_312_1.time_ < var_315_28 + var_315_31 + arg_315_0 then
				var_315_27.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_315_34 = arg_312_1.actors_["128404"]
			local var_315_35 = 3.16666666666667

			if var_315_35 < arg_312_1.time_ and arg_312_1.time_ <= var_315_35 + arg_315_0 then
				local var_315_36 = var_315_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_315_36 then
					arg_312_1.var_.alphaOldValue128404 = var_315_36.alpha
					arg_312_1.var_.characterEffect128404 = var_315_36
				end

				arg_312_1.var_.alphaOldValue128404 = 0
			end

			local var_315_37 = 0.2

			if var_315_35 <= arg_312_1.time_ and arg_312_1.time_ < var_315_35 + var_315_37 then
				local var_315_38 = (arg_312_1.time_ - var_315_35) / var_315_37
				local var_315_39 = Mathf.Lerp(arg_312_1.var_.alphaOldValue128404, 1, var_315_38)

				if arg_312_1.var_.characterEffect128404 then
					arg_312_1.var_.characterEffect128404.alpha = var_315_39
				end
			end

			if arg_312_1.time_ >= var_315_35 + var_315_37 and arg_312_1.time_ < var_315_35 + var_315_37 + arg_315_0 and arg_312_1.var_.characterEffect128404 then
				arg_312_1.var_.characterEffect128404.alpha = 1
			end

			local var_315_40 = arg_312_1.actors_["128404"].transform
			local var_315_41 = 1.75

			if var_315_41 < arg_312_1.time_ and arg_312_1.time_ <= var_315_41 + arg_315_0 then
				arg_312_1.var_.moveOldPos128404 = var_315_40.localPosition
				var_315_40.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("128404", 7)

				local var_315_42 = var_315_40.childCount

				for iter_315_3 = 0, var_315_42 - 1 do
					local var_315_43 = var_315_40:GetChild(iter_315_3)

					if var_315_43.name == "split_4" or not string.find(var_315_43.name, "split") then
						var_315_43.gameObject:SetActive(true)
					else
						var_315_43.gameObject:SetActive(false)
					end
				end
			end

			local var_315_44 = 0.001

			if var_315_41 <= arg_312_1.time_ and arg_312_1.time_ < var_315_41 + var_315_44 then
				local var_315_45 = (arg_312_1.time_ - var_315_41) / var_315_44
				local var_315_46 = Vector3.New(0, -2000, 0)

				var_315_40.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos128404, var_315_46, var_315_45)
			end

			if arg_312_1.time_ >= var_315_41 + var_315_44 and arg_312_1.time_ < var_315_41 + var_315_44 + arg_315_0 then
				var_315_40.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_47 = manager.ui.mainCamera.transform
			local var_315_48 = 1.76666666666667

			if var_315_48 < arg_312_1.time_ and arg_312_1.time_ <= var_315_48 + arg_315_0 then
				local var_315_49 = arg_312_1.var_.effect1234

				if var_315_49 then
					Object.Destroy(var_315_49)

					arg_312_1.var_.effect1234 = nil
				end
			end

			local var_315_50 = 0
			local var_315_51 = 0.3

			if var_315_50 < arg_312_1.time_ and arg_312_1.time_ <= var_315_50 + arg_315_0 then
				local var_315_52 = "play"
				local var_315_53 = "music"

				arg_312_1:AudioAction(var_315_52, var_315_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_315_54 = ""
				local var_315_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_315_55 ~= "" then
					if arg_312_1.bgmTxt_.text ~= var_315_55 and arg_312_1.bgmTxt_.text ~= "" then
						if arg_312_1.bgmTxt2_.text ~= "" then
							arg_312_1.bgmTxt_.text = arg_312_1.bgmTxt2_.text
						end

						arg_312_1.bgmTxt2_.text = var_315_55

						arg_312_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_312_1.bgmTxt_.text = var_315_55
						arg_312_1.bgmTxt2_.text = var_315_55
					end

					if arg_312_1.bgmTimer then
						arg_312_1.bgmTimer:Stop()

						arg_312_1.bgmTimer = nil
					end

					if arg_312_1.settingData.show_music_name == 1 then
						arg_312_1.musicController:SetSelectedState("show")
						arg_312_1.musicAnimator_:Play("open", 0, 0)

						if arg_312_1.settingData.music_time ~= 0 then
							arg_312_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_312_1.settingData.music_time), function()
								if arg_312_1 == nil or isNil(arg_312_1.bgmTxt_) then
									return
								end

								arg_312_1.musicController:SetSelectedState("hide")
								arg_312_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_315_56 = 0.6
			local var_315_57 = 1

			if var_315_56 < arg_312_1.time_ and arg_312_1.time_ <= var_315_56 + arg_315_0 then
				local var_315_58 = "play"
				local var_315_59 = "music"

				arg_312_1:AudioAction(var_315_58, var_315_59, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_315_60 = ""
				local var_315_61 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_315_61 ~= "" then
					if arg_312_1.bgmTxt_.text ~= var_315_61 and arg_312_1.bgmTxt_.text ~= "" then
						if arg_312_1.bgmTxt2_.text ~= "" then
							arg_312_1.bgmTxt_.text = arg_312_1.bgmTxt2_.text
						end

						arg_312_1.bgmTxt2_.text = var_315_61

						arg_312_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_312_1.bgmTxt_.text = var_315_61
						arg_312_1.bgmTxt2_.text = var_315_61
					end

					if arg_312_1.bgmTimer then
						arg_312_1.bgmTimer:Stop()

						arg_312_1.bgmTimer = nil
					end

					if arg_312_1.settingData.show_music_name == 1 then
						arg_312_1.musicController:SetSelectedState("show")
						arg_312_1.musicAnimator_:Play("open", 0, 0)

						if arg_312_1.settingData.music_time ~= 0 then
							arg_312_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_312_1.settingData.music_time), function()
								if arg_312_1 == nil or isNil(arg_312_1.bgmTxt_) then
									return
								end

								arg_312_1.musicController:SetSelectedState("hide")
								arg_312_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_62 = 3.6
			local var_315_63 = 0.375

			if var_315_62 < arg_312_1.time_ and arg_312_1.time_ <= var_315_62 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_64 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_64:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_312_1.dialogCg_.alpha = arg_318_0
				end))
				var_315_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_65 = arg_312_1:FormatText(StoryNameCfg[6].name)

				arg_312_1.leftNameTxt_.text = var_315_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_66 = arg_312_1:GetWordFromCfg(926011075)
				local var_315_67 = arg_312_1:FormatText(var_315_66.content)

				arg_312_1.text_.text = var_315_67

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_68 = 15
				local var_315_69 = utf8.len(var_315_67)
				local var_315_70 = var_315_68 <= 0 and var_315_63 or var_315_63 * (var_315_69 / var_315_68)

				if var_315_70 > 0 and var_315_63 < var_315_70 then
					arg_312_1.talkMaxDuration = var_315_70
					var_315_62 = var_315_62 + 0.3

					if var_315_70 + var_315_62 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_70 + var_315_62
					end
				end

				arg_312_1.text_.text = var_315_67
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011075", "story_v_out_926011.awb") ~= 0 then
					local var_315_71 = manager.audio:GetVoiceLength("story_v_out_926011", "926011075", "story_v_out_926011.awb") / 1000

					if var_315_71 + var_315_62 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_71 + var_315_62
					end

					if var_315_66.prefab_name ~= "" and arg_312_1.actors_[var_315_66.prefab_name] ~= nil then
						local var_315_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_66.prefab_name].transform, "story_v_out_926011", "926011075", "story_v_out_926011.awb")

						arg_312_1:RecordAudio("926011075", var_315_72)
						arg_312_1:RecordAudio("926011075", var_315_72)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_926011", "926011075", "story_v_out_926011.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_926011", "926011075", "story_v_out_926011.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_73 = var_315_62 + 0.3
			local var_315_74 = math.max(var_315_63, arg_312_1.talkMaxDuration)

			if var_315_73 <= arg_312_1.time_ and arg_312_1.time_ < var_315_73 + var_315_74 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_73) / var_315_74

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_73 + var_315_74 and arg_312_1.time_ < var_315_73 + var_315_74 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.75,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play926011076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 926011076
		arg_320_1.duration_ = 6.07

		local var_320_0 = {
			zh = 5.366,
			ja = 6.066
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play926011077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.775

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[6].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_3 = arg_320_1:GetWordFromCfg(926011076)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 31
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011076", "story_v_out_926011.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011076", "story_v_out_926011.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_926011", "926011076", "story_v_out_926011.awb")

						arg_320_1:RecordAudio("926011076", var_323_9)
						arg_320_1:RecordAudio("926011076", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_926011", "926011076", "story_v_out_926011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_926011", "926011076", "story_v_out_926011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play926011077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 926011077
		arg_324_1.duration_ = 6.57

		local var_324_0 = {
			zh = 4.666,
			ja = 6.566
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play926011078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["128404"].transform
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.var_.moveOldPos128404 = var_327_0.localPosition
				var_327_0.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("128404", 3)

				local var_327_2 = var_327_0.childCount

				for iter_327_0 = 0, var_327_2 - 1 do
					local var_327_3 = var_327_0:GetChild(iter_327_0)

					if var_327_3.name == "" or not string.find(var_327_3.name, "split") then
						var_327_3.gameObject:SetActive(true)
					else
						var_327_3.gameObject:SetActive(false)
					end
				end
			end

			local var_327_4 = 0.001

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_4 then
				local var_327_5 = (arg_324_1.time_ - var_327_1) / var_327_4
				local var_327_6 = Vector3.New(-16.1, -362, -375)

				var_327_0.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos128404, var_327_6, var_327_5)
			end

			if arg_324_1.time_ >= var_327_1 + var_327_4 and arg_324_1.time_ < var_327_1 + var_327_4 + arg_327_0 then
				var_327_0.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_327_7 = 0
			local var_327_8 = 0.625

			if var_327_7 < arg_324_1.time_ and arg_324_1.time_ <= var_327_7 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_9 = arg_324_1:FormatText(StoryNameCfg[6].name)

				arg_324_1.leftNameTxt_.text = var_327_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_10 = arg_324_1:GetWordFromCfg(926011077)
				local var_327_11 = arg_324_1:FormatText(var_327_10.content)

				arg_324_1.text_.text = var_327_11

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_12 = 25
				local var_327_13 = utf8.len(var_327_11)
				local var_327_14 = var_327_12 <= 0 and var_327_8 or var_327_8 * (var_327_13 / var_327_12)

				if var_327_14 > 0 and var_327_8 < var_327_14 then
					arg_324_1.talkMaxDuration = var_327_14

					if var_327_14 + var_327_7 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_7
					end
				end

				arg_324_1.text_.text = var_327_11
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011077", "story_v_out_926011.awb") ~= 0 then
					local var_327_15 = manager.audio:GetVoiceLength("story_v_out_926011", "926011077", "story_v_out_926011.awb") / 1000

					if var_327_15 + var_327_7 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_15 + var_327_7
					end

					if var_327_10.prefab_name ~= "" and arg_324_1.actors_[var_327_10.prefab_name] ~= nil then
						local var_327_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_10.prefab_name].transform, "story_v_out_926011", "926011077", "story_v_out_926011.awb")

						arg_324_1:RecordAudio("926011077", var_327_16)
						arg_324_1:RecordAudio("926011077", var_327_16)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_926011", "926011077", "story_v_out_926011.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_926011", "926011077", "story_v_out_926011.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_17 = math.max(var_327_8, arg_324_1.talkMaxDuration)

			if var_327_7 <= arg_324_1.time_ and arg_324_1.time_ < var_327_7 + var_327_17 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_7) / var_327_17

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_7 + var_327_17 and arg_324_1.time_ < var_327_7 + var_327_17 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
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

		arg_324_1:InitPlayNodeList()
	end,
	Play926011078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 926011078
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play926011079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["128404"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps128404 == nil then
				arg_328_1.var_.actorSpriteComps128404 = var_331_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.actorSpriteComps128404 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								local var_331_4 = Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, var_331_3)
								local var_331_5 = Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, var_331_3)
								local var_331_6 = Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, var_331_3)

								iter_331_1.color = Color.New(var_331_4, var_331_5, var_331_6)
							else
								local var_331_7 = Mathf.Lerp(iter_331_1.color.r, 0.5, var_331_3)

								iter_331_1.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps128404 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_331_3 then
						if arg_328_1.isInRecall_ then
							iter_331_3.color = arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_331_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_328_1.var_.actorSpriteComps128404 = nil
			end

			local var_331_8 = 0
			local var_331_9 = 0.225

			if var_331_8 < arg_328_1.time_ and arg_328_1.time_ <= var_331_8 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_10 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_11 = arg_328_1:GetWordFromCfg(926011078)
				local var_331_12 = arg_328_1:FormatText(var_331_11.content)

				arg_328_1.text_.text = var_331_12

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_13 = 9
				local var_331_14 = utf8.len(var_331_12)
				local var_331_15 = var_331_13 <= 0 and var_331_9 or var_331_9 * (var_331_14 / var_331_13)

				if var_331_15 > 0 and var_331_9 < var_331_15 then
					arg_328_1.talkMaxDuration = var_331_15

					if var_331_15 + var_331_8 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_15 + var_331_8
					end
				end

				arg_328_1.text_.text = var_331_12
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_9, arg_328_1.talkMaxDuration)

			if var_331_8 <= arg_328_1.time_ and arg_328_1.time_ < var_331_8 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_8) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_8 + var_331_16 and arg_328_1.time_ < var_331_8 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play926011079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 926011079
		arg_332_1.duration_ = 7.1

		local var_332_0 = {
			zh = 5.3,
			ja = 7.1
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play926011080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["128404"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps128404 == nil then
				arg_332_1.var_.actorSpriteComps128404 = var_335_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.actorSpriteComps128404 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								local var_335_4 = Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor1.r, var_335_3)
								local var_335_5 = Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor1.g, var_335_3)
								local var_335_6 = Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor1.b, var_335_3)

								iter_335_1.color = Color.New(var_335_4, var_335_5, var_335_6)
							else
								local var_335_7 = Mathf.Lerp(iter_335_1.color.r, 1, var_335_3)

								iter_335_1.color = Color.New(var_335_7, var_335_7, var_335_7)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps128404 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_335_3 then
						if arg_332_1.isInRecall_ then
							iter_335_3.color = arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_335_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps128404 = nil
			end

			local var_335_8 = 0
			local var_335_9 = 0.75

			if var_335_8 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_10 = arg_332_1:FormatText(StoryNameCfg[6].name)

				arg_332_1.leftNameTxt_.text = var_335_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_11 = arg_332_1:GetWordFromCfg(926011079)
				local var_335_12 = arg_332_1:FormatText(var_335_11.content)

				arg_332_1.text_.text = var_335_12

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 30
				local var_335_14 = utf8.len(var_335_12)
				local var_335_15 = var_335_13 <= 0 and var_335_9 or var_335_9 * (var_335_14 / var_335_13)

				if var_335_15 > 0 and var_335_9 < var_335_15 then
					arg_332_1.talkMaxDuration = var_335_15

					if var_335_15 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_15 + var_335_8
					end
				end

				arg_332_1.text_.text = var_335_12
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011079", "story_v_out_926011.awb") ~= 0 then
					local var_335_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011079", "story_v_out_926011.awb") / 1000

					if var_335_16 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_16 + var_335_8
					end

					if var_335_11.prefab_name ~= "" and arg_332_1.actors_[var_335_11.prefab_name] ~= nil then
						local var_335_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_11.prefab_name].transform, "story_v_out_926011", "926011079", "story_v_out_926011.awb")

						arg_332_1:RecordAudio("926011079", var_335_17)
						arg_332_1:RecordAudio("926011079", var_335_17)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_926011", "926011079", "story_v_out_926011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_926011", "926011079", "story_v_out_926011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_18 = math.max(var_335_9, arg_332_1.talkMaxDuration)

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_18 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_8) / var_335_18

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_8 + var_335_18 and arg_332_1.time_ < var_335_8 + var_335_18 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play926011080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 926011080
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play926011081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["128404"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps128404 == nil then
				arg_336_1.var_.actorSpriteComps128404 = var_339_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_2 = 0.2

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.actorSpriteComps128404 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								local var_339_4 = Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor2.r, var_339_3)
								local var_339_5 = Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor2.g, var_339_3)
								local var_339_6 = Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor2.b, var_339_3)

								iter_339_1.color = Color.New(var_339_4, var_339_5, var_339_6)
							else
								local var_339_7 = Mathf.Lerp(iter_339_1.color.r, 0.5, var_339_3)

								iter_339_1.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps128404 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_339_3 then
						if arg_336_1.isInRecall_ then
							iter_339_3.color = arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_339_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_336_1.var_.actorSpriteComps128404 = nil
			end

			local var_339_8 = 0
			local var_339_9 = 0.375

			if var_339_8 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_10 = arg_336_1:FormatText(StoryNameCfg[7].name)

				arg_336_1.leftNameTxt_.text = var_339_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_11 = arg_336_1:GetWordFromCfg(926011080)
				local var_339_12 = arg_336_1:FormatText(var_339_11.content)

				arg_336_1.text_.text = var_339_12

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 15
				local var_339_14 = utf8.len(var_339_12)
				local var_339_15 = var_339_13 <= 0 and var_339_9 or var_339_9 * (var_339_14 / var_339_13)

				if var_339_15 > 0 and var_339_9 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15

					if var_339_15 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_12
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_16 and arg_336_1.time_ < var_339_8 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play926011081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 926011081
		arg_340_1.duration_ = 7.67

		local var_340_0 = {
			zh = 3.666,
			ja = 7.666
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play926011082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["128404"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps128404 == nil then
				arg_340_1.var_.actorSpriteComps128404 = var_343_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_2 = 0.2

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.actorSpriteComps128404 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								local var_343_4 = Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, var_343_3)
								local var_343_5 = Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, var_343_3)
								local var_343_6 = Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, var_343_3)

								iter_343_1.color = Color.New(var_343_4, var_343_5, var_343_6)
							else
								local var_343_7 = Mathf.Lerp(iter_343_1.color.r, 1, var_343_3)

								iter_343_1.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps128404 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_343_3 then
						if arg_340_1.isInRecall_ then
							iter_343_3.color = arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_343_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps128404 = nil
			end

			local var_343_8 = 0
			local var_343_9 = 0.475

			if var_343_8 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_10 = arg_340_1:FormatText(StoryNameCfg[6].name)

				arg_340_1.leftNameTxt_.text = var_343_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_11 = arg_340_1:GetWordFromCfg(926011081)
				local var_343_12 = arg_340_1:FormatText(var_343_11.content)

				arg_340_1.text_.text = var_343_12

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_13 = 19
				local var_343_14 = utf8.len(var_343_12)
				local var_343_15 = var_343_13 <= 0 and var_343_9 or var_343_9 * (var_343_14 / var_343_13)

				if var_343_15 > 0 and var_343_9 < var_343_15 then
					arg_340_1.talkMaxDuration = var_343_15

					if var_343_15 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_15 + var_343_8
					end
				end

				arg_340_1.text_.text = var_343_12
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011081", "story_v_out_926011.awb") ~= 0 then
					local var_343_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011081", "story_v_out_926011.awb") / 1000

					if var_343_16 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_16 + var_343_8
					end

					if var_343_11.prefab_name ~= "" and arg_340_1.actors_[var_343_11.prefab_name] ~= nil then
						local var_343_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_11.prefab_name].transform, "story_v_out_926011", "926011081", "story_v_out_926011.awb")

						arg_340_1:RecordAudio("926011081", var_343_17)
						arg_340_1:RecordAudio("926011081", var_343_17)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_926011", "926011081", "story_v_out_926011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_926011", "926011081", "story_v_out_926011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_18 = math.max(var_343_9, arg_340_1.talkMaxDuration)

			if var_343_8 <= arg_340_1.time_ and arg_340_1.time_ < var_343_8 + var_343_18 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_8) / var_343_18

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_8 + var_343_18 and arg_340_1.time_ < var_343_8 + var_343_18 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play926011082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 926011082
		arg_344_1.duration_ = 6.83

		local var_344_0 = {
			zh = 3.433,
			ja = 6.833
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play926011083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.45

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[6].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(926011082)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 18
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011082", "story_v_out_926011.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011082", "story_v_out_926011.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_926011", "926011082", "story_v_out_926011.awb")

						arg_344_1:RecordAudio("926011082", var_347_9)
						arg_344_1:RecordAudio("926011082", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_926011", "926011082", "story_v_out_926011.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_926011", "926011082", "story_v_out_926011.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play926011083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 926011083
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play926011084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["128404"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps128404 == nil then
				arg_348_1.var_.actorSpriteComps128404 = var_351_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_2 = 0.2

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.actorSpriteComps128404 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								local var_351_4 = Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor2.r, var_351_3)
								local var_351_5 = Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor2.g, var_351_3)
								local var_351_6 = Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor2.b, var_351_3)

								iter_351_1.color = Color.New(var_351_4, var_351_5, var_351_6)
							else
								local var_351_7 = Mathf.Lerp(iter_351_1.color.r, 0.5, var_351_3)

								iter_351_1.color = Color.New(var_351_7, var_351_7, var_351_7)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps128404 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_351_3 then
						if arg_348_1.isInRecall_ then
							iter_351_3.color = arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_351_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_348_1.var_.actorSpriteComps128404 = nil
			end

			local var_351_8 = 0
			local var_351_9 = 0.35

			if var_351_8 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_10 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_11 = arg_348_1:GetWordFromCfg(926011083)
				local var_351_12 = arg_348_1:FormatText(var_351_11.content)

				arg_348_1.text_.text = var_351_12

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_13 = 14
				local var_351_14 = utf8.len(var_351_12)
				local var_351_15 = var_351_13 <= 0 and var_351_9 or var_351_9 * (var_351_14 / var_351_13)

				if var_351_15 > 0 and var_351_9 < var_351_15 then
					arg_348_1.talkMaxDuration = var_351_15

					if var_351_15 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_15 + var_351_8
					end
				end

				arg_348_1.text_.text = var_351_12
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_9, arg_348_1.talkMaxDuration)

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_8) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_8 + var_351_16 and arg_348_1.time_ < var_351_8 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play926011084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 926011084
		arg_352_1.duration_ = 5.93

		local var_352_0 = {
			zh = 4.3,
			ja = 5.933
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play926011085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["128404"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps128404 == nil then
				arg_352_1.var_.actorSpriteComps128404 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps128404 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 1, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps128404 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_355_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps128404 = nil
			end

			local var_355_8 = arg_352_1.actors_["128404"].transform
			local var_355_9 = 0

			if var_355_9 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 then
				arg_352_1.var_.moveOldPos128404 = var_355_8.localPosition
				var_355_8.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("128404", 3)

				local var_355_10 = var_355_8.childCount

				for iter_355_4 = 0, var_355_10 - 1 do
					local var_355_11 = var_355_8:GetChild(iter_355_4)

					if var_355_11.name == "" or not string.find(var_355_11.name, "split") then
						var_355_11.gameObject:SetActive(true)
					else
						var_355_11.gameObject:SetActive(false)
					end
				end
			end

			local var_355_12 = 0.001

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_12 then
				local var_355_13 = (arg_352_1.time_ - var_355_9) / var_355_12
				local var_355_14 = Vector3.New(-16.1, -362, -375)

				var_355_8.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos128404, var_355_14, var_355_13)
			end

			if arg_352_1.time_ >= var_355_9 + var_355_12 and arg_352_1.time_ < var_355_9 + var_355_12 + arg_355_0 then
				var_355_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_355_15 = 0
			local var_355_16 = 0.55

			if var_355_15 < arg_352_1.time_ and arg_352_1.time_ <= var_355_15 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_17 = arg_352_1:FormatText(StoryNameCfg[6].name)

				arg_352_1.leftNameTxt_.text = var_355_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_18 = arg_352_1:GetWordFromCfg(926011084)
				local var_355_19 = arg_352_1:FormatText(var_355_18.content)

				arg_352_1.text_.text = var_355_19

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_20 = 22
				local var_355_21 = utf8.len(var_355_19)
				local var_355_22 = var_355_20 <= 0 and var_355_16 or var_355_16 * (var_355_21 / var_355_20)

				if var_355_22 > 0 and var_355_16 < var_355_22 then
					arg_352_1.talkMaxDuration = var_355_22

					if var_355_22 + var_355_15 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_22 + var_355_15
					end
				end

				arg_352_1.text_.text = var_355_19
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011084", "story_v_out_926011.awb") ~= 0 then
					local var_355_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011084", "story_v_out_926011.awb") / 1000

					if var_355_23 + var_355_15 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_23 + var_355_15
					end

					if var_355_18.prefab_name ~= "" and arg_352_1.actors_[var_355_18.prefab_name] ~= nil then
						local var_355_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_18.prefab_name].transform, "story_v_out_926011", "926011084", "story_v_out_926011.awb")

						arg_352_1:RecordAudio("926011084", var_355_24)
						arg_352_1:RecordAudio("926011084", var_355_24)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_926011", "926011084", "story_v_out_926011.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_926011", "926011084", "story_v_out_926011.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_25 = math.max(var_355_16, arg_352_1.talkMaxDuration)

			if var_355_15 <= arg_352_1.time_ and arg_352_1.time_ < var_355_15 + var_355_25 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_15) / var_355_25

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_15 + var_355_25 and arg_352_1.time_ < var_355_15 + var_355_25 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
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

		arg_352_1:InitPlayNodeList()
	end,
	Play926011085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 926011085
		arg_356_1.duration_ = 7.57

		local var_356_0 = {
			zh = 4.6,
			ja = 7.566
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play926011086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.675

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[6].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(926011085)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 27
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011085", "story_v_out_926011.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011085", "story_v_out_926011.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_926011", "926011085", "story_v_out_926011.awb")

						arg_356_1:RecordAudio("926011085", var_359_9)
						arg_356_1:RecordAudio("926011085", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_926011", "926011085", "story_v_out_926011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_926011", "926011085", "story_v_out_926011.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play926011086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 926011086
		arg_360_1.duration_ = 6.2

		local var_360_0 = {
			zh = 3.733,
			ja = 6.2
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play926011087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.475

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[6].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(926011086)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 19
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011086", "story_v_out_926011.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011086", "story_v_out_926011.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_926011", "926011086", "story_v_out_926011.awb")

						arg_360_1:RecordAudio("926011086", var_363_9)
						arg_360_1:RecordAudio("926011086", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_926011", "926011086", "story_v_out_926011.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_926011", "926011086", "story_v_out_926011.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play926011087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 926011087
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play926011088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["128404"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps128404 == nil then
				arg_364_1.var_.actorSpriteComps128404 = var_367_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_2 = 0.2

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.actorSpriteComps128404 then
					for iter_367_0, iter_367_1 in pairs(arg_364_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_367_1 then
							if arg_364_1.isInRecall_ then
								local var_367_4 = Mathf.Lerp(iter_367_1.color.r, arg_364_1.hightColor2.r, var_367_3)
								local var_367_5 = Mathf.Lerp(iter_367_1.color.g, arg_364_1.hightColor2.g, var_367_3)
								local var_367_6 = Mathf.Lerp(iter_367_1.color.b, arg_364_1.hightColor2.b, var_367_3)

								iter_367_1.color = Color.New(var_367_4, var_367_5, var_367_6)
							else
								local var_367_7 = Mathf.Lerp(iter_367_1.color.r, 0.5, var_367_3)

								iter_367_1.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps128404 then
				for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_367_3 then
						if arg_364_1.isInRecall_ then
							iter_367_3.color = arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_367_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_364_1.var_.actorSpriteComps128404 = nil
			end

			local var_367_8 = 0
			local var_367_9 = 0.525

			if var_367_8 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_10 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_11 = arg_364_1:GetWordFromCfg(926011087)
				local var_367_12 = arg_364_1:FormatText(var_367_11.content)

				arg_364_1.text_.text = var_367_12

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_13 = 21
				local var_367_14 = utf8.len(var_367_12)
				local var_367_15 = var_367_13 <= 0 and var_367_9 or var_367_9 * (var_367_14 / var_367_13)

				if var_367_15 > 0 and var_367_9 < var_367_15 then
					arg_364_1.talkMaxDuration = var_367_15

					if var_367_15 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_15 + var_367_8
					end
				end

				arg_364_1.text_.text = var_367_12
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_9, arg_364_1.talkMaxDuration)

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_8) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_8 + var_367_16 and arg_364_1.time_ < var_367_8 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play926011088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 926011088
		arg_368_1.duration_ = 6.13

		local var_368_0 = {
			zh = 3.2,
			ja = 6.133
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play926011089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["128404"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps128404 == nil then
				arg_368_1.var_.actorSpriteComps128404 = var_371_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_2 = 0.2

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.actorSpriteComps128404 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								local var_371_4 = Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor1.r, var_371_3)
								local var_371_5 = Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor1.g, var_371_3)
								local var_371_6 = Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor1.b, var_371_3)

								iter_371_1.color = Color.New(var_371_4, var_371_5, var_371_6)
							else
								local var_371_7 = Mathf.Lerp(iter_371_1.color.r, 1, var_371_3)

								iter_371_1.color = Color.New(var_371_7, var_371_7, var_371_7)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps128404 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_371_3 then
						if arg_368_1.isInRecall_ then
							iter_371_3.color = arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_371_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_368_1.var_.actorSpriteComps128404 = nil
			end

			local var_371_8 = arg_368_1.actors_["128404"].transform
			local var_371_9 = 0

			if var_371_9 < arg_368_1.time_ and arg_368_1.time_ <= var_371_9 + arg_371_0 then
				arg_368_1.var_.moveOldPos128404 = var_371_8.localPosition
				var_371_8.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("128404", 3)

				local var_371_10 = var_371_8.childCount

				for iter_371_4 = 0, var_371_10 - 1 do
					local var_371_11 = var_371_8:GetChild(iter_371_4)

					if var_371_11.name == "split_4" or not string.find(var_371_11.name, "split") then
						var_371_11.gameObject:SetActive(true)
					else
						var_371_11.gameObject:SetActive(false)
					end
				end
			end

			local var_371_12 = 0.001

			if var_371_9 <= arg_368_1.time_ and arg_368_1.time_ < var_371_9 + var_371_12 then
				local var_371_13 = (arg_368_1.time_ - var_371_9) / var_371_12
				local var_371_14 = Vector3.New(-16.1, -362, -375)

				var_371_8.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos128404, var_371_14, var_371_13)
			end

			if arg_368_1.time_ >= var_371_9 + var_371_12 and arg_368_1.time_ < var_371_9 + var_371_12 + arg_371_0 then
				var_371_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_371_15 = 0
			local var_371_16 = 0.325

			if var_371_15 < arg_368_1.time_ and arg_368_1.time_ <= var_371_15 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_17 = arg_368_1:FormatText(StoryNameCfg[6].name)

				arg_368_1.leftNameTxt_.text = var_371_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_18 = arg_368_1:GetWordFromCfg(926011088)
				local var_371_19 = arg_368_1:FormatText(var_371_18.content)

				arg_368_1.text_.text = var_371_19

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_20 = 13
				local var_371_21 = utf8.len(var_371_19)
				local var_371_22 = var_371_20 <= 0 and var_371_16 or var_371_16 * (var_371_21 / var_371_20)

				if var_371_22 > 0 and var_371_16 < var_371_22 then
					arg_368_1.talkMaxDuration = var_371_22

					if var_371_22 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_22 + var_371_15
					end
				end

				arg_368_1.text_.text = var_371_19
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011088", "story_v_out_926011.awb") ~= 0 then
					local var_371_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011088", "story_v_out_926011.awb") / 1000

					if var_371_23 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_23 + var_371_15
					end

					if var_371_18.prefab_name ~= "" and arg_368_1.actors_[var_371_18.prefab_name] ~= nil then
						local var_371_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_18.prefab_name].transform, "story_v_out_926011", "926011088", "story_v_out_926011.awb")

						arg_368_1:RecordAudio("926011088", var_371_24)
						arg_368_1:RecordAudio("926011088", var_371_24)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_926011", "926011088", "story_v_out_926011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_926011", "926011088", "story_v_out_926011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_25 = math.max(var_371_16, arg_368_1.talkMaxDuration)

			if var_371_15 <= arg_368_1.time_ and arg_368_1.time_ < var_371_15 + var_371_25 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_15) / var_371_25

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_15 + var_371_25 and arg_368_1.time_ < var_371_15 + var_371_25 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
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

		arg_368_1:InitPlayNodeList()
	end,
	Play926011089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 926011089
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play926011090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["128404"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps128404 == nil then
				arg_372_1.var_.actorSpriteComps128404 = var_375_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_2 = 0.2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.actorSpriteComps128404 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								local var_375_4 = Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor2.r, var_375_3)
								local var_375_5 = Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor2.g, var_375_3)
								local var_375_6 = Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor2.b, var_375_3)

								iter_375_1.color = Color.New(var_375_4, var_375_5, var_375_6)
							else
								local var_375_7 = Mathf.Lerp(iter_375_1.color.r, 0.5, var_375_3)

								iter_375_1.color = Color.New(var_375_7, var_375_7, var_375_7)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps128404 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_375_3 then
						if arg_372_1.isInRecall_ then
							iter_375_3.color = arg_372_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_375_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_372_1.var_.actorSpriteComps128404 = nil
			end

			local var_375_8 = 0
			local var_375_9 = 0.45

			if var_375_8 < arg_372_1.time_ and arg_372_1.time_ <= var_375_8 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_10 = arg_372_1:FormatText(StoryNameCfg[7].name)

				arg_372_1.leftNameTxt_.text = var_375_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_11 = arg_372_1:GetWordFromCfg(926011089)
				local var_375_12 = arg_372_1:FormatText(var_375_11.content)

				arg_372_1.text_.text = var_375_12

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_13 = 18
				local var_375_14 = utf8.len(var_375_12)
				local var_375_15 = var_375_13 <= 0 and var_375_9 or var_375_9 * (var_375_14 / var_375_13)

				if var_375_15 > 0 and var_375_9 < var_375_15 then
					arg_372_1.talkMaxDuration = var_375_15

					if var_375_15 + var_375_8 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_15 + var_375_8
					end
				end

				arg_372_1.text_.text = var_375_12
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_9, arg_372_1.talkMaxDuration)

			if var_375_8 <= arg_372_1.time_ and arg_372_1.time_ < var_375_8 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_8) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_8 + var_375_16 and arg_372_1.time_ < var_375_8 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play926011090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 926011090
		arg_376_1.duration_ = 9.77

		local var_376_0 = {
			zh = 8.1,
			ja = 9.766
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play926011091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["128404"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps128404 == nil then
				arg_376_1.var_.actorSpriteComps128404 = var_379_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.actorSpriteComps128404 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								local var_379_4 = Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, var_379_3)
								local var_379_5 = Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, var_379_3)
								local var_379_6 = Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, var_379_3)

								iter_379_1.color = Color.New(var_379_4, var_379_5, var_379_6)
							else
								local var_379_7 = Mathf.Lerp(iter_379_1.color.r, 1, var_379_3)

								iter_379_1.color = Color.New(var_379_7, var_379_7, var_379_7)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps128404 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_379_3 then
						if arg_376_1.isInRecall_ then
							iter_379_3.color = arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_379_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps128404 = nil
			end

			local var_379_8 = 0
			local var_379_9 = 1

			if var_379_8 < arg_376_1.time_ and arg_376_1.time_ <= var_379_8 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_10 = arg_376_1:FormatText(StoryNameCfg[6].name)

				arg_376_1.leftNameTxt_.text = var_379_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_11 = arg_376_1:GetWordFromCfg(926011090)
				local var_379_12 = arg_376_1:FormatText(var_379_11.content)

				arg_376_1.text_.text = var_379_12

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_13 = 40
				local var_379_14 = utf8.len(var_379_12)
				local var_379_15 = var_379_13 <= 0 and var_379_9 or var_379_9 * (var_379_14 / var_379_13)

				if var_379_15 > 0 and var_379_9 < var_379_15 then
					arg_376_1.talkMaxDuration = var_379_15

					if var_379_15 + var_379_8 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_15 + var_379_8
					end
				end

				arg_376_1.text_.text = var_379_12
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011090", "story_v_out_926011.awb") ~= 0 then
					local var_379_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011090", "story_v_out_926011.awb") / 1000

					if var_379_16 + var_379_8 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_16 + var_379_8
					end

					if var_379_11.prefab_name ~= "" and arg_376_1.actors_[var_379_11.prefab_name] ~= nil then
						local var_379_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_11.prefab_name].transform, "story_v_out_926011", "926011090", "story_v_out_926011.awb")

						arg_376_1:RecordAudio("926011090", var_379_17)
						arg_376_1:RecordAudio("926011090", var_379_17)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_926011", "926011090", "story_v_out_926011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_926011", "926011090", "story_v_out_926011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_18 = math.max(var_379_9, arg_376_1.talkMaxDuration)

			if var_379_8 <= arg_376_1.time_ and arg_376_1.time_ < var_379_8 + var_379_18 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_8) / var_379_18

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_8 + var_379_18 and arg_376_1.time_ < var_379_8 + var_379_18 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play926011091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 926011091
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play926011092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["128404"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps128404 == nil then
				arg_380_1.var_.actorSpriteComps128404 = var_383_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_2 = 0.2

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.actorSpriteComps128404 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								local var_383_4 = Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor2.r, var_383_3)
								local var_383_5 = Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor2.g, var_383_3)
								local var_383_6 = Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor2.b, var_383_3)

								iter_383_1.color = Color.New(var_383_4, var_383_5, var_383_6)
							else
								local var_383_7 = Mathf.Lerp(iter_383_1.color.r, 0.5, var_383_3)

								iter_383_1.color = Color.New(var_383_7, var_383_7, var_383_7)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps128404 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_383_3 then
						if arg_380_1.isInRecall_ then
							iter_383_3.color = arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_383_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps128404 = nil
			end

			local var_383_8 = 0
			local var_383_9 = 0.95

			if var_383_8 < arg_380_1.time_ and arg_380_1.time_ <= var_383_8 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_10 = arg_380_1:FormatText(StoryNameCfg[7].name)

				arg_380_1.leftNameTxt_.text = var_383_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_11 = arg_380_1:GetWordFromCfg(926011091)
				local var_383_12 = arg_380_1:FormatText(var_383_11.content)

				arg_380_1.text_.text = var_383_12

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_13 = 38
				local var_383_14 = utf8.len(var_383_12)
				local var_383_15 = var_383_13 <= 0 and var_383_9 or var_383_9 * (var_383_14 / var_383_13)

				if var_383_15 > 0 and var_383_9 < var_383_15 then
					arg_380_1.talkMaxDuration = var_383_15

					if var_383_15 + var_383_8 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_15 + var_383_8
					end
				end

				arg_380_1.text_.text = var_383_12
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_9, arg_380_1.talkMaxDuration)

			if var_383_8 <= arg_380_1.time_ and arg_380_1.time_ < var_383_8 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_8) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_8 + var_383_16 and arg_380_1.time_ < var_383_8 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play926011092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 926011092
		arg_384_1.duration_ = 1.3

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play926011093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["128404"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps128404 == nil then
				arg_384_1.var_.actorSpriteComps128404 = var_387_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.actorSpriteComps128404 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								local var_387_4 = Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, var_387_3)
								local var_387_5 = Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, var_387_3)
								local var_387_6 = Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, var_387_3)

								iter_387_1.color = Color.New(var_387_4, var_387_5, var_387_6)
							else
								local var_387_7 = Mathf.Lerp(iter_387_1.color.r, 1, var_387_3)

								iter_387_1.color = Color.New(var_387_7, var_387_7, var_387_7)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps128404 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_387_3 then
						if arg_384_1.isInRecall_ then
							iter_387_3.color = arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_387_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_384_1.var_.actorSpriteComps128404 = nil
			end

			local var_387_8 = 0
			local var_387_9 = 0.0329999998211861

			if var_387_8 < arg_384_1.time_ and arg_384_1.time_ <= var_387_8 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_10 = arg_384_1:FormatText(StoryNameCfg[6].name)

				arg_384_1.leftNameTxt_.text = var_387_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_11 = arg_384_1:GetWordFromCfg(926011092)
				local var_387_12 = arg_384_1:FormatText(var_387_11.content)

				arg_384_1.text_.text = var_387_12

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_13 = 1
				local var_387_14 = utf8.len(var_387_12)
				local var_387_15 = var_387_13 <= 0 and var_387_9 or var_387_9 * (var_387_14 / var_387_13)

				if var_387_15 > 0 and var_387_9 < var_387_15 then
					arg_384_1.talkMaxDuration = var_387_15

					if var_387_15 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_15 + var_387_8
					end
				end

				arg_384_1.text_.text = var_387_12
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011092", "story_v_out_926011.awb") ~= 0 then
					local var_387_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011092", "story_v_out_926011.awb") / 1000

					if var_387_16 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_16 + var_387_8
					end

					if var_387_11.prefab_name ~= "" and arg_384_1.actors_[var_387_11.prefab_name] ~= nil then
						local var_387_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_11.prefab_name].transform, "story_v_out_926011", "926011092", "story_v_out_926011.awb")

						arg_384_1:RecordAudio("926011092", var_387_17)
						arg_384_1:RecordAudio("926011092", var_387_17)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_926011", "926011092", "story_v_out_926011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_926011", "926011092", "story_v_out_926011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_18 = math.max(var_387_9, arg_384_1.talkMaxDuration)

			if var_387_8 <= arg_384_1.time_ and arg_384_1.time_ < var_387_8 + var_387_18 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_8) / var_387_18

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_8 + var_387_18 and arg_384_1.time_ < var_387_8 + var_387_18 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play926011093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 926011093
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play926011094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["128404"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps128404 == nil then
				arg_388_1.var_.actorSpriteComps128404 = var_391_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.actorSpriteComps128404 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								local var_391_4 = Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor2.r, var_391_3)
								local var_391_5 = Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor2.g, var_391_3)
								local var_391_6 = Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor2.b, var_391_3)

								iter_391_1.color = Color.New(var_391_4, var_391_5, var_391_6)
							else
								local var_391_7 = Mathf.Lerp(iter_391_1.color.r, 0.5, var_391_3)

								iter_391_1.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps128404 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_391_3 then
						if arg_388_1.isInRecall_ then
							iter_391_3.color = arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_391_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps128404 = nil
			end

			local var_391_8 = 0
			local var_391_9 = 0.825

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_10 = arg_388_1:FormatText(StoryNameCfg[7].name)

				arg_388_1.leftNameTxt_.text = var_391_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_11 = arg_388_1:GetWordFromCfg(926011093)
				local var_391_12 = arg_388_1:FormatText(var_391_11.content)

				arg_388_1.text_.text = var_391_12

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 33
				local var_391_14 = utf8.len(var_391_12)
				local var_391_15 = var_391_13 <= 0 and var_391_9 or var_391_9 * (var_391_14 / var_391_13)

				if var_391_15 > 0 and var_391_9 < var_391_15 then
					arg_388_1.talkMaxDuration = var_391_15

					if var_391_15 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_15 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_12
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_16 and arg_388_1.time_ < var_391_8 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play926011094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 926011094
		arg_392_1.duration_ = 7.17

		local var_392_0 = {
			zh = 3.6,
			ja = 7.166
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play926011095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["128404"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps128404 == nil then
				arg_392_1.var_.actorSpriteComps128404 = var_395_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_2 = 0.2

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.actorSpriteComps128404 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								local var_395_4 = Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor1.r, var_395_3)
								local var_395_5 = Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor1.g, var_395_3)
								local var_395_6 = Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor1.b, var_395_3)

								iter_395_1.color = Color.New(var_395_4, var_395_5, var_395_6)
							else
								local var_395_7 = Mathf.Lerp(iter_395_1.color.r, 1, var_395_3)

								iter_395_1.color = Color.New(var_395_7, var_395_7, var_395_7)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps128404 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_395_3 then
						if arg_392_1.isInRecall_ then
							iter_395_3.color = arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_395_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps128404 = nil
			end

			local var_395_8 = arg_392_1.actors_["128404"].transform
			local var_395_9 = 0

			if var_395_9 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 then
				arg_392_1.var_.moveOldPos128404 = var_395_8.localPosition
				var_395_8.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("128404", 3)

				local var_395_10 = var_395_8.childCount

				for iter_395_4 = 0, var_395_10 - 1 do
					local var_395_11 = var_395_8:GetChild(iter_395_4)

					if var_395_11.name == "" or not string.find(var_395_11.name, "split") then
						var_395_11.gameObject:SetActive(true)
					else
						var_395_11.gameObject:SetActive(false)
					end
				end
			end

			local var_395_12 = 0.001

			if var_395_9 <= arg_392_1.time_ and arg_392_1.time_ < var_395_9 + var_395_12 then
				local var_395_13 = (arg_392_1.time_ - var_395_9) / var_395_12
				local var_395_14 = Vector3.New(-16.1, -362, -375)

				var_395_8.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos128404, var_395_14, var_395_13)
			end

			if arg_392_1.time_ >= var_395_9 + var_395_12 and arg_392_1.time_ < var_395_9 + var_395_12 + arg_395_0 then
				var_395_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_395_15 = 0
			local var_395_16 = 0.45

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_17 = arg_392_1:FormatText(StoryNameCfg[6].name)

				arg_392_1.leftNameTxt_.text = var_395_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_18 = arg_392_1:GetWordFromCfg(926011094)
				local var_395_19 = arg_392_1:FormatText(var_395_18.content)

				arg_392_1.text_.text = var_395_19

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_20 = 18
				local var_395_21 = utf8.len(var_395_19)
				local var_395_22 = var_395_20 <= 0 and var_395_16 or var_395_16 * (var_395_21 / var_395_20)

				if var_395_22 > 0 and var_395_16 < var_395_22 then
					arg_392_1.talkMaxDuration = var_395_22

					if var_395_22 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_22 + var_395_15
					end
				end

				arg_392_1.text_.text = var_395_19
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011094", "story_v_out_926011.awb") ~= 0 then
					local var_395_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011094", "story_v_out_926011.awb") / 1000

					if var_395_23 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_23 + var_395_15
					end

					if var_395_18.prefab_name ~= "" and arg_392_1.actors_[var_395_18.prefab_name] ~= nil then
						local var_395_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_18.prefab_name].transform, "story_v_out_926011", "926011094", "story_v_out_926011.awb")

						arg_392_1:RecordAudio("926011094", var_395_24)
						arg_392_1:RecordAudio("926011094", var_395_24)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_926011", "926011094", "story_v_out_926011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_926011", "926011094", "story_v_out_926011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_25 = math.max(var_395_16, arg_392_1.talkMaxDuration)

			if var_395_15 <= arg_392_1.time_ and arg_392_1.time_ < var_395_15 + var_395_25 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_15) / var_395_25

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_15 + var_395_25 and arg_392_1.time_ < var_395_15 + var_395_25 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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

		arg_392_1:InitPlayNodeList()
	end,
	Play926011095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 926011095
		arg_396_1.duration_ = 1

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"

			SetActive(arg_396_1.choicesGo_, true)

			for iter_397_0, iter_397_1 in ipairs(arg_396_1.choices_) do
				local var_397_0 = iter_397_0 <= 1

				SetActive(iter_397_1.go, var_397_0)
			end

			arg_396_1.choices_[1].txt.text = arg_396_1:FormatText(StoryChoiceCfg[1309].name)
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play926011096(arg_396_1)
			end

			arg_396_1:RecordChoiceLog(926011095, 1309)
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["128404"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps128404 == nil then
				arg_396_1.var_.actorSpriteComps128404 = var_399_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_2 = 0.2

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.actorSpriteComps128404 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								local var_399_4 = Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor2.r, var_399_3)
								local var_399_5 = Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor2.g, var_399_3)
								local var_399_6 = Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor2.b, var_399_3)

								iter_399_1.color = Color.New(var_399_4, var_399_5, var_399_6)
							else
								local var_399_7 = Mathf.Lerp(iter_399_1.color.r, 0.5, var_399_3)

								iter_399_1.color = Color.New(var_399_7, var_399_7, var_399_7)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps128404 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_399_3 then
						if arg_396_1.isInRecall_ then
							iter_399_3.color = arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_399_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play926011096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 926011096
		arg_400_1.duration_ = 6.8

		local var_400_0 = {
			zh = 5.8,
			ja = 6.8
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
				arg_400_0:Play926011097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["128404"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.actorSpriteComps128404 == nil then
				arg_400_1.var_.actorSpriteComps128404 = var_403_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_2 = 0.2

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.actorSpriteComps128404 then
					for iter_403_0, iter_403_1 in pairs(arg_400_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_403_1 then
							if arg_400_1.isInRecall_ then
								local var_403_4 = Mathf.Lerp(iter_403_1.color.r, arg_400_1.hightColor1.r, var_403_3)
								local var_403_5 = Mathf.Lerp(iter_403_1.color.g, arg_400_1.hightColor1.g, var_403_3)
								local var_403_6 = Mathf.Lerp(iter_403_1.color.b, arg_400_1.hightColor1.b, var_403_3)

								iter_403_1.color = Color.New(var_403_4, var_403_5, var_403_6)
							else
								local var_403_7 = Mathf.Lerp(iter_403_1.color.r, 1, var_403_3)

								iter_403_1.color = Color.New(var_403_7, var_403_7, var_403_7)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.actorSpriteComps128404 then
				for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_403_3 then
						if arg_400_1.isInRecall_ then
							iter_403_3.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_403_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps128404 = nil
			end

			local var_403_8 = arg_400_1.actors_["128404"].transform
			local var_403_9 = 0

			if var_403_9 < arg_400_1.time_ and arg_400_1.time_ <= var_403_9 + arg_403_0 then
				arg_400_1.var_.moveOldPos128404 = var_403_8.localPosition
				var_403_8.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("128404", 3)

				local var_403_10 = var_403_8.childCount

				for iter_403_4 = 0, var_403_10 - 1 do
					local var_403_11 = var_403_8:GetChild(iter_403_4)

					if var_403_11.name == "split_5" or not string.find(var_403_11.name, "split") then
						var_403_11.gameObject:SetActive(true)
					else
						var_403_11.gameObject:SetActive(false)
					end
				end
			end

			local var_403_12 = 0.001

			if var_403_9 <= arg_400_1.time_ and arg_400_1.time_ < var_403_9 + var_403_12 then
				local var_403_13 = (arg_400_1.time_ - var_403_9) / var_403_12
				local var_403_14 = Vector3.New(-16.1, -362, -375)

				var_403_8.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos128404, var_403_14, var_403_13)
			end

			if arg_400_1.time_ >= var_403_9 + var_403_12 and arg_400_1.time_ < var_403_9 + var_403_12 + arg_403_0 then
				var_403_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_403_15 = 0
			local var_403_16 = 0.575

			if var_403_15 < arg_400_1.time_ and arg_400_1.time_ <= var_403_15 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_17 = arg_400_1:FormatText(StoryNameCfg[6].name)

				arg_400_1.leftNameTxt_.text = var_403_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_18 = arg_400_1:GetWordFromCfg(926011096)
				local var_403_19 = arg_400_1:FormatText(var_403_18.content)

				arg_400_1.text_.text = var_403_19

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_20 = 23
				local var_403_21 = utf8.len(var_403_19)
				local var_403_22 = var_403_20 <= 0 and var_403_16 or var_403_16 * (var_403_21 / var_403_20)

				if var_403_22 > 0 and var_403_16 < var_403_22 then
					arg_400_1.talkMaxDuration = var_403_22

					if var_403_22 + var_403_15 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_22 + var_403_15
					end
				end

				arg_400_1.text_.text = var_403_19
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011096", "story_v_out_926011.awb") ~= 0 then
					local var_403_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011096", "story_v_out_926011.awb") / 1000

					if var_403_23 + var_403_15 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_23 + var_403_15
					end

					if var_403_18.prefab_name ~= "" and arg_400_1.actors_[var_403_18.prefab_name] ~= nil then
						local var_403_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_18.prefab_name].transform, "story_v_out_926011", "926011096", "story_v_out_926011.awb")

						arg_400_1:RecordAudio("926011096", var_403_24)
						arg_400_1:RecordAudio("926011096", var_403_24)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_926011", "926011096", "story_v_out_926011.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_926011", "926011096", "story_v_out_926011.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_25 = math.max(var_403_16, arg_400_1.talkMaxDuration)

			if var_403_15 <= arg_400_1.time_ and arg_400_1.time_ < var_403_15 + var_403_25 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_15) / var_403_25

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_15 + var_403_25 and arg_400_1.time_ < var_403_15 + var_403_25 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
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

		arg_400_1:InitPlayNodeList()
	end,
	Play926011097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 926011097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play926011098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["128404"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps128404 == nil then
				arg_404_1.var_.actorSpriteComps128404 = var_407_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_2 = 0.2

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.actorSpriteComps128404 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps128404 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_407_3 then
						if arg_404_1.isInRecall_ then
							iter_407_3.color = arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_407_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps128404 = nil
			end

			local var_407_8 = 0
			local var_407_9 = 0.4

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

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_11 = arg_404_1:GetWordFromCfg(926011097)
				local var_407_12 = arg_404_1:FormatText(var_407_11.content)

				arg_404_1.text_.text = var_407_12

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_13 = 16
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
	Play926011098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 926011098
		arg_408_1.duration_ = 6.03

		local var_408_0 = {
			zh = 3.866,
			ja = 6.033
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
				arg_408_0:Play926011099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["128404"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.actorSpriteComps128404 == nil then
				arg_408_1.var_.actorSpriteComps128404 = var_411_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_2 = 0.2

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.actorSpriteComps128404 then
					for iter_411_0, iter_411_1 in pairs(arg_408_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_411_1 then
							if arg_408_1.isInRecall_ then
								local var_411_4 = Mathf.Lerp(iter_411_1.color.r, arg_408_1.hightColor1.r, var_411_3)
								local var_411_5 = Mathf.Lerp(iter_411_1.color.g, arg_408_1.hightColor1.g, var_411_3)
								local var_411_6 = Mathf.Lerp(iter_411_1.color.b, arg_408_1.hightColor1.b, var_411_3)

								iter_411_1.color = Color.New(var_411_4, var_411_5, var_411_6)
							else
								local var_411_7 = Mathf.Lerp(iter_411_1.color.r, 1, var_411_3)

								iter_411_1.color = Color.New(var_411_7, var_411_7, var_411_7)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.actorSpriteComps128404 then
				for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_411_3 then
						if arg_408_1.isInRecall_ then
							iter_411_3.color = arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_411_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_408_1.var_.actorSpriteComps128404 = nil
			end

			local var_411_8 = arg_408_1.actors_["128404"].transform
			local var_411_9 = 0

			if var_411_9 < arg_408_1.time_ and arg_408_1.time_ <= var_411_9 + arg_411_0 then
				arg_408_1.var_.moveOldPos128404 = var_411_8.localPosition
				var_411_8.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("128404", 3)

				local var_411_10 = var_411_8.childCount

				for iter_411_4 = 0, var_411_10 - 1 do
					local var_411_11 = var_411_8:GetChild(iter_411_4)

					if var_411_11.name == "split_4" or not string.find(var_411_11.name, "split") then
						var_411_11.gameObject:SetActive(true)
					else
						var_411_11.gameObject:SetActive(false)
					end
				end
			end

			local var_411_12 = 0.001

			if var_411_9 <= arg_408_1.time_ and arg_408_1.time_ < var_411_9 + var_411_12 then
				local var_411_13 = (arg_408_1.time_ - var_411_9) / var_411_12
				local var_411_14 = Vector3.New(-16.1, -362, -375)

				var_411_8.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos128404, var_411_14, var_411_13)
			end

			if arg_408_1.time_ >= var_411_9 + var_411_12 and arg_408_1.time_ < var_411_9 + var_411_12 + arg_411_0 then
				var_411_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_411_15 = 0
			local var_411_16 = 0.525

			if var_411_15 < arg_408_1.time_ and arg_408_1.time_ <= var_411_15 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_17 = arg_408_1:FormatText(StoryNameCfg[6].name)

				arg_408_1.leftNameTxt_.text = var_411_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_18 = arg_408_1:GetWordFromCfg(926011098)
				local var_411_19 = arg_408_1:FormatText(var_411_18.content)

				arg_408_1.text_.text = var_411_19

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_20 = 21
				local var_411_21 = utf8.len(var_411_19)
				local var_411_22 = var_411_20 <= 0 and var_411_16 or var_411_16 * (var_411_21 / var_411_20)

				if var_411_22 > 0 and var_411_16 < var_411_22 then
					arg_408_1.talkMaxDuration = var_411_22

					if var_411_22 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_22 + var_411_15
					end
				end

				arg_408_1.text_.text = var_411_19
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011098", "story_v_out_926011.awb") ~= 0 then
					local var_411_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011098", "story_v_out_926011.awb") / 1000

					if var_411_23 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_23 + var_411_15
					end

					if var_411_18.prefab_name ~= "" and arg_408_1.actors_[var_411_18.prefab_name] ~= nil then
						local var_411_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_18.prefab_name].transform, "story_v_out_926011", "926011098", "story_v_out_926011.awb")

						arg_408_1:RecordAudio("926011098", var_411_24)
						arg_408_1:RecordAudio("926011098", var_411_24)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_926011", "926011098", "story_v_out_926011.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_926011", "926011098", "story_v_out_926011.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_25 = math.max(var_411_16, arg_408_1.talkMaxDuration)

			if var_411_15 <= arg_408_1.time_ and arg_408_1.time_ < var_411_15 + var_411_25 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_15) / var_411_25

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_15 + var_411_25 and arg_408_1.time_ < var_411_15 + var_411_25 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
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

		arg_408_1:InitPlayNodeList()
	end,
	Play926011099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 926011099
		arg_412_1.duration_ = 1

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"

			SetActive(arg_412_1.choicesGo_, true)

			for iter_413_0, iter_413_1 in ipairs(arg_412_1.choices_) do
				local var_413_0 = iter_413_0 <= 2

				SetActive(iter_413_1.go, var_413_0)
			end

			arg_412_1.choices_[1].txt.text = arg_412_1:FormatText(StoryChoiceCfg[1310].name)
			arg_412_1.choices_[2].txt.text = arg_412_1:FormatText(StoryChoiceCfg[1311].name)
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play926011100(arg_412_1)
			end

			if arg_414_0 == 2 then
				arg_412_0:Play926011100(arg_412_1)
			end

			arg_412_1:RecordChoiceLog(926011099, 1310, 1311)
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["128404"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps128404 == nil then
				arg_412_1.var_.actorSpriteComps128404 = var_415_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_2 = 0.2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.actorSpriteComps128404 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								local var_415_4 = Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor2.r, var_415_3)
								local var_415_5 = Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor2.g, var_415_3)
								local var_415_6 = Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor2.b, var_415_3)

								iter_415_1.color = Color.New(var_415_4, var_415_5, var_415_6)
							else
								local var_415_7 = Mathf.Lerp(iter_415_1.color.r, 0.5, var_415_3)

								iter_415_1.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps128404 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_415_3 then
						if arg_412_1.isInRecall_ then
							iter_415_3.color = arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_415_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play926011100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 926011100
		arg_416_1.duration_ = 10.57

		local var_416_0 = {
			zh = 6.5,
			ja = 10.566
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
				arg_416_0:Play926011101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["128404"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps128404 == nil then
				arg_416_1.var_.actorSpriteComps128404 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps128404 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor1.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor1.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor1.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 1, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps128404 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_419_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps128404 = nil
			end

			local var_419_8 = arg_416_1.actors_["128404"].transform
			local var_419_9 = 0

			if var_419_9 < arg_416_1.time_ and arg_416_1.time_ <= var_419_9 + arg_419_0 then
				arg_416_1.var_.moveOldPos128404 = var_419_8.localPosition
				var_419_8.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("128404", 3)

				local var_419_10 = var_419_8.childCount

				for iter_419_4 = 0, var_419_10 - 1 do
					local var_419_11 = var_419_8:GetChild(iter_419_4)

					if var_419_11.name == "" or not string.find(var_419_11.name, "split") then
						var_419_11.gameObject:SetActive(true)
					else
						var_419_11.gameObject:SetActive(false)
					end
				end
			end

			local var_419_12 = 0.001

			if var_419_9 <= arg_416_1.time_ and arg_416_1.time_ < var_419_9 + var_419_12 then
				local var_419_13 = (arg_416_1.time_ - var_419_9) / var_419_12
				local var_419_14 = Vector3.New(-16.1, -362, -375)

				var_419_8.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos128404, var_419_14, var_419_13)
			end

			if arg_416_1.time_ >= var_419_9 + var_419_12 and arg_416_1.time_ < var_419_9 + var_419_12 + arg_419_0 then
				var_419_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_419_15 = 0
			local var_419_16 = 0.9

			if var_419_15 < arg_416_1.time_ and arg_416_1.time_ <= var_419_15 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_17 = arg_416_1:FormatText(StoryNameCfg[6].name)

				arg_416_1.leftNameTxt_.text = var_419_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_18 = arg_416_1:GetWordFromCfg(926011100)
				local var_419_19 = arg_416_1:FormatText(var_419_18.content)

				arg_416_1.text_.text = var_419_19

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_20 = 36
				local var_419_21 = utf8.len(var_419_19)
				local var_419_22 = var_419_20 <= 0 and var_419_16 or var_419_16 * (var_419_21 / var_419_20)

				if var_419_22 > 0 and var_419_16 < var_419_22 then
					arg_416_1.talkMaxDuration = var_419_22

					if var_419_22 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_22 + var_419_15
					end
				end

				arg_416_1.text_.text = var_419_19
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011100", "story_v_out_926011.awb") ~= 0 then
					local var_419_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011100", "story_v_out_926011.awb") / 1000

					if var_419_23 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_23 + var_419_15
					end

					if var_419_18.prefab_name ~= "" and arg_416_1.actors_[var_419_18.prefab_name] ~= nil then
						local var_419_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_18.prefab_name].transform, "story_v_out_926011", "926011100", "story_v_out_926011.awb")

						arg_416_1:RecordAudio("926011100", var_419_24)
						arg_416_1:RecordAudio("926011100", var_419_24)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_926011", "926011100", "story_v_out_926011.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_926011", "926011100", "story_v_out_926011.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_25 = math.max(var_419_16, arg_416_1.talkMaxDuration)

			if var_419_15 <= arg_416_1.time_ and arg_416_1.time_ < var_419_15 + var_419_25 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_15) / var_419_25

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_15 + var_419_25 and arg_416_1.time_ < var_419_15 + var_419_25 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play926011101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 926011101
		arg_420_1.duration_ = 6.4

		local var_420_0 = {
			zh = 3.733,
			ja = 6.4
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
				arg_420_0:Play926011102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.425

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_2 = arg_420_1:FormatText(StoryNameCfg[6].name)

				arg_420_1.leftNameTxt_.text = var_423_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_3 = arg_420_1:GetWordFromCfg(926011101)
				local var_423_4 = arg_420_1:FormatText(var_423_3.content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011101", "story_v_out_926011.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011101", "story_v_out_926011.awb") / 1000

					if var_423_8 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_0
					end

					if var_423_3.prefab_name ~= "" and arg_420_1.actors_[var_423_3.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_3.prefab_name].transform, "story_v_out_926011", "926011101", "story_v_out_926011.awb")

						arg_420_1:RecordAudio("926011101", var_423_9)
						arg_420_1:RecordAudio("926011101", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_926011", "926011101", "story_v_out_926011.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_926011", "926011101", "story_v_out_926011.awb")
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
	Play926011102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 926011102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play926011103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["128404"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.actorSpriteComps128404 == nil then
				arg_424_1.var_.actorSpriteComps128404 = var_427_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_2 = 0.2

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.actorSpriteComps128404 then
					for iter_427_0, iter_427_1 in pairs(arg_424_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_427_1 then
							if arg_424_1.isInRecall_ then
								local var_427_4 = Mathf.Lerp(iter_427_1.color.r, arg_424_1.hightColor2.r, var_427_3)
								local var_427_5 = Mathf.Lerp(iter_427_1.color.g, arg_424_1.hightColor2.g, var_427_3)
								local var_427_6 = Mathf.Lerp(iter_427_1.color.b, arg_424_1.hightColor2.b, var_427_3)

								iter_427_1.color = Color.New(var_427_4, var_427_5, var_427_6)
							else
								local var_427_7 = Mathf.Lerp(iter_427_1.color.r, 0.5, var_427_3)

								iter_427_1.color = Color.New(var_427_7, var_427_7, var_427_7)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.actorSpriteComps128404 then
				for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_427_3 then
						if arg_424_1.isInRecall_ then
							iter_427_3.color = arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_427_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_424_1.var_.actorSpriteComps128404 = nil
			end

			local var_427_8 = 0
			local var_427_9 = 0.35

			if var_427_8 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_10 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_11 = arg_424_1:GetWordFromCfg(926011102)
				local var_427_12 = arg_424_1:FormatText(var_427_11.content)

				arg_424_1.text_.text = var_427_12

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 14
				local var_427_14 = utf8.len(var_427_12)
				local var_427_15 = var_427_13 <= 0 and var_427_9 or var_427_9 * (var_427_14 / var_427_13)

				if var_427_15 > 0 and var_427_9 < var_427_15 then
					arg_424_1.talkMaxDuration = var_427_15

					if var_427_15 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_15 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_12
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play926011103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 926011103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play926011104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 1.225

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(926011103)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 49
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
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_8 and arg_428_1.time_ < var_431_0 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play926011104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 926011104
		arg_432_1.duration_ = 8.87

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play926011105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = "I22g"

			if arg_432_1.bgs_[var_435_0] == nil then
				local var_435_1 = Object.Instantiate(arg_432_1.paintGo_)

				var_435_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_435_0)
				var_435_1.name = var_435_0
				var_435_1.transform.parent = arg_432_1.stage_.transform
				var_435_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.bgs_[var_435_0] = var_435_1
			end

			local var_435_2 = 1.97711200127378

			if var_435_2 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 then
				local var_435_3 = manager.ui.mainCamera.transform.localPosition
				local var_435_4 = Vector3.New(0, 0, 10) + Vector3.New(var_435_3.x, var_435_3.y, 0)
				local var_435_5 = arg_432_1.bgs_.I22g

				var_435_5.transform.localPosition = var_435_4
				var_435_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_435_6 = var_435_5:GetComponent("SpriteRenderer")

				if var_435_6 and var_435_6.sprite then
					local var_435_7 = (var_435_5.transform.localPosition - var_435_3).z
					local var_435_8 = manager.ui.mainCameraCom_
					local var_435_9 = 2 * var_435_7 * Mathf.Tan(var_435_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_435_10 = var_435_9 * var_435_8.aspect
					local var_435_11 = var_435_6.sprite.bounds.size.x
					local var_435_12 = var_435_6.sprite.bounds.size.y
					local var_435_13 = var_435_10 / var_435_11
					local var_435_14 = var_435_9 / var_435_12
					local var_435_15 = var_435_14 < var_435_13 and var_435_13 or var_435_14

					var_435_5.transform.localScale = Vector3.New(var_435_15, var_435_15, 0)
				end

				for iter_435_0, iter_435_1 in pairs(arg_432_1.bgs_) do
					if iter_435_0 ~= "I22g" then
						iter_435_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_435_16 = 1.97711200127378

			if var_435_16 < arg_432_1.time_ and arg_432_1.time_ <= var_435_16 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			local var_435_17 = 0.3

			if arg_432_1.time_ >= var_435_16 + var_435_17 and arg_432_1.time_ < var_435_16 + var_435_17 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end

			local var_435_18 = 0

			if var_435_18 < arg_432_1.time_ and arg_432_1.time_ <= var_435_18 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_19 = 2

			if var_435_18 <= arg_432_1.time_ and arg_432_1.time_ < var_435_18 + var_435_19 then
				local var_435_20 = (arg_432_1.time_ - var_435_18) / var_435_19
				local var_435_21 = Color.New(0, 0, 0)

				var_435_21.a = Mathf.Lerp(0, 1, var_435_20)
				arg_432_1.mask_.color = var_435_21
			end

			if arg_432_1.time_ >= var_435_18 + var_435_19 and arg_432_1.time_ < var_435_18 + var_435_19 + arg_435_0 then
				local var_435_22 = Color.New(0, 0, 0)

				var_435_22.a = 1
				arg_432_1.mask_.color = var_435_22
			end

			local var_435_23 = 2

			if var_435_23 < arg_432_1.time_ and arg_432_1.time_ <= var_435_23 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_24 = 2

			if var_435_23 <= arg_432_1.time_ and arg_432_1.time_ < var_435_23 + var_435_24 then
				local var_435_25 = (arg_432_1.time_ - var_435_23) / var_435_24
				local var_435_26 = Color.New(0, 0, 0)

				var_435_26.a = Mathf.Lerp(1, 0, var_435_25)
				arg_432_1.mask_.color = var_435_26
			end

			if arg_432_1.time_ >= var_435_23 + var_435_24 and arg_432_1.time_ < var_435_23 + var_435_24 + arg_435_0 then
				local var_435_27 = Color.New(0, 0, 0)
				local var_435_28 = 0

				arg_432_1.mask_.enabled = false
				var_435_27.a = var_435_28
				arg_432_1.mask_.color = var_435_27
			end

			local var_435_29 = arg_432_1.actors_["128404"].transform
			local var_435_30 = 2

			if var_435_30 < arg_432_1.time_ and arg_432_1.time_ <= var_435_30 + arg_435_0 then
				arg_432_1.var_.moveOldPos128404 = var_435_29.localPosition
				var_435_29.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("128404", 7)

				local var_435_31 = var_435_29.childCount

				for iter_435_2 = 0, var_435_31 - 1 do
					local var_435_32 = var_435_29:GetChild(iter_435_2)

					if var_435_32.name == "" or not string.find(var_435_32.name, "split") then
						var_435_32.gameObject:SetActive(true)
					else
						var_435_32.gameObject:SetActive(false)
					end
				end
			end

			local var_435_33 = 0.001

			if var_435_30 <= arg_432_1.time_ and arg_432_1.time_ < var_435_30 + var_435_33 then
				local var_435_34 = (arg_432_1.time_ - var_435_30) / var_435_33
				local var_435_35 = Vector3.New(0, -2000, 0)

				var_435_29.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos128404, var_435_35, var_435_34)
			end

			if arg_432_1.time_ >= var_435_30 + var_435_33 and arg_432_1.time_ < var_435_30 + var_435_33 + arg_435_0 then
				var_435_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_432_1.frameCnt_ <= 1 then
				arg_432_1.dialog_:SetActive(false)
			end

			local var_435_36 = 3.86666666666667
			local var_435_37 = 0.275

			if var_435_36 < arg_432_1.time_ and arg_432_1.time_ <= var_435_36 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_38 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_38:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_39 = arg_432_1:GetWordFromCfg(926011104)
				local var_435_40 = arg_432_1:FormatText(var_435_39.content)

				arg_432_1.text_.text = var_435_40

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_41 = 11
				local var_435_42 = utf8.len(var_435_40)
				local var_435_43 = var_435_41 <= 0 and var_435_37 or var_435_37 * (var_435_42 / var_435_41)

				if var_435_43 > 0 and var_435_37 < var_435_43 then
					arg_432_1.talkMaxDuration = var_435_43
					var_435_36 = var_435_36 + 0.3

					if var_435_43 + var_435_36 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_43 + var_435_36
					end
				end

				arg_432_1.text_.text = var_435_40
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_44 = var_435_36 + 0.3
			local var_435_45 = math.max(var_435_37, arg_432_1.talkMaxDuration)

			if var_435_44 <= arg_432_1.time_ and arg_432_1.time_ < var_435_44 + var_435_45 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_44) / var_435_45

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_44 + var_435_45 and arg_432_1.time_ < var_435_44 + var_435_45 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play926011105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 926011105
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play926011106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.325

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(926011105)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 13
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_8 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_8 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_8

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_8 and arg_438_1.time_ < var_441_0 + var_441_8 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play926011106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 926011106
		arg_442_1.duration_ = 2.13

		local var_442_0 = {
			zh = 1.666,
			ja = 2.133
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
				arg_442_0:Play926011107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = "106103"

			if arg_442_1.actors_[var_445_0] == nil then
				local var_445_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_445_1) then
					local var_445_2 = Object.Instantiate(var_445_1, arg_442_1.canvasGo_.transform)

					var_445_2.transform:SetSiblingIndex(1)

					var_445_2.name = var_445_0
					var_445_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_442_1.actors_[var_445_0] = var_445_2

					local var_445_3 = var_445_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_442_1.isInRecall_ then
						for iter_445_0, iter_445_1 in ipairs(var_445_3) do
							iter_445_1.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_445_4 = arg_442_1.actors_["106103"]
			local var_445_5 = 0

			if var_445_5 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 and not isNil(var_445_4) and arg_442_1.var_.actorSpriteComps106103 == nil then
				arg_442_1.var_.actorSpriteComps106103 = var_445_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_6 = 0.2

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_6 and not isNil(var_445_4) then
				local var_445_7 = (arg_442_1.time_ - var_445_5) / var_445_6

				if arg_442_1.var_.actorSpriteComps106103 then
					for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_445_3 then
							if arg_442_1.isInRecall_ then
								local var_445_8 = Mathf.Lerp(iter_445_3.color.r, arg_442_1.hightColor1.r, var_445_7)
								local var_445_9 = Mathf.Lerp(iter_445_3.color.g, arg_442_1.hightColor1.g, var_445_7)
								local var_445_10 = Mathf.Lerp(iter_445_3.color.b, arg_442_1.hightColor1.b, var_445_7)

								iter_445_3.color = Color.New(var_445_8, var_445_9, var_445_10)
							else
								local var_445_11 = Mathf.Lerp(iter_445_3.color.r, 1, var_445_7)

								iter_445_3.color = Color.New(var_445_11, var_445_11, var_445_11)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_5 + var_445_6 and arg_442_1.time_ < var_445_5 + var_445_6 + arg_445_0 and not isNil(var_445_4) and arg_442_1.var_.actorSpriteComps106103 then
				for iter_445_4, iter_445_5 in pairs(arg_442_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_445_5 then
						if arg_442_1.isInRecall_ then
							iter_445_5.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_445_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps106103 = nil
			end

			local var_445_12 = arg_442_1.actors_["106103"].transform
			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1.var_.moveOldPos106103 = var_445_12.localPosition
				var_445_12.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("106103", 3)

				local var_445_14 = var_445_12.childCount

				for iter_445_6 = 0, var_445_14 - 1 do
					local var_445_15 = var_445_12:GetChild(iter_445_6)

					if var_445_15.name == "split_1" or not string.find(var_445_15.name, "split") then
						var_445_15.gameObject:SetActive(true)
					else
						var_445_15.gameObject:SetActive(false)
					end
				end
			end

			local var_445_16 = 0.001

			if var_445_13 <= arg_442_1.time_ and arg_442_1.time_ < var_445_13 + var_445_16 then
				local var_445_17 = (arg_442_1.time_ - var_445_13) / var_445_16
				local var_445_18 = Vector3.New(-36.6, -398.2, -333.7)

				var_445_12.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos106103, var_445_18, var_445_17)
			end

			if arg_442_1.time_ >= var_445_13 + var_445_16 and arg_442_1.time_ < var_445_13 + var_445_16 + arg_445_0 then
				var_445_12.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_445_19 = 0
			local var_445_20 = 0.2

			if var_445_19 < arg_442_1.time_ and arg_442_1.time_ <= var_445_19 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_21 = arg_442_1:FormatText(StoryNameCfg[612].name)

				arg_442_1.leftNameTxt_.text = var_445_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_22 = arg_442_1:GetWordFromCfg(926011106)
				local var_445_23 = arg_442_1:FormatText(var_445_22.content)

				arg_442_1.text_.text = var_445_23

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_24 = 8
				local var_445_25 = utf8.len(var_445_23)
				local var_445_26 = var_445_24 <= 0 and var_445_20 or var_445_20 * (var_445_25 / var_445_24)

				if var_445_26 > 0 and var_445_20 < var_445_26 then
					arg_442_1.talkMaxDuration = var_445_26

					if var_445_26 + var_445_19 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_26 + var_445_19
					end
				end

				arg_442_1.text_.text = var_445_23
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011106", "story_v_out_926011.awb") ~= 0 then
					local var_445_27 = manager.audio:GetVoiceLength("story_v_out_926011", "926011106", "story_v_out_926011.awb") / 1000

					if var_445_27 + var_445_19 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_27 + var_445_19
					end

					if var_445_22.prefab_name ~= "" and arg_442_1.actors_[var_445_22.prefab_name] ~= nil then
						local var_445_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_22.prefab_name].transform, "story_v_out_926011", "926011106", "story_v_out_926011.awb")

						arg_442_1:RecordAudio("926011106", var_445_28)
						arg_442_1:RecordAudio("926011106", var_445_28)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_926011", "926011106", "story_v_out_926011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_926011", "926011106", "story_v_out_926011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_29 = math.max(var_445_20, arg_442_1.talkMaxDuration)

			if var_445_19 <= arg_442_1.time_ and arg_442_1.time_ < var_445_19 + var_445_29 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_19) / var_445_29

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_19 + var_445_29 and arg_442_1.time_ < var_445_19 + var_445_29 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926011107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 926011107
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play926011108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["106103"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps106103 == nil then
				arg_446_1.var_.actorSpriteComps106103 = var_449_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_2 = 0.2

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.actorSpriteComps106103 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								local var_449_4 = Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor2.r, var_449_3)
								local var_449_5 = Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor2.g, var_449_3)
								local var_449_6 = Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor2.b, var_449_3)

								iter_449_1.color = Color.New(var_449_4, var_449_5, var_449_6)
							else
								local var_449_7 = Mathf.Lerp(iter_449_1.color.r, 0.5, var_449_3)

								iter_449_1.color = Color.New(var_449_7, var_449_7, var_449_7)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps106103 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_449_3 then
						if arg_446_1.isInRecall_ then
							iter_449_3.color = arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_449_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps106103 = nil
			end

			local var_449_8 = 0
			local var_449_9 = 0.075

			if var_449_8 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_10 = arg_446_1:FormatText(StoryNameCfg[7].name)

				arg_446_1.leftNameTxt_.text = var_449_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_11 = arg_446_1:GetWordFromCfg(926011107)
				local var_449_12 = arg_446_1:FormatText(var_449_11.content)

				arg_446_1.text_.text = var_449_12

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_13 = 3
				local var_449_14 = utf8.len(var_449_12)
				local var_449_15 = var_449_13 <= 0 and var_449_9 or var_449_9 * (var_449_14 / var_449_13)

				if var_449_15 > 0 and var_449_9 < var_449_15 then
					arg_446_1.talkMaxDuration = var_449_15

					if var_449_15 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_15 + var_449_8
					end
				end

				arg_446_1.text_.text = var_449_12
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_9, arg_446_1.talkMaxDuration)

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_8) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_8 + var_449_16 and arg_446_1.time_ < var_449_8 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play926011108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 926011108
		arg_450_1.duration_ = 1.8

		local var_450_0 = {
			zh = 1,
			ja = 1.8
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
				arg_450_0:Play926011109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["106103"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps106103 == nil then
				arg_450_1.var_.actorSpriteComps106103 = var_453_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_2 = 0.2

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.actorSpriteComps106103 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps106103 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_453_3 then
						if arg_450_1.isInRecall_ then
							iter_453_3.color = arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_453_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps106103 = nil
			end

			local var_453_8 = 0
			local var_453_9 = 0.075

			if var_453_8 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_10 = arg_450_1:FormatText(StoryNameCfg[612].name)

				arg_450_1.leftNameTxt_.text = var_453_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_11 = arg_450_1:GetWordFromCfg(926011108)
				local var_453_12 = arg_450_1:FormatText(var_453_11.content)

				arg_450_1.text_.text = var_453_12

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 3
				local var_453_14 = utf8.len(var_453_12)
				local var_453_15 = var_453_13 <= 0 and var_453_9 or var_453_9 * (var_453_14 / var_453_13)

				if var_453_15 > 0 and var_453_9 < var_453_15 then
					arg_450_1.talkMaxDuration = var_453_15

					if var_453_15 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_15 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_12
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011108", "story_v_out_926011.awb") ~= 0 then
					local var_453_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011108", "story_v_out_926011.awb") / 1000

					if var_453_16 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_16 + var_453_8
					end

					if var_453_11.prefab_name ~= "" and arg_450_1.actors_[var_453_11.prefab_name] ~= nil then
						local var_453_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_11.prefab_name].transform, "story_v_out_926011", "926011108", "story_v_out_926011.awb")

						arg_450_1:RecordAudio("926011108", var_453_17)
						arg_450_1:RecordAudio("926011108", var_453_17)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_926011", "926011108", "story_v_out_926011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_926011", "926011108", "story_v_out_926011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_18 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_18 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_18

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_18 and arg_450_1.time_ < var_453_8 + var_453_18 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play926011109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 926011109
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play926011110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["106103"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.actorSpriteComps106103 == nil then
				arg_454_1.var_.actorSpriteComps106103 = var_457_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_2 = 0.2

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.actorSpriteComps106103 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								local var_457_4 = Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor2.r, var_457_3)
								local var_457_5 = Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor2.g, var_457_3)
								local var_457_6 = Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor2.b, var_457_3)

								iter_457_1.color = Color.New(var_457_4, var_457_5, var_457_6)
							else
								local var_457_7 = Mathf.Lerp(iter_457_1.color.r, 0.5, var_457_3)

								iter_457_1.color = Color.New(var_457_7, var_457_7, var_457_7)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.actorSpriteComps106103 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_457_3 then
						if arg_454_1.isInRecall_ then
							iter_457_3.color = arg_454_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_457_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_454_1.var_.actorSpriteComps106103 = nil
			end

			local var_457_8 = 0
			local var_457_9 = 0.45

			if var_457_8 < arg_454_1.time_ and arg_454_1.time_ <= var_457_8 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_10 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_11 = arg_454_1:GetWordFromCfg(926011109)
				local var_457_12 = arg_454_1:FormatText(var_457_11.content)

				arg_454_1.text_.text = var_457_12

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_13 = 18
				local var_457_14 = utf8.len(var_457_12)
				local var_457_15 = var_457_13 <= 0 and var_457_9 or var_457_9 * (var_457_14 / var_457_13)

				if var_457_15 > 0 and var_457_9 < var_457_15 then
					arg_454_1.talkMaxDuration = var_457_15

					if var_457_15 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_15 + var_457_8
					end
				end

				arg_454_1.text_.text = var_457_12
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_16 = math.max(var_457_9, arg_454_1.talkMaxDuration)

			if var_457_8 <= arg_454_1.time_ and arg_454_1.time_ < var_457_8 + var_457_16 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_8) / var_457_16

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_8 + var_457_16 and arg_454_1.time_ < var_457_8 + var_457_16 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play926011110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 926011110
		arg_458_1.duration_ = 9.93

		local var_458_0 = {
			zh = 8.8,
			ja = 9.933
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play926011111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["106103"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps106103 == nil then
				arg_458_1.var_.actorSpriteComps106103 = var_461_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_461_2 = 0.2

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.actorSpriteComps106103 then
					for iter_461_0, iter_461_1 in pairs(arg_458_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_461_1 then
							if arg_458_1.isInRecall_ then
								local var_461_4 = Mathf.Lerp(iter_461_1.color.r, arg_458_1.hightColor1.r, var_461_3)
								local var_461_5 = Mathf.Lerp(iter_461_1.color.g, arg_458_1.hightColor1.g, var_461_3)
								local var_461_6 = Mathf.Lerp(iter_461_1.color.b, arg_458_1.hightColor1.b, var_461_3)

								iter_461_1.color = Color.New(var_461_4, var_461_5, var_461_6)
							else
								local var_461_7 = Mathf.Lerp(iter_461_1.color.r, 1, var_461_3)

								iter_461_1.color = Color.New(var_461_7, var_461_7, var_461_7)
							end
						end
					end
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps106103 then
				for iter_461_2, iter_461_3 in pairs(arg_458_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_461_3 then
						if arg_458_1.isInRecall_ then
							iter_461_3.color = arg_458_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_461_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_458_1.var_.actorSpriteComps106103 = nil
			end

			local var_461_8 = arg_458_1.actors_["106103"].transform
			local var_461_9 = 0

			if var_461_9 < arg_458_1.time_ and arg_458_1.time_ <= var_461_9 + arg_461_0 then
				arg_458_1.var_.moveOldPos106103 = var_461_8.localPosition
				var_461_8.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("106103", 3)

				local var_461_10 = var_461_8.childCount

				for iter_461_4 = 0, var_461_10 - 1 do
					local var_461_11 = var_461_8:GetChild(iter_461_4)

					if var_461_11.name == "split_4" or not string.find(var_461_11.name, "split") then
						var_461_11.gameObject:SetActive(true)
					else
						var_461_11.gameObject:SetActive(false)
					end
				end
			end

			local var_461_12 = 0.001

			if var_461_9 <= arg_458_1.time_ and arg_458_1.time_ < var_461_9 + var_461_12 then
				local var_461_13 = (arg_458_1.time_ - var_461_9) / var_461_12
				local var_461_14 = Vector3.New(-36.6, -398.2, -333.7)

				var_461_8.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos106103, var_461_14, var_461_13)
			end

			if arg_458_1.time_ >= var_461_9 + var_461_12 and arg_458_1.time_ < var_461_9 + var_461_12 + arg_461_0 then
				var_461_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_461_15 = 0
			local var_461_16 = 0.9

			if var_461_15 < arg_458_1.time_ and arg_458_1.time_ <= var_461_15 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_17 = arg_458_1:FormatText(StoryNameCfg[612].name)

				arg_458_1.leftNameTxt_.text = var_461_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_18 = arg_458_1:GetWordFromCfg(926011110)
				local var_461_19 = arg_458_1:FormatText(var_461_18.content)

				arg_458_1.text_.text = var_461_19

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_20 = 36
				local var_461_21 = utf8.len(var_461_19)
				local var_461_22 = var_461_20 <= 0 and var_461_16 or var_461_16 * (var_461_21 / var_461_20)

				if var_461_22 > 0 and var_461_16 < var_461_22 then
					arg_458_1.talkMaxDuration = var_461_22

					if var_461_22 + var_461_15 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_22 + var_461_15
					end
				end

				arg_458_1.text_.text = var_461_19
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011110", "story_v_out_926011.awb") ~= 0 then
					local var_461_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011110", "story_v_out_926011.awb") / 1000

					if var_461_23 + var_461_15 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_23 + var_461_15
					end

					if var_461_18.prefab_name ~= "" and arg_458_1.actors_[var_461_18.prefab_name] ~= nil then
						local var_461_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_18.prefab_name].transform, "story_v_out_926011", "926011110", "story_v_out_926011.awb")

						arg_458_1:RecordAudio("926011110", var_461_24)
						arg_458_1:RecordAudio("926011110", var_461_24)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_926011", "926011110", "story_v_out_926011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_926011", "926011110", "story_v_out_926011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_25 = math.max(var_461_16, arg_458_1.talkMaxDuration)

			if var_461_15 <= arg_458_1.time_ and arg_458_1.time_ < var_461_15 + var_461_25 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_15) / var_461_25

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_15 + var_461_25 and arg_458_1.time_ < var_461_15 + var_461_25 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926011111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 926011111
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play926011112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["106103"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps106103 == nil then
				arg_462_1.var_.actorSpriteComps106103 = var_465_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_2 = 0.2

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.actorSpriteComps106103 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								local var_465_4 = Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor2.r, var_465_3)
								local var_465_5 = Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor2.g, var_465_3)
								local var_465_6 = Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor2.b, var_465_3)

								iter_465_1.color = Color.New(var_465_4, var_465_5, var_465_6)
							else
								local var_465_7 = Mathf.Lerp(iter_465_1.color.r, 0.5, var_465_3)

								iter_465_1.color = Color.New(var_465_7, var_465_7, var_465_7)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps106103 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_465_3 then
						if arg_462_1.isInRecall_ then
							iter_465_3.color = arg_462_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_465_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_462_1.var_.actorSpriteComps106103 = nil
			end

			local var_465_8 = 0
			local var_465_9 = 0.45

			if var_465_8 < arg_462_1.time_ and arg_462_1.time_ <= var_465_8 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_10 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_11 = arg_462_1:GetWordFromCfg(926011111)
				local var_465_12 = arg_462_1:FormatText(var_465_11.content)

				arg_462_1.text_.text = var_465_12

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_13 = 18
				local var_465_14 = utf8.len(var_465_12)
				local var_465_15 = var_465_13 <= 0 and var_465_9 or var_465_9 * (var_465_14 / var_465_13)

				if var_465_15 > 0 and var_465_9 < var_465_15 then
					arg_462_1.talkMaxDuration = var_465_15

					if var_465_15 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_15 + var_465_8
					end
				end

				arg_462_1.text_.text = var_465_12
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_16 = math.max(var_465_9, arg_462_1.talkMaxDuration)

			if var_465_8 <= arg_462_1.time_ and arg_462_1.time_ < var_465_8 + var_465_16 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_8) / var_465_16

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_8 + var_465_16 and arg_462_1.time_ < var_465_8 + var_465_16 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play926011112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 926011112
		arg_466_1.duration_ = 8.23

		local var_466_0 = {
			zh = 4.633,
			ja = 8.233
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
				arg_466_0:Play926011113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["106103"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps106103 == nil then
				arg_466_1.var_.actorSpriteComps106103 = var_469_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_2 = 0.2

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.actorSpriteComps106103 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps106103 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_469_3 then
						if arg_466_1.isInRecall_ then
							iter_469_3.color = arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_469_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_466_1.var_.actorSpriteComps106103 = nil
			end

			local var_469_8 = arg_466_1.actors_["106103"].transform
			local var_469_9 = 0

			if var_469_9 < arg_466_1.time_ and arg_466_1.time_ <= var_469_9 + arg_469_0 then
				arg_466_1.var_.moveOldPos106103 = var_469_8.localPosition
				var_469_8.localScale = Vector3.New(1, 1, 1)

				arg_466_1:CheckSpriteTmpPos("106103", 3)

				local var_469_10 = var_469_8.childCount

				for iter_469_4 = 0, var_469_10 - 1 do
					local var_469_11 = var_469_8:GetChild(iter_469_4)

					if var_469_11.name == "split_3" or not string.find(var_469_11.name, "split") then
						var_469_11.gameObject:SetActive(true)
					else
						var_469_11.gameObject:SetActive(false)
					end
				end
			end

			local var_469_12 = 0.001

			if var_469_9 <= arg_466_1.time_ and arg_466_1.time_ < var_469_9 + var_469_12 then
				local var_469_13 = (arg_466_1.time_ - var_469_9) / var_469_12
				local var_469_14 = Vector3.New(-36.6, -398.2, -333.7)

				var_469_8.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos106103, var_469_14, var_469_13)
			end

			if arg_466_1.time_ >= var_469_9 + var_469_12 and arg_466_1.time_ < var_469_9 + var_469_12 + arg_469_0 then
				var_469_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_469_15 = 0
			local var_469_16 = 0.475

			if var_469_15 < arg_466_1.time_ and arg_466_1.time_ <= var_469_15 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_17 = arg_466_1:FormatText(StoryNameCfg[612].name)

				arg_466_1.leftNameTxt_.text = var_469_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_18 = arg_466_1:GetWordFromCfg(926011112)
				local var_469_19 = arg_466_1:FormatText(var_469_18.content)

				arg_466_1.text_.text = var_469_19

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_20 = 19
				local var_469_21 = utf8.len(var_469_19)
				local var_469_22 = var_469_20 <= 0 and var_469_16 or var_469_16 * (var_469_21 / var_469_20)

				if var_469_22 > 0 and var_469_16 < var_469_22 then
					arg_466_1.talkMaxDuration = var_469_22

					if var_469_22 + var_469_15 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_22 + var_469_15
					end
				end

				arg_466_1.text_.text = var_469_19
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011112", "story_v_out_926011.awb") ~= 0 then
					local var_469_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011112", "story_v_out_926011.awb") / 1000

					if var_469_23 + var_469_15 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_23 + var_469_15
					end

					if var_469_18.prefab_name ~= "" and arg_466_1.actors_[var_469_18.prefab_name] ~= nil then
						local var_469_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_18.prefab_name].transform, "story_v_out_926011", "926011112", "story_v_out_926011.awb")

						arg_466_1:RecordAudio("926011112", var_469_24)
						arg_466_1:RecordAudio("926011112", var_469_24)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_926011", "926011112", "story_v_out_926011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_926011", "926011112", "story_v_out_926011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_25 = math.max(var_469_16, arg_466_1.talkMaxDuration)

			if var_469_15 <= arg_466_1.time_ and arg_466_1.time_ < var_469_15 + var_469_25 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_15) / var_469_25

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_15 + var_469_25 and arg_466_1.time_ < var_469_15 + var_469_25 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926011113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 926011113
		arg_470_1.duration_ = 8.8

		local var_470_0 = {
			zh = 6.3,
			ja = 8.8
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
				arg_470_0:Play926011114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.775

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[612].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:GetWordFromCfg(926011113)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 31
				local var_473_6 = utf8.len(var_473_4)
				local var_473_7 = var_473_5 <= 0 and var_473_1 or var_473_1 * (var_473_6 / var_473_5)

				if var_473_7 > 0 and var_473_1 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011113", "story_v_out_926011.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011113", "story_v_out_926011.awb") / 1000

					if var_473_8 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_0
					end

					if var_473_3.prefab_name ~= "" and arg_470_1.actors_[var_473_3.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_3.prefab_name].transform, "story_v_out_926011", "926011113", "story_v_out_926011.awb")

						arg_470_1:RecordAudio("926011113", var_473_9)
						arg_470_1:RecordAudio("926011113", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_926011", "926011113", "story_v_out_926011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_926011", "926011113", "story_v_out_926011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_10 and arg_470_1.time_ < var_473_0 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play926011114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 926011114
		arg_474_1.duration_ = 7.93

		local var_474_0 = {
			zh = 7.733,
			ja = 7.933
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
				arg_474_0:Play926011115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["106103"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos106103 = var_477_0.localPosition
				var_477_0.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("106103", 3)

				local var_477_2 = var_477_0.childCount

				for iter_477_0 = 0, var_477_2 - 1 do
					local var_477_3 = var_477_0:GetChild(iter_477_0)

					if var_477_3.name == "split_1" or not string.find(var_477_3.name, "split") then
						var_477_3.gameObject:SetActive(true)
					else
						var_477_3.gameObject:SetActive(false)
					end
				end
			end

			local var_477_4 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_4 then
				local var_477_5 = (arg_474_1.time_ - var_477_1) / var_477_4
				local var_477_6 = Vector3.New(-36.6, -398.2, -333.7)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos106103, var_477_6, var_477_5)
			end

			if arg_474_1.time_ >= var_477_1 + var_477_4 and arg_474_1.time_ < var_477_1 + var_477_4 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_477_7 = 0
			local var_477_8 = 0.95

			if var_477_7 < arg_474_1.time_ and arg_474_1.time_ <= var_477_7 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_9 = arg_474_1:FormatText(StoryNameCfg[612].name)

				arg_474_1.leftNameTxt_.text = var_477_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_10 = arg_474_1:GetWordFromCfg(926011114)
				local var_477_11 = arg_474_1:FormatText(var_477_10.content)

				arg_474_1.text_.text = var_477_11

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_12 = 38
				local var_477_13 = utf8.len(var_477_11)
				local var_477_14 = var_477_12 <= 0 and var_477_8 or var_477_8 * (var_477_13 / var_477_12)

				if var_477_14 > 0 and var_477_8 < var_477_14 then
					arg_474_1.talkMaxDuration = var_477_14

					if var_477_14 + var_477_7 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_14 + var_477_7
					end
				end

				arg_474_1.text_.text = var_477_11
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011114", "story_v_out_926011.awb") ~= 0 then
					local var_477_15 = manager.audio:GetVoiceLength("story_v_out_926011", "926011114", "story_v_out_926011.awb") / 1000

					if var_477_15 + var_477_7 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_15 + var_477_7
					end

					if var_477_10.prefab_name ~= "" and arg_474_1.actors_[var_477_10.prefab_name] ~= nil then
						local var_477_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_10.prefab_name].transform, "story_v_out_926011", "926011114", "story_v_out_926011.awb")

						arg_474_1:RecordAudio("926011114", var_477_16)
						arg_474_1:RecordAudio("926011114", var_477_16)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_926011", "926011114", "story_v_out_926011.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_926011", "926011114", "story_v_out_926011.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_17 = math.max(var_477_8, arg_474_1.talkMaxDuration)

			if var_477_7 <= arg_474_1.time_ and arg_474_1.time_ < var_477_7 + var_477_17 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_7) / var_477_17

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_7 + var_477_17 and arg_474_1.time_ < var_477_7 + var_477_17 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926011115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 926011115
		arg_478_1.duration_ = 4.73

		local var_478_0 = {
			zh = 2.933,
			ja = 4.733
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
				arg_478_0:Play926011116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["128404"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.actorSpriteComps128404 == nil then
				arg_478_1.var_.actorSpriteComps128404 = var_481_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_2 = 0.2

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.actorSpriteComps128404 then
					for iter_481_0, iter_481_1 in pairs(arg_478_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.actorSpriteComps128404 then
				for iter_481_2, iter_481_3 in pairs(arg_478_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_481_3 then
						if arg_478_1.isInRecall_ then
							iter_481_3.color = arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_481_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps128404 = nil
			end

			local var_481_8 = arg_478_1.actors_["106103"]
			local var_481_9 = 0

			if var_481_9 < arg_478_1.time_ and arg_478_1.time_ <= var_481_9 + arg_481_0 and not isNil(var_481_8) and arg_478_1.var_.actorSpriteComps106103 == nil then
				arg_478_1.var_.actorSpriteComps106103 = var_481_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_10 = 0.2

			if var_481_9 <= arg_478_1.time_ and arg_478_1.time_ < var_481_9 + var_481_10 and not isNil(var_481_8) then
				local var_481_11 = (arg_478_1.time_ - var_481_9) / var_481_10

				if arg_478_1.var_.actorSpriteComps106103 then
					for iter_481_4, iter_481_5 in pairs(arg_478_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_478_1.time_ >= var_481_9 + var_481_10 and arg_478_1.time_ < var_481_9 + var_481_10 + arg_481_0 and not isNil(var_481_8) and arg_478_1.var_.actorSpriteComps106103 then
				for iter_481_6, iter_481_7 in pairs(arg_478_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_481_7 then
						if arg_478_1.isInRecall_ then
							iter_481_7.color = arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_481_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps106103 = nil
			end

			local var_481_16 = 0
			local var_481_17 = 0.45

			if var_481_16 < arg_478_1.time_ and arg_478_1.time_ <= var_481_16 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_18 = arg_478_1:FormatText(StoryNameCfg[6].name)

				arg_478_1.leftNameTxt_.text = var_481_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_19 = arg_478_1:GetWordFromCfg(926011115)
				local var_481_20 = arg_478_1:FormatText(var_481_19.content)

				arg_478_1.text_.text = var_481_20

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_21 = 18
				local var_481_22 = utf8.len(var_481_20)
				local var_481_23 = var_481_21 <= 0 and var_481_17 or var_481_17 * (var_481_22 / var_481_21)

				if var_481_23 > 0 and var_481_17 < var_481_23 then
					arg_478_1.talkMaxDuration = var_481_23

					if var_481_23 + var_481_16 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_23 + var_481_16
					end
				end

				arg_478_1.text_.text = var_481_20
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011115", "story_v_out_926011.awb") ~= 0 then
					local var_481_24 = manager.audio:GetVoiceLength("story_v_out_926011", "926011115", "story_v_out_926011.awb") / 1000

					if var_481_24 + var_481_16 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_24 + var_481_16
					end

					if var_481_19.prefab_name ~= "" and arg_478_1.actors_[var_481_19.prefab_name] ~= nil then
						local var_481_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_19.prefab_name].transform, "story_v_out_926011", "926011115", "story_v_out_926011.awb")

						arg_478_1:RecordAudio("926011115", var_481_25)
						arg_478_1:RecordAudio("926011115", var_481_25)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_926011", "926011115", "story_v_out_926011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_926011", "926011115", "story_v_out_926011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_26 = math.max(var_481_17, arg_478_1.talkMaxDuration)

			if var_481_16 <= arg_478_1.time_ and arg_478_1.time_ < var_481_16 + var_481_26 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_16) / var_481_26

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_16 + var_481_26 and arg_478_1.time_ < var_481_16 + var_481_26 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play926011116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 926011116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play926011117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["128404"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps128404 == nil then
				arg_482_1.var_.actorSpriteComps128404 = var_485_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_2 = 0.2

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.actorSpriteComps128404 then
					for iter_485_0, iter_485_1 in pairs(arg_482_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_485_1 then
							if arg_482_1.isInRecall_ then
								local var_485_4 = Mathf.Lerp(iter_485_1.color.r, arg_482_1.hightColor2.r, var_485_3)
								local var_485_5 = Mathf.Lerp(iter_485_1.color.g, arg_482_1.hightColor2.g, var_485_3)
								local var_485_6 = Mathf.Lerp(iter_485_1.color.b, arg_482_1.hightColor2.b, var_485_3)

								iter_485_1.color = Color.New(var_485_4, var_485_5, var_485_6)
							else
								local var_485_7 = Mathf.Lerp(iter_485_1.color.r, 0.5, var_485_3)

								iter_485_1.color = Color.New(var_485_7, var_485_7, var_485_7)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps128404 then
				for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_485_3 then
						if arg_482_1.isInRecall_ then
							iter_485_3.color = arg_482_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_485_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_482_1.var_.actorSpriteComps128404 = nil
			end

			local var_485_8 = arg_482_1.actors_["106103"].transform
			local var_485_9 = 0

			if var_485_9 < arg_482_1.time_ and arg_482_1.time_ <= var_485_9 + arg_485_0 then
				arg_482_1.var_.moveOldPos106103 = var_485_8.localPosition
				var_485_8.localScale = Vector3.New(1, 1, 1)

				arg_482_1:CheckSpriteTmpPos("106103", 7)

				local var_485_10 = var_485_8.childCount

				for iter_485_4 = 0, var_485_10 - 1 do
					local var_485_11 = var_485_8:GetChild(iter_485_4)

					if var_485_11.name == "" or not string.find(var_485_11.name, "split") then
						var_485_11.gameObject:SetActive(true)
					else
						var_485_11.gameObject:SetActive(false)
					end
				end
			end

			local var_485_12 = 0.001

			if var_485_9 <= arg_482_1.time_ and arg_482_1.time_ < var_485_9 + var_485_12 then
				local var_485_13 = (arg_482_1.time_ - var_485_9) / var_485_12
				local var_485_14 = Vector3.New(0, -2000, 0)

				var_485_8.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos106103, var_485_14, var_485_13)
			end

			if arg_482_1.time_ >= var_485_9 + var_485_12 and arg_482_1.time_ < var_485_9 + var_485_12 + arg_485_0 then
				var_485_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_485_15 = 0
			local var_485_16 = 1.225

			if var_485_15 < arg_482_1.time_ and arg_482_1.time_ <= var_485_15 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_17 = arg_482_1:GetWordFromCfg(926011116)
				local var_485_18 = arg_482_1:FormatText(var_485_17.content)

				arg_482_1.text_.text = var_485_18

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_19 = 49
				local var_485_20 = utf8.len(var_485_18)
				local var_485_21 = var_485_19 <= 0 and var_485_16 or var_485_16 * (var_485_20 / var_485_19)

				if var_485_21 > 0 and var_485_16 < var_485_21 then
					arg_482_1.talkMaxDuration = var_485_21

					if var_485_21 + var_485_15 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_21 + var_485_15
					end
				end

				arg_482_1.text_.text = var_485_18
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_22 = math.max(var_485_16, arg_482_1.talkMaxDuration)

			if var_485_15 <= arg_482_1.time_ and arg_482_1.time_ < var_485_15 + var_485_22 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_15) / var_485_22

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_15 + var_485_22 and arg_482_1.time_ < var_485_15 + var_485_22 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play926011117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 926011117
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play926011118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["106103"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos106103 = var_489_0.localPosition
				var_489_0.localScale = Vector3.New(1, 1, 1)

				arg_486_1:CheckSpriteTmpPos("106103", 7)

				local var_489_2 = var_489_0.childCount

				for iter_489_0 = 0, var_489_2 - 1 do
					local var_489_3 = var_489_0:GetChild(iter_489_0)

					if var_489_3.name == "" or not string.find(var_489_3.name, "split") then
						var_489_3.gameObject:SetActive(true)
					else
						var_489_3.gameObject:SetActive(false)
					end
				end
			end

			local var_489_4 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_4 then
				local var_489_5 = (arg_486_1.time_ - var_489_1) / var_489_4
				local var_489_6 = Vector3.New(0, -2000, 0)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos106103, var_489_6, var_489_5)
			end

			if arg_486_1.time_ >= var_489_1 + var_489_4 and arg_486_1.time_ < var_489_1 + var_489_4 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_489_7 = 0
			local var_489_8 = 0.55

			if var_489_7 < arg_486_1.time_ and arg_486_1.time_ <= var_489_7 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_9 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_10 = arg_486_1:GetWordFromCfg(926011117)
				local var_489_11 = arg_486_1:FormatText(var_489_10.content)

				arg_486_1.text_.text = var_489_11

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_12 = 22
				local var_489_13 = utf8.len(var_489_11)
				local var_489_14 = var_489_12 <= 0 and var_489_8 or var_489_8 * (var_489_13 / var_489_12)

				if var_489_14 > 0 and var_489_8 < var_489_14 then
					arg_486_1.talkMaxDuration = var_489_14

					if var_489_14 + var_489_7 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_14 + var_489_7
					end
				end

				arg_486_1.text_.text = var_489_11
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_15 = math.max(var_489_8, arg_486_1.talkMaxDuration)

			if var_489_7 <= arg_486_1.time_ and arg_486_1.time_ < var_489_7 + var_489_15 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_7) / var_489_15

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_7 + var_489_15 and arg_486_1.time_ < var_489_7 + var_489_15 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play926011118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 926011118
		arg_490_1.duration_ = 4.17

		local var_490_0 = {
			zh = 3.1,
			ja = 4.166
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
				arg_490_0:Play926011119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["128404"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps128404 == nil then
				arg_490_1.var_.actorSpriteComps128404 = var_493_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_2 = 0.2

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.actorSpriteComps128404 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps128404 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_493_3 then
						if arg_490_1.isInRecall_ then
							iter_493_3.color = arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_493_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_490_1.var_.actorSpriteComps128404 = nil
			end

			local var_493_8 = arg_490_1.actors_["128404"].transform
			local var_493_9 = 0

			if var_493_9 < arg_490_1.time_ and arg_490_1.time_ <= var_493_9 + arg_493_0 then
				arg_490_1.var_.moveOldPos128404 = var_493_8.localPosition
				var_493_8.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("128404", 3)

				local var_493_10 = var_493_8.childCount

				for iter_493_4 = 0, var_493_10 - 1 do
					local var_493_11 = var_493_8:GetChild(iter_493_4)

					if var_493_11.name == "" or not string.find(var_493_11.name, "split") then
						var_493_11.gameObject:SetActive(true)
					else
						var_493_11.gameObject:SetActive(false)
					end
				end
			end

			local var_493_12 = 0.001

			if var_493_9 <= arg_490_1.time_ and arg_490_1.time_ < var_493_9 + var_493_12 then
				local var_493_13 = (arg_490_1.time_ - var_493_9) / var_493_12
				local var_493_14 = Vector3.New(-16.1, -362, -375)

				var_493_8.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos128404, var_493_14, var_493_13)
			end

			if arg_490_1.time_ >= var_493_9 + var_493_12 and arg_490_1.time_ < var_493_9 + var_493_12 + arg_493_0 then
				var_493_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_493_15 = 0
			local var_493_16 = 0.35

			if var_493_15 < arg_490_1.time_ and arg_490_1.time_ <= var_493_15 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_17 = arg_490_1:FormatText(StoryNameCfg[6].name)

				arg_490_1.leftNameTxt_.text = var_493_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_18 = arg_490_1:GetWordFromCfg(926011118)
				local var_493_19 = arg_490_1:FormatText(var_493_18.content)

				arg_490_1.text_.text = var_493_19

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_20 = 14
				local var_493_21 = utf8.len(var_493_19)
				local var_493_22 = var_493_20 <= 0 and var_493_16 or var_493_16 * (var_493_21 / var_493_20)

				if var_493_22 > 0 and var_493_16 < var_493_22 then
					arg_490_1.talkMaxDuration = var_493_22

					if var_493_22 + var_493_15 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_22 + var_493_15
					end
				end

				arg_490_1.text_.text = var_493_19
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011118", "story_v_out_926011.awb") ~= 0 then
					local var_493_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011118", "story_v_out_926011.awb") / 1000

					if var_493_23 + var_493_15 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_23 + var_493_15
					end

					if var_493_18.prefab_name ~= "" and arg_490_1.actors_[var_493_18.prefab_name] ~= nil then
						local var_493_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_18.prefab_name].transform, "story_v_out_926011", "926011118", "story_v_out_926011.awb")

						arg_490_1:RecordAudio("926011118", var_493_24)
						arg_490_1:RecordAudio("926011118", var_493_24)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_926011", "926011118", "story_v_out_926011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_926011", "926011118", "story_v_out_926011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_25 = math.max(var_493_16, arg_490_1.talkMaxDuration)

			if var_493_15 <= arg_490_1.time_ and arg_490_1.time_ < var_493_15 + var_493_25 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_15) / var_493_25

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_15 + var_493_25 and arg_490_1.time_ < var_493_15 + var_493_25 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
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

		arg_490_1:InitPlayNodeList()
	end,
	Play926011119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 926011119
		arg_494_1.duration_ = 5.7

		local var_494_0 = {
			zh = 4.2,
			ja = 5.7
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play926011120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.575

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[6].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_3 = arg_494_1:GetWordFromCfg(926011119)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 23
				local var_497_6 = utf8.len(var_497_4)
				local var_497_7 = var_497_5 <= 0 and var_497_1 or var_497_1 * (var_497_6 / var_497_5)

				if var_497_7 > 0 and var_497_1 < var_497_7 then
					arg_494_1.talkMaxDuration = var_497_7

					if var_497_7 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011119", "story_v_out_926011.awb") ~= 0 then
					local var_497_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011119", "story_v_out_926011.awb") / 1000

					if var_497_8 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_0
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_out_926011", "926011119", "story_v_out_926011.awb")

						arg_494_1:RecordAudio("926011119", var_497_9)
						arg_494_1:RecordAudio("926011119", var_497_9)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_926011", "926011119", "story_v_out_926011.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_926011", "926011119", "story_v_out_926011.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_10 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_10 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_10

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_10 and arg_494_1.time_ < var_497_0 + var_497_10 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play926011120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 926011120
		arg_498_1.duration_ = 4.33

		local var_498_0 = {
			zh = 3.666,
			ja = 4.333
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
				arg_498_0:Play926011121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["106103"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.actorSpriteComps106103 == nil then
				arg_498_1.var_.actorSpriteComps106103 = var_501_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_2 = 0.2

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.actorSpriteComps106103 then
					for iter_501_0, iter_501_1 in pairs(arg_498_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.actorSpriteComps106103 then
				for iter_501_2, iter_501_3 in pairs(arg_498_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_501_3 then
						if arg_498_1.isInRecall_ then
							iter_501_3.color = arg_498_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_501_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_498_1.var_.actorSpriteComps106103 = nil
			end

			local var_501_8 = arg_498_1.actors_["128404"]
			local var_501_9 = 0

			if var_501_9 < arg_498_1.time_ and arg_498_1.time_ <= var_501_9 + arg_501_0 and not isNil(var_501_8) and arg_498_1.var_.actorSpriteComps128404 == nil then
				arg_498_1.var_.actorSpriteComps128404 = var_501_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_10 = 0.2

			if var_501_9 <= arg_498_1.time_ and arg_498_1.time_ < var_501_9 + var_501_10 and not isNil(var_501_8) then
				local var_501_11 = (arg_498_1.time_ - var_501_9) / var_501_10

				if arg_498_1.var_.actorSpriteComps128404 then
					for iter_501_4, iter_501_5 in pairs(arg_498_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_501_5 then
							if arg_498_1.isInRecall_ then
								local var_501_12 = Mathf.Lerp(iter_501_5.color.r, arg_498_1.hightColor2.r, var_501_11)
								local var_501_13 = Mathf.Lerp(iter_501_5.color.g, arg_498_1.hightColor2.g, var_501_11)
								local var_501_14 = Mathf.Lerp(iter_501_5.color.b, arg_498_1.hightColor2.b, var_501_11)

								iter_501_5.color = Color.New(var_501_12, var_501_13, var_501_14)
							else
								local var_501_15 = Mathf.Lerp(iter_501_5.color.r, 0.5, var_501_11)

								iter_501_5.color = Color.New(var_501_15, var_501_15, var_501_15)
							end
						end
					end
				end
			end

			if arg_498_1.time_ >= var_501_9 + var_501_10 and arg_498_1.time_ < var_501_9 + var_501_10 + arg_501_0 and not isNil(var_501_8) and arg_498_1.var_.actorSpriteComps128404 then
				for iter_501_6, iter_501_7 in pairs(arg_498_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_501_7 then
						if arg_498_1.isInRecall_ then
							iter_501_7.color = arg_498_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_501_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_498_1.var_.actorSpriteComps128404 = nil
			end

			local var_501_16 = arg_498_1.actors_["128404"].transform
			local var_501_17 = 0

			if var_501_17 < arg_498_1.time_ and arg_498_1.time_ <= var_501_17 + arg_501_0 then
				arg_498_1.var_.moveOldPos128404 = var_501_16.localPosition
				var_501_16.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("128404", 7)

				local var_501_18 = var_501_16.childCount

				for iter_501_8 = 0, var_501_18 - 1 do
					local var_501_19 = var_501_16:GetChild(iter_501_8)

					if var_501_19.name == "" or not string.find(var_501_19.name, "split") then
						var_501_19.gameObject:SetActive(true)
					else
						var_501_19.gameObject:SetActive(false)
					end
				end
			end

			local var_501_20 = 0.001

			if var_501_17 <= arg_498_1.time_ and arg_498_1.time_ < var_501_17 + var_501_20 then
				local var_501_21 = (arg_498_1.time_ - var_501_17) / var_501_20
				local var_501_22 = Vector3.New(0, -2000, 0)

				var_501_16.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos128404, var_501_22, var_501_21)
			end

			if arg_498_1.time_ >= var_501_17 + var_501_20 and arg_498_1.time_ < var_501_17 + var_501_20 + arg_501_0 then
				var_501_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_501_23 = arg_498_1.actors_["106103"].transform
			local var_501_24 = 0

			if var_501_24 < arg_498_1.time_ and arg_498_1.time_ <= var_501_24 + arg_501_0 then
				arg_498_1.var_.moveOldPos106103 = var_501_23.localPosition
				var_501_23.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("106103", 3)

				local var_501_25 = var_501_23.childCount

				for iter_501_9 = 0, var_501_25 - 1 do
					local var_501_26 = var_501_23:GetChild(iter_501_9)

					if var_501_26.name == "split_4" or not string.find(var_501_26.name, "split") then
						var_501_26.gameObject:SetActive(true)
					else
						var_501_26.gameObject:SetActive(false)
					end
				end
			end

			local var_501_27 = 0.001

			if var_501_24 <= arg_498_1.time_ and arg_498_1.time_ < var_501_24 + var_501_27 then
				local var_501_28 = (arg_498_1.time_ - var_501_24) / var_501_27
				local var_501_29 = Vector3.New(-36.6, -398.2, -333.7)

				var_501_23.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos106103, var_501_29, var_501_28)
			end

			if arg_498_1.time_ >= var_501_24 + var_501_27 and arg_498_1.time_ < var_501_24 + var_501_27 + arg_501_0 then
				var_501_23.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_501_30 = 0
			local var_501_31 = 0.375

			if var_501_30 < arg_498_1.time_ and arg_498_1.time_ <= var_501_30 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_32 = arg_498_1:FormatText(StoryNameCfg[612].name)

				arg_498_1.leftNameTxt_.text = var_501_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_33 = arg_498_1:GetWordFromCfg(926011120)
				local var_501_34 = arg_498_1:FormatText(var_501_33.content)

				arg_498_1.text_.text = var_501_34

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_35 = 15
				local var_501_36 = utf8.len(var_501_34)
				local var_501_37 = var_501_35 <= 0 and var_501_31 or var_501_31 * (var_501_36 / var_501_35)

				if var_501_37 > 0 and var_501_31 < var_501_37 then
					arg_498_1.talkMaxDuration = var_501_37

					if var_501_37 + var_501_30 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_37 + var_501_30
					end
				end

				arg_498_1.text_.text = var_501_34
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011120", "story_v_out_926011.awb") ~= 0 then
					local var_501_38 = manager.audio:GetVoiceLength("story_v_out_926011", "926011120", "story_v_out_926011.awb") / 1000

					if var_501_38 + var_501_30 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_38 + var_501_30
					end

					if var_501_33.prefab_name ~= "" and arg_498_1.actors_[var_501_33.prefab_name] ~= nil then
						local var_501_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_33.prefab_name].transform, "story_v_out_926011", "926011120", "story_v_out_926011.awb")

						arg_498_1:RecordAudio("926011120", var_501_39)
						arg_498_1:RecordAudio("926011120", var_501_39)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_926011", "926011120", "story_v_out_926011.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_926011", "926011120", "story_v_out_926011.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_40 = math.max(var_501_31, arg_498_1.talkMaxDuration)

			if var_501_30 <= arg_498_1.time_ and arg_498_1.time_ < var_501_30 + var_501_40 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_30) / var_501_40

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_30 + var_501_40 and arg_498_1.time_ < var_501_30 + var_501_40 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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
				actorName = "106103",
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
	Play926011121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 926011121
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play926011122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["106103"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.actorSpriteComps106103 == nil then
				arg_502_1.var_.actorSpriteComps106103 = var_505_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_2 = 0.2

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.actorSpriteComps106103 then
					for iter_505_0, iter_505_1 in pairs(arg_502_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_505_1 then
							if arg_502_1.isInRecall_ then
								local var_505_4 = Mathf.Lerp(iter_505_1.color.r, arg_502_1.hightColor2.r, var_505_3)
								local var_505_5 = Mathf.Lerp(iter_505_1.color.g, arg_502_1.hightColor2.g, var_505_3)
								local var_505_6 = Mathf.Lerp(iter_505_1.color.b, arg_502_1.hightColor2.b, var_505_3)

								iter_505_1.color = Color.New(var_505_4, var_505_5, var_505_6)
							else
								local var_505_7 = Mathf.Lerp(iter_505_1.color.r, 0.5, var_505_3)

								iter_505_1.color = Color.New(var_505_7, var_505_7, var_505_7)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.actorSpriteComps106103 then
				for iter_505_2, iter_505_3 in pairs(arg_502_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_505_3 then
						if arg_502_1.isInRecall_ then
							iter_505_3.color = arg_502_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_505_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_502_1.var_.actorSpriteComps106103 = nil
			end

			local var_505_8 = arg_502_1.actors_["106103"].transform
			local var_505_9 = 0

			if var_505_9 < arg_502_1.time_ and arg_502_1.time_ <= var_505_9 + arg_505_0 then
				arg_502_1.var_.moveOldPos106103 = var_505_8.localPosition
				var_505_8.localScale = Vector3.New(1, 1, 1)

				arg_502_1:CheckSpriteTmpPos("106103", 7)

				local var_505_10 = var_505_8.childCount

				for iter_505_4 = 0, var_505_10 - 1 do
					local var_505_11 = var_505_8:GetChild(iter_505_4)

					if var_505_11.name == "" or not string.find(var_505_11.name, "split") then
						var_505_11.gameObject:SetActive(true)
					else
						var_505_11.gameObject:SetActive(false)
					end
				end
			end

			local var_505_12 = 0.001

			if var_505_9 <= arg_502_1.time_ and arg_502_1.time_ < var_505_9 + var_505_12 then
				local var_505_13 = (arg_502_1.time_ - var_505_9) / var_505_12
				local var_505_14 = Vector3.New(0, -2000, 0)

				var_505_8.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos106103, var_505_14, var_505_13)
			end

			if arg_502_1.time_ >= var_505_9 + var_505_12 and arg_502_1.time_ < var_505_9 + var_505_12 + arg_505_0 then
				var_505_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_505_15 = 0.2
			local var_505_16 = 1

			if var_505_15 < arg_502_1.time_ and arg_502_1.time_ <= var_505_15 + arg_505_0 then
				local var_505_17 = "play"
				local var_505_18 = "effect"

				arg_502_1:AudioAction(var_505_17, var_505_18, "se_story_143", "se_story_143_wave", "")
			end

			local var_505_19 = 0
			local var_505_20 = 1.025

			if var_505_19 < arg_502_1.time_ and arg_502_1.time_ <= var_505_19 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_21 = arg_502_1:GetWordFromCfg(926011121)
				local var_505_22 = arg_502_1:FormatText(var_505_21.content)

				arg_502_1.text_.text = var_505_22

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_23 = 41
				local var_505_24 = utf8.len(var_505_22)
				local var_505_25 = var_505_23 <= 0 and var_505_20 or var_505_20 * (var_505_24 / var_505_23)

				if var_505_25 > 0 and var_505_20 < var_505_25 then
					arg_502_1.talkMaxDuration = var_505_25

					if var_505_25 + var_505_19 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_25 + var_505_19
					end
				end

				arg_502_1.text_.text = var_505_22
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_26 = math.max(var_505_20, arg_502_1.talkMaxDuration)

			if var_505_19 <= arg_502_1.time_ and arg_502_1.time_ < var_505_19 + var_505_26 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_19) / var_505_26

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_19 + var_505_26 and arg_502_1.time_ < var_505_19 + var_505_26 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play926011122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 926011122
		arg_506_1.duration_ = 16.53

		local var_506_0 = {
			zh = 11.233,
			ja = 16.533
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play926011123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["106103"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.actorSpriteComps106103 == nil then
				arg_506_1.var_.actorSpriteComps106103 = var_509_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_509_2 = 0.2

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.actorSpriteComps106103 then
					for iter_509_0, iter_509_1 in pairs(arg_506_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_509_1 then
							if arg_506_1.isInRecall_ then
								local var_509_4 = Mathf.Lerp(iter_509_1.color.r, arg_506_1.hightColor1.r, var_509_3)
								local var_509_5 = Mathf.Lerp(iter_509_1.color.g, arg_506_1.hightColor1.g, var_509_3)
								local var_509_6 = Mathf.Lerp(iter_509_1.color.b, arg_506_1.hightColor1.b, var_509_3)

								iter_509_1.color = Color.New(var_509_4, var_509_5, var_509_6)
							else
								local var_509_7 = Mathf.Lerp(iter_509_1.color.r, 1, var_509_3)

								iter_509_1.color = Color.New(var_509_7, var_509_7, var_509_7)
							end
						end
					end
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.actorSpriteComps106103 then
				for iter_509_2, iter_509_3 in pairs(arg_506_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_509_3 then
						if arg_506_1.isInRecall_ then
							iter_509_3.color = arg_506_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_509_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_506_1.var_.actorSpriteComps106103 = nil
			end

			local var_509_8 = arg_506_1.actors_["106103"].transform
			local var_509_9 = 0

			if var_509_9 < arg_506_1.time_ and arg_506_1.time_ <= var_509_9 + arg_509_0 then
				arg_506_1.var_.moveOldPos106103 = var_509_8.localPosition
				var_509_8.localScale = Vector3.New(1, 1, 1)

				arg_506_1:CheckSpriteTmpPos("106103", 3)

				local var_509_10 = var_509_8.childCount

				for iter_509_4 = 0, var_509_10 - 1 do
					local var_509_11 = var_509_8:GetChild(iter_509_4)

					if var_509_11.name == "split_3" or not string.find(var_509_11.name, "split") then
						var_509_11.gameObject:SetActive(true)
					else
						var_509_11.gameObject:SetActive(false)
					end
				end
			end

			local var_509_12 = 0.001

			if var_509_9 <= arg_506_1.time_ and arg_506_1.time_ < var_509_9 + var_509_12 then
				local var_509_13 = (arg_506_1.time_ - var_509_9) / var_509_12
				local var_509_14 = Vector3.New(-36.6, -398.2, -333.7)

				var_509_8.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos106103, var_509_14, var_509_13)
			end

			if arg_506_1.time_ >= var_509_9 + var_509_12 and arg_506_1.time_ < var_509_9 + var_509_12 + arg_509_0 then
				var_509_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_509_15 = 0
			local var_509_16 = 1.3

			if var_509_15 < arg_506_1.time_ and arg_506_1.time_ <= var_509_15 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_17 = arg_506_1:FormatText(StoryNameCfg[612].name)

				arg_506_1.leftNameTxt_.text = var_509_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_18 = arg_506_1:GetWordFromCfg(926011122)
				local var_509_19 = arg_506_1:FormatText(var_509_18.content)

				arg_506_1.text_.text = var_509_19

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_20 = 52
				local var_509_21 = utf8.len(var_509_19)
				local var_509_22 = var_509_20 <= 0 and var_509_16 or var_509_16 * (var_509_21 / var_509_20)

				if var_509_22 > 0 and var_509_16 < var_509_22 then
					arg_506_1.talkMaxDuration = var_509_22

					if var_509_22 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_15
					end
				end

				arg_506_1.text_.text = var_509_19
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011122", "story_v_out_926011.awb") ~= 0 then
					local var_509_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011122", "story_v_out_926011.awb") / 1000

					if var_509_23 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_23 + var_509_15
					end

					if var_509_18.prefab_name ~= "" and arg_506_1.actors_[var_509_18.prefab_name] ~= nil then
						local var_509_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_18.prefab_name].transform, "story_v_out_926011", "926011122", "story_v_out_926011.awb")

						arg_506_1:RecordAudio("926011122", var_509_24)
						arg_506_1:RecordAudio("926011122", var_509_24)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_926011", "926011122", "story_v_out_926011.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_926011", "926011122", "story_v_out_926011.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_25 = math.max(var_509_16, arg_506_1.talkMaxDuration)

			if var_509_15 <= arg_506_1.time_ and arg_506_1.time_ < var_509_15 + var_509_25 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_15) / var_509_25

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_15 + var_509_25 and arg_506_1.time_ < var_509_15 + var_509_25 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926011123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 926011123
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play926011124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["106103"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.actorSpriteComps106103 == nil then
				arg_510_1.var_.actorSpriteComps106103 = var_513_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_513_2 = 0.2

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.actorSpriteComps106103 then
					for iter_513_0, iter_513_1 in pairs(arg_510_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_513_1 then
							if arg_510_1.isInRecall_ then
								local var_513_4 = Mathf.Lerp(iter_513_1.color.r, arg_510_1.hightColor2.r, var_513_3)
								local var_513_5 = Mathf.Lerp(iter_513_1.color.g, arg_510_1.hightColor2.g, var_513_3)
								local var_513_6 = Mathf.Lerp(iter_513_1.color.b, arg_510_1.hightColor2.b, var_513_3)

								iter_513_1.color = Color.New(var_513_4, var_513_5, var_513_6)
							else
								local var_513_7 = Mathf.Lerp(iter_513_1.color.r, 0.5, var_513_3)

								iter_513_1.color = Color.New(var_513_7, var_513_7, var_513_7)
							end
						end
					end
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.actorSpriteComps106103 then
				for iter_513_2, iter_513_3 in pairs(arg_510_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_513_3 then
						if arg_510_1.isInRecall_ then
							iter_513_3.color = arg_510_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_513_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_510_1.var_.actorSpriteComps106103 = nil
			end

			local var_513_8 = 0
			local var_513_9 = 0.425

			if var_513_8 < arg_510_1.time_ and arg_510_1.time_ <= var_513_8 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_10 = arg_510_1:FormatText(StoryNameCfg[7].name)

				arg_510_1.leftNameTxt_.text = var_513_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_11 = arg_510_1:GetWordFromCfg(926011123)
				local var_513_12 = arg_510_1:FormatText(var_513_11.content)

				arg_510_1.text_.text = var_513_12

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_13 = 17
				local var_513_14 = utf8.len(var_513_12)
				local var_513_15 = var_513_13 <= 0 and var_513_9 or var_513_9 * (var_513_14 / var_513_13)

				if var_513_15 > 0 and var_513_9 < var_513_15 then
					arg_510_1.talkMaxDuration = var_513_15

					if var_513_15 + var_513_8 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_15 + var_513_8
					end
				end

				arg_510_1.text_.text = var_513_12
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_16 = math.max(var_513_9, arg_510_1.talkMaxDuration)

			if var_513_8 <= arg_510_1.time_ and arg_510_1.time_ < var_513_8 + var_513_16 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_8) / var_513_16

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_8 + var_513_16 and arg_510_1.time_ < var_513_8 + var_513_16 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play926011124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 926011124
		arg_514_1.duration_ = 9.97

		local var_514_0 = {
			zh = 9.966,
			ja = 7.4
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
				arg_514_0:Play926011125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["106103"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.actorSpriteComps106103 == nil then
				arg_514_1.var_.actorSpriteComps106103 = var_517_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_517_2 = 0.2

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.actorSpriteComps106103 then
					for iter_517_0, iter_517_1 in pairs(arg_514_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_517_1 then
							if arg_514_1.isInRecall_ then
								local var_517_4 = Mathf.Lerp(iter_517_1.color.r, arg_514_1.hightColor1.r, var_517_3)
								local var_517_5 = Mathf.Lerp(iter_517_1.color.g, arg_514_1.hightColor1.g, var_517_3)
								local var_517_6 = Mathf.Lerp(iter_517_1.color.b, arg_514_1.hightColor1.b, var_517_3)

								iter_517_1.color = Color.New(var_517_4, var_517_5, var_517_6)
							else
								local var_517_7 = Mathf.Lerp(iter_517_1.color.r, 1, var_517_3)

								iter_517_1.color = Color.New(var_517_7, var_517_7, var_517_7)
							end
						end
					end
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.actorSpriteComps106103 then
				for iter_517_2, iter_517_3 in pairs(arg_514_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_517_3 then
						if arg_514_1.isInRecall_ then
							iter_517_3.color = arg_514_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_517_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_514_1.var_.actorSpriteComps106103 = nil
			end

			local var_517_8 = 0
			local var_517_9 = 0.95

			if var_517_8 < arg_514_1.time_ and arg_514_1.time_ <= var_517_8 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_10 = arg_514_1:FormatText(StoryNameCfg[612].name)

				arg_514_1.leftNameTxt_.text = var_517_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_11 = arg_514_1:GetWordFromCfg(926011124)
				local var_517_12 = arg_514_1:FormatText(var_517_11.content)

				arg_514_1.text_.text = var_517_12

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_13 = 38
				local var_517_14 = utf8.len(var_517_12)
				local var_517_15 = var_517_13 <= 0 and var_517_9 or var_517_9 * (var_517_14 / var_517_13)

				if var_517_15 > 0 and var_517_9 < var_517_15 then
					arg_514_1.talkMaxDuration = var_517_15

					if var_517_15 + var_517_8 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_15 + var_517_8
					end
				end

				arg_514_1.text_.text = var_517_12
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011124", "story_v_out_926011.awb") ~= 0 then
					local var_517_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011124", "story_v_out_926011.awb") / 1000

					if var_517_16 + var_517_8 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_16 + var_517_8
					end

					if var_517_11.prefab_name ~= "" and arg_514_1.actors_[var_517_11.prefab_name] ~= nil then
						local var_517_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_11.prefab_name].transform, "story_v_out_926011", "926011124", "story_v_out_926011.awb")

						arg_514_1:RecordAudio("926011124", var_517_17)
						arg_514_1:RecordAudio("926011124", var_517_17)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_926011", "926011124", "story_v_out_926011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_926011", "926011124", "story_v_out_926011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_18 = math.max(var_517_9, arg_514_1.talkMaxDuration)

			if var_517_8 <= arg_514_1.time_ and arg_514_1.time_ < var_517_8 + var_517_18 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_8) / var_517_18

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_8 + var_517_18 and arg_514_1.time_ < var_517_8 + var_517_18 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play926011125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 926011125
		arg_518_1.duration_ = 8.97

		local var_518_0 = {
			zh = 7.066,
			ja = 8.966
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play926011126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["128404"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.actorSpriteComps128404 == nil then
				arg_518_1.var_.actorSpriteComps128404 = var_521_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_2 = 0.2

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.actorSpriteComps128404 then
					for iter_521_0, iter_521_1 in pairs(arg_518_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_521_1 then
							if arg_518_1.isInRecall_ then
								local var_521_4 = Mathf.Lerp(iter_521_1.color.r, arg_518_1.hightColor1.r, var_521_3)
								local var_521_5 = Mathf.Lerp(iter_521_1.color.g, arg_518_1.hightColor1.g, var_521_3)
								local var_521_6 = Mathf.Lerp(iter_521_1.color.b, arg_518_1.hightColor1.b, var_521_3)

								iter_521_1.color = Color.New(var_521_4, var_521_5, var_521_6)
							else
								local var_521_7 = Mathf.Lerp(iter_521_1.color.r, 1, var_521_3)

								iter_521_1.color = Color.New(var_521_7, var_521_7, var_521_7)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.actorSpriteComps128404 then
				for iter_521_2, iter_521_3 in pairs(arg_518_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_521_3 then
						if arg_518_1.isInRecall_ then
							iter_521_3.color = arg_518_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_521_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_518_1.var_.actorSpriteComps128404 = nil
			end

			local var_521_8 = arg_518_1.actors_["106103"]
			local var_521_9 = 0

			if var_521_9 < arg_518_1.time_ and arg_518_1.time_ <= var_521_9 + arg_521_0 and not isNil(var_521_8) and arg_518_1.var_.actorSpriteComps106103 == nil then
				arg_518_1.var_.actorSpriteComps106103 = var_521_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_10 = 0.2

			if var_521_9 <= arg_518_1.time_ and arg_518_1.time_ < var_521_9 + var_521_10 and not isNil(var_521_8) then
				local var_521_11 = (arg_518_1.time_ - var_521_9) / var_521_10

				if arg_518_1.var_.actorSpriteComps106103 then
					for iter_521_4, iter_521_5 in pairs(arg_518_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_521_5 then
							if arg_518_1.isInRecall_ then
								local var_521_12 = Mathf.Lerp(iter_521_5.color.r, arg_518_1.hightColor2.r, var_521_11)
								local var_521_13 = Mathf.Lerp(iter_521_5.color.g, arg_518_1.hightColor2.g, var_521_11)
								local var_521_14 = Mathf.Lerp(iter_521_5.color.b, arg_518_1.hightColor2.b, var_521_11)

								iter_521_5.color = Color.New(var_521_12, var_521_13, var_521_14)
							else
								local var_521_15 = Mathf.Lerp(iter_521_5.color.r, 0.5, var_521_11)

								iter_521_5.color = Color.New(var_521_15, var_521_15, var_521_15)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= var_521_9 + var_521_10 and arg_518_1.time_ < var_521_9 + var_521_10 + arg_521_0 and not isNil(var_521_8) and arg_518_1.var_.actorSpriteComps106103 then
				for iter_521_6, iter_521_7 in pairs(arg_518_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_521_7 then
						if arg_518_1.isInRecall_ then
							iter_521_7.color = arg_518_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_521_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_518_1.var_.actorSpriteComps106103 = nil
			end

			local var_521_16 = arg_518_1.actors_["128404"].transform
			local var_521_17 = 0

			if var_521_17 < arg_518_1.time_ and arg_518_1.time_ <= var_521_17 + arg_521_0 then
				arg_518_1.var_.moveOldPos128404 = var_521_16.localPosition
				var_521_16.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("128404", 4)

				local var_521_18 = var_521_16.childCount

				for iter_521_8 = 0, var_521_18 - 1 do
					local var_521_19 = var_521_16:GetChild(iter_521_8)

					if var_521_19.name == "" or not string.find(var_521_19.name, "split") then
						var_521_19.gameObject:SetActive(true)
					else
						var_521_19.gameObject:SetActive(false)
					end
				end
			end

			local var_521_20 = 0.001

			if var_521_17 <= arg_518_1.time_ and arg_518_1.time_ < var_521_17 + var_521_20 then
				local var_521_21 = (arg_518_1.time_ - var_521_17) / var_521_20
				local var_521_22 = Vector3.New(390.2, -356, -362.3)

				var_521_16.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos128404, var_521_22, var_521_21)
			end

			if arg_518_1.time_ >= var_521_17 + var_521_20 and arg_518_1.time_ < var_521_17 + var_521_20 + arg_521_0 then
				var_521_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_521_23 = arg_518_1.actors_["106103"].transform
			local var_521_24 = 0

			if var_521_24 < arg_518_1.time_ and arg_518_1.time_ <= var_521_24 + arg_521_0 then
				arg_518_1.var_.moveOldPos106103 = var_521_23.localPosition
				var_521_23.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("106103", 2)

				local var_521_25 = var_521_23.childCount

				for iter_521_9 = 0, var_521_25 - 1 do
					local var_521_26 = var_521_23:GetChild(iter_521_9)

					if var_521_26.name == "" or not string.find(var_521_26.name, "split") then
						var_521_26.gameObject:SetActive(true)
					else
						var_521_26.gameObject:SetActive(false)
					end
				end
			end

			local var_521_27 = 0.001

			if var_521_24 <= arg_518_1.time_ and arg_518_1.time_ < var_521_24 + var_521_27 then
				local var_521_28 = (arg_518_1.time_ - var_521_24) / var_521_27
				local var_521_29 = Vector3.New(-428.4, -398.2, -333.7)

				var_521_23.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos106103, var_521_29, var_521_28)
			end

			if arg_518_1.time_ >= var_521_24 + var_521_27 and arg_518_1.time_ < var_521_24 + var_521_27 + arg_521_0 then
				var_521_23.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_521_30 = 0
			local var_521_31 = 0.725

			if var_521_30 < arg_518_1.time_ and arg_518_1.time_ <= var_521_30 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_32 = arg_518_1:FormatText(StoryNameCfg[6].name)

				arg_518_1.leftNameTxt_.text = var_521_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_33 = arg_518_1:GetWordFromCfg(926011125)
				local var_521_34 = arg_518_1:FormatText(var_521_33.content)

				arg_518_1.text_.text = var_521_34

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_35 = 29
				local var_521_36 = utf8.len(var_521_34)
				local var_521_37 = var_521_35 <= 0 and var_521_31 or var_521_31 * (var_521_36 / var_521_35)

				if var_521_37 > 0 and var_521_31 < var_521_37 then
					arg_518_1.talkMaxDuration = var_521_37

					if var_521_37 + var_521_30 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_37 + var_521_30
					end
				end

				arg_518_1.text_.text = var_521_34
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011125", "story_v_out_926011.awb") ~= 0 then
					local var_521_38 = manager.audio:GetVoiceLength("story_v_out_926011", "926011125", "story_v_out_926011.awb") / 1000

					if var_521_38 + var_521_30 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_38 + var_521_30
					end

					if var_521_33.prefab_name ~= "" and arg_518_1.actors_[var_521_33.prefab_name] ~= nil then
						local var_521_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_33.prefab_name].transform, "story_v_out_926011", "926011125", "story_v_out_926011.awb")

						arg_518_1:RecordAudio("926011125", var_521_39)
						arg_518_1:RecordAudio("926011125", var_521_39)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_926011", "926011125", "story_v_out_926011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_926011", "926011125", "story_v_out_926011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_40 = math.max(var_521_31, arg_518_1.talkMaxDuration)

			if var_521_30 <= arg_518_1.time_ and arg_518_1.time_ < var_521_30 + var_521_40 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_30) / var_521_40

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_30 + var_521_40 and arg_518_1.time_ < var_521_30 + var_521_40 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
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
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play926011126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 926011126
		arg_522_1.duration_ = 6.1

		local var_522_0 = {
			zh = 3.766,
			ja = 6.1
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play926011127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["128404"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps128404 == nil then
				arg_522_1.var_.actorSpriteComps128404 = var_525_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_2 = 0.2

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.actorSpriteComps128404 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								local var_525_4 = Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, var_525_3)
								local var_525_5 = Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, var_525_3)
								local var_525_6 = Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, var_525_3)

								iter_525_1.color = Color.New(var_525_4, var_525_5, var_525_6)
							else
								local var_525_7 = Mathf.Lerp(iter_525_1.color.r, 0.5, var_525_3)

								iter_525_1.color = Color.New(var_525_7, var_525_7, var_525_7)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps128404 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_525_3 then
						if arg_522_1.isInRecall_ then
							iter_525_3.color = arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_525_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_522_1.var_.actorSpriteComps128404 = nil
			end

			local var_525_8 = 0
			local var_525_9 = 0.375

			if var_525_8 < arg_522_1.time_ and arg_522_1.time_ <= var_525_8 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_10 = arg_522_1:FormatText(StoryNameCfg[36].name)

				arg_522_1.leftNameTxt_.text = var_525_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_11 = arg_522_1:GetWordFromCfg(926011126)
				local var_525_12 = arg_522_1:FormatText(var_525_11.content)

				arg_522_1.text_.text = var_525_12

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_13 = 15
				local var_525_14 = utf8.len(var_525_12)
				local var_525_15 = var_525_13 <= 0 and var_525_9 or var_525_9 * (var_525_14 / var_525_13)

				if var_525_15 > 0 and var_525_9 < var_525_15 then
					arg_522_1.talkMaxDuration = var_525_15

					if var_525_15 + var_525_8 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_15 + var_525_8
					end
				end

				arg_522_1.text_.text = var_525_12
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011126", "story_v_out_926011.awb") ~= 0 then
					local var_525_16 = manager.audio:GetVoiceLength("story_v_out_926011", "926011126", "story_v_out_926011.awb") / 1000

					if var_525_16 + var_525_8 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_16 + var_525_8
					end

					if var_525_11.prefab_name ~= "" and arg_522_1.actors_[var_525_11.prefab_name] ~= nil then
						local var_525_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_11.prefab_name].transform, "story_v_out_926011", "926011126", "story_v_out_926011.awb")

						arg_522_1:RecordAudio("926011126", var_525_17)
						arg_522_1:RecordAudio("926011126", var_525_17)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_926011", "926011126", "story_v_out_926011.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_926011", "926011126", "story_v_out_926011.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_18 = math.max(var_525_9, arg_522_1.talkMaxDuration)

			if var_525_8 <= arg_522_1.time_ and arg_522_1.time_ < var_525_8 + var_525_18 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_8) / var_525_18

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_8 + var_525_18 and arg_522_1.time_ < var_525_8 + var_525_18 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play926011127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 926011127
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play926011128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["106103"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos106103 = var_529_0.localPosition
				var_529_0.localScale = Vector3.New(1, 1, 1)

				arg_526_1:CheckSpriteTmpPos("106103", 7)

				local var_529_2 = var_529_0.childCount

				for iter_529_0 = 0, var_529_2 - 1 do
					local var_529_3 = var_529_0:GetChild(iter_529_0)

					if var_529_3.name == "" or not string.find(var_529_3.name, "split") then
						var_529_3.gameObject:SetActive(true)
					else
						var_529_3.gameObject:SetActive(false)
					end
				end
			end

			local var_529_4 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_4 then
				local var_529_5 = (arg_526_1.time_ - var_529_1) / var_529_4
				local var_529_6 = Vector3.New(0, -2000, 0)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos106103, var_529_6, var_529_5)
			end

			if arg_526_1.time_ >= var_529_1 + var_529_4 and arg_526_1.time_ < var_529_1 + var_529_4 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_529_7 = arg_526_1.actors_["128404"].transform
			local var_529_8 = 0

			if var_529_8 < arg_526_1.time_ and arg_526_1.time_ <= var_529_8 + arg_529_0 then
				arg_526_1.var_.moveOldPos128404 = var_529_7.localPosition
				var_529_7.localScale = Vector3.New(1, 1, 1)

				arg_526_1:CheckSpriteTmpPos("128404", 7)

				local var_529_9 = var_529_7.childCount

				for iter_529_1 = 0, var_529_9 - 1 do
					local var_529_10 = var_529_7:GetChild(iter_529_1)

					if var_529_10.name == "" or not string.find(var_529_10.name, "split") then
						var_529_10.gameObject:SetActive(true)
					else
						var_529_10.gameObject:SetActive(false)
					end
				end
			end

			local var_529_11 = 0.001

			if var_529_8 <= arg_526_1.time_ and arg_526_1.time_ < var_529_8 + var_529_11 then
				local var_529_12 = (arg_526_1.time_ - var_529_8) / var_529_11
				local var_529_13 = Vector3.New(0, -2000, 0)

				var_529_7.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos128404, var_529_13, var_529_12)
			end

			if arg_526_1.time_ >= var_529_8 + var_529_11 and arg_526_1.time_ < var_529_8 + var_529_11 + arg_529_0 then
				var_529_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_529_14 = 0
			local var_529_15 = 0.9

			if var_529_14 < arg_526_1.time_ and arg_526_1.time_ <= var_529_14 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_16 = arg_526_1:GetWordFromCfg(926011127)
				local var_529_17 = arg_526_1:FormatText(var_529_16.content)

				arg_526_1.text_.text = var_529_17

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_18 = 36
				local var_529_19 = utf8.len(var_529_17)
				local var_529_20 = var_529_18 <= 0 and var_529_15 or var_529_15 * (var_529_19 / var_529_18)

				if var_529_20 > 0 and var_529_15 < var_529_20 then
					arg_526_1.talkMaxDuration = var_529_20

					if var_529_20 + var_529_14 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_20 + var_529_14
					end
				end

				arg_526_1.text_.text = var_529_17
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_21 = math.max(var_529_15, arg_526_1.talkMaxDuration)

			if var_529_14 <= arg_526_1.time_ and arg_526_1.time_ < var_529_14 + var_529_21 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_14) / var_529_21

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_14 + var_529_21 and arg_526_1.time_ < var_529_14 + var_529_21 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_526_1:InitPlayNodeList()
	end,
	Play926011128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 926011128
		arg_530_1.duration_ = 5.27

		local var_530_0 = {
			zh = 4.4,
			ja = 5.266
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play926011129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["128404"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps128404 == nil then
				arg_530_1.var_.actorSpriteComps128404 = var_533_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_2 = 0.2

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.actorSpriteComps128404 then
					for iter_533_0, iter_533_1 in pairs(arg_530_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_533_1 then
							if arg_530_1.isInRecall_ then
								local var_533_4 = Mathf.Lerp(iter_533_1.color.r, arg_530_1.hightColor1.r, var_533_3)
								local var_533_5 = Mathf.Lerp(iter_533_1.color.g, arg_530_1.hightColor1.g, var_533_3)
								local var_533_6 = Mathf.Lerp(iter_533_1.color.b, arg_530_1.hightColor1.b, var_533_3)

								iter_533_1.color = Color.New(var_533_4, var_533_5, var_533_6)
							else
								local var_533_7 = Mathf.Lerp(iter_533_1.color.r, 1, var_533_3)

								iter_533_1.color = Color.New(var_533_7, var_533_7, var_533_7)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps128404 then
				for iter_533_2, iter_533_3 in pairs(arg_530_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_533_3 then
						if arg_530_1.isInRecall_ then
							iter_533_3.color = arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_533_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_530_1.var_.actorSpriteComps128404 = nil
			end

			local var_533_8 = arg_530_1.actors_["128404"].transform
			local var_533_9 = 0

			if var_533_9 < arg_530_1.time_ and arg_530_1.time_ <= var_533_9 + arg_533_0 then
				arg_530_1.var_.moveOldPos128404 = var_533_8.localPosition
				var_533_8.localScale = Vector3.New(1, 1, 1)

				arg_530_1:CheckSpriteTmpPos("128404", 3)

				local var_533_10 = var_533_8.childCount

				for iter_533_4 = 0, var_533_10 - 1 do
					local var_533_11 = var_533_8:GetChild(iter_533_4)

					if var_533_11.name == "" or not string.find(var_533_11.name, "split") then
						var_533_11.gameObject:SetActive(true)
					else
						var_533_11.gameObject:SetActive(false)
					end
				end
			end

			local var_533_12 = 0.001

			if var_533_9 <= arg_530_1.time_ and arg_530_1.time_ < var_533_9 + var_533_12 then
				local var_533_13 = (arg_530_1.time_ - var_533_9) / var_533_12
				local var_533_14 = Vector3.New(-16.1, -362, -375)

				var_533_8.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos128404, var_533_14, var_533_13)
			end

			if arg_530_1.time_ >= var_533_9 + var_533_12 and arg_530_1.time_ < var_533_9 + var_533_12 + arg_533_0 then
				var_533_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_533_15 = 0
			local var_533_16 = 0.475

			if var_533_15 < arg_530_1.time_ and arg_530_1.time_ <= var_533_15 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_17 = arg_530_1:FormatText(StoryNameCfg[6].name)

				arg_530_1.leftNameTxt_.text = var_533_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_18 = arg_530_1:GetWordFromCfg(926011128)
				local var_533_19 = arg_530_1:FormatText(var_533_18.content)

				arg_530_1.text_.text = var_533_19

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_20 = 19
				local var_533_21 = utf8.len(var_533_19)
				local var_533_22 = var_533_20 <= 0 and var_533_16 or var_533_16 * (var_533_21 / var_533_20)

				if var_533_22 > 0 and var_533_16 < var_533_22 then
					arg_530_1.talkMaxDuration = var_533_22

					if var_533_22 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_22 + var_533_15
					end
				end

				arg_530_1.text_.text = var_533_19
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011128", "story_v_out_926011.awb") ~= 0 then
					local var_533_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011128", "story_v_out_926011.awb") / 1000

					if var_533_23 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_23 + var_533_15
					end

					if var_533_18.prefab_name ~= "" and arg_530_1.actors_[var_533_18.prefab_name] ~= nil then
						local var_533_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_18.prefab_name].transform, "story_v_out_926011", "926011128", "story_v_out_926011.awb")

						arg_530_1:RecordAudio("926011128", var_533_24)
						arg_530_1:RecordAudio("926011128", var_533_24)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_926011", "926011128", "story_v_out_926011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_926011", "926011128", "story_v_out_926011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_25 = math.max(var_533_16, arg_530_1.talkMaxDuration)

			if var_533_15 <= arg_530_1.time_ and arg_530_1.time_ < var_533_15 + var_533_25 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_15) / var_533_25

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_15 + var_533_25 and arg_530_1.time_ < var_533_15 + var_533_25 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
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

		arg_530_1:InitPlayNodeList()
	end,
	Play926011129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 926011129
		arg_534_1.duration_ = 15.5

		local var_534_0 = {
			zh = 10.733,
			ja = 15.5
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play926011130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = "104701"

			if arg_534_1.actors_[var_537_0] == nil then
				local var_537_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_537_1) then
					local var_537_2 = Object.Instantiate(var_537_1, arg_534_1.canvasGo_.transform)

					var_537_2.transform:SetSiblingIndex(1)

					var_537_2.name = var_537_0
					var_537_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_534_1.actors_[var_537_0] = var_537_2

					local var_537_3 = var_537_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_534_1.isInRecall_ then
						for iter_537_0, iter_537_1 in ipairs(var_537_3) do
							iter_537_1.color = arg_534_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_537_4 = arg_534_1.actors_["104701"]
			local var_537_5 = 0

			if var_537_5 < arg_534_1.time_ and arg_534_1.time_ <= var_537_5 + arg_537_0 and not isNil(var_537_4) and arg_534_1.var_.actorSpriteComps104701 == nil then
				arg_534_1.var_.actorSpriteComps104701 = var_537_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_6 = 0.2

			if var_537_5 <= arg_534_1.time_ and arg_534_1.time_ < var_537_5 + var_537_6 and not isNil(var_537_4) then
				local var_537_7 = (arg_534_1.time_ - var_537_5) / var_537_6

				if arg_534_1.var_.actorSpriteComps104701 then
					for iter_537_2, iter_537_3 in pairs(arg_534_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_537_3 then
							if arg_534_1.isInRecall_ then
								local var_537_8 = Mathf.Lerp(iter_537_3.color.r, arg_534_1.hightColor1.r, var_537_7)
								local var_537_9 = Mathf.Lerp(iter_537_3.color.g, arg_534_1.hightColor1.g, var_537_7)
								local var_537_10 = Mathf.Lerp(iter_537_3.color.b, arg_534_1.hightColor1.b, var_537_7)

								iter_537_3.color = Color.New(var_537_8, var_537_9, var_537_10)
							else
								local var_537_11 = Mathf.Lerp(iter_537_3.color.r, 1, var_537_7)

								iter_537_3.color = Color.New(var_537_11, var_537_11, var_537_11)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= var_537_5 + var_537_6 and arg_534_1.time_ < var_537_5 + var_537_6 + arg_537_0 and not isNil(var_537_4) and arg_534_1.var_.actorSpriteComps104701 then
				for iter_537_4, iter_537_5 in pairs(arg_534_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_537_5 then
						if arg_534_1.isInRecall_ then
							iter_537_5.color = arg_534_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_537_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_534_1.var_.actorSpriteComps104701 = nil
			end

			local var_537_12 = arg_534_1.actors_["128404"]
			local var_537_13 = 0

			if var_537_13 < arg_534_1.time_ and arg_534_1.time_ <= var_537_13 + arg_537_0 and not isNil(var_537_12) and arg_534_1.var_.actorSpriteComps128404 == nil then
				arg_534_1.var_.actorSpriteComps128404 = var_537_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_14 = 0.2

			if var_537_13 <= arg_534_1.time_ and arg_534_1.time_ < var_537_13 + var_537_14 and not isNil(var_537_12) then
				local var_537_15 = (arg_534_1.time_ - var_537_13) / var_537_14

				if arg_534_1.var_.actorSpriteComps128404 then
					for iter_537_6, iter_537_7 in pairs(arg_534_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_537_7 then
							if arg_534_1.isInRecall_ then
								local var_537_16 = Mathf.Lerp(iter_537_7.color.r, arg_534_1.hightColor2.r, var_537_15)
								local var_537_17 = Mathf.Lerp(iter_537_7.color.g, arg_534_1.hightColor2.g, var_537_15)
								local var_537_18 = Mathf.Lerp(iter_537_7.color.b, arg_534_1.hightColor2.b, var_537_15)

								iter_537_7.color = Color.New(var_537_16, var_537_17, var_537_18)
							else
								local var_537_19 = Mathf.Lerp(iter_537_7.color.r, 0.5, var_537_15)

								iter_537_7.color = Color.New(var_537_19, var_537_19, var_537_19)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= var_537_13 + var_537_14 and arg_534_1.time_ < var_537_13 + var_537_14 + arg_537_0 and not isNil(var_537_12) and arg_534_1.var_.actorSpriteComps128404 then
				for iter_537_8, iter_537_9 in pairs(arg_534_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_537_9 then
						if arg_534_1.isInRecall_ then
							iter_537_9.color = arg_534_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_537_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_534_1.var_.actorSpriteComps128404 = nil
			end

			local var_537_20 = arg_534_1.actors_["104701"].transform
			local var_537_21 = 0

			if var_537_21 < arg_534_1.time_ and arg_534_1.time_ <= var_537_21 + arg_537_0 then
				arg_534_1.var_.moveOldPos104701 = var_537_20.localPosition
				var_537_20.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("104701", 5)

				local var_537_22 = var_537_20.childCount

				for iter_537_10 = 0, var_537_22 - 1 do
					local var_537_23 = var_537_20:GetChild(iter_537_10)

					if var_537_23.name == "" or not string.find(var_537_23.name, "split") then
						var_537_23.gameObject:SetActive(true)
					else
						var_537_23.gameObject:SetActive(false)
					end
				end
			end

			local var_537_24 = 0.366666666666667

			if var_537_21 <= arg_534_1.time_ and arg_534_1.time_ < var_537_21 + var_537_24 then
				local var_537_25 = (arg_534_1.time_ - var_537_21) / var_537_24
				local var_537_26 = Vector3.New(815.7, -469, 638.2)

				var_537_20.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos104701, var_537_26, var_537_25)
			end

			if arg_534_1.time_ >= var_537_21 + var_537_24 and arg_534_1.time_ < var_537_21 + var_537_24 + arg_537_0 then
				var_537_20.localPosition = Vector3.New(815.7, -469, 638.2)
			end

			local var_537_27 = arg_534_1.actors_["128404"].transform
			local var_537_28 = 0

			if var_537_28 < arg_534_1.time_ and arg_534_1.time_ <= var_537_28 + arg_537_0 then
				arg_534_1.var_.moveOldPos128404 = var_537_27.localPosition
				var_537_27.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("128404", 3)

				local var_537_29 = var_537_27.childCount

				for iter_537_11 = 0, var_537_29 - 1 do
					local var_537_30 = var_537_27:GetChild(iter_537_11)

					if var_537_30.name == "" or not string.find(var_537_30.name, "split") then
						var_537_30.gameObject:SetActive(true)
					else
						var_537_30.gameObject:SetActive(false)
					end
				end
			end

			local var_537_31 = 0.001

			if var_537_28 <= arg_534_1.time_ and arg_534_1.time_ < var_537_28 + var_537_31 then
				local var_537_32 = (arg_534_1.time_ - var_537_28) / var_537_31
				local var_537_33 = Vector3.New(-16.1, -362, -375)

				var_537_27.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos128404, var_537_33, var_537_32)
			end

			if arg_534_1.time_ >= var_537_28 + var_537_31 and arg_534_1.time_ < var_537_28 + var_537_31 + arg_537_0 then
				var_537_27.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_537_34 = 0

			if var_537_34 < arg_534_1.time_ and arg_534_1.time_ <= var_537_34 + arg_537_0 then
				arg_534_1.allBtn_.enabled = false
			end

			local var_537_35 = 0.833333333333333

			if arg_534_1.time_ >= var_537_34 + var_537_35 and arg_534_1.time_ < var_537_34 + var_537_35 + arg_537_0 then
				arg_534_1.allBtn_.enabled = true
			end

			if arg_534_1.frameCnt_ <= 1 then
				arg_534_1.dialog_:SetActive(false)
			end

			local var_537_36 = 0.6
			local var_537_37 = 1.075

			if var_537_36 < arg_534_1.time_ and arg_534_1.time_ <= var_537_36 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0

				arg_534_1.dialog_:SetActive(true)

				arg_534_1.dialogCg_.alpha = 0

				local var_537_38 = LeanTween.value(arg_534_1.dialog_, 0, 1, 0.3)

				var_537_38:setOnUpdate(LuaHelper.FloatAction(function(arg_538_0)
					arg_534_1.dialogCg_.alpha = arg_538_0
				end))
				var_537_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_534_1.dialog_)
					var_537_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_534_1.duration_ = arg_534_1.duration_ + 0.3

				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_39 = arg_534_1:FormatText(StoryNameCfg[1296].name)

				arg_534_1.leftNameTxt_.text = var_537_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_40 = arg_534_1:GetWordFromCfg(926011129)
				local var_537_41 = arg_534_1:FormatText(var_537_40.content)

				arg_534_1.text_.text = var_537_41

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_42 = 43
				local var_537_43 = utf8.len(var_537_41)
				local var_537_44 = var_537_42 <= 0 and var_537_37 or var_537_37 * (var_537_43 / var_537_42)

				if var_537_44 > 0 and var_537_37 < var_537_44 then
					arg_534_1.talkMaxDuration = var_537_44
					var_537_36 = var_537_36 + 0.3

					if var_537_44 + var_537_36 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_44 + var_537_36
					end
				end

				arg_534_1.text_.text = var_537_41
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011129", "story_v_out_926011.awb") ~= 0 then
					local var_537_45 = manager.audio:GetVoiceLength("story_v_out_926011", "926011129", "story_v_out_926011.awb") / 1000

					if var_537_45 + var_537_36 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_45 + var_537_36
					end

					if var_537_40.prefab_name ~= "" and arg_534_1.actors_[var_537_40.prefab_name] ~= nil then
						local var_537_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_40.prefab_name].transform, "story_v_out_926011", "926011129", "story_v_out_926011.awb")

						arg_534_1:RecordAudio("926011129", var_537_46)
						arg_534_1:RecordAudio("926011129", var_537_46)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_926011", "926011129", "story_v_out_926011.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_926011", "926011129", "story_v_out_926011.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_47 = var_537_36 + 0.3
			local var_537_48 = math.max(var_537_37, arg_534_1.talkMaxDuration)

			if var_537_47 <= arg_534_1.time_ and arg_534_1.time_ < var_537_47 + var_537_48 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_47) / var_537_48

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_47 + var_537_48 and arg_534_1.time_ < var_537_47 + var_537_48 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.034,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(970.4, -525.3, 1159.8),
					endPos = Vector3.New(815.7, -469, 638.2),
					easeType = LeanTweenType.notUsed
				}
			},
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

		arg_534_1:InitPlayNodeList()
	end,
	Play926011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 926011130
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play926011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["104701"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps104701 == nil then
				arg_540_1.var_.actorSpriteComps104701 = var_543_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_2 = 0.2

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.actorSpriteComps104701 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								local var_543_4 = Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor2.r, var_543_3)
								local var_543_5 = Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor2.g, var_543_3)
								local var_543_6 = Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor2.b, var_543_3)

								iter_543_1.color = Color.New(var_543_4, var_543_5, var_543_6)
							else
								local var_543_7 = Mathf.Lerp(iter_543_1.color.r, 0.5, var_543_3)

								iter_543_1.color = Color.New(var_543_7, var_543_7, var_543_7)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps104701 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_543_3 then
						if arg_540_1.isInRecall_ then
							iter_543_3.color = arg_540_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_543_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_540_1.var_.actorSpriteComps104701 = nil
			end

			local var_543_8 = 0
			local var_543_9 = 0.425

			if var_543_8 < arg_540_1.time_ and arg_540_1.time_ <= var_543_8 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_10 = arg_540_1:FormatText(StoryNameCfg[7].name)

				arg_540_1.leftNameTxt_.text = var_543_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_11 = arg_540_1:GetWordFromCfg(926011130)
				local var_543_12 = arg_540_1:FormatText(var_543_11.content)

				arg_540_1.text_.text = var_543_12

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_13 = 17
				local var_543_14 = utf8.len(var_543_12)
				local var_543_15 = var_543_13 <= 0 and var_543_9 or var_543_9 * (var_543_14 / var_543_13)

				if var_543_15 > 0 and var_543_9 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15

					if var_543_15 + var_543_8 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_8
					end
				end

				arg_540_1.text_.text = var_543_12
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_16 = math.max(var_543_9, arg_540_1.talkMaxDuration)

			if var_543_8 <= arg_540_1.time_ and arg_540_1.time_ < var_543_8 + var_543_16 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_8) / var_543_16

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_8 + var_543_16 and arg_540_1.time_ < var_543_8 + var_543_16 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play926011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 926011131
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play926011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["104701"].transform
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.var_.moveOldPos104701 = var_547_0.localPosition
				var_547_0.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("104701", 7)

				local var_547_2 = var_547_0.childCount

				for iter_547_0 = 0, var_547_2 - 1 do
					local var_547_3 = var_547_0:GetChild(iter_547_0)

					if var_547_3.name == "" or not string.find(var_547_3.name, "split") then
						var_547_3.gameObject:SetActive(true)
					else
						var_547_3.gameObject:SetActive(false)
					end
				end
			end

			local var_547_4 = 0.001

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_4 then
				local var_547_5 = (arg_544_1.time_ - var_547_1) / var_547_4
				local var_547_6 = Vector3.New(0, -2000, 0)

				var_547_0.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos104701, var_547_6, var_547_5)
			end

			if arg_544_1.time_ >= var_547_1 + var_547_4 and arg_544_1.time_ < var_547_1 + var_547_4 + arg_547_0 then
				var_547_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_547_7 = 0.166666666666667
			local var_547_8 = 1

			if var_547_7 < arg_544_1.time_ and arg_544_1.time_ <= var_547_7 + arg_547_0 then
				local var_547_9 = "play"
				local var_547_10 = "effect"

				arg_544_1:AudioAction(var_547_9, var_547_10, "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_547_11 = arg_544_1.actors_["128404"].transform
			local var_547_12 = 0

			if var_547_12 < arg_544_1.time_ and arg_544_1.time_ <= var_547_12 + arg_547_0 then
				arg_544_1.var_.moveOldPos128404 = var_547_11.localPosition
				var_547_11.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("128404", 7)

				local var_547_13 = var_547_11.childCount

				for iter_547_1 = 0, var_547_13 - 1 do
					local var_547_14 = var_547_11:GetChild(iter_547_1)

					if var_547_14.name == "" or not string.find(var_547_14.name, "split") then
						var_547_14.gameObject:SetActive(true)
					else
						var_547_14.gameObject:SetActive(false)
					end
				end
			end

			local var_547_15 = 0.001

			if var_547_12 <= arg_544_1.time_ and arg_544_1.time_ < var_547_12 + var_547_15 then
				local var_547_16 = (arg_544_1.time_ - var_547_12) / var_547_15
				local var_547_17 = Vector3.New(0, -2000, 0)

				var_547_11.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos128404, var_547_17, var_547_16)
			end

			if arg_544_1.time_ >= var_547_12 + var_547_15 and arg_544_1.time_ < var_547_12 + var_547_15 + arg_547_0 then
				var_547_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_547_18 = 0
			local var_547_19 = 1.125

			if var_547_18 < arg_544_1.time_ and arg_544_1.time_ <= var_547_18 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_20 = arg_544_1:GetWordFromCfg(926011131)
				local var_547_21 = arg_544_1:FormatText(var_547_20.content)

				arg_544_1.text_.text = var_547_21

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_22 = 45
				local var_547_23 = utf8.len(var_547_21)
				local var_547_24 = var_547_22 <= 0 and var_547_19 or var_547_19 * (var_547_23 / var_547_22)

				if var_547_24 > 0 and var_547_19 < var_547_24 then
					arg_544_1.talkMaxDuration = var_547_24

					if var_547_24 + var_547_18 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_24 + var_547_18
					end
				end

				arg_544_1.text_.text = var_547_21
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_25 = math.max(var_547_19, arg_544_1.talkMaxDuration)

			if var_547_18 <= arg_544_1.time_ and arg_544_1.time_ < var_547_18 + var_547_25 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_18) / var_547_25

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_18 + var_547_25 and arg_544_1.time_ < var_547_18 + var_547_25 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_544_1:InitPlayNodeList()
	end,
	Play926011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 926011132
		arg_548_1.duration_ = 8.51

		local var_548_0 = {
			zh = 5.540999999999,
			ja = 8.507999999999
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
				arg_548_0:Play926011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["104701"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps104701 == nil then
				arg_548_1.var_.actorSpriteComps104701 = var_551_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_2 = 0.2

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.actorSpriteComps104701 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps104701 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_551_3 then
						if arg_548_1.isInRecall_ then
							iter_551_3.color = arg_548_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_551_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_548_1.var_.actorSpriteComps104701 = nil
			end

			local var_551_8 = arg_548_1.actors_["104701"].transform
			local var_551_9 = 0

			if var_551_9 < arg_548_1.time_ and arg_548_1.time_ <= var_551_9 + arg_551_0 then
				arg_548_1.var_.moveOldPos104701 = var_551_8.localPosition
				var_551_8.localScale = Vector3.New(1, 1, 1)

				arg_548_1:CheckSpriteTmpPos("104701", 3)

				local var_551_10 = var_551_8.childCount

				for iter_551_4 = 0, var_551_10 - 1 do
					local var_551_11 = var_551_8:GetChild(iter_551_4)

					if var_551_11.name == "split_4" or not string.find(var_551_11.name, "split") then
						var_551_11.gameObject:SetActive(true)
					else
						var_551_11.gameObject:SetActive(false)
					end
				end
			end

			local var_551_12 = 0.001

			if var_551_9 <= arg_548_1.time_ and arg_548_1.time_ < var_551_9 + var_551_12 then
				local var_551_13 = (arg_548_1.time_ - var_551_9) / var_551_12
				local var_551_14 = Vector3.New(-67.4, -386.8, -295)

				var_551_8.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos104701, var_551_14, var_551_13)
			end

			if arg_548_1.time_ >= var_551_9 + var_551_12 and arg_548_1.time_ < var_551_9 + var_551_12 + arg_551_0 then
				var_551_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_551_15 = arg_548_1.actors_["104701"]
			local var_551_16 = 0

			if var_551_16 < arg_548_1.time_ and arg_548_1.time_ <= var_551_16 + arg_551_0 then
				local var_551_17 = var_551_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_551_17 then
					arg_548_1.var_.alphaOldValue104701 = var_551_17.alpha
					arg_548_1.var_.characterEffect104701 = var_551_17
				end

				arg_548_1.var_.alphaOldValue104701 = 0
			end

			local var_551_18 = 0.2

			if var_551_16 <= arg_548_1.time_ and arg_548_1.time_ < var_551_16 + var_551_18 then
				local var_551_19 = (arg_548_1.time_ - var_551_16) / var_551_18
				local var_551_20 = Mathf.Lerp(arg_548_1.var_.alphaOldValue104701, 1, var_551_19)

				if arg_548_1.var_.characterEffect104701 then
					arg_548_1.var_.characterEffect104701.alpha = var_551_20
				end
			end

			if arg_548_1.time_ >= var_551_16 + var_551_18 and arg_548_1.time_ < var_551_16 + var_551_18 + arg_551_0 and arg_548_1.var_.characterEffect104701 then
				arg_548_1.var_.characterEffect104701.alpha = 1
			end

			local var_551_21 = 0

			if var_551_21 < arg_548_1.time_ and arg_548_1.time_ <= var_551_21 + arg_551_0 then
				arg_548_1.allBtn_.enabled = false
			end

			local var_551_22 = 0.666666666666667

			if arg_548_1.time_ >= var_551_21 + var_551_22 and arg_548_1.time_ < var_551_21 + var_551_22 + arg_551_0 then
				arg_548_1.allBtn_.enabled = true
			end

			if arg_548_1.frameCnt_ <= 1 then
				arg_548_1.dialog_:SetActive(false)
			end

			local var_551_23 = 0.474999999999
			local var_551_24 = 0.525

			if var_551_23 < arg_548_1.time_ and arg_548_1.time_ <= var_551_23 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0

				arg_548_1.dialog_:SetActive(true)

				arg_548_1.dialogCg_.alpha = 0

				local var_551_25 = LeanTween.value(arg_548_1.dialog_, 0, 1, 0.3)

				var_551_25:setOnUpdate(LuaHelper.FloatAction(function(arg_552_0)
					arg_548_1.dialogCg_.alpha = arg_552_0
				end))
				var_551_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_548_1.dialog_)
					var_551_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_548_1.duration_ = arg_548_1.duration_ + 0.3

				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_26 = arg_548_1:FormatText(StoryNameCfg[1296].name)

				arg_548_1.leftNameTxt_.text = var_551_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_27 = arg_548_1:GetWordFromCfg(926011132)
				local var_551_28 = arg_548_1:FormatText(var_551_27.content)

				arg_548_1.text_.text = var_551_28

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_29 = 21
				local var_551_30 = utf8.len(var_551_28)
				local var_551_31 = var_551_29 <= 0 and var_551_24 or var_551_24 * (var_551_30 / var_551_29)

				if var_551_31 > 0 and var_551_24 < var_551_31 then
					arg_548_1.talkMaxDuration = var_551_31
					var_551_23 = var_551_23 + 0.3

					if var_551_31 + var_551_23 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_31 + var_551_23
					end
				end

				arg_548_1.text_.text = var_551_28
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011132", "story_v_out_926011.awb") ~= 0 then
					local var_551_32 = manager.audio:GetVoiceLength("story_v_out_926011", "926011132", "story_v_out_926011.awb") / 1000

					if var_551_32 + var_551_23 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_32 + var_551_23
					end

					if var_551_27.prefab_name ~= "" and arg_548_1.actors_[var_551_27.prefab_name] ~= nil then
						local var_551_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_27.prefab_name].transform, "story_v_out_926011", "926011132", "story_v_out_926011.awb")

						arg_548_1:RecordAudio("926011132", var_551_33)
						arg_548_1:RecordAudio("926011132", var_551_33)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_926011", "926011132", "story_v_out_926011.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_926011", "926011132", "story_v_out_926011.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_34 = var_551_23 + 0.3
			local var_551_35 = math.max(var_551_24, arg_548_1.talkMaxDuration)

			if var_551_34 <= arg_548_1.time_ and arg_548_1.time_ < var_551_34 + var_551_35 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_34) / var_551_35

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_34 + var_551_35 and arg_548_1.time_ < var_551_34 + var_551_35 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926011133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 926011133
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play926011134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["104701"]
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.actorSpriteComps104701 == nil then
				arg_554_1.var_.actorSpriteComps104701 = var_557_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_557_2 = 0.2

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 and not isNil(var_557_0) then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2

				if arg_554_1.var_.actorSpriteComps104701 then
					for iter_557_0, iter_557_1 in pairs(arg_554_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_557_1 then
							if arg_554_1.isInRecall_ then
								local var_557_4 = Mathf.Lerp(iter_557_1.color.r, arg_554_1.hightColor2.r, var_557_3)
								local var_557_5 = Mathf.Lerp(iter_557_1.color.g, arg_554_1.hightColor2.g, var_557_3)
								local var_557_6 = Mathf.Lerp(iter_557_1.color.b, arg_554_1.hightColor2.b, var_557_3)

								iter_557_1.color = Color.New(var_557_4, var_557_5, var_557_6)
							else
								local var_557_7 = Mathf.Lerp(iter_557_1.color.r, 0.5, var_557_3)

								iter_557_1.color = Color.New(var_557_7, var_557_7, var_557_7)
							end
						end
					end
				end
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.actorSpriteComps104701 then
				for iter_557_2, iter_557_3 in pairs(arg_554_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_557_3 then
						if arg_554_1.isInRecall_ then
							iter_557_3.color = arg_554_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_557_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_554_1.var_.actorSpriteComps104701 = nil
			end

			local var_557_8 = 0
			local var_557_9 = 0.775

			if var_557_8 < arg_554_1.time_ and arg_554_1.time_ <= var_557_8 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_10 = arg_554_1:FormatText(StoryNameCfg[7].name)

				arg_554_1.leftNameTxt_.text = var_557_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_11 = arg_554_1:GetWordFromCfg(926011133)
				local var_557_12 = arg_554_1:FormatText(var_557_11.content)

				arg_554_1.text_.text = var_557_12

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_13 = 31
				local var_557_14 = utf8.len(var_557_12)
				local var_557_15 = var_557_13 <= 0 and var_557_9 or var_557_9 * (var_557_14 / var_557_13)

				if var_557_15 > 0 and var_557_9 < var_557_15 then
					arg_554_1.talkMaxDuration = var_557_15

					if var_557_15 + var_557_8 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_15 + var_557_8
					end
				end

				arg_554_1.text_.text = var_557_12
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_16 = math.max(var_557_9, arg_554_1.talkMaxDuration)

			if var_557_8 <= arg_554_1.time_ and arg_554_1.time_ < var_557_8 + var_557_16 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_8) / var_557_16

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_8 + var_557_16 and arg_554_1.time_ < var_557_8 + var_557_16 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play926011134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 926011134
		arg_558_1.duration_ = 13.33

		local var_558_0 = {
			zh = 10.9,
			ja = 13.333
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play926011135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["104701"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.actorSpriteComps104701 == nil then
				arg_558_1.var_.actorSpriteComps104701 = var_561_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_561_2 = 0.2

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.actorSpriteComps104701 then
					for iter_561_0, iter_561_1 in pairs(arg_558_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_561_1 then
							if arg_558_1.isInRecall_ then
								local var_561_4 = Mathf.Lerp(iter_561_1.color.r, arg_558_1.hightColor1.r, var_561_3)
								local var_561_5 = Mathf.Lerp(iter_561_1.color.g, arg_558_1.hightColor1.g, var_561_3)
								local var_561_6 = Mathf.Lerp(iter_561_1.color.b, arg_558_1.hightColor1.b, var_561_3)

								iter_561_1.color = Color.New(var_561_4, var_561_5, var_561_6)
							else
								local var_561_7 = Mathf.Lerp(iter_561_1.color.r, 1, var_561_3)

								iter_561_1.color = Color.New(var_561_7, var_561_7, var_561_7)
							end
						end
					end
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.actorSpriteComps104701 then
				for iter_561_2, iter_561_3 in pairs(arg_558_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_561_3 then
						if arg_558_1.isInRecall_ then
							iter_561_3.color = arg_558_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_561_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_558_1.var_.actorSpriteComps104701 = nil
			end

			local var_561_8 = arg_558_1.actors_["104701"].transform
			local var_561_9 = 0

			if var_561_9 < arg_558_1.time_ and arg_558_1.time_ <= var_561_9 + arg_561_0 then
				arg_558_1.var_.moveOldPos104701 = var_561_8.localPosition
				var_561_8.localScale = Vector3.New(1, 1, 1)

				arg_558_1:CheckSpriteTmpPos("104701", 3)

				local var_561_10 = var_561_8.childCount

				for iter_561_4 = 0, var_561_10 - 1 do
					local var_561_11 = var_561_8:GetChild(iter_561_4)

					if var_561_11.name == "" or not string.find(var_561_11.name, "split") then
						var_561_11.gameObject:SetActive(true)
					else
						var_561_11.gameObject:SetActive(false)
					end
				end
			end

			local var_561_12 = 0.001

			if var_561_9 <= arg_558_1.time_ and arg_558_1.time_ < var_561_9 + var_561_12 then
				local var_561_13 = (arg_558_1.time_ - var_561_9) / var_561_12
				local var_561_14 = Vector3.New(-67.4, -386.8, -295)

				var_561_8.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos104701, var_561_14, var_561_13)
			end

			if arg_558_1.time_ >= var_561_9 + var_561_12 and arg_558_1.time_ < var_561_9 + var_561_12 + arg_561_0 then
				var_561_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_561_15 = 0
			local var_561_16 = 1.05

			if var_561_15 < arg_558_1.time_ and arg_558_1.time_ <= var_561_15 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_17 = arg_558_1:FormatText(StoryNameCfg[1296].name)

				arg_558_1.leftNameTxt_.text = var_561_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_18 = arg_558_1:GetWordFromCfg(926011134)
				local var_561_19 = arg_558_1:FormatText(var_561_18.content)

				arg_558_1.text_.text = var_561_19

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_20 = 42
				local var_561_21 = utf8.len(var_561_19)
				local var_561_22 = var_561_20 <= 0 and var_561_16 or var_561_16 * (var_561_21 / var_561_20)

				if var_561_22 > 0 and var_561_16 < var_561_22 then
					arg_558_1.talkMaxDuration = var_561_22

					if var_561_22 + var_561_15 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_22 + var_561_15
					end
				end

				arg_558_1.text_.text = var_561_19
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011134", "story_v_out_926011.awb") ~= 0 then
					local var_561_23 = manager.audio:GetVoiceLength("story_v_out_926011", "926011134", "story_v_out_926011.awb") / 1000

					if var_561_23 + var_561_15 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_23 + var_561_15
					end

					if var_561_18.prefab_name ~= "" and arg_558_1.actors_[var_561_18.prefab_name] ~= nil then
						local var_561_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_18.prefab_name].transform, "story_v_out_926011", "926011134", "story_v_out_926011.awb")

						arg_558_1:RecordAudio("926011134", var_561_24)
						arg_558_1:RecordAudio("926011134", var_561_24)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_926011", "926011134", "story_v_out_926011.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_926011", "926011134", "story_v_out_926011.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_25 = math.max(var_561_16, arg_558_1.talkMaxDuration)

			if var_561_15 <= arg_558_1.time_ and arg_558_1.time_ < var_561_15 + var_561_25 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_15) / var_561_25

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_15 + var_561_25 and arg_558_1.time_ < var_561_15 + var_561_25 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play926011135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 926011135
		arg_562_1.duration_ = 3.7

		local var_562_0 = {
			zh = 2.9,
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
				arg_562_0:Play926011136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["128404"]
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.actorSpriteComps128404 == nil then
				arg_562_1.var_.actorSpriteComps128404 = var_565_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_565_2 = 0.2

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 and not isNil(var_565_0) then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2

				if arg_562_1.var_.actorSpriteComps128404 then
					for iter_565_0, iter_565_1 in pairs(arg_562_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_565_1 then
							if arg_562_1.isInRecall_ then
								local var_565_4 = Mathf.Lerp(iter_565_1.color.r, arg_562_1.hightColor1.r, var_565_3)
								local var_565_5 = Mathf.Lerp(iter_565_1.color.g, arg_562_1.hightColor1.g, var_565_3)
								local var_565_6 = Mathf.Lerp(iter_565_1.color.b, arg_562_1.hightColor1.b, var_565_3)

								iter_565_1.color = Color.New(var_565_4, var_565_5, var_565_6)
							else
								local var_565_7 = Mathf.Lerp(iter_565_1.color.r, 1, var_565_3)

								iter_565_1.color = Color.New(var_565_7, var_565_7, var_565_7)
							end
						end
					end
				end
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.actorSpriteComps128404 then
				for iter_565_2, iter_565_3 in pairs(arg_562_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_565_3 then
						if arg_562_1.isInRecall_ then
							iter_565_3.color = arg_562_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_565_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_562_1.var_.actorSpriteComps128404 = nil
			end

			local var_565_8 = arg_562_1.actors_["104701"]
			local var_565_9 = 0

			if var_565_9 < arg_562_1.time_ and arg_562_1.time_ <= var_565_9 + arg_565_0 and not isNil(var_565_8) and arg_562_1.var_.actorSpriteComps104701 == nil then
				arg_562_1.var_.actorSpriteComps104701 = var_565_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_565_10 = 0.2

			if var_565_9 <= arg_562_1.time_ and arg_562_1.time_ < var_565_9 + var_565_10 and not isNil(var_565_8) then
				local var_565_11 = (arg_562_1.time_ - var_565_9) / var_565_10

				if arg_562_1.var_.actorSpriteComps104701 then
					for iter_565_4, iter_565_5 in pairs(arg_562_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_565_5 then
							if arg_562_1.isInRecall_ then
								local var_565_12 = Mathf.Lerp(iter_565_5.color.r, arg_562_1.hightColor2.r, var_565_11)
								local var_565_13 = Mathf.Lerp(iter_565_5.color.g, arg_562_1.hightColor2.g, var_565_11)
								local var_565_14 = Mathf.Lerp(iter_565_5.color.b, arg_562_1.hightColor2.b, var_565_11)

								iter_565_5.color = Color.New(var_565_12, var_565_13, var_565_14)
							else
								local var_565_15 = Mathf.Lerp(iter_565_5.color.r, 0.5, var_565_11)

								iter_565_5.color = Color.New(var_565_15, var_565_15, var_565_15)
							end
						end
					end
				end
			end

			if arg_562_1.time_ >= var_565_9 + var_565_10 and arg_562_1.time_ < var_565_9 + var_565_10 + arg_565_0 and not isNil(var_565_8) and arg_562_1.var_.actorSpriteComps104701 then
				for iter_565_6, iter_565_7 in pairs(arg_562_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_565_7 then
						if arg_562_1.isInRecall_ then
							iter_565_7.color = arg_562_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_565_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_562_1.var_.actorSpriteComps104701 = nil
			end

			local var_565_16 = 0
			local var_565_17 = 0.325

			if var_565_16 < arg_562_1.time_ and arg_562_1.time_ <= var_565_16 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_18 = arg_562_1:FormatText(StoryNameCfg[6].name)

				arg_562_1.leftNameTxt_.text = var_565_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_19 = arg_562_1:GetWordFromCfg(926011135)
				local var_565_20 = arg_562_1:FormatText(var_565_19.content)

				arg_562_1.text_.text = var_565_20

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_21 = 13
				local var_565_22 = utf8.len(var_565_20)
				local var_565_23 = var_565_21 <= 0 and var_565_17 or var_565_17 * (var_565_22 / var_565_21)

				if var_565_23 > 0 and var_565_17 < var_565_23 then
					arg_562_1.talkMaxDuration = var_565_23

					if var_565_23 + var_565_16 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_23 + var_565_16
					end
				end

				arg_562_1.text_.text = var_565_20
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011135", "story_v_out_926011.awb") ~= 0 then
					local var_565_24 = manager.audio:GetVoiceLength("story_v_out_926011", "926011135", "story_v_out_926011.awb") / 1000

					if var_565_24 + var_565_16 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_24 + var_565_16
					end

					if var_565_19.prefab_name ~= "" and arg_562_1.actors_[var_565_19.prefab_name] ~= nil then
						local var_565_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_19.prefab_name].transform, "story_v_out_926011", "926011135", "story_v_out_926011.awb")

						arg_562_1:RecordAudio("926011135", var_565_25)
						arg_562_1:RecordAudio("926011135", var_565_25)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_926011", "926011135", "story_v_out_926011.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_926011", "926011135", "story_v_out_926011.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_26 = math.max(var_565_17, arg_562_1.talkMaxDuration)

			if var_565_16 <= arg_562_1.time_ and arg_562_1.time_ < var_565_16 + var_565_26 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_16) / var_565_26

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_16 + var_565_26 and arg_562_1.time_ < var_565_16 + var_565_26 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play926011136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 926011136
		arg_566_1.duration_ = 6.2

		local var_566_0 = {
			zh = 5.633,
			ja = 6.2
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
				arg_566_0:Play926011137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["104701"]
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 and not isNil(var_569_0) and arg_566_1.var_.actorSpriteComps104701 == nil then
				arg_566_1.var_.actorSpriteComps104701 = var_569_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_2 = 0.2

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 and not isNil(var_569_0) then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2

				if arg_566_1.var_.actorSpriteComps104701 then
					for iter_569_0, iter_569_1 in pairs(arg_566_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_569_1 then
							if arg_566_1.isInRecall_ then
								local var_569_4 = Mathf.Lerp(iter_569_1.color.r, arg_566_1.hightColor1.r, var_569_3)
								local var_569_5 = Mathf.Lerp(iter_569_1.color.g, arg_566_1.hightColor1.g, var_569_3)
								local var_569_6 = Mathf.Lerp(iter_569_1.color.b, arg_566_1.hightColor1.b, var_569_3)

								iter_569_1.color = Color.New(var_569_4, var_569_5, var_569_6)
							else
								local var_569_7 = Mathf.Lerp(iter_569_1.color.r, 1, var_569_3)

								iter_569_1.color = Color.New(var_569_7, var_569_7, var_569_7)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 and not isNil(var_569_0) and arg_566_1.var_.actorSpriteComps104701 then
				for iter_569_2, iter_569_3 in pairs(arg_566_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_569_3 then
						if arg_566_1.isInRecall_ then
							iter_569_3.color = arg_566_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_569_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_566_1.var_.actorSpriteComps104701 = nil
			end

			local var_569_8 = arg_566_1.actors_["128404"]
			local var_569_9 = 0

			if var_569_9 < arg_566_1.time_ and arg_566_1.time_ <= var_569_9 + arg_569_0 and not isNil(var_569_8) and arg_566_1.var_.actorSpriteComps128404 == nil then
				arg_566_1.var_.actorSpriteComps128404 = var_569_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_10 = 0.2

			if var_569_9 <= arg_566_1.time_ and arg_566_1.time_ < var_569_9 + var_569_10 and not isNil(var_569_8) then
				local var_569_11 = (arg_566_1.time_ - var_569_9) / var_569_10

				if arg_566_1.var_.actorSpriteComps128404 then
					for iter_569_4, iter_569_5 in pairs(arg_566_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_569_5 then
							if arg_566_1.isInRecall_ then
								local var_569_12 = Mathf.Lerp(iter_569_5.color.r, arg_566_1.hightColor2.r, var_569_11)
								local var_569_13 = Mathf.Lerp(iter_569_5.color.g, arg_566_1.hightColor2.g, var_569_11)
								local var_569_14 = Mathf.Lerp(iter_569_5.color.b, arg_566_1.hightColor2.b, var_569_11)

								iter_569_5.color = Color.New(var_569_12, var_569_13, var_569_14)
							else
								local var_569_15 = Mathf.Lerp(iter_569_5.color.r, 0.5, var_569_11)

								iter_569_5.color = Color.New(var_569_15, var_569_15, var_569_15)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= var_569_9 + var_569_10 and arg_566_1.time_ < var_569_9 + var_569_10 + arg_569_0 and not isNil(var_569_8) and arg_566_1.var_.actorSpriteComps128404 then
				for iter_569_6, iter_569_7 in pairs(arg_566_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_569_7 then
						if arg_566_1.isInRecall_ then
							iter_569_7.color = arg_566_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_569_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_566_1.var_.actorSpriteComps128404 = nil
			end

			local var_569_16 = arg_566_1.actors_["104701"].transform
			local var_569_17 = 0

			if var_569_17 < arg_566_1.time_ and arg_566_1.time_ <= var_569_17 + arg_569_0 then
				arg_566_1.var_.moveOldPos104701 = var_569_16.localPosition
				var_569_16.localScale = Vector3.New(1, 1, 1)

				arg_566_1:CheckSpriteTmpPos("104701", 3)

				local var_569_18 = var_569_16.childCount

				for iter_569_8 = 0, var_569_18 - 1 do
					local var_569_19 = var_569_16:GetChild(iter_569_8)

					if var_569_19.name == "" or not string.find(var_569_19.name, "split") then
						var_569_19.gameObject:SetActive(true)
					else
						var_569_19.gameObject:SetActive(false)
					end
				end
			end

			local var_569_20 = 0.001

			if var_569_17 <= arg_566_1.time_ and arg_566_1.time_ < var_569_17 + var_569_20 then
				local var_569_21 = (arg_566_1.time_ - var_569_17) / var_569_20
				local var_569_22 = Vector3.New(-67.4, -386.8, -295)

				var_569_16.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos104701, var_569_22, var_569_21)
			end

			if arg_566_1.time_ >= var_569_17 + var_569_20 and arg_566_1.time_ < var_569_17 + var_569_20 + arg_569_0 then
				var_569_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_569_23 = 0
			local var_569_24 = 0.575

			if var_569_23 < arg_566_1.time_ and arg_566_1.time_ <= var_569_23 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_25 = arg_566_1:FormatText(StoryNameCfg[1296].name)

				arg_566_1.leftNameTxt_.text = var_569_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_26 = arg_566_1:GetWordFromCfg(926011136)
				local var_569_27 = arg_566_1:FormatText(var_569_26.content)

				arg_566_1.text_.text = var_569_27

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_28 = 23
				local var_569_29 = utf8.len(var_569_27)
				local var_569_30 = var_569_28 <= 0 and var_569_24 or var_569_24 * (var_569_29 / var_569_28)

				if var_569_30 > 0 and var_569_24 < var_569_30 then
					arg_566_1.talkMaxDuration = var_569_30

					if var_569_30 + var_569_23 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_30 + var_569_23
					end
				end

				arg_566_1.text_.text = var_569_27
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011136", "story_v_out_926011.awb") ~= 0 then
					local var_569_31 = manager.audio:GetVoiceLength("story_v_out_926011", "926011136", "story_v_out_926011.awb") / 1000

					if var_569_31 + var_569_23 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_31 + var_569_23
					end

					if var_569_26.prefab_name ~= "" and arg_566_1.actors_[var_569_26.prefab_name] ~= nil then
						local var_569_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_26.prefab_name].transform, "story_v_out_926011", "926011136", "story_v_out_926011.awb")

						arg_566_1:RecordAudio("926011136", var_569_32)
						arg_566_1:RecordAudio("926011136", var_569_32)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_926011", "926011136", "story_v_out_926011.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_926011", "926011136", "story_v_out_926011.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_33 = math.max(var_569_24, arg_566_1.talkMaxDuration)

			if var_569_23 <= arg_566_1.time_ and arg_566_1.time_ < var_569_23 + var_569_33 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_23) / var_569_33

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_23 + var_569_33 and arg_566_1.time_ < var_569_23 + var_569_33 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play926011137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 926011137
		arg_570_1.duration_ = 2.4

		local var_570_0 = {
			zh = 2.233,
			ja = 2.4
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play926011138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0
			local var_573_1 = 0.25

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_2 = arg_570_1:FormatText(StoryNameCfg[1296].name)

				arg_570_1.leftNameTxt_.text = var_573_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_3 = arg_570_1:GetWordFromCfg(926011137)
				local var_573_4 = arg_570_1:FormatText(var_573_3.content)

				arg_570_1.text_.text = var_573_4

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 10
				local var_573_6 = utf8.len(var_573_4)
				local var_573_7 = var_573_5 <= 0 and var_573_1 or var_573_1 * (var_573_6 / var_573_5)

				if var_573_7 > 0 and var_573_1 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_0
					end
				end

				arg_570_1.text_.text = var_573_4
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011137", "story_v_out_926011.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011137", "story_v_out_926011.awb") / 1000

					if var_573_8 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_0
					end

					if var_573_3.prefab_name ~= "" and arg_570_1.actors_[var_573_3.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_3.prefab_name].transform, "story_v_out_926011", "926011137", "story_v_out_926011.awb")

						arg_570_1:RecordAudio("926011137", var_573_9)
						arg_570_1:RecordAudio("926011137", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_926011", "926011137", "story_v_out_926011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_926011", "926011137", "story_v_out_926011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_1, arg_570_1.talkMaxDuration)

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_0) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_0 + var_573_10 and arg_570_1.time_ < var_573_0 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play926011138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 926011138
		arg_574_1.duration_ = 1

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"

			SetActive(arg_574_1.choicesGo_, true)

			for iter_575_0, iter_575_1 in ipairs(arg_574_1.choices_) do
				local var_575_0 = iter_575_0 <= 2

				SetActive(iter_575_1.go, var_575_0)
			end

			arg_574_1.choices_[1].txt.text = arg_574_1:FormatText(StoryChoiceCfg[1312].name)
			arg_574_1.choices_[2].txt.text = arg_574_1:FormatText(StoryChoiceCfg[1313].name)
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play926011139(arg_574_1)
			end

			if arg_576_0 == 2 then
				arg_574_0:Play926011139(arg_574_1)
			end

			arg_574_1:RecordChoiceLog(926011138, 1312, 1313)
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["104701"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.actorSpriteComps104701 == nil then
				arg_574_1.var_.actorSpriteComps104701 = var_577_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_577_2 = 0.2

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.actorSpriteComps104701 then
					for iter_577_0, iter_577_1 in pairs(arg_574_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_577_1 then
							if arg_574_1.isInRecall_ then
								local var_577_4 = Mathf.Lerp(iter_577_1.color.r, arg_574_1.hightColor2.r, var_577_3)
								local var_577_5 = Mathf.Lerp(iter_577_1.color.g, arg_574_1.hightColor2.g, var_577_3)
								local var_577_6 = Mathf.Lerp(iter_577_1.color.b, arg_574_1.hightColor2.b, var_577_3)

								iter_577_1.color = Color.New(var_577_4, var_577_5, var_577_6)
							else
								local var_577_7 = Mathf.Lerp(iter_577_1.color.r, 0.5, var_577_3)

								iter_577_1.color = Color.New(var_577_7, var_577_7, var_577_7)
							end
						end
					end
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.actorSpriteComps104701 then
				for iter_577_2, iter_577_3 in pairs(arg_574_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_577_3 then
						if arg_574_1.isInRecall_ then
							iter_577_3.color = arg_574_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_577_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_574_1.var_.actorSpriteComps104701 = nil
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play926011139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 926011139
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play926011140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0
			local var_581_1 = 0.65

			if var_581_0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_2 = arg_578_1:FormatText(StoryNameCfg[7].name)

				arg_578_1.leftNameTxt_.text = var_581_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_3 = arg_578_1:GetWordFromCfg(926011139)
				local var_581_4 = arg_578_1:FormatText(var_581_3.content)

				arg_578_1.text_.text = var_581_4

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 26
				local var_581_6 = utf8.len(var_581_4)
				local var_581_7 = var_581_5 <= 0 and var_581_1 or var_581_1 * (var_581_6 / var_581_5)

				if var_581_7 > 0 and var_581_1 < var_581_7 then
					arg_578_1.talkMaxDuration = var_581_7

					if var_581_7 + var_581_0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_7 + var_581_0
					end
				end

				arg_578_1.text_.text = var_581_4
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_8 = math.max(var_581_1, arg_578_1.talkMaxDuration)

			if var_581_0 <= arg_578_1.time_ and arg_578_1.time_ < var_581_0 + var_581_8 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_0) / var_581_8

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_0 + var_581_8 and arg_578_1.time_ < var_581_0 + var_581_8 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play926011140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 926011140
		arg_582_1.duration_ = 3.03

		local var_582_0 = {
			zh = 2.533,
			ja = 3.033
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play926011141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["106103"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.actorSpriteComps106103 == nil then
				arg_582_1.var_.actorSpriteComps106103 = var_585_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_585_2 = 0.2

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.actorSpriteComps106103 then
					for iter_585_0, iter_585_1 in pairs(arg_582_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_585_1 then
							if arg_582_1.isInRecall_ then
								local var_585_4 = Mathf.Lerp(iter_585_1.color.r, arg_582_1.hightColor1.r, var_585_3)
								local var_585_5 = Mathf.Lerp(iter_585_1.color.g, arg_582_1.hightColor1.g, var_585_3)
								local var_585_6 = Mathf.Lerp(iter_585_1.color.b, arg_582_1.hightColor1.b, var_585_3)

								iter_585_1.color = Color.New(var_585_4, var_585_5, var_585_6)
							else
								local var_585_7 = Mathf.Lerp(iter_585_1.color.r, 1, var_585_3)

								iter_585_1.color = Color.New(var_585_7, var_585_7, var_585_7)
							end
						end
					end
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.actorSpriteComps106103 then
				for iter_585_2, iter_585_3 in pairs(arg_582_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_585_3 then
						if arg_582_1.isInRecall_ then
							iter_585_3.color = arg_582_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_585_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_582_1.var_.actorSpriteComps106103 = nil
			end

			local var_585_8 = arg_582_1.actors_["104701"].transform
			local var_585_9 = 0

			if var_585_9 < arg_582_1.time_ and arg_582_1.time_ <= var_585_9 + arg_585_0 then
				arg_582_1.var_.moveOldPos104701 = var_585_8.localPosition
				var_585_8.localScale = Vector3.New(1, 1, 1)

				arg_582_1:CheckSpriteTmpPos("104701", 7)

				local var_585_10 = var_585_8.childCount

				for iter_585_4 = 0, var_585_10 - 1 do
					local var_585_11 = var_585_8:GetChild(iter_585_4)

					if var_585_11.name == "" or not string.find(var_585_11.name, "split") then
						var_585_11.gameObject:SetActive(true)
					else
						var_585_11.gameObject:SetActive(false)
					end
				end
			end

			local var_585_12 = 0.001

			if var_585_9 <= arg_582_1.time_ and arg_582_1.time_ < var_585_9 + var_585_12 then
				local var_585_13 = (arg_582_1.time_ - var_585_9) / var_585_12
				local var_585_14 = Vector3.New(0, -2000, 0)

				var_585_8.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos104701, var_585_14, var_585_13)
			end

			if arg_582_1.time_ >= var_585_9 + var_585_12 and arg_582_1.time_ < var_585_9 + var_585_12 + arg_585_0 then
				var_585_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_585_15 = arg_582_1.actors_["106103"].transform
			local var_585_16 = 0

			if var_585_16 < arg_582_1.time_ and arg_582_1.time_ <= var_585_16 + arg_585_0 then
				arg_582_1.var_.moveOldPos106103 = var_585_15.localPosition
				var_585_15.localScale = Vector3.New(1, 1, 1)

				arg_582_1:CheckSpriteTmpPos("106103", 3)

				local var_585_17 = var_585_15.childCount

				for iter_585_5 = 0, var_585_17 - 1 do
					local var_585_18 = var_585_15:GetChild(iter_585_5)

					if var_585_18.name == "split_5" or not string.find(var_585_18.name, "split") then
						var_585_18.gameObject:SetActive(true)
					else
						var_585_18.gameObject:SetActive(false)
					end
				end
			end

			local var_585_19 = 0.001

			if var_585_16 <= arg_582_1.time_ and arg_582_1.time_ < var_585_16 + var_585_19 then
				local var_585_20 = (arg_582_1.time_ - var_585_16) / var_585_19
				local var_585_21 = Vector3.New(-36.6, -398.2, -333.7)

				var_585_15.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos106103, var_585_21, var_585_20)
			end

			if arg_582_1.time_ >= var_585_16 + var_585_19 and arg_582_1.time_ < var_585_16 + var_585_19 + arg_585_0 then
				var_585_15.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_585_22 = 0
			local var_585_23 = 0.275

			if var_585_22 < arg_582_1.time_ and arg_582_1.time_ <= var_585_22 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_24 = arg_582_1:FormatText(StoryNameCfg[612].name)

				arg_582_1.leftNameTxt_.text = var_585_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_25 = arg_582_1:GetWordFromCfg(926011140)
				local var_585_26 = arg_582_1:FormatText(var_585_25.content)

				arg_582_1.text_.text = var_585_26

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_27 = 11
				local var_585_28 = utf8.len(var_585_26)
				local var_585_29 = var_585_27 <= 0 and var_585_23 or var_585_23 * (var_585_28 / var_585_27)

				if var_585_29 > 0 and var_585_23 < var_585_29 then
					arg_582_1.talkMaxDuration = var_585_29

					if var_585_29 + var_585_22 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_29 + var_585_22
					end
				end

				arg_582_1.text_.text = var_585_26
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011140", "story_v_out_926011.awb") ~= 0 then
					local var_585_30 = manager.audio:GetVoiceLength("story_v_out_926011", "926011140", "story_v_out_926011.awb") / 1000

					if var_585_30 + var_585_22 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_30 + var_585_22
					end

					if var_585_25.prefab_name ~= "" and arg_582_1.actors_[var_585_25.prefab_name] ~= nil then
						local var_585_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_25.prefab_name].transform, "story_v_out_926011", "926011140", "story_v_out_926011.awb")

						arg_582_1:RecordAudio("926011140", var_585_31)
						arg_582_1:RecordAudio("926011140", var_585_31)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_926011", "926011140", "story_v_out_926011.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_926011", "926011140", "story_v_out_926011.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_32 = math.max(var_585_23, arg_582_1.talkMaxDuration)

			if var_585_22 <= arg_582_1.time_ and arg_582_1.time_ < var_585_22 + var_585_32 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_22) / var_585_32

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_22 + var_585_32 and arg_582_1.time_ < var_585_22 + var_585_32 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play926011141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 926011141
		arg_586_1.duration_ = 4.8

		local var_586_0 = {
			zh = 3.966,
			ja = 4.8
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
			arg_586_1.auto_ = false
		end

		function arg_586_1.playNext_(arg_588_0)
			arg_586_1.onStoryFinished_()
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["106103"].transform
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.var_.moveOldPos106103 = var_589_0.localPosition
				var_589_0.localScale = Vector3.New(1, 1, 1)

				arg_586_1:CheckSpriteTmpPos("106103", 3)

				local var_589_2 = var_589_0.childCount

				for iter_589_0 = 0, var_589_2 - 1 do
					local var_589_3 = var_589_0:GetChild(iter_589_0)

					if var_589_3.name == "split_3" or not string.find(var_589_3.name, "split") then
						var_589_3.gameObject:SetActive(true)
					else
						var_589_3.gameObject:SetActive(false)
					end
				end
			end

			local var_589_4 = 0.001

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_4 then
				local var_589_5 = (arg_586_1.time_ - var_589_1) / var_589_4
				local var_589_6 = Vector3.New(-36.6, -398.2, -333.7)

				var_589_0.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos106103, var_589_6, var_589_5)
			end

			if arg_586_1.time_ >= var_589_1 + var_589_4 and arg_586_1.time_ < var_589_1 + var_589_4 + arg_589_0 then
				var_589_0.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_589_7 = 0.034
			local var_589_8 = 1

			if var_589_7 < arg_586_1.time_ and arg_586_1.time_ <= var_589_7 + arg_589_0 then
				local var_589_9 = "play"
				local var_589_10 = "effect"

				arg_586_1:AudioAction(var_589_9, var_589_10, "se_story_141", "se_story_141_boxing_organic", "")
			end

			local var_589_11 = 0
			local var_589_12 = 0.525

			if var_589_11 < arg_586_1.time_ and arg_586_1.time_ <= var_589_11 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_13 = arg_586_1:FormatText(StoryNameCfg[612].name)

				arg_586_1.leftNameTxt_.text = var_589_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_14 = arg_586_1:GetWordFromCfg(926011141)
				local var_589_15 = arg_586_1:FormatText(var_589_14.content)

				arg_586_1.text_.text = var_589_15

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_16 = 21
				local var_589_17 = utf8.len(var_589_15)
				local var_589_18 = var_589_16 <= 0 and var_589_12 or var_589_12 * (var_589_17 / var_589_16)

				if var_589_18 > 0 and var_589_12 < var_589_18 then
					arg_586_1.talkMaxDuration = var_589_18

					if var_589_18 + var_589_11 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_18 + var_589_11
					end
				end

				arg_586_1.text_.text = var_589_15
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011141", "story_v_out_926011.awb") ~= 0 then
					local var_589_19 = manager.audio:GetVoiceLength("story_v_out_926011", "926011141", "story_v_out_926011.awb") / 1000

					if var_589_19 + var_589_11 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_19 + var_589_11
					end

					if var_589_14.prefab_name ~= "" and arg_586_1.actors_[var_589_14.prefab_name] ~= nil then
						local var_589_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_14.prefab_name].transform, "story_v_out_926011", "926011141", "story_v_out_926011.awb")

						arg_586_1:RecordAudio("926011141", var_589_20)
						arg_586_1:RecordAudio("926011141", var_589_20)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_926011", "926011141", "story_v_out_926011.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_926011", "926011141", "story_v_out_926011.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_21 = math.max(var_589_12, arg_586_1.talkMaxDuration)

			if var_589_11 <= arg_586_1.time_ and arg_586_1.time_ < var_589_11 + var_589_21 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_11) / var_589_21

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_11 + var_589_21 and arg_586_1.time_ < var_589_11 + var_589_21 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I22f",
		"TextureConfig/Background/I22g"
	},
	voices = {
		"story_v_out_926011.awb"
	}
}
