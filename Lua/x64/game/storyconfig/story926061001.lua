return {
	Play926061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926061001
		arg_1_1.duration_ = 6

		local var_1_0 = {
			zh = 5.83333333333333,
			ja = 5.99933333333333
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
				arg_1_0:Play926061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0114"

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
				local var_4_5 = arg_1_1.bgs_.ST0114

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
					if iter_4_0 ~= "ST0114" then
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

			local var_4_24 = "10144"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_4_28 = arg_1_1.actors_["10144"]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			local var_4_36 = manager.ui.mainCamera.transform
			local var_4_37 = 0.833333333333333

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_38 = arg_1_1.var_.effect1124
				local var_4_39
				local var_4_40 = var_4_36

				if not var_4_38 then
					var_4_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), var_4_40)
					var_4_38.name = "1124"
					arg_1_1.var_.effect1124 = var_4_38
				else
					var_4_38.transform:SetParent(var_4_40)
				end

				var_4_38.transform.localPosition = Vector3.New(0, 2.03, 0)
				var_4_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_41 = manager.ui.mainCamera.transform
			local var_4_42 = 0

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = arg_1_1.var_.effect1125
				local var_4_44
				local var_4_45 = var_4_41

				if not var_4_43 then
					var_4_43 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), var_4_45)
					var_4_43.name = "1125"
					arg_1_1.var_.effect1125 = var_4_43
				else
					var_4_43.transform:SetParent(var_4_45)
				end

				var_4_43.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_43.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_46 = manager.ui.mainCameraCom_
				local var_4_47 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_4_46.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_48 = var_4_43.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_4_49 = 15
				local var_4_50 = 2 * var_4_49 * Mathf.Tan(var_4_46.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_4_46.aspect
				local var_4_51 = 1
				local var_4_52 = 1.7777777777777777

				if var_4_52 < var_4_46.aspect then
					var_4_51 = var_4_50 / (2 * var_4_49 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_4_52)
				end

				for iter_4_8, iter_4_9 in ipairs(var_4_48) do
					local var_4_53 = iter_4_9.transform.localScale

					iter_4_9.transform.localScale = Vector3.New(var_4_53.x / var_4_47 * var_4_51, var_4_53.y / var_4_47, var_4_53.z)
				end
			end

			local var_4_54 = arg_1_1.actors_["10144"].transform
			local var_4_55 = 2.275

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_54.localPosition
				var_4_54.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

				local var_4_56 = var_4_54.childCount

				for iter_4_10 = 0, var_4_56 - 1 do
					local var_4_57 = var_4_54:GetChild(iter_4_10)

					if var_4_57.name == "split_10" or not string.find(var_4_57.name, "split") then
						var_4_57.gameObject:SetActive(true)
					else
						var_4_57.gameObject:SetActive(false)
					end
				end
			end

			local var_4_58 = 0.001

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_58 then
				local var_4_59 = (arg_1_1.time_ - var_4_55) / var_4_58
				local var_4_60 = Vector3.New(-8.8, -458.8, -89.4)

				var_4_54.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, var_4_60, var_4_59)
			end

			if arg_1_1.time_ >= var_4_55 + var_4_58 and arg_1_1.time_ < var_4_55 + var_4_58 + arg_4_0 then
				var_4_54.localPosition = Vector3.New(-8.8, -458.8, -89.4)
			end

			local var_4_61 = arg_1_1.actors_["10144"]
			local var_4_62 = 2.275

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				local var_4_63 = var_4_61:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_63 then
					arg_1_1.var_.alphaOldValue10144 = var_4_63.alpha
					arg_1_1.var_.characterEffect10144 = var_4_63
				end

				arg_1_1.var_.alphaOldValue10144 = 0
			end

			local var_4_64 = 0.358333333333333

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_64 then
				local var_4_65 = (arg_1_1.time_ - var_4_62) / var_4_64
				local var_4_66 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10144, 1, var_4_65)

				if arg_1_1.var_.characterEffect10144 then
					arg_1_1.var_.characterEffect10144.alpha = var_4_66
				end
			end

			if arg_1_1.time_ >= var_4_62 + var_4_64 and arg_1_1.time_ < var_4_62 + var_4_64 + arg_4_0 and arg_1_1.var_.characterEffect10144 then
				arg_1_1.var_.characterEffect10144.alpha = 1
			end

			local var_4_67 = 0
			local var_4_68 = 0.3

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "music"

				arg_1_1:AudioAction(var_4_69, var_4_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_71 = ""
				local var_4_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_72 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_72 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_72

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_72
						arg_1_1.bgmTxt2_.text = var_4_72
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

			local var_4_73 = 0.166666666666667
			local var_4_74 = 1

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				local var_4_75 = "play"
				local var_4_76 = "effect"

				arg_1_1:AudioAction(var_4_75, var_4_76, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_4_77 = manager.ui.mainCamera.transform
			local var_4_78 = 0.833333333333333

			if var_4_78 < arg_1_1.time_ and arg_1_1.time_ <= var_4_78 + arg_4_0 then
				local var_4_79 = arg_1_1.var_.effect2323
				local var_4_80
				local var_4_81 = var_4_77

				if not var_4_79 then
					var_4_79 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), var_4_81)
					var_4_79.name = "2323"
					arg_1_1.var_.effect2323 = var_4_79
				else
					var_4_79.transform:SetParent(var_4_81)
				end

				var_4_79.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_79.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_82 = 3.23333333333333
			local var_4_83 = 0.275

			if var_4_82 < arg_1_1.time_ and arg_1_1.time_ <= var_4_82 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_84 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_84:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_84:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_84:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_85 = arg_1_1:FormatText(StoryNameCfg[1297].name)

				arg_1_1.leftNameTxt_.text = var_4_85

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_86 = arg_1_1:GetWordFromCfg(926061001)
				local var_4_87 = arg_1_1:FormatText(var_4_86.content)

				arg_1_1.text_.text = var_4_87

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_88 = 11
				local var_4_89 = utf8.len(var_4_87)
				local var_4_90 = var_4_88 <= 0 and var_4_83 or var_4_83 * (var_4_89 / var_4_88)

				if var_4_90 > 0 and var_4_83 < var_4_90 then
					arg_1_1.talkMaxDuration = var_4_90
					var_4_82 = var_4_82 + 0.3

					if var_4_90 + var_4_82 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_90 + var_4_82
					end
				end

				arg_1_1.text_.text = var_4_87
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061001", "story_v_out_926061.awb") ~= 0 then
					local var_4_91 = manager.audio:GetVoiceLength("story_v_out_926061", "926061001", "story_v_out_926061.awb") / 1000

					if var_4_91 + var_4_82 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_91 + var_4_82
					end

					if var_4_86.prefab_name ~= "" and arg_1_1.actors_[var_4_86.prefab_name] ~= nil then
						local var_4_92 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_86.prefab_name].transform, "story_v_out_926061", "926061001", "story_v_out_926061.awb")

						arg_1_1:RecordAudio("926061001", var_4_92)
						arg_1_1:RecordAudio("926061001", var_4_92)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926061", "926061001", "story_v_out_926061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926061", "926061001", "story_v_out_926061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_93 = var_4_82 + 0.3
			local var_4_94 = math.max(var_4_83, arg_1_1.talkMaxDuration)

			if var_4_93 <= arg_1_1.time_ and arg_1_1.time_ < var_4_93 + var_4_94 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_93) / var_4_94

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_93 + var_4_94 and arg_1_1.time_ < var_4_93 + var_4_94 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.275,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 926061002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play926061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10144"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10144 == nil then
				arg_8_1.var_.actorSpriteComps10144 = var_11_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.actorSpriteComps10144 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_11_1 then
							if arg_8_1.isInRecall_ then
								local var_11_4 = Mathf.Lerp(iter_11_1.color.r, arg_8_1.hightColor2.r, var_11_3)
								local var_11_5 = Mathf.Lerp(iter_11_1.color.g, arg_8_1.hightColor2.g, var_11_3)
								local var_11_6 = Mathf.Lerp(iter_11_1.color.b, arg_8_1.hightColor2.b, var_11_3)

								iter_11_1.color = Color.New(var_11_4, var_11_5, var_11_6)
							else
								local var_11_7 = Mathf.Lerp(iter_11_1.color.r, 0.5, var_11_3)

								iter_11_1.color = Color.New(var_11_7, var_11_7, var_11_7)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10144 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_11_3 then
						if arg_8_1.isInRecall_ then
							iter_11_3.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10144 = nil
			end

			local var_11_8 = 0
			local var_11_9 = 1.3

			if var_11_8 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(926061002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_12 = 52
				local var_11_13 = utf8.len(var_11_11)
				local var_11_14 = var_11_12 <= 0 and var_11_9 or var_11_9 * (var_11_13 / var_11_12)

				if var_11_14 > 0 and var_11_9 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_15 and arg_8_1.time_ < var_11_8 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play926061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 926061003
		arg_12_1.duration_ = 8.6

		local var_12_0 = {
			zh = 6.566,
			ja = 8.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play926061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10144"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10144 == nil then
				arg_12_1.var_.actorSpriteComps10144 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps10144 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 1, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10144 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10144 = nil
			end

			local var_15_8 = 0
			local var_15_9 = 0.65

			if var_15_8 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_10 = arg_12_1:FormatText(StoryNameCfg[1297].name)

				arg_12_1.leftNameTxt_.text = var_15_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_11 = arg_12_1:GetWordFromCfg(926061003)
				local var_15_12 = arg_12_1:FormatText(var_15_11.content)

				arg_12_1.text_.text = var_15_12

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 26
				local var_15_14 = utf8.len(var_15_12)
				local var_15_15 = var_15_13 <= 0 and var_15_9 or var_15_9 * (var_15_14 / var_15_13)

				if var_15_15 > 0 and var_15_9 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_12
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061003", "story_v_out_926061.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_926061", "926061003", "story_v_out_926061.awb") / 1000

					if var_15_16 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_8
					end

					if var_15_11.prefab_name ~= "" and arg_12_1.actors_[var_15_11.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_11.prefab_name].transform, "story_v_out_926061", "926061003", "story_v_out_926061.awb")

						arg_12_1:RecordAudio("926061003", var_15_17)
						arg_12_1:RecordAudio("926061003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_926061", "926061003", "story_v_out_926061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_926061", "926061003", "story_v_out_926061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_18 and arg_12_1.time_ < var_15_8 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play926061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 926061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play926061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10144"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 == nil then
				arg_16_1.var_.actorSpriteComps10144 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps10144 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 0.5, var_19_3)

								iter_19_1.color = Color.New(var_19_7, var_19_7, var_19_7)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_8 = 0
			local var_19_9 = 0.35

			if var_19_8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_10 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_11 = arg_16_1:GetWordFromCfg(926061004)
				local var_19_12 = arg_16_1:FormatText(var_19_11.content)

				arg_16_1.text_.text = var_19_12

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 14
				local var_19_14 = utf8.len(var_19_12)
				local var_19_15 = var_19_13 <= 0 and var_19_9 or var_19_9 * (var_19_14 / var_19_13)

				if var_19_15 > 0 and var_19_9 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_12
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play926061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 926061005
		arg_20_1.duration_ = 5.27

		local var_20_0 = {
			zh = 3.2,
			ja = 5.266
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play926061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10144"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10144 == nil then
				arg_20_1.var_.actorSpriteComps10144 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps10144 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								local var_23_4 = Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, var_23_3)
								local var_23_5 = Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, var_23_3)
								local var_23_6 = Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, var_23_3)

								iter_23_1.color = Color.New(var_23_4, var_23_5, var_23_6)
							else
								local var_23_7 = Mathf.Lerp(iter_23_1.color.r, 1, var_23_3)

								iter_23_1.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10144 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10144 = nil
			end

			local var_23_8 = 0
			local var_23_9 = 0.325

			if var_23_8 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_10 = arg_20_1:FormatText(StoryNameCfg[1297].name)

				arg_20_1.leftNameTxt_.text = var_23_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_11 = arg_20_1:GetWordFromCfg(926061005)
				local var_23_12 = arg_20_1:FormatText(var_23_11.content)

				arg_20_1.text_.text = var_23_12

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 13
				local var_23_14 = utf8.len(var_23_12)
				local var_23_15 = var_23_13 <= 0 and var_23_9 or var_23_9 * (var_23_14 / var_23_13)

				if var_23_15 > 0 and var_23_9 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_12
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061005", "story_v_out_926061.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_926061", "926061005", "story_v_out_926061.awb") / 1000

					if var_23_16 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_8
					end

					if var_23_11.prefab_name ~= "" and arg_20_1.actors_[var_23_11.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_11.prefab_name].transform, "story_v_out_926061", "926061005", "story_v_out_926061.awb")

						arg_20_1:RecordAudio("926061005", var_23_17)
						arg_20_1:RecordAudio("926061005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_926061", "926061005", "story_v_out_926061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_926061", "926061005", "story_v_out_926061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_18 and arg_20_1.time_ < var_23_8 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play926061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 926061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play926061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10144"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10144 == nil then
				arg_24_1.var_.actorSpriteComps10144 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps10144 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 0.5, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10144 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10144 = nil
			end

			local var_27_8 = arg_24_1.actors_["10144"].transform
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.var_.moveOldPos10144 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10144", 7)

				local var_27_10 = var_27_8.childCount

				for iter_27_4 = 0, var_27_10 - 1 do
					local var_27_11 = var_27_8:GetChild(iter_27_4)

					if var_27_11.name == "" or not string.find(var_27_11.name, "split") then
						var_27_11.gameObject:SetActive(true)
					else
						var_27_11.gameObject:SetActive(false)
					end
				end
			end

			local var_27_12 = 0.001

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_9) / var_27_12
				local var_27_14 = Vector3.New(0, -2000, 0)

				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10144, var_27_14, var_27_13)
			end

			if arg_24_1.time_ >= var_27_9 + var_27_12 and arg_24_1.time_ < var_27_9 + var_27_12 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_27_15 = manager.ui.mainCamera.transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				local var_27_17 = arg_24_1.var_.effect1125

				if var_27_17 then
					Object.Destroy(var_27_17)

					arg_24_1.var_.effect1125 = nil
				end
			end

			local var_27_18 = manager.ui.mainCamera.transform
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				local var_27_20 = arg_24_1.var_.effect1124

				if var_27_20 then
					Object.Destroy(var_27_20)

					arg_24_1.var_.effect1124 = nil
				end
			end

			local var_27_21 = manager.ui.mainCamera.transform
			local var_27_22 = 0

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				local var_27_23 = arg_24_1.var_.effect1122
				local var_27_24
				local var_27_25 = var_27_21

				if not var_27_23 then
					var_27_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_out"), var_27_25)
					var_27_23.name = "1122"
					arg_24_1.var_.effect1122 = var_27_23
				else
					var_27_23.transform:SetParent(var_27_25)
				end

				var_27_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_27_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_27_26 = manager.ui.mainCameraCom_
				local var_27_27 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_27_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_27_28 = var_27_23.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_27_29 = 15
				local var_27_30 = 2 * var_27_29 * Mathf.Tan(var_27_26.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_27_26.aspect
				local var_27_31 = 1
				local var_27_32 = 1.7777777777777777

				if var_27_32 < var_27_26.aspect then
					var_27_31 = var_27_30 / (2 * var_27_29 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_27_32)
				end

				for iter_27_5, iter_27_6 in ipairs(var_27_28) do
					local var_27_33 = iter_27_6.transform.localScale

					iter_27_6.transform.localScale = Vector3.New(var_27_33.x / var_27_27 * var_27_31, var_27_33.y / var_27_27, var_27_33.z)
				end
			end

			local var_27_34 = manager.ui.mainCamera.transform
			local var_27_35 = 0

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				local var_27_36 = arg_24_1.var_.effect1126
				local var_27_37
				local var_27_38 = var_27_34

				if not var_27_36 then
					var_27_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), var_27_38)
					var_27_36.name = "1126"
					arg_24_1.var_.effect1126 = var_27_36
				else
					var_27_36.transform:SetParent(var_27_38)
				end

				var_27_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_27_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_27_39 = 0
			local var_27_40 = 1

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 then
				local var_27_41 = "play"
				local var_27_42 = "effect"

				arg_24_1:AudioAction(var_27_41, var_27_42, "se_story_143", "se_story_143_eyeglasses_break", "")
			end

			local var_27_43 = manager.ui.mainCamera.transform
			local var_27_44 = 0

			if var_27_44 < arg_24_1.time_ and arg_24_1.time_ <= var_27_44 + arg_27_0 then
				local var_27_45 = arg_24_1.var_.effect2323

				if var_27_45 then
					Object.Destroy(var_27_45)

					arg_24_1.var_.effect2323 = nil
				end
			end

			local var_27_46 = 0.034
			local var_27_47 = 1

			if var_27_46 < arg_24_1.time_ and arg_24_1.time_ <= var_27_46 + arg_27_0 then
				local var_27_48 = "play"
				local var_27_49 = "music"

				arg_24_1:AudioAction(var_27_48, var_27_49, "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_27_50 = ""
				local var_27_51 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if var_27_51 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_51 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_51

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_51
						arg_24_1.bgmTxt2_.text = var_27_51
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_52 = 0
			local var_27_53 = 0.875

			if var_27_52 < arg_24_1.time_ and arg_24_1.time_ <= var_27_52 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_54 = arg_24_1:GetWordFromCfg(926061006)
				local var_27_55 = arg_24_1:FormatText(var_27_54.content)

				arg_24_1.text_.text = var_27_55

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_56 = 35
				local var_27_57 = utf8.len(var_27_55)
				local var_27_58 = var_27_56 <= 0 and var_27_53 or var_27_53 * (var_27_57 / var_27_56)

				if var_27_58 > 0 and var_27_53 < var_27_58 then
					arg_24_1.talkMaxDuration = var_27_58

					if var_27_58 + var_27_52 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_58 + var_27_52
					end
				end

				arg_24_1.text_.text = var_27_55
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_59 = math.max(var_27_53, arg_24_1.talkMaxDuration)

			if var_27_52 <= arg_24_1.time_ and arg_24_1.time_ < var_27_52 + var_27_59 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_52) / var_27_59

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_52 + var_27_59 and arg_24_1.time_ < var_27_52 + var_27_59 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play926061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926061007
		arg_29_1.duration_ = 6.07

		local var_29_0 = {
			zh = 3.766,
			ja = 6.066
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
				arg_29_0:Play926061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "128404"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(var_32_1, arg_29_1.canvasGo_.transform)

					var_32_2.transform:SetSiblingIndex(1)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs(var_32_3) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["128404"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps128404 == nil then
				arg_29_1.var_.actorSpriteComps128404 = var_32_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.actorSpriteComps128404 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_8 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, var_32_7)
								local var_32_9 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, var_32_7)
								local var_32_10 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, var_32_7)

								iter_32_3.color = Color.New(var_32_8, var_32_9, var_32_10)
							else
								local var_32_11 = Mathf.Lerp(iter_32_3.color.r, 1, var_32_7)

								iter_32_3.color = Color.New(var_32_11, var_32_11, var_32_11)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps128404 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps128404 = nil
			end

			local var_32_12 = arg_29_1.actors_["128404"].transform
			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_12.localPosition
				var_32_12.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 3)

				local var_32_14 = var_32_12.childCount

				for iter_32_6 = 0, var_32_14 - 1 do
					local var_32_15 = var_32_12:GetChild(iter_32_6)

					if var_32_15.name == "" or not string.find(var_32_15.name, "split") then
						var_32_15.gameObject:SetActive(true)
					else
						var_32_15.gameObject:SetActive(false)
					end
				end
			end

			local var_32_16 = 0.001

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_16 then
				local var_32_17 = (arg_29_1.time_ - var_32_13) / var_32_16
				local var_32_18 = Vector3.New(-16.1, -362, -375)

				var_32_12.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, var_32_18, var_32_17)
			end

			if arg_29_1.time_ >= var_32_13 + var_32_16 and arg_29_1.time_ < var_32_13 + var_32_16 + arg_32_0 then
				var_32_12.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_32_19 = 0
			local var_32_20 = 0.45

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_21 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_22 = arg_29_1:GetWordFromCfg(926061007)
				local var_32_23 = arg_29_1:FormatText(var_32_22.content)

				arg_29_1.text_.text = var_32_23

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_24 = 18
				local var_32_25 = utf8.len(var_32_23)
				local var_32_26 = var_32_24 <= 0 and var_32_20 or var_32_20 * (var_32_25 / var_32_24)

				if var_32_26 > 0 and var_32_20 < var_32_26 then
					arg_29_1.talkMaxDuration = var_32_26

					if var_32_26 + var_32_19 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_26 + var_32_19
					end
				end

				arg_29_1.text_.text = var_32_23
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061007", "story_v_out_926061.awb") ~= 0 then
					local var_32_27 = manager.audio:GetVoiceLength("story_v_out_926061", "926061007", "story_v_out_926061.awb") / 1000

					if var_32_27 + var_32_19 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_19
					end

					if var_32_22.prefab_name ~= "" and arg_29_1.actors_[var_32_22.prefab_name] ~= nil then
						local var_32_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_22.prefab_name].transform, "story_v_out_926061", "926061007", "story_v_out_926061.awb")

						arg_29_1:RecordAudio("926061007", var_32_28)
						arg_29_1:RecordAudio("926061007", var_32_28)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926061", "926061007", "story_v_out_926061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926061", "926061007", "story_v_out_926061.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_29 = math.max(var_32_20, arg_29_1.talkMaxDuration)

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_29 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_19) / var_32_29

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_19 + var_32_29 and arg_29_1.time_ < var_32_19 + var_32_29 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play926061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926061008
		arg_33_1.duration_ = 10.43

		local var_33_0 = {
			zh = 8.1,
			ja = 10.433
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
				arg_33_0:Play926061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "104701"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(var_36_1, arg_33_1.canvasGo_.transform)

					var_36_2.transform:SetSiblingIndex(1)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_33_1.isInRecall_ then
						for iter_36_0, iter_36_1 in ipairs(var_36_3) do
							iter_36_1.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_36_4 = arg_33_1.actors_["104701"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = var_36_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 0.2

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								local var_36_8 = Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor1.r, var_36_7)
								local var_36_9 = Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor1.g, var_36_7)
								local var_36_10 = Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor1.b, var_36_7)

								iter_36_3.color = Color.New(var_36_8, var_36_9, var_36_10)
							else
								local var_36_11 = Mathf.Lerp(iter_36_3.color.r, 1, var_36_7)

								iter_36_3.color = Color.New(var_36_11, var_36_11, var_36_11)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_5 then
						if arg_33_1.isInRecall_ then
							iter_36_5.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_12 = arg_33_1.actors_["128404"]
			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 and not isNil(var_36_12) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = var_36_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_14 = 0.2

			if var_36_13 <= arg_33_1.time_ and arg_33_1.time_ < var_36_13 + var_36_14 and not isNil(var_36_12) then
				local var_36_15 = (arg_33_1.time_ - var_36_13) / var_36_14

				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								local var_36_16 = Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor2.r, var_36_15)
								local var_36_17 = Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor2.g, var_36_15)
								local var_36_18 = Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor2.b, var_36_15)

								iter_36_7.color = Color.New(var_36_16, var_36_17, var_36_18)
							else
								local var_36_19 = Mathf.Lerp(iter_36_7.color.r, 0.5, var_36_15)

								iter_36_7.color = Color.New(var_36_19, var_36_19, var_36_19)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_13 + var_36_14 and arg_33_1.time_ < var_36_13 + var_36_14 + arg_36_0 and not isNil(var_36_12) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_9 then
						if arg_33_1.isInRecall_ then
							iter_36_9.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end

			local var_36_20 = arg_33_1.actors_["128404"].transform
			local var_36_21 = 0

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.var_.moveOldPos128404 = var_36_20.localPosition
				var_36_20.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("128404", 7)

				local var_36_22 = var_36_20.childCount

				for iter_36_10 = 0, var_36_22 - 1 do
					local var_36_23 = var_36_20:GetChild(iter_36_10)

					if var_36_23.name == "" or not string.find(var_36_23.name, "split") then
						var_36_23.gameObject:SetActive(true)
					else
						var_36_23.gameObject:SetActive(false)
					end
				end
			end

			local var_36_24 = 0.001

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_24 then
				local var_36_25 = (arg_33_1.time_ - var_36_21) / var_36_24
				local var_36_26 = Vector3.New(0, -2000, 0)

				var_36_20.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos128404, var_36_26, var_36_25)
			end

			if arg_33_1.time_ >= var_36_21 + var_36_24 and arg_33_1.time_ < var_36_21 + var_36_24 + arg_36_0 then
				var_36_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_27 = arg_33_1.actors_["104701"].transform
			local var_36_28 = 0

			if var_36_28 < arg_33_1.time_ and arg_33_1.time_ <= var_36_28 + arg_36_0 then
				arg_33_1.var_.moveOldPos104701 = var_36_27.localPosition
				var_36_27.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("104701", 3)

				local var_36_29 = var_36_27.childCount

				for iter_36_11 = 0, var_36_29 - 1 do
					local var_36_30 = var_36_27:GetChild(iter_36_11)

					if var_36_30.name == "" or not string.find(var_36_30.name, "split") then
						var_36_30.gameObject:SetActive(true)
					else
						var_36_30.gameObject:SetActive(false)
					end
				end
			end

			local var_36_31 = 0.001

			if var_36_28 <= arg_33_1.time_ and arg_33_1.time_ < var_36_28 + var_36_31 then
				local var_36_32 = (arg_33_1.time_ - var_36_28) / var_36_31
				local var_36_33 = Vector3.New(-67.4, -386.8, -295)

				var_36_27.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos104701, var_36_33, var_36_32)
			end

			if arg_33_1.time_ >= var_36_28 + var_36_31 and arg_33_1.time_ < var_36_28 + var_36_31 + arg_36_0 then
				var_36_27.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_36_34 = 0
			local var_36_35 = 0.975

			if var_36_34 < arg_33_1.time_ and arg_33_1.time_ <= var_36_34 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_36 = arg_33_1:FormatText(StoryNameCfg[1296].name)

				arg_33_1.leftNameTxt_.text = var_36_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_37 = arg_33_1:GetWordFromCfg(926061008)
				local var_36_38 = arg_33_1:FormatText(var_36_37.content)

				arg_33_1.text_.text = var_36_38

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_39 = 39
				local var_36_40 = utf8.len(var_36_38)
				local var_36_41 = var_36_39 <= 0 and var_36_35 or var_36_35 * (var_36_40 / var_36_39)

				if var_36_41 > 0 and var_36_35 < var_36_41 then
					arg_33_1.talkMaxDuration = var_36_41

					if var_36_41 + var_36_34 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_41 + var_36_34
					end
				end

				arg_33_1.text_.text = var_36_38
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061008", "story_v_out_926061.awb") ~= 0 then
					local var_36_42 = manager.audio:GetVoiceLength("story_v_out_926061", "926061008", "story_v_out_926061.awb") / 1000

					if var_36_42 + var_36_34 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_42 + var_36_34
					end

					if var_36_37.prefab_name ~= "" and arg_33_1.actors_[var_36_37.prefab_name] ~= nil then
						local var_36_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_37.prefab_name].transform, "story_v_out_926061", "926061008", "story_v_out_926061.awb")

						arg_33_1:RecordAudio("926061008", var_36_43)
						arg_33_1:RecordAudio("926061008", var_36_43)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926061", "926061008", "story_v_out_926061.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926061", "926061008", "story_v_out_926061.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_44 = math.max(var_36_35, arg_33_1.talkMaxDuration)

			if var_36_34 <= arg_33_1.time_ and arg_33_1.time_ < var_36_34 + var_36_44 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_34) / var_36_44

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_34 + var_36_44 and arg_33_1.time_ < var_36_34 + var_36_44 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "104701",
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
	Play926061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926061009
		arg_37_1.duration_ = 4.8

		local var_37_0 = {
			zh = 4.8,
			ja = 4.533
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
				arg_37_0:Play926061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "106603"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(var_40_1, arg_37_1.canvasGo_.transform)

					var_40_2.transform:SetSiblingIndex(1)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs(var_40_3) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_4 = arg_37_1.actors_["106603"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps106603 == nil then
				arg_37_1.var_.actorSpriteComps106603 = var_40_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.actorSpriteComps106603 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_8 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_7)
								local var_40_9 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_7)
								local var_40_10 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_7)

								iter_40_3.color = Color.New(var_40_8, var_40_9, var_40_10)
							else
								local var_40_11 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_7)

								iter_40_3.color = Color.New(var_40_11, var_40_11, var_40_11)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps106603 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps106603 = nil
			end

			local var_40_12 = "10115"

			if arg_37_1.actors_[var_40_12] == nil then
				local var_40_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_40_13) then
					local var_40_14 = Object.Instantiate(var_40_13, arg_37_1.canvasGo_.transform)

					var_40_14.transform:SetSiblingIndex(1)

					var_40_14.name = var_40_12
					var_40_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_12] = var_40_14

					local var_40_15 = var_40_14:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_6, iter_40_7 in ipairs(var_40_15) do
							iter_40_7.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_16 = arg_37_1.actors_["10115"]
			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.actorSpriteComps10115 == nil then
				arg_37_1.var_.actorSpriteComps10115 = var_40_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_18 = 0.2

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_18 and not isNil(var_40_16) then
				local var_40_19 = (arg_37_1.time_ - var_40_17) / var_40_18

				if arg_37_1.var_.actorSpriteComps10115 then
					for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_40_9 then
							if arg_37_1.isInRecall_ then
								local var_40_20 = Mathf.Lerp(iter_40_9.color.r, arg_37_1.hightColor2.r, var_40_19)
								local var_40_21 = Mathf.Lerp(iter_40_9.color.g, arg_37_1.hightColor2.g, var_40_19)
								local var_40_22 = Mathf.Lerp(iter_40_9.color.b, arg_37_1.hightColor2.b, var_40_19)

								iter_40_9.color = Color.New(var_40_20, var_40_21, var_40_22)
							else
								local var_40_23 = Mathf.Lerp(iter_40_9.color.r, 0.5, var_40_19)

								iter_40_9.color = Color.New(var_40_23, var_40_23, var_40_23)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_17 + var_40_18 and arg_37_1.time_ < var_40_17 + var_40_18 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.actorSpriteComps10115 then
				for iter_40_10, iter_40_11 in pairs(arg_37_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_40_11 then
						if arg_37_1.isInRecall_ then
							iter_40_11.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10115 = nil
			end

			local var_40_24 = arg_37_1.actors_["104701"].transform
			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1.var_.moveOldPos104701 = var_40_24.localPosition
				var_40_24.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("104701", 7)

				local var_40_26 = var_40_24.childCount

				for iter_40_12 = 0, var_40_26 - 1 do
					local var_40_27 = var_40_24:GetChild(iter_40_12)

					if var_40_27.name == "" or not string.find(var_40_27.name, "split") then
						var_40_27.gameObject:SetActive(true)
					else
						var_40_27.gameObject:SetActive(false)
					end
				end
			end

			local var_40_28 = 0.001

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_28 then
				local var_40_29 = (arg_37_1.time_ - var_40_25) / var_40_28
				local var_40_30 = Vector3.New(0, -2000, 0)

				var_40_24.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos104701, var_40_30, var_40_29)
			end

			if arg_37_1.time_ >= var_40_25 + var_40_28 and arg_37_1.time_ < var_40_25 + var_40_28 + arg_40_0 then
				var_40_24.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_31 = arg_37_1.actors_["106603"].transform
			local var_40_32 = 0

			if var_40_32 < arg_37_1.time_ and arg_37_1.time_ <= var_40_32 + arg_40_0 then
				arg_37_1.var_.moveOldPos106603 = var_40_31.localPosition
				var_40_31.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106603", 3)

				local var_40_33 = var_40_31.childCount

				for iter_40_13 = 0, var_40_33 - 1 do
					local var_40_34 = var_40_31:GetChild(iter_40_13)

					if var_40_34.name == "" or not string.find(var_40_34.name, "split") then
						var_40_34.gameObject:SetActive(true)
					else
						var_40_34.gameObject:SetActive(false)
					end
				end
			end

			local var_40_35 = 0.001

			if var_40_32 <= arg_37_1.time_ and arg_37_1.time_ < var_40_32 + var_40_35 then
				local var_40_36 = (arg_37_1.time_ - var_40_32) / var_40_35
				local var_40_37 = Vector3.New(-77.5, -399.1, -303.3)

				var_40_31.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106603, var_40_37, var_40_36)
			end

			if arg_37_1.time_ >= var_40_32 + var_40_35 and arg_37_1.time_ < var_40_32 + var_40_35 + arg_40_0 then
				var_40_31.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_40_38 = 0
			local var_40_39 = 0.55

			if var_40_38 < arg_37_1.time_ and arg_37_1.time_ <= var_40_38 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_40 = arg_37_1:FormatText(StoryNameCfg[32].name)

				arg_37_1.leftNameTxt_.text = var_40_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_41 = arg_37_1:GetWordFromCfg(926061009)
				local var_40_42 = arg_37_1:FormatText(var_40_41.content)

				arg_37_1.text_.text = var_40_42

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_43 = 22
				local var_40_44 = utf8.len(var_40_42)
				local var_40_45 = var_40_43 <= 0 and var_40_39 or var_40_39 * (var_40_44 / var_40_43)

				if var_40_45 > 0 and var_40_39 < var_40_45 then
					arg_37_1.talkMaxDuration = var_40_45

					if var_40_45 + var_40_38 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_45 + var_40_38
					end
				end

				arg_37_1.text_.text = var_40_42
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061009", "story_v_out_926061.awb") ~= 0 then
					local var_40_46 = manager.audio:GetVoiceLength("story_v_out_926061", "926061009", "story_v_out_926061.awb") / 1000

					if var_40_46 + var_40_38 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_46 + var_40_38
					end

					if var_40_41.prefab_name ~= "" and arg_37_1.actors_[var_40_41.prefab_name] ~= nil then
						local var_40_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_41.prefab_name].transform, "story_v_out_926061", "926061009", "story_v_out_926061.awb")

						arg_37_1:RecordAudio("926061009", var_40_47)
						arg_37_1:RecordAudio("926061009", var_40_47)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926061", "926061009", "story_v_out_926061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926061", "926061009", "story_v_out_926061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_48 = math.max(var_40_39, arg_37_1.talkMaxDuration)

			if var_40_38 <= arg_37_1.time_ and arg_37_1.time_ < var_40_38 + var_40_48 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_38) / var_40_48

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_38 + var_40_48 and arg_37_1.time_ < var_40_38 + var_40_48 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "106603",
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
	Play926061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926061010
		arg_41_1.duration_ = 7.67

		local var_41_0 = {
			zh = 6.866,
			ja = 7.666
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
				arg_41_0:Play926061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "106103"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

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

			local var_44_4 = arg_41_1.actors_["106103"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_12 = arg_41_1.actors_["106603"]
			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps106603 == nil then
				arg_41_1.var_.actorSpriteComps106603 = var_44_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_14 = 0.2

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_14 and not isNil(var_44_12) then
				local var_44_15 = (arg_41_1.time_ - var_44_13) / var_44_14

				if arg_41_1.var_.actorSpriteComps106603 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_41_1.time_ >= var_44_13 + var_44_14 and arg_41_1.time_ < var_44_13 + var_44_14 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps106603 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps106603 = nil
			end

			local var_44_20 = arg_41_1.actors_["106603"].transform
			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.var_.moveOldPos106603 = var_44_20.localPosition
				var_44_20.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106603", 7)

				local var_44_22 = var_44_20.childCount

				for iter_44_10 = 0, var_44_22 - 1 do
					local var_44_23 = var_44_20:GetChild(iter_44_10)

					if var_44_23.name == "" or not string.find(var_44_23.name, "split") then
						var_44_23.gameObject:SetActive(true)
					else
						var_44_23.gameObject:SetActive(false)
					end
				end
			end

			local var_44_24 = 0.001

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_24 then
				local var_44_25 = (arg_41_1.time_ - var_44_21) / var_44_24
				local var_44_26 = Vector3.New(0, -2000, 0)

				var_44_20.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106603, var_44_26, var_44_25)
			end

			if arg_41_1.time_ >= var_44_21 + var_44_24 and arg_41_1.time_ < var_44_21 + var_44_24 + arg_44_0 then
				var_44_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_27 = arg_41_1.actors_["106103"].transform
			local var_44_28 = 0

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.var_.moveOldPos106103 = var_44_27.localPosition
				var_44_27.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106103", 3)

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
				local var_44_33 = Vector3.New(-36.6, -398.2, -333.7)

				var_44_27.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106103, var_44_33, var_44_32)
			end

			if arg_41_1.time_ >= var_44_28 + var_44_31 and arg_41_1.time_ < var_44_28 + var_44_31 + arg_44_0 then
				var_44_27.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_44_34 = 0
			local var_44_35 = 0.775

			if var_44_34 < arg_41_1.time_ and arg_41_1.time_ <= var_44_34 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_36 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_37 = arg_41_1:GetWordFromCfg(926061010)
				local var_44_38 = arg_41_1:FormatText(var_44_37.content)

				arg_41_1.text_.text = var_44_38

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_39 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061010", "story_v_out_926061.awb") ~= 0 then
					local var_44_42 = manager.audio:GetVoiceLength("story_v_out_926061", "926061010", "story_v_out_926061.awb") / 1000

					if var_44_42 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_34
					end

					if var_44_37.prefab_name ~= "" and arg_41_1.actors_[var_44_37.prefab_name] ~= nil then
						local var_44_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_37.prefab_name].transform, "story_v_out_926061", "926061010", "story_v_out_926061.awb")

						arg_41_1:RecordAudio("926061010", var_44_43)
						arg_41_1:RecordAudio("926061010", var_44_43)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926061", "926061010", "story_v_out_926061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926061", "926061010", "story_v_out_926061.awb")
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
				actorName = "106603",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play926061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926061011
		arg_45_1.duration_ = 2.4

		local var_45_0 = {
			zh = 2.066,
			ja = 2.4
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
				arg_45_0:Play926061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10144"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10144 == nil then
				arg_45_1.var_.actorSpriteComps10144 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10144 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10144 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10144 = nil
			end

			local var_48_8 = arg_45_1.actors_["106103"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps106103 == nil then
				arg_45_1.var_.actorSpriteComps106103 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps106103 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps106103 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps106103 = nil
			end

			local var_48_16 = arg_45_1.actors_["106103"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

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
				local var_48_22 = Vector3.New(0, -2000, 0)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_23 = arg_45_1.actors_["10144"].transform
			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1.var_.moveOldPos10144 = var_48_23.localPosition
				var_48_23.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10144", 3)

				local var_48_25 = var_48_23.childCount

				for iter_48_9 = 0, var_48_25 - 1 do
					local var_48_26 = var_48_23:GetChild(iter_48_9)

					if var_48_26.name == "split_6" or not string.find(var_48_26.name, "split") then
						var_48_26.gameObject:SetActive(true)
					else
						var_48_26.gameObject:SetActive(false)
					end
				end
			end

			local var_48_27 = 0.001

			if var_48_24 <= arg_45_1.time_ and arg_45_1.time_ < var_48_24 + var_48_27 then
				local var_48_28 = (arg_45_1.time_ - var_48_24) / var_48_27
				local var_48_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_48_23.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10144, var_48_29, var_48_28)
			end

			if arg_45_1.time_ >= var_48_24 + var_48_27 and arg_45_1.time_ < var_48_24 + var_48_27 + arg_48_0 then
				var_48_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_48_30 = 0
			local var_48_31 = 0.2

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[1297].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(926061011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 8
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061011", "story_v_out_926061.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_926061", "926061011", "story_v_out_926061.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_926061", "926061011", "story_v_out_926061.awb")

						arg_45_1:RecordAudio("926061011", var_48_39)
						arg_45_1:RecordAudio("926061011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926061", "926061011", "story_v_out_926061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926061", "926061011", "story_v_out_926061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "10144",
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
	Play926061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926061012
		arg_49_1.duration_ = 8.2

		local var_49_0 = {
			zh = 6.4,
			ja = 8.2
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
				arg_49_0:Play926061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.775

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1297].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(926061012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061012", "story_v_out_926061.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_926061", "926061012", "story_v_out_926061.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_926061", "926061012", "story_v_out_926061.awb")

						arg_49_1:RecordAudio("926061012", var_52_9)
						arg_49_1:RecordAudio("926061012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926061", "926061012", "story_v_out_926061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926061", "926061012", "story_v_out_926061.awb")
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
	Play926061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926061013
		arg_53_1.duration_ = 10.73

		local var_53_0 = {
			zh = 10.433,
			ja = 10.733
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
				arg_53_0:Play926061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.175

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1297].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(926061013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 47
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061013", "story_v_out_926061.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_926061", "926061013", "story_v_out_926061.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_926061", "926061013", "story_v_out_926061.awb")

						arg_53_1:RecordAudio("926061013", var_56_9)
						arg_53_1:RecordAudio("926061013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926061", "926061013", "story_v_out_926061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926061", "926061013", "story_v_out_926061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926061014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10144"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10144 == nil then
				arg_57_1.var_.actorSpriteComps10144 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10144 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10144 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10144 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.0329999998211861

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[1298].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(926061014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 1
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926061015
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["106603"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps106603 == nil then
				arg_61_1.var_.actorSpriteComps106603 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps106603 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps106603 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps106603 = nil
			end

			local var_64_8 = arg_61_1.actors_["10144"].transform
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.var_.moveOldPos10144 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10144", 7)

				local var_64_10 = var_64_8.childCount

				for iter_64_4 = 0, var_64_10 - 1 do
					local var_64_11 = var_64_8:GetChild(iter_64_4)

					if var_64_11.name == "" or not string.find(var_64_11.name, "split") then
						var_64_11.gameObject:SetActive(true)
					else
						var_64_11.gameObject:SetActive(false)
					end
				end
			end

			local var_64_12 = 0.001

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_12 then
				local var_64_13 = (arg_61_1.time_ - var_64_9) / var_64_12
				local var_64_14 = Vector3.New(0, -2000, 0)

				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10144, var_64_14, var_64_13)
			end

			if arg_61_1.time_ >= var_64_9 + var_64_12 and arg_61_1.time_ < var_64_9 + var_64_12 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_15 = arg_61_1.actors_["106603"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos106603 = var_64_15.localPosition
				var_64_15.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("106603", 3)

				local var_64_17 = var_64_15.childCount

				for iter_64_5 = 0, var_64_17 - 1 do
					local var_64_18 = var_64_15:GetChild(iter_64_5)

					if var_64_18.name == "split_2" or not string.find(var_64_18.name, "split") then
						var_64_18.gameObject:SetActive(true)
					else
						var_64_18.gameObject:SetActive(false)
					end
				end
			end

			local var_64_19 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_19 then
				local var_64_20 = (arg_61_1.time_ - var_64_16) / var_64_19
				local var_64_21 = Vector3.New(-77.5, -399.1, -303.3)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos106603, var_64_21, var_64_20)
			end

			if arg_61_1.time_ >= var_64_16 + var_64_19 and arg_61_1.time_ < var_64_16 + var_64_19 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_64_22 = 0
			local var_64_23 = 0.05

			if var_64_22 < arg_61_1.time_ and arg_61_1.time_ <= var_64_22 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_24 = arg_61_1:FormatText(StoryNameCfg[32].name)

				arg_61_1.leftNameTxt_.text = var_64_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_25 = arg_61_1:GetWordFromCfg(926061015)
				local var_64_26 = arg_61_1:FormatText(var_64_25.content)

				arg_61_1.text_.text = var_64_26

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_27 = 2
				local var_64_28 = utf8.len(var_64_26)
				local var_64_29 = var_64_27 <= 0 and var_64_23 or var_64_23 * (var_64_28 / var_64_27)

				if var_64_29 > 0 and var_64_23 < var_64_29 then
					arg_61_1.talkMaxDuration = var_64_29

					if var_64_29 + var_64_22 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_22
					end
				end

				arg_61_1.text_.text = var_64_26
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061015", "story_v_out_926061.awb") ~= 0 then
					local var_64_30 = manager.audio:GetVoiceLength("story_v_out_926061", "926061015", "story_v_out_926061.awb") / 1000

					if var_64_30 + var_64_22 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_22
					end

					if var_64_25.prefab_name ~= "" and arg_61_1.actors_[var_64_25.prefab_name] ~= nil then
						local var_64_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_25.prefab_name].transform, "story_v_out_926061", "926061015", "story_v_out_926061.awb")

						arg_61_1:RecordAudio("926061015", var_64_31)
						arg_61_1:RecordAudio("926061015", var_64_31)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926061", "926061015", "story_v_out_926061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926061", "926061015", "story_v_out_926061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_32 = math.max(var_64_23, arg_61_1.talkMaxDuration)

			if var_64_22 <= arg_61_1.time_ and arg_61_1.time_ < var_64_22 + var_64_32 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_22) / var_64_32

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_22 + var_64_32 and arg_61_1.time_ < var_64_22 + var_64_32 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				assetPath = "",
				actorName = "106603",
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
	Play926061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926061016
		arg_65_1.duration_ = 4.33

		local var_65_0 = {
			zh = 3.7,
			ja = 4.333
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
				arg_65_0:Play926061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10144"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_8 = arg_65_1.actors_["106603"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps106603 == nil then
				arg_65_1.var_.actorSpriteComps106603 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps106603 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 0.5, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps106603 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps106603 = nil
			end

			local var_68_16 = arg_65_1.actors_["106603"].transform
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.var_.moveOldPos106603 = var_68_16.localPosition
				var_68_16.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("106603", 7)

				local var_68_18 = var_68_16.childCount

				for iter_68_8 = 0, var_68_18 - 1 do
					local var_68_19 = var_68_16:GetChild(iter_68_8)

					if var_68_19.name == "" or not string.find(var_68_19.name, "split") then
						var_68_19.gameObject:SetActive(true)
					else
						var_68_19.gameObject:SetActive(false)
					end
				end
			end

			local var_68_20 = 0.001

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_20 then
				local var_68_21 = (arg_65_1.time_ - var_68_17) / var_68_20
				local var_68_22 = Vector3.New(0, -2000, 0)

				var_68_16.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos106603, var_68_22, var_68_21)
			end

			if arg_65_1.time_ >= var_68_17 + var_68_20 and arg_65_1.time_ < var_68_17 + var_68_20 + arg_68_0 then
				var_68_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_23 = arg_65_1.actors_["10144"].transform
			local var_68_24 = 0

			if var_68_24 < arg_65_1.time_ and arg_65_1.time_ <= var_68_24 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_23.localPosition
				var_68_23.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				local var_68_25 = var_68_23.childCount

				for iter_68_9 = 0, var_68_25 - 1 do
					local var_68_26 = var_68_23:GetChild(iter_68_9)

					if var_68_26.name == "split_5" or not string.find(var_68_26.name, "split") then
						var_68_26.gameObject:SetActive(true)
					else
						var_68_26.gameObject:SetActive(false)
					end
				end
			end

			local var_68_27 = 0.001

			if var_68_24 <= arg_65_1.time_ and arg_65_1.time_ < var_68_24 + var_68_27 then
				local var_68_28 = (arg_65_1.time_ - var_68_24) / var_68_27
				local var_68_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_68_23.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, var_68_29, var_68_28)
			end

			if arg_65_1.time_ >= var_68_24 + var_68_27 and arg_65_1.time_ < var_68_24 + var_68_27 + arg_68_0 then
				var_68_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_30 = 0
			local var_68_31 = 0.5

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[1297].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(926061016)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 20
				local var_68_36 = utf8.len(var_68_34)
				local var_68_37 = var_68_35 <= 0 and var_68_31 or var_68_31 * (var_68_36 / var_68_35)

				if var_68_37 > 0 and var_68_31 < var_68_37 then
					arg_65_1.talkMaxDuration = var_68_37

					if var_68_37 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_37 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_34
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061016", "story_v_out_926061.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_926061", "926061016", "story_v_out_926061.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_926061", "926061016", "story_v_out_926061.awb")

						arg_65_1:RecordAudio("926061016", var_68_39)
						arg_65_1:RecordAudio("926061016", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926061", "926061016", "story_v_out_926061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926061", "926061016", "story_v_out_926061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_40 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_40 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_30) / var_68_40

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_30 + var_68_40 and arg_65_1.time_ < var_68_30 + var_68_40 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play926061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926061017
		arg_69_1.duration_ = 12.63

		local var_69_0 = {
			zh = 9.166,
			ja = 12.633
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
				arg_69_0:Play926061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10144"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 3)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_4" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_72_7 = 0
			local var_72_8 = 1.025

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_9 = arg_69_1:FormatText(StoryNameCfg[1297].name)

				arg_69_1.leftNameTxt_.text = var_72_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(926061017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 41
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_8 or var_72_8 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_8 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14

					if var_72_14 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061017", "story_v_out_926061.awb") ~= 0 then
					local var_72_15 = manager.audio:GetVoiceLength("story_v_out_926061", "926061017", "story_v_out_926061.awb") / 1000

					if var_72_15 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_7
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_926061", "926061017", "story_v_out_926061.awb")

						arg_69_1:RecordAudio("926061017", var_72_16)
						arg_69_1:RecordAudio("926061017", var_72_16)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926061", "926061017", "story_v_out_926061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926061", "926061017", "story_v_out_926061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_17 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_17 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_17

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_17 and arg_69_1.time_ < var_72_7 + var_72_17 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play926061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926061018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10144"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10144 == nil then
				arg_73_1.var_.actorSpriteComps10144 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10144 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.3

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

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_11 = arg_73_1:GetWordFromCfg(926061018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 12
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
	Play926061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926061019
		arg_77_1.duration_ = 6.87

		local var_77_0 = {
			zh = 6.266,
			ja = 6.866
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
			arg_77_1.auto_ = false
		end

		function arg_77_1.playNext_(arg_79_0)
			arg_77_1.onStoryFinished_()
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10144"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10144 == nil then
				arg_77_1.var_.actorSpriteComps10144 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10144 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10144 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10144 = nil
			end

			local var_80_8 = arg_77_1.actors_["10144"].transform
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 3)

				local var_80_10 = var_80_8.childCount

				for iter_80_4 = 0, var_80_10 - 1 do
					local var_80_11 = var_80_8:GetChild(iter_80_4)

					if var_80_11.name == "split_6" or not string.find(var_80_11.name, "split") then
						var_80_11.gameObject:SetActive(true)
					else
						var_80_11.gameObject:SetActive(false)
					end
				end
			end

			local var_80_12 = 0.001

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_12 then
				local var_80_13 = (arg_77_1.time_ - var_80_9) / var_80_12
				local var_80_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, var_80_14, var_80_13)
			end

			if arg_77_1.time_ >= var_80_9 + var_80_12 and arg_77_1.time_ < var_80_9 + var_80_12 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_80_15 = 0
			local var_80_16 = 0.725

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[1297].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(926061019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061019", "story_v_out_926061.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_926061", "926061019", "story_v_out_926061.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_926061", "926061019", "story_v_out_926061.awb")

						arg_77_1:RecordAudio("926061019", var_80_24)
						arg_77_1:RecordAudio("926061019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926061", "926061019", "story_v_out_926061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926061", "926061019", "story_v_out_926061.awb")
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926061.awb"
	}
}
