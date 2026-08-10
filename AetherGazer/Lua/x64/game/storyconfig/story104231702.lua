return {
	Play423172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423172001
		arg_1_1.duration_ = 6.53

		local var_1_0 = {
			zh = 6.266,
			ja = 6.533
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
				arg_1_0:Play423172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I24f"

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
				local var_4_5 = arg_1_1.bgs_.I24f

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
					if iter_4_0 ~= "I24f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.025

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

			local var_4_24 = "1083"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_4_28 = arg_1_1.actors_["1083"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1083 == nil then
				arg_1_1.var_.actorSpriteComps1083 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1083 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1083 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1083 = nil
			end

			local var_4_36 = arg_1_1.actors_["1083"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1083 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1083", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_7" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-50, -345, -345)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1083, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_4_43 = arg_1_1.actors_["1083"]
			local var_4_44 = 2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1083 = var_4_45.alpha
					arg_1_1.var_.characterEffect1083 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1083 = 0
			end

			local var_4_46 = 0.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1083, 1, var_4_47)

				if arg_1_1.var_.characterEffect1083 then
					arg_1_1.var_.characterEffect1083.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1083 then
				arg_1_1.var_.characterEffect1083.alpha = 1
			end

			local var_4_49 = manager.ui.mainCamera.transform
			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_51 = arg_1_1.var_.effectchedingzuozhan1
				local var_4_52
				local var_4_53 = var_4_49

				if not var_4_51 then
					var_4_51 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_4_53)
					var_4_51.name = "chedingzuozhan1"
					arg_1_1.var_.effectchedingzuozhan1 = var_4_51
				else
					var_4_51.transform:SetParent(var_4_53)
				end

				var_4_51.transform.localPosition = Vector3.New(0, 0, -2)
				var_4_51.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_54 = 0.166666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "effect"

				arg_1_1:AudioAction(var_4_56, var_4_57, "se_story_144", "se_story_144_amb_train_roof", "")
			end

			local var_4_58 = 0.3
			local var_4_59 = 1

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_60 = "play"
				local var_4_61 = "effect"

				arg_1_1:AudioAction(var_4_60, var_4_61, "se_story_144", "se_story_144_gun04", "")
			end

			local var_4_62 = 0
			local var_4_63 = 0.3

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				local var_4_64 = "play"
				local var_4_65 = "music"

				arg_1_1:AudioAction(var_4_64, var_4_65, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_66 = ""
				local var_4_67 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_67 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_67 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_67

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_67
						arg_1_1.bgmTxt2_.text = var_4_67
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

			local var_4_68 = 0.500666666666667
			local var_4_69 = 1

			if var_4_68 < arg_1_1.time_ and arg_1_1.time_ <= var_4_68 + arg_4_0 then
				local var_4_70 = "play"
				local var_4_71 = "music"

				arg_1_1:AudioAction(var_4_70, var_4_71, "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_72 = ""
				local var_4_73 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if var_4_73 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_73 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_73

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_73
						arg_1_1.bgmTxt2_.text = var_4_73
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

			local var_4_74 = 2
			local var_4_75 = 0.325

			if var_4_74 < arg_1_1.time_ and arg_1_1.time_ <= var_4_74 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_76 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_76:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_77 = arg_1_1:FormatText(StoryNameCfg[1332].name)

				arg_1_1.leftNameTxt_.text = var_4_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_78 = arg_1_1:GetWordFromCfg(423172001)
				local var_4_79 = arg_1_1:FormatText(var_4_78.content)

				arg_1_1.text_.text = var_4_79

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_80 = 13
				local var_4_81 = utf8.len(var_4_79)
				local var_4_82 = var_4_80 <= 0 and var_4_75 or var_4_75 * (var_4_81 / var_4_80)

				if var_4_82 > 0 and var_4_75 < var_4_82 then
					arg_1_1.talkMaxDuration = var_4_82
					var_4_74 = var_4_74 + 0.3

					if var_4_82 + var_4_74 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_82 + var_4_74
					end
				end

				arg_1_1.text_.text = var_4_79
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172001", "story_v_out_423172.awb") ~= 0 then
					local var_4_83 = manager.audio:GetVoiceLength("story_v_out_423172", "423172001", "story_v_out_423172.awb") / 1000

					if var_4_83 + var_4_74 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_83 + var_4_74
					end

					if var_4_78.prefab_name ~= "" and arg_1_1.actors_[var_4_78.prefab_name] ~= nil then
						local var_4_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_78.prefab_name].transform, "story_v_out_423172", "423172001", "story_v_out_423172.awb")

						arg_1_1:RecordAudio("423172001", var_4_84)
						arg_1_1:RecordAudio("423172001", var_4_84)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423172", "423172001", "story_v_out_423172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423172", "423172001", "story_v_out_423172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_85 = var_4_74 + 0.3
			local var_4_86 = math.max(var_4_75, arg_1_1.talkMaxDuration)

			if var_4_85 <= arg_1_1.time_ and arg_1_1.time_ < var_4_85 + var_4_86 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_85) / var_4_86

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_85 + var_4_86 and arg_1_1.time_ < var_4_85 + var_4_86 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423172002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1083"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1083 == nil then
				arg_9_1.var_.actorSpriteComps1083 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1083 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1083 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1083 = nil
			end

			local var_12_8 = arg_9_1.actors_["1083"].transform
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.var_.moveOldPos1083 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1083", 7)

				local var_12_10 = var_12_8.childCount

				for iter_12_4 = 0, var_12_10 - 1 do
					local var_12_11 = var_12_8:GetChild(iter_12_4)

					if var_12_11.name == "" or not string.find(var_12_11.name, "split") then
						var_12_11.gameObject:SetActive(true)
					else
						var_12_11.gameObject:SetActive(false)
					end
				end
			end

			local var_12_12 = 0.001

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_12 then
				local var_12_13 = (arg_9_1.time_ - var_12_9) / var_12_12
				local var_12_14 = Vector3.New(0, -2000, 0)

				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1083, var_12_14, var_12_13)
			end

			if arg_9_1.time_ >= var_12_9 + var_12_12 and arg_9_1.time_ < var_12_9 + var_12_12 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_15 = 0
			local var_12_16 = 1.6

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(423172002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 56
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play423172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423172003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.275

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(423172003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 52
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423172004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.45

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(423172004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 69
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play423172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423172005
		arg_21_1.duration_ = 6.77

		local var_21_0 = {
			zh = 6.233,
			ja = 6.766
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
				arg_21_0:Play423172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "3054"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(var_24_1, arg_21_1.canvasGo_.transform)

					var_24_2.transform:SetSiblingIndex(1)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs(var_24_3) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["3054"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps3054 == nil then
				arg_21_1.var_.actorSpriteComps3054 = var_24_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.actorSpriteComps3054 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_8 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_7)
								local var_24_9 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_7)
								local var_24_10 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_7)

								iter_24_3.color = Color.New(var_24_8, var_24_9, var_24_10)
							else
								local var_24_11 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_7)

								iter_24_3.color = Color.New(var_24_11, var_24_11, var_24_11)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps3054 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps3054 = nil
			end

			local var_24_12 = arg_21_1.actors_["3054"].transform
			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.var_.moveOldPos3054 = var_24_12.localPosition
				var_24_12.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("3054", 3)

				local var_24_14 = var_24_12.childCount

				for iter_24_6 = 0, var_24_14 - 1 do
					local var_24_15 = var_24_12:GetChild(iter_24_6)

					if var_24_15.name == "split_2" or not string.find(var_24_15.name, "split") then
						var_24_15.gameObject:SetActive(true)
					else
						var_24_15.gameObject:SetActive(false)
					end
				end
			end

			local var_24_16 = 0.001

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_13) / var_24_16
				local var_24_18 = Vector3.New(0, -275, -280)

				var_24_12.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos3054, var_24_18, var_24_17)
			end

			if arg_21_1.time_ >= var_24_13 + var_24_16 and arg_21_1.time_ < var_24_13 + var_24_16 + arg_24_0 then
				var_24_12.localPosition = Vector3.New(0, -275, -280)
			end

			local var_24_19 = 0
			local var_24_20 = 0.65

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_21 = arg_21_1:FormatText(StoryNameCfg[1339].name)

				arg_21_1.leftNameTxt_.text = var_24_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_22 = arg_21_1:GetWordFromCfg(423172005)
				local var_24_23 = arg_21_1:FormatText(var_24_22.content)

				arg_21_1.text_.text = var_24_23

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_24 = 26
				local var_24_25 = utf8.len(var_24_23)
				local var_24_26 = var_24_24 <= 0 and var_24_20 or var_24_20 * (var_24_25 / var_24_24)

				if var_24_26 > 0 and var_24_20 < var_24_26 then
					arg_21_1.talkMaxDuration = var_24_26

					if var_24_26 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_19
					end
				end

				arg_21_1.text_.text = var_24_23
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172005", "story_v_out_423172.awb") ~= 0 then
					local var_24_27 = manager.audio:GetVoiceLength("story_v_out_423172", "423172005", "story_v_out_423172.awb") / 1000

					if var_24_27 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_19
					end

					if var_24_22.prefab_name ~= "" and arg_21_1.actors_[var_24_22.prefab_name] ~= nil then
						local var_24_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_22.prefab_name].transform, "story_v_out_423172", "423172005", "story_v_out_423172.awb")

						arg_21_1:RecordAudio("423172005", var_24_28)
						arg_21_1:RecordAudio("423172005", var_24_28)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423172", "423172005", "story_v_out_423172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423172", "423172005", "story_v_out_423172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_29 = math.max(var_24_20, arg_21_1.talkMaxDuration)

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_19) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_19 + var_24_29 and arg_21_1.time_ < var_24_19 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423172006
		arg_25_1.duration_ = 6.53

		local var_25_0 = {
			zh = 6.533,
			ja = 6.233
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
				arg_25_0:Play423172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["3054"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos3054 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("3054", 3)

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
				local var_28_6 = Vector3.New(0, -275, -280)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos3054, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_28_7 = 0
			local var_28_8 = 0.55

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[1339].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(423172006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 22
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172006", "story_v_out_423172.awb") ~= 0 then
					local var_28_15 = manager.audio:GetVoiceLength("story_v_out_423172", "423172006", "story_v_out_423172.awb") / 1000

					if var_28_15 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_7
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_423172", "423172006", "story_v_out_423172.awb")

						arg_25_1:RecordAudio("423172006", var_28_16)
						arg_25_1:RecordAudio("423172006", var_28_16)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423172", "423172006", "story_v_out_423172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423172", "423172006", "story_v_out_423172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_17 and arg_25_1.time_ < var_28_7 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423172007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			zh = 5,
			ja = 4.533
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
				arg_29_0:Play423172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1083"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1083 == nil then
				arg_29_1.var_.actorSpriteComps1083 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1083 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1083 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1083 = nil
			end

			local var_32_8 = arg_29_1.actors_["3054"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps3054 == nil then
				arg_29_1.var_.actorSpriteComps3054 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps3054 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps3054 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps3054 = nil
			end

			local var_32_16 = arg_29_1.actors_["3054"].transform
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.moveOldPos3054 = var_32_16.localPosition
				var_32_16.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("3054", 7)

				local var_32_18 = var_32_16.childCount

				for iter_32_8 = 0, var_32_18 - 1 do
					local var_32_19 = var_32_16:GetChild(iter_32_8)

					if var_32_19.name == "" or not string.find(var_32_19.name, "split") then
						var_32_19.gameObject:SetActive(true)
					else
						var_32_19.gameObject:SetActive(false)
					end
				end
			end

			local var_32_20 = 0.001

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_20 then
				local var_32_21 = (arg_29_1.time_ - var_32_17) / var_32_20
				local var_32_22 = Vector3.New(0, -2000, 0)

				var_32_16.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos3054, var_32_22, var_32_21)
			end

			if arg_29_1.time_ >= var_32_17 + var_32_20 and arg_29_1.time_ < var_32_17 + var_32_20 + arg_32_0 then
				var_32_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_23 = arg_29_1.actors_["1083"].transform
			local var_32_24 = 0

			if var_32_24 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 then
				arg_29_1.var_.moveOldPos1083 = var_32_23.localPosition
				var_32_23.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1083", 3)

				local var_32_25 = var_32_23.childCount

				for iter_32_9 = 0, var_32_25 - 1 do
					local var_32_26 = var_32_23:GetChild(iter_32_9)

					if var_32_26.name == "split_7" or not string.find(var_32_26.name, "split") then
						var_32_26.gameObject:SetActive(true)
					else
						var_32_26.gameObject:SetActive(false)
					end
				end
			end

			local var_32_27 = 0.001

			if var_32_24 <= arg_29_1.time_ and arg_29_1.time_ < var_32_24 + var_32_27 then
				local var_32_28 = (arg_29_1.time_ - var_32_24) / var_32_27
				local var_32_29 = Vector3.New(-50, -345, -345)

				var_32_23.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1083, var_32_29, var_32_28)
			end

			if arg_29_1.time_ >= var_32_24 + var_32_27 and arg_29_1.time_ < var_32_24 + var_32_27 + arg_32_0 then
				var_32_23.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_32_30 = 0
			local var_32_31 = 0.5

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[1332].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_33 = arg_29_1:GetWordFromCfg(423172007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 20
				local var_32_36 = utf8.len(var_32_34)
				local var_32_37 = var_32_35 <= 0 and var_32_31 or var_32_31 * (var_32_36 / var_32_35)

				if var_32_37 > 0 and var_32_31 < var_32_37 then
					arg_29_1.talkMaxDuration = var_32_37

					if var_32_37 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_30
					end
				end

				arg_29_1.text_.text = var_32_34
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172007", "story_v_out_423172.awb") ~= 0 then
					local var_32_38 = manager.audio:GetVoiceLength("story_v_out_423172", "423172007", "story_v_out_423172.awb") / 1000

					if var_32_38 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_38 + var_32_30
					end

					if var_32_33.prefab_name ~= "" and arg_29_1.actors_[var_32_33.prefab_name] ~= nil then
						local var_32_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_33.prefab_name].transform, "story_v_out_423172", "423172007", "story_v_out_423172.awb")

						arg_29_1:RecordAudio("423172007", var_32_39)
						arg_29_1:RecordAudio("423172007", var_32_39)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423172", "423172007", "story_v_out_423172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423172", "423172007", "story_v_out_423172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_40 = math.max(var_32_31, arg_29_1.talkMaxDuration)

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_40 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_30) / var_32_40

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_30 + var_32_40 and arg_29_1.time_ < var_32_30 + var_32_40 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_29_1:InitPlayNodeList()
	end,
	Play423172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423172008
		arg_33_1.duration_ = 5.43

		local var_33_0 = {
			zh = 4.566,
			ja = 5.433
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
				arg_33_0:Play423172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.6

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1332].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(423172008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172008", "story_v_out_423172.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172008", "story_v_out_423172.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_423172", "423172008", "story_v_out_423172.awb")

						arg_33_1:RecordAudio("423172008", var_36_9)
						arg_33_1:RecordAudio("423172008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423172", "423172008", "story_v_out_423172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423172", "423172008", "story_v_out_423172.awb")
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
	Play423172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423172009
		arg_37_1.duration_ = 6

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1083"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1083 == nil then
				arg_37_1.var_.actorSpriteComps1083 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1083 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1083 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1083 = nil
			end

			local var_40_8 = arg_37_1.actors_["1083"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos1083 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1083", 7)

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
				local var_40_14 = Vector3.New(0, -2000, 0)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1083, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_15
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				local var_40_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_17 then
					var_40_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_17.radialBlurScale = 0.6
					var_40_17.radialBlurGradient = 1
					var_40_17.radialBlurIntensity = 1

					if var_40_15 then
						var_40_17.radialBlurTarget = var_40_15.transform
					end
				end
			end

			local var_40_18 = 2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_18 then
				local var_40_19 = (arg_37_1.time_ - var_40_16) / var_40_18
				local var_40_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_20 then
					var_40_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_20.radialBlurScale = Mathf.Lerp(0.6, 0, var_40_19)
					var_40_20.radialBlurGradient = Mathf.Lerp(1, 1, var_40_19)
					var_40_20.radialBlurIntensity = Mathf.Lerp(1, 1, var_40_19)
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_18 and arg_37_1.time_ < var_40_16 + var_40_18 + arg_40_0 then
				local var_40_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_21 then
					var_40_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_21.radialBlurScale = 0
					var_40_21.radialBlurGradient = 1
					var_40_21.radialBlurIntensity = 1
				end
			end

			local var_40_22 = 0.0333333333333333

			if var_40_22 < arg_37_1.time_ and arg_37_1.time_ <= var_40_22 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_23 = 0.966666666666667

			if arg_37_1.time_ >= var_40_22 + var_40_23 and arg_37_1.time_ < var_40_22 + var_40_23 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_24 = 1
			local var_40_25 = 1.375

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_26 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_26:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_27 = arg_37_1:GetWordFromCfg(423172009)
				local var_40_28 = arg_37_1:FormatText(var_40_27.content)

				arg_37_1.text_.text = var_40_28

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_29 = 55
				local var_40_30 = utf8.len(var_40_28)
				local var_40_31 = var_40_29 <= 0 and var_40_25 or var_40_25 * (var_40_30 / var_40_29)

				if var_40_31 > 0 and var_40_25 < var_40_31 then
					arg_37_1.talkMaxDuration = var_40_31
					var_40_24 = var_40_24 + 0.3

					if var_40_31 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_24
					end
				end

				arg_37_1.text_.text = var_40_28
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_32 = var_40_24 + 0.3
			local var_40_33 = math.max(var_40_25, arg_37_1.talkMaxDuration)

			if var_40_32 <= arg_37_1.time_ and arg_37_1.time_ < var_40_32 + var_40_33 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_32) / var_40_33

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_32 + var_40_33 and arg_37_1.time_ < var_40_32 + var_40_33 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play423172010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423172010
		arg_43_1.duration_ = 7

		local var_43_0 = {
			zh = 7,
			ja = 4.733
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play423172011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["3054"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps3054 == nil then
				arg_43_1.var_.actorSpriteComps3054 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps3054 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor1.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor1.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor1.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 1, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps3054 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps3054 = nil
			end

			local var_46_8 = arg_43_1.actors_["3054"].transform
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.var_.moveOldPos3054 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("3054", 3)

				local var_46_10 = var_46_8.childCount

				for iter_46_4 = 0, var_46_10 - 1 do
					local var_46_11 = var_46_8:GetChild(iter_46_4)

					if var_46_11.name == "" or not string.find(var_46_11.name, "split") then
						var_46_11.gameObject:SetActive(true)
					else
						var_46_11.gameObject:SetActive(false)
					end
				end
			end

			local var_46_12 = 0.001

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_9) / var_46_12
				local var_46_14 = Vector3.New(0, -275, -280)

				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos3054, var_46_14, var_46_13)
			end

			if arg_43_1.time_ >= var_46_9 + var_46_12 and arg_43_1.time_ < var_46_9 + var_46_12 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_46_15 = 0
			local var_46_16 = 0.675

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[1339].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(423172010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 27
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172010", "story_v_out_423172.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_423172", "423172010", "story_v_out_423172.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_423172", "423172010", "story_v_out_423172.awb")

						arg_43_1:RecordAudio("423172010", var_46_24)
						arg_43_1:RecordAudio("423172010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423172", "423172010", "story_v_out_423172.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423172", "423172010", "story_v_out_423172.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play423172011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 423172011
		arg_47_1.duration_ = 10.77

		local var_47_0 = {
			zh = 10.166,
			ja = 10.766
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play423172012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["3054"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos3054 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("3054", 3)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_2" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -275, -280)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos3054, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_50_7 = 0
			local var_50_8 = 1.05

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_9 = arg_47_1:FormatText(StoryNameCfg[1339].name)

				arg_47_1.leftNameTxt_.text = var_50_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(423172011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 42
				local var_50_13 = utf8.len(var_50_11)
				local var_50_14 = var_50_12 <= 0 and var_50_8 or var_50_8 * (var_50_13 / var_50_12)

				if var_50_14 > 0 and var_50_8 < var_50_14 then
					arg_47_1.talkMaxDuration = var_50_14

					if var_50_14 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172011", "story_v_out_423172.awb") ~= 0 then
					local var_50_15 = manager.audio:GetVoiceLength("story_v_out_423172", "423172011", "story_v_out_423172.awb") / 1000

					if var_50_15 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_7
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_423172", "423172011", "story_v_out_423172.awb")

						arg_47_1:RecordAudio("423172011", var_50_16)
						arg_47_1:RecordAudio("423172011", var_50_16)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_423172", "423172011", "story_v_out_423172.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_423172", "423172011", "story_v_out_423172.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_17 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_17 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_17

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_17 and arg_47_1.time_ < var_50_7 + var_50_17 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play423172012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423172012
		arg_51_1.duration_ = 2.33

		local var_51_0 = {
			zh = 2.333,
			ja = 1.433
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play423172013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1083"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1083 == nil then
				arg_51_1.var_.actorSpriteComps1083 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1083 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 1, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1083 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1083 = nil
			end

			local var_54_8 = arg_51_1.actors_["3054"]
			local var_54_9 = 0

			if var_54_9 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps3054 == nil then
				arg_51_1.var_.actorSpriteComps3054 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_10 = 0.2

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_10 and not isNil(var_54_8) then
				local var_54_11 = (arg_51_1.time_ - var_54_9) / var_54_10

				if arg_51_1.var_.actorSpriteComps3054 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								local var_54_12 = Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor2.r, var_54_11)
								local var_54_13 = Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor2.g, var_54_11)
								local var_54_14 = Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor2.b, var_54_11)

								iter_54_5.color = Color.New(var_54_12, var_54_13, var_54_14)
							else
								local var_54_15 = Mathf.Lerp(iter_54_5.color.r, 0.5, var_54_11)

								iter_54_5.color = Color.New(var_54_15, var_54_15, var_54_15)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_9 + var_54_10 and arg_51_1.time_ < var_54_9 + var_54_10 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps3054 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_54_7 then
						if arg_51_1.isInRecall_ then
							iter_54_7.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps3054 = nil
			end

			local var_54_16 = arg_51_1.actors_["3054"].transform
			local var_54_17 = 0

			if var_54_17 < arg_51_1.time_ and arg_51_1.time_ <= var_54_17 + arg_54_0 then
				arg_51_1.var_.moveOldPos3054 = var_54_16.localPosition
				var_54_16.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("3054", 2)

				local var_54_18 = var_54_16.childCount

				for iter_54_8 = 0, var_54_18 - 1 do
					local var_54_19 = var_54_16:GetChild(iter_54_8)

					if var_54_19.name == "" or not string.find(var_54_19.name, "split") then
						var_54_19.gameObject:SetActive(true)
					else
						var_54_19.gameObject:SetActive(false)
					end
				end
			end

			local var_54_20 = 0.001

			if var_54_17 <= arg_51_1.time_ and arg_51_1.time_ < var_54_17 + var_54_20 then
				local var_54_21 = (arg_51_1.time_ - var_54_17) / var_54_20
				local var_54_22 = Vector3.New(-390, -275, -280)

				var_54_16.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos3054, var_54_22, var_54_21)
			end

			if arg_51_1.time_ >= var_54_17 + var_54_20 and arg_51_1.time_ < var_54_17 + var_54_20 + arg_54_0 then
				var_54_16.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_54_23 = arg_51_1.actors_["1083"].transform
			local var_54_24 = 0

			if var_54_24 < arg_51_1.time_ and arg_51_1.time_ <= var_54_24 + arg_54_0 then
				arg_51_1.var_.moveOldPos1083 = var_54_23.localPosition
				var_54_23.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1083", 4)

				local var_54_25 = var_54_23.childCount

				for iter_54_9 = 0, var_54_25 - 1 do
					local var_54_26 = var_54_23:GetChild(iter_54_9)

					if var_54_26.name == "split_7" or not string.find(var_54_26.name, "split") then
						var_54_26.gameObject:SetActive(true)
					else
						var_54_26.gameObject:SetActive(false)
					end
				end
			end

			local var_54_27 = 0.001

			if var_54_24 <= arg_51_1.time_ and arg_51_1.time_ < var_54_24 + var_54_27 then
				local var_54_28 = (arg_51_1.time_ - var_54_24) / var_54_27
				local var_54_29 = Vector3.New(390, -345, -345)

				var_54_23.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1083, var_54_29, var_54_28)
			end

			if arg_51_1.time_ >= var_54_24 + var_54_27 and arg_51_1.time_ < var_54_24 + var_54_27 + arg_54_0 then
				var_54_23.localPosition = Vector3.New(390, -345, -345)
			end

			local var_54_30 = manager.ui.mainCamera.transform
			local var_54_31 = 0

			if var_54_31 < arg_51_1.time_ and arg_51_1.time_ <= var_54_31 + arg_54_0 then
				arg_51_1.var_.shakeOldPos = var_54_30.localPosition
			end

			local var_54_32 = 0.6

			if var_54_31 <= arg_51_1.time_ and arg_51_1.time_ < var_54_31 + var_54_32 then
				local var_54_33 = (arg_51_1.time_ - var_54_31) / 0.066
				local var_54_34, var_54_35 = math.modf(var_54_33)

				var_54_30.localPosition = Vector3.New(var_54_35 * 0.02, var_54_35 * 0.02, var_54_35 * 0.02) + arg_51_1.var_.shakeOldPos
			end

			if arg_51_1.time_ >= var_54_31 + var_54_32 and arg_51_1.time_ < var_54_31 + var_54_32 + arg_54_0 then
				var_54_30.localPosition = arg_51_1.var_.shakeOldPos
			end

			local var_54_36 = 0

			if var_54_36 < arg_51_1.time_ and arg_51_1.time_ <= var_54_36 + arg_54_0 then
				arg_51_1.allBtn_.enabled = false
			end

			local var_54_37 = 0.6

			if arg_51_1.time_ >= var_54_36 + var_54_37 and arg_51_1.time_ < var_54_36 + var_54_37 + arg_54_0 then
				arg_51_1.allBtn_.enabled = true
			end

			local var_54_38 = 0
			local var_54_39 = 0.3

			if var_54_38 < arg_51_1.time_ and arg_51_1.time_ <= var_54_38 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_40 = arg_51_1:FormatText(StoryNameCfg[1332].name)

				arg_51_1.leftNameTxt_.text = var_54_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_41 = arg_51_1:GetWordFromCfg(423172012)
				local var_54_42 = arg_51_1:FormatText(var_54_41.content)

				arg_51_1.text_.text = var_54_42

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_43 = 12
				local var_54_44 = utf8.len(var_54_42)
				local var_54_45 = var_54_43 <= 0 and var_54_39 or var_54_39 * (var_54_44 / var_54_43)

				if var_54_45 > 0 and var_54_39 < var_54_45 then
					arg_51_1.talkMaxDuration = var_54_45

					if var_54_45 + var_54_38 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_45 + var_54_38
					end
				end

				arg_51_1.text_.text = var_54_42
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172012", "story_v_out_423172.awb") ~= 0 then
					local var_54_46 = manager.audio:GetVoiceLength("story_v_out_423172", "423172012", "story_v_out_423172.awb") / 1000

					if var_54_46 + var_54_38 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_46 + var_54_38
					end

					if var_54_41.prefab_name ~= "" and arg_51_1.actors_[var_54_41.prefab_name] ~= nil then
						local var_54_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_41.prefab_name].transform, "story_v_out_423172", "423172012", "story_v_out_423172.awb")

						arg_51_1:RecordAudio("423172012", var_54_47)
						arg_51_1:RecordAudio("423172012", var_54_47)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_423172", "423172012", "story_v_out_423172.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_423172", "423172012", "story_v_out_423172.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_48 = math.max(var_54_39, arg_51_1.talkMaxDuration)

			if var_54_38 <= arg_51_1.time_ and arg_51_1.time_ < var_54_38 + var_54_48 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_38) / var_54_48

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_38 + var_54_48 and arg_51_1.time_ < var_54_38 + var_54_48 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_51_1:InitPlayNodeList()
	end,
	Play423172013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 423172013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play423172014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1083"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1083 == nil then
				arg_55_1.var_.actorSpriteComps1083 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps1083 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 0.5, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1083 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1083 = nil
			end

			local var_58_8 = arg_55_1.actors_["1083"].transform
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.var_.moveOldPos1083 = var_58_8.localPosition
				var_58_8.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1083", 7)

				local var_58_10 = var_58_8.childCount

				for iter_58_4 = 0, var_58_10 - 1 do
					local var_58_11 = var_58_8:GetChild(iter_58_4)

					if var_58_11.name == "" or not string.find(var_58_11.name, "split") then
						var_58_11.gameObject:SetActive(true)
					else
						var_58_11.gameObject:SetActive(false)
					end
				end
			end

			local var_58_12 = 0.001

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_9) / var_58_12
				local var_58_14 = Vector3.New(0, -2000, 0)

				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1083, var_58_14, var_58_13)
			end

			if arg_55_1.time_ >= var_58_9 + var_58_12 and arg_55_1.time_ < var_58_9 + var_58_12 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_15 = arg_55_1.actors_["3054"].transform
			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.var_.moveOldPos3054 = var_58_15.localPosition
				var_58_15.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("3054", 7)

				local var_58_17 = var_58_15.childCount

				for iter_58_5 = 0, var_58_17 - 1 do
					local var_58_18 = var_58_15:GetChild(iter_58_5)

					if var_58_18.name == "" or not string.find(var_58_18.name, "split") then
						var_58_18.gameObject:SetActive(true)
					else
						var_58_18.gameObject:SetActive(false)
					end
				end
			end

			local var_58_19 = 0.001

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_19 then
				local var_58_20 = (arg_55_1.time_ - var_58_16) / var_58_19
				local var_58_21 = Vector3.New(0, -2000, 0)

				var_58_15.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos3054, var_58_21, var_58_20)
			end

			if arg_55_1.time_ >= var_58_16 + var_58_19 and arg_55_1.time_ < var_58_16 + var_58_19 + arg_58_0 then
				var_58_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_22 = 0
			local var_58_23 = 1

			if var_58_22 < arg_55_1.time_ and arg_55_1.time_ <= var_58_22 + arg_58_0 then
				local var_58_24 = "play"
				local var_58_25 = "effect"

				arg_55_1:AudioAction(var_58_24, var_58_25, "se_story_141", "se_story_141_foley_cloth", "")
			end

			local var_58_26 = 0
			local var_58_27 = 1.1

			if var_58_26 < arg_55_1.time_ and arg_55_1.time_ <= var_58_26 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_28 = arg_55_1:GetWordFromCfg(423172013)
				local var_58_29 = arg_55_1:FormatText(var_58_28.content)

				arg_55_1.text_.text = var_58_29

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_30 = 46
				local var_58_31 = utf8.len(var_58_29)
				local var_58_32 = var_58_30 <= 0 and var_58_27 or var_58_27 * (var_58_31 / var_58_30)

				if var_58_32 > 0 and var_58_27 < var_58_32 then
					arg_55_1.talkMaxDuration = var_58_32

					if var_58_32 + var_58_26 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_32 + var_58_26
					end
				end

				arg_55_1.text_.text = var_58_29
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_33 = math.max(var_58_27, arg_55_1.talkMaxDuration)

			if var_58_26 <= arg_55_1.time_ and arg_55_1.time_ < var_58_26 + var_58_33 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_26) / var_58_33

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_26 + var_58_33 and arg_55_1.time_ < var_58_26 + var_58_33 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play423172014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423172014
		arg_59_1.duration_ = 2.33

		local var_59_0 = {
			zh = 2.333,
			ja = 2.2
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
				arg_59_0:Play423172015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["3054"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps3054 == nil then
				arg_59_1.var_.actorSpriteComps3054 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps3054 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 1, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps3054 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps3054 = nil
			end

			local var_62_8 = arg_59_1.actors_["3054"].transform
			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.var_.moveOldPos3054 = var_62_8.localPosition
				var_62_8.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("3054", 3)

				local var_62_10 = var_62_8.childCount

				for iter_62_4 = 0, var_62_10 - 1 do
					local var_62_11 = var_62_8:GetChild(iter_62_4)

					if var_62_11.name == "split_2" or not string.find(var_62_11.name, "split") then
						var_62_11.gameObject:SetActive(true)
					else
						var_62_11.gameObject:SetActive(false)
					end
				end
			end

			local var_62_12 = 0.001

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_12 then
				local var_62_13 = (arg_59_1.time_ - var_62_9) / var_62_12
				local var_62_14 = Vector3.New(0, -275, -280)

				var_62_8.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos3054, var_62_14, var_62_13)
			end

			if arg_59_1.time_ >= var_62_9 + var_62_12 and arg_59_1.time_ < var_62_9 + var_62_12 + arg_62_0 then
				var_62_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_62_15 = arg_59_1.actors_["3054"]
			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				local var_62_17 = var_62_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_62_17 then
					arg_59_1.var_.alphaOldValue3054 = var_62_17.alpha
					arg_59_1.var_.characterEffect3054 = var_62_17
				end

				arg_59_1.var_.alphaOldValue3054 = 0
			end

			local var_62_18 = 0.5

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_18 then
				local var_62_19 = (arg_59_1.time_ - var_62_16) / var_62_18
				local var_62_20 = Mathf.Lerp(arg_59_1.var_.alphaOldValue3054, 1, var_62_19)

				if arg_59_1.var_.characterEffect3054 then
					arg_59_1.var_.characterEffect3054.alpha = var_62_20
				end
			end

			if arg_59_1.time_ >= var_62_16 + var_62_18 and arg_59_1.time_ < var_62_16 + var_62_18 + arg_62_0 and arg_59_1.var_.characterEffect3054 then
				arg_59_1.var_.characterEffect3054.alpha = 1
			end

			local var_62_21 = 0
			local var_62_22 = 0.175

			if var_62_21 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_23 = arg_59_1:FormatText(StoryNameCfg[1339].name)

				arg_59_1.leftNameTxt_.text = var_62_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_24 = arg_59_1:GetWordFromCfg(423172014)
				local var_62_25 = arg_59_1:FormatText(var_62_24.content)

				arg_59_1.text_.text = var_62_25

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_26 = 7
				local var_62_27 = utf8.len(var_62_25)
				local var_62_28 = var_62_26 <= 0 and var_62_22 or var_62_22 * (var_62_27 / var_62_26)

				if var_62_28 > 0 and var_62_22 < var_62_28 then
					arg_59_1.talkMaxDuration = var_62_28

					if var_62_28 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_21
					end
				end

				arg_59_1.text_.text = var_62_25
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172014", "story_v_out_423172.awb") ~= 0 then
					local var_62_29 = manager.audio:GetVoiceLength("story_v_out_423172", "423172014", "story_v_out_423172.awb") / 1000

					if var_62_29 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_29 + var_62_21
					end

					if var_62_24.prefab_name ~= "" and arg_59_1.actors_[var_62_24.prefab_name] ~= nil then
						local var_62_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_24.prefab_name].transform, "story_v_out_423172", "423172014", "story_v_out_423172.awb")

						arg_59_1:RecordAudio("423172014", var_62_30)
						arg_59_1:RecordAudio("423172014", var_62_30)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423172", "423172014", "story_v_out_423172.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423172", "423172014", "story_v_out_423172.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_31 = math.max(var_62_22, arg_59_1.talkMaxDuration)

			if var_62_21 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_31 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_21) / var_62_31

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_21 + var_62_31 and arg_59_1.time_ < var_62_21 + var_62_31 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play423172015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423172015
		arg_63_1.duration_ = 6.4

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play423172016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["3054"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps3054 == nil then
				arg_63_1.var_.actorSpriteComps3054 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.034

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps3054 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor2.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor2.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor2.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 0.5, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps3054 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps3054 = nil
			end

			local var_66_8 = arg_63_1.actors_["3054"].transform
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.var_.moveOldPos3054 = var_66_8.localPosition
				var_66_8.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("3054", 7)

				local var_66_10 = var_66_8.childCount

				for iter_66_4 = 0, var_66_10 - 1 do
					local var_66_11 = var_66_8:GetChild(iter_66_4)

					if var_66_11.name == "" or not string.find(var_66_11.name, "split") then
						var_66_11.gameObject:SetActive(true)
					else
						var_66_11.gameObject:SetActive(false)
					end
				end
			end

			local var_66_12 = 0.001

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_12 then
				local var_66_13 = (arg_63_1.time_ - var_66_9) / var_66_12
				local var_66_14 = Vector3.New(0, -2000, 0)

				var_66_8.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos3054, var_66_14, var_66_13)
			end

			if arg_63_1.time_ >= var_66_9 + var_66_12 and arg_63_1.time_ < var_66_9 + var_66_12 + arg_66_0 then
				var_66_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_15 = manager.ui.mainCamera.transform
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				local var_66_17 = arg_63_1.var_.effectliechepaohong1
				local var_66_18
				local var_66_19 = var_66_15

				if not var_66_17 then
					var_66_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_66_19)
					var_66_17.name = "liechepaohong1"
					arg_63_1.var_.effectliechepaohong1 = var_66_17
				else
					var_66_17.transform:SetParent(var_66_19)
				end

				var_66_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_66_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_66_20 = 0

			if var_66_20 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_21 = 1.6

			if arg_63_1.time_ >= var_66_20 + var_66_21 and arg_63_1.time_ < var_66_20 + var_66_21 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_22 = manager.ui.mainCamera.transform
			local var_66_23 = 0

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 then
				arg_63_1.var_.shakeOldPos = var_66_22.localPosition
			end

			local var_66_24 = 1

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_24 then
				local var_66_25 = (arg_63_1.time_ - var_66_23) / 0.066
				local var_66_26, var_66_27 = math.modf(var_66_25)

				var_66_22.localPosition = Vector3.New(var_66_27 * 0.13, var_66_27 * 0.13, var_66_27 * 0.13) + arg_63_1.var_.shakeOldPos
			end

			if arg_63_1.time_ >= var_66_23 + var_66_24 and arg_63_1.time_ < var_66_23 + var_66_24 + arg_66_0 then
				var_66_22.localPosition = arg_63_1.var_.shakeOldPos
			end

			local var_66_28
			local var_66_29 = 0

			if var_66_29 < arg_63_1.time_ and arg_63_1.time_ <= var_66_29 + arg_66_0 then
				local var_66_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_30 then
					var_66_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_30.radialBlurScale = 0
					var_66_30.radialBlurGradient = 1
					var_66_30.radialBlurIntensity = 1

					if var_66_28 then
						var_66_30.radialBlurTarget = var_66_28.transform
					end
				end
			end

			local var_66_31 = 0.1

			if var_66_29 <= arg_63_1.time_ and arg_63_1.time_ < var_66_29 + var_66_31 then
				local var_66_32 = (arg_63_1.time_ - var_66_29) / var_66_31
				local var_66_33 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_33 then
					var_66_33.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_33.radialBlurScale = Mathf.Lerp(0, 0, var_66_32)
					var_66_33.radialBlurGradient = Mathf.Lerp(1, 1, var_66_32)
					var_66_33.radialBlurIntensity = Mathf.Lerp(1, 1, var_66_32)
				end
			end

			if arg_63_1.time_ >= var_66_29 + var_66_31 and arg_63_1.time_ < var_66_29 + var_66_31 + arg_66_0 then
				local var_66_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_34 then
					var_66_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_34.radialBlurScale = 0
					var_66_34.radialBlurGradient = 1
					var_66_34.radialBlurIntensity = 1
				end
			end

			local var_66_35 = 0
			local var_66_36 = 1

			if var_66_35 < arg_63_1.time_ and arg_63_1.time_ <= var_66_35 + arg_66_0 then
				local var_66_37 = "play"
				local var_66_38 = "effect"

				arg_63_1:AudioAction(var_66_37, var_66_38, "se_story_140", "se_story_140_laser", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_39 = 1.4
			local var_66_40 = 1.175

			if var_66_39 < arg_63_1.time_ and arg_63_1.time_ <= var_66_39 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_41 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_41:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_42 = arg_63_1:GetWordFromCfg(423172015)
				local var_66_43 = arg_63_1:FormatText(var_66_42.content)

				arg_63_1.text_.text = var_66_43

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_44 = 47
				local var_66_45 = utf8.len(var_66_43)
				local var_66_46 = var_66_44 <= 0 and var_66_40 or var_66_40 * (var_66_45 / var_66_44)

				if var_66_46 > 0 and var_66_40 < var_66_46 then
					arg_63_1.talkMaxDuration = var_66_46
					var_66_39 = var_66_39 + 0.3

					if var_66_46 + var_66_39 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_46 + var_66_39
					end
				end

				arg_63_1.text_.text = var_66_43
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_47 = var_66_39 + 0.3
			local var_66_48 = math.max(var_66_40, arg_63_1.talkMaxDuration)

			if var_66_47 <= arg_63_1.time_ and arg_63_1.time_ < var_66_47 + var_66_48 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_47) / var_66_48

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_47 + var_66_48 and arg_63_1.time_ < var_66_47 + var_66_48 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play423172016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423172016
		arg_69_1.duration_ = 12.57

		local var_69_0 = {
			zh = 12.566,
			ja = 11.433
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
				arg_69_0:Play423172017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "ST0113a"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 1.999999999999

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.ST0113a

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST0113a" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 3.999999999999

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_17 = 0.3

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_19 = 2

			if var_72_18 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				local var_72_20 = (arg_69_1.time_ - var_72_18) / var_72_19
				local var_72_21 = Color.New(0, 0, 0)

				var_72_21.a = Mathf.Lerp(0, 1, var_72_20)
				arg_69_1.mask_.color = var_72_21
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				local var_72_22 = Color.New(0, 0, 0)

				var_72_22.a = 1
				arg_69_1.mask_.color = var_72_22
			end

			local var_72_23 = 2

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_24 = 2

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24
				local var_72_26 = Color.New(0, 0, 0)

				var_72_26.a = Mathf.Lerp(1, 0, var_72_25)
				arg_69_1.mask_.color = var_72_26
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 then
				local var_72_27 = Color.New(0, 0, 0)
				local var_72_28 = 0

				arg_69_1.mask_.enabled = false
				var_72_27.a = var_72_28
				arg_69_1.mask_.color = var_72_27
			end

			local var_72_29 = manager.ui.mainCamera.transform
			local var_72_30 = 2

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				local var_72_31 = arg_69_1.var_.effectchedingzuozhan1

				if var_72_31 then
					Object.Destroy(var_72_31)

					arg_69_1.var_.effectchedingzuozhan1 = nil
				end
			end

			local var_72_32 = manager.ui.mainCamera.transform
			local var_72_33 = 1.999999999999

			if var_72_33 < arg_69_1.time_ and arg_69_1.time_ <= var_72_33 + arg_72_0 then
				local var_72_34 = arg_69_1.var_.effecthuangyuanbaoyu1
				local var_72_35
				local var_72_36 = var_72_32

				if not var_72_34 then
					var_72_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_72_36)
					var_72_34.name = "huangyuanbaoyu1"
					arg_69_1.var_.effecthuangyuanbaoyu1 = var_72_34
				else
					var_72_34.transform:SetParent(var_72_36)
				end

				var_72_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_72_37 = manager.ui.mainCameraCom_
				local var_72_38 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_72_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_72_39 = var_72_34.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_72_40 = 15
				local var_72_41 = 2 * var_72_40 * Mathf.Tan(var_72_37.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_72_37.aspect
				local var_72_42 = 1
				local var_72_43 = 1.7777777777777777

				if var_72_43 < var_72_37.aspect then
					var_72_42 = var_72_41 / (2 * var_72_40 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_72_43)
				end

				for iter_72_2, iter_72_3 in ipairs(var_72_39) do
					local var_72_44 = iter_72_3.transform.localScale

					iter_72_3.transform.localScale = Vector3.New(var_72_44.x / var_72_38 * var_72_42, var_72_44.y / var_72_38, var_72_44.z)
				end
			end

			local var_72_45 = manager.ui.mainCamera.transform
			local var_72_46 = 1.999999999999

			if var_72_46 < arg_69_1.time_ and arg_69_1.time_ <= var_72_46 + arg_72_0 then
				local var_72_47 = arg_69_1.var_.effecthuangyuanbaoyu1
				local var_72_48
				local var_72_49 = var_72_45

				if not var_72_47 then
					var_72_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_72_49)
					var_72_47.name = "huangyuanbaoyu1"
					arg_69_1.var_.effecthuangyuanbaoyu1 = var_72_47
				else
					var_72_47.transform:SetParent(var_72_49)
				end

				var_72_47.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_47.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_50 = 0.333333333333333
			local var_72_51 = 1

			if var_72_50 < arg_69_1.time_ and arg_69_1.time_ <= var_72_50 + arg_72_0 then
				local var_72_52 = "stop"
				local var_72_53 = "effect"

				arg_69_1:AudioAction(var_72_52, var_72_53, "se_story_144", "se_story_144_amb_train_roof", "")
			end

			local var_72_54 = 1.8
			local var_72_55 = 1

			if var_72_54 < arg_69_1.time_ and arg_69_1.time_ <= var_72_54 + arg_72_0 then
				local var_72_56 = "play"
				local var_72_57 = "effect"

				arg_69_1:AudioAction(var_72_56, var_72_57, "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_58 = 4
			local var_72_59 = 0.525

			if var_72_58 < arg_69_1.time_ and arg_69_1.time_ <= var_72_58 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_60 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_60:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_61 = arg_69_1:FormatText(StoryNameCfg[1332].name)

				arg_69_1.leftNameTxt_.text = var_72_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_4")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_62 = arg_69_1:GetWordFromCfg(423172016)
				local var_72_63 = arg_69_1:FormatText(var_72_62.content)

				arg_69_1.text_.text = var_72_63

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_64 = 21
				local var_72_65 = utf8.len(var_72_63)
				local var_72_66 = var_72_64 <= 0 and var_72_59 or var_72_59 * (var_72_65 / var_72_64)

				if var_72_66 > 0 and var_72_59 < var_72_66 then
					arg_69_1.talkMaxDuration = var_72_66
					var_72_58 = var_72_58 + 0.3

					if var_72_66 + var_72_58 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_66 + var_72_58
					end
				end

				arg_69_1.text_.text = var_72_63
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172016", "story_v_out_423172.awb") ~= 0 then
					local var_72_67 = manager.audio:GetVoiceLength("story_v_out_423172", "423172016", "story_v_out_423172.awb") / 1000

					if var_72_67 + var_72_58 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_67 + var_72_58
					end

					if var_72_62.prefab_name ~= "" and arg_69_1.actors_[var_72_62.prefab_name] ~= nil then
						local var_72_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_62.prefab_name].transform, "story_v_out_423172", "423172016", "story_v_out_423172.awb")

						arg_69_1:RecordAudio("423172016", var_72_68)
						arg_69_1:RecordAudio("423172016", var_72_68)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423172", "423172016", "story_v_out_423172.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423172", "423172016", "story_v_out_423172.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_69 = var_72_58 + 0.3
			local var_72_70 = math.max(var_72_59, arg_69_1.talkMaxDuration)

			if var_72_69 <= arg_69_1.time_ and arg_69_1.time_ < var_72_69 + var_72_70 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_69) / var_72_70

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_69 + var_72_70 and arg_69_1.time_ < var_72_69 + var_72_70 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play423172017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423172017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423172018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.7

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(423172017)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 68
				local var_78_5 = utf8.len(var_78_3)
				local var_78_6 = var_78_4 <= 0 and var_78_1 or var_78_1 * (var_78_5 / var_78_4)

				if var_78_6 > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_7 and arg_75_1.time_ < var_78_0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423172018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423172018
		arg_79_1.duration_ = 7.2

		local var_79_0 = {
			zh = 7.2,
			ja = 6.866
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
				arg_79_0:Play423172019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1083"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1083 == nil then
				arg_79_1.var_.actorSpriteComps1083 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1083 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 1, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1083 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1083 = nil
			end

			local var_82_8 = arg_79_1.actors_["1083"].transform
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.var_.moveOldPos1083 = var_82_8.localPosition
				var_82_8.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1083", 3)

				local var_82_10 = var_82_8.childCount

				for iter_82_4 = 0, var_82_10 - 1 do
					local var_82_11 = var_82_8:GetChild(iter_82_4)

					if var_82_11.name == "split_4" or not string.find(var_82_11.name, "split") then
						var_82_11.gameObject:SetActive(true)
					else
						var_82_11.gameObject:SetActive(false)
					end
				end
			end

			local var_82_12 = 0.001

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_9) / var_82_12
				local var_82_14 = Vector3.New(-50, -345, -345)

				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1083, var_82_14, var_82_13)
			end

			if arg_79_1.time_ >= var_82_9 + var_82_12 and arg_79_1.time_ < var_82_9 + var_82_12 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_82_15 = arg_79_1.actors_["1083"]
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				local var_82_17 = var_82_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_17 then
					arg_79_1.var_.alphaOldValue1083 = var_82_17.alpha
					arg_79_1.var_.characterEffect1083 = var_82_17
				end

				arg_79_1.var_.alphaOldValue1083 = 0
			end

			local var_82_18 = 0.5

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_18 then
				local var_82_19 = (arg_79_1.time_ - var_82_16) / var_82_18
				local var_82_20 = Mathf.Lerp(arg_79_1.var_.alphaOldValue1083, 1, var_82_19)

				if arg_79_1.var_.characterEffect1083 then
					arg_79_1.var_.characterEffect1083.alpha = var_82_20
				end
			end

			if arg_79_1.time_ >= var_82_16 + var_82_18 and arg_79_1.time_ < var_82_16 + var_82_18 + arg_82_0 and arg_79_1.var_.characterEffect1083 then
				arg_79_1.var_.characterEffect1083.alpha = 1
			end

			local var_82_21 = 0
			local var_82_22 = 0.4

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[1332].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(423172018)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 16
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172018", "story_v_out_423172.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_423172", "423172018", "story_v_out_423172.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_423172", "423172018", "story_v_out_423172.awb")

						arg_79_1:RecordAudio("423172018", var_82_30)
						arg_79_1:RecordAudio("423172018", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_423172", "423172018", "story_v_out_423172.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_423172", "423172018", "story_v_out_423172.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play423172019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423172019
		arg_83_1.duration_ = 5.8

		local var_83_0 = {
			zh = 5.8,
			ja = 5.333
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
				arg_83_0:Play423172020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1083"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps1083 == nil then
				arg_83_1.var_.actorSpriteComps1083 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps1083 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_4 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, var_86_3)
								local var_86_5 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, var_86_3)
								local var_86_6 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, var_86_3)

								iter_86_1.color = Color.New(var_86_4, var_86_5, var_86_6)
							else
								local var_86_7 = Mathf.Lerp(iter_86_1.color.r, 0.5, var_86_3)

								iter_86_1.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps1083 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1083 = nil
			end

			local var_86_8 = 0
			local var_86_9 = 0.425

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_10 = arg_83_1:FormatText(StoryNameCfg[1339].name)

				arg_83_1.leftNameTxt_.text = var_86_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054_split_1")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_11 = arg_83_1:GetWordFromCfg(423172019)
				local var_86_12 = arg_83_1:FormatText(var_86_11.content)

				arg_83_1.text_.text = var_86_12

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 17
				local var_86_14 = utf8.len(var_86_12)
				local var_86_15 = var_86_13 <= 0 and var_86_9 or var_86_9 * (var_86_14 / var_86_13)

				if var_86_15 > 0 and var_86_9 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_12
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172019", "story_v_out_423172.awb") ~= 0 then
					local var_86_16 = manager.audio:GetVoiceLength("story_v_out_423172", "423172019", "story_v_out_423172.awb") / 1000

					if var_86_16 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_8
					end

					if var_86_11.prefab_name ~= "" and arg_83_1.actors_[var_86_11.prefab_name] ~= nil then
						local var_86_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_11.prefab_name].transform, "story_v_out_423172", "423172019", "story_v_out_423172.awb")

						arg_83_1:RecordAudio("423172019", var_86_17)
						arg_83_1:RecordAudio("423172019", var_86_17)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423172", "423172019", "story_v_out_423172.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423172", "423172019", "story_v_out_423172.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_18 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_18 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_18

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_18 and arg_83_1.time_ < var_86_8 + var_86_18 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play423172020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423172020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play423172021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1083"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1083 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1083", 7)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -2000, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1083, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_7 = 0.166666666666667
			local var_90_8 = 1

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				local var_90_9 = "play"
				local var_90_10 = "effect"

				arg_87_1:AudioAction(var_90_9, var_90_10, "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_90_11 = 0
			local var_90_12 = 1.7

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_13 = arg_87_1:GetWordFromCfg(423172020)
				local var_90_14 = arg_87_1:FormatText(var_90_13.content)

				arg_87_1.text_.text = var_90_14

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_15 = 68
				local var_90_16 = utf8.len(var_90_14)
				local var_90_17 = var_90_15 <= 0 and var_90_12 or var_90_12 * (var_90_16 / var_90_15)

				if var_90_17 > 0 and var_90_12 < var_90_17 then
					arg_87_1.talkMaxDuration = var_90_17

					if var_90_17 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_14
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_18 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_18 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_18

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_18 and arg_87_1.time_ < var_90_11 + var_90_18 + arg_90_0 then
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
	Play423172021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423172021
		arg_91_1.duration_ = 10.23

		local var_91_0 = {
			zh = 7.766,
			ja = 10.233
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
				arg_91_0:Play423172022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["3054"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos3054 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("3054", 3)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_1" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(0, -275, -280)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos3054, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_94_7 = arg_91_1.actors_["3054"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps3054 == nil then
				arg_91_1.var_.actorSpriteComps3054 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.2

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps3054 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								local var_94_11 = Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, var_94_10)
								local var_94_12 = Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, var_94_10)
								local var_94_13 = Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, var_94_10)

								iter_94_2.color = Color.New(var_94_11, var_94_12, var_94_13)
							else
								local var_94_14 = Mathf.Lerp(iter_94_2.color.r, 1, var_94_10)

								iter_94_2.color = Color.New(var_94_14, var_94_14, var_94_14)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps3054 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps3054 = nil
			end

			local var_94_15 = arg_91_1.actors_["3054"]
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				local var_94_17 = var_94_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_17 then
					arg_91_1.var_.alphaOldValue3054 = var_94_17.alpha
					arg_91_1.var_.characterEffect3054 = var_94_17
				end

				arg_91_1.var_.alphaOldValue3054 = 0
			end

			local var_94_18 = 0.5

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_18 then
				local var_94_19 = (arg_91_1.time_ - var_94_16) / var_94_18
				local var_94_20 = Mathf.Lerp(arg_91_1.var_.alphaOldValue3054, 1, var_94_19)

				if arg_91_1.var_.characterEffect3054 then
					arg_91_1.var_.characterEffect3054.alpha = var_94_20
				end
			end

			if arg_91_1.time_ >= var_94_16 + var_94_18 and arg_91_1.time_ < var_94_16 + var_94_18 + arg_94_0 and arg_91_1.var_.characterEffect3054 then
				arg_91_1.var_.characterEffect3054.alpha = 1
			end

			local var_94_21 = 0
			local var_94_22 = 0.725

			if var_94_21 < arg_91_1.time_ and arg_91_1.time_ <= var_94_21 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_23 = arg_91_1:FormatText(StoryNameCfg[1339].name)

				arg_91_1.leftNameTxt_.text = var_94_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_24 = arg_91_1:GetWordFromCfg(423172021)
				local var_94_25 = arg_91_1:FormatText(var_94_24.content)

				arg_91_1.text_.text = var_94_25

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_26 = 29
				local var_94_27 = utf8.len(var_94_25)
				local var_94_28 = var_94_26 <= 0 and var_94_22 or var_94_22 * (var_94_27 / var_94_26)

				if var_94_28 > 0 and var_94_22 < var_94_28 then
					arg_91_1.talkMaxDuration = var_94_28

					if var_94_28 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_28 + var_94_21
					end
				end

				arg_91_1.text_.text = var_94_25
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172021", "story_v_out_423172.awb") ~= 0 then
					local var_94_29 = manager.audio:GetVoiceLength("story_v_out_423172", "423172021", "story_v_out_423172.awb") / 1000

					if var_94_29 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_29 + var_94_21
					end

					if var_94_24.prefab_name ~= "" and arg_91_1.actors_[var_94_24.prefab_name] ~= nil then
						local var_94_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_24.prefab_name].transform, "story_v_out_423172", "423172021", "story_v_out_423172.awb")

						arg_91_1:RecordAudio("423172021", var_94_30)
						arg_91_1:RecordAudio("423172021", var_94_30)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423172", "423172021", "story_v_out_423172.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423172", "423172021", "story_v_out_423172.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_31 = math.max(var_94_22, arg_91_1.talkMaxDuration)

			if var_94_21 <= arg_91_1.time_ and arg_91_1.time_ < var_94_21 + var_94_31 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_21) / var_94_31

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_21 + var_94_31 and arg_91_1.time_ < var_94_21 + var_94_31 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423172022
		arg_95_1.duration_ = 6.63

		local var_95_0 = {
			zh = 6.1,
			ja = 6.633
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
				arg_95_0:Play423172023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.525

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[1339].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(423172022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172022", "story_v_out_423172.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172022", "story_v_out_423172.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_423172", "423172022", "story_v_out_423172.awb")

						arg_95_1:RecordAudio("423172022", var_98_9)
						arg_95_1:RecordAudio("423172022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_423172", "423172022", "story_v_out_423172.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_423172", "423172022", "story_v_out_423172.awb")
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
	Play423172023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423172023
		arg_99_1.duration_ = 6.43

		local var_99_0 = {
			zh = 5.4,
			ja = 6.433
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
				arg_99_0:Play423172024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.475

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1339].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(423172023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172023", "story_v_out_423172.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172023", "story_v_out_423172.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_423172", "423172023", "story_v_out_423172.awb")

						arg_99_1:RecordAudio("423172023", var_102_9)
						arg_99_1:RecordAudio("423172023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_423172", "423172023", "story_v_out_423172.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_423172", "423172023", "story_v_out_423172.awb")
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
	Play423172024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423172024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play423172025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.034
			local var_106_1 = 1

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_2 = "play"
				local var_106_3 = "effect"

				arg_103_1:AudioAction(var_106_2, var_106_3, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_106_4 = arg_103_1.actors_["3054"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				local var_106_6 = var_106_4:GetComponentInChildren(typeof(CanvasGroup))

				if var_106_6 then
					arg_103_1.var_.alphaOldValue3054 = var_106_6.alpha
					arg_103_1.var_.characterEffect3054 = var_106_6
				end

				arg_103_1.var_.alphaOldValue3054 = 1
			end

			local var_106_7 = 0.5

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_7 then
				local var_106_8 = (arg_103_1.time_ - var_106_5) / var_106_7
				local var_106_9 = Mathf.Lerp(arg_103_1.var_.alphaOldValue3054, 0, var_106_8)

				if arg_103_1.var_.characterEffect3054 then
					arg_103_1.var_.characterEffect3054.alpha = var_106_9
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_7 and arg_103_1.time_ < var_106_5 + var_106_7 + arg_106_0 and arg_103_1.var_.characterEffect3054 then
				arg_103_1.var_.characterEffect3054.alpha = 0
			end

			local var_106_10 = 0
			local var_106_11 = 1.475

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_12 = arg_103_1:GetWordFromCfg(423172024)
				local var_106_13 = arg_103_1:FormatText(var_106_12.content)

				arg_103_1.text_.text = var_106_13

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_14 = 59
				local var_106_15 = utf8.len(var_106_13)
				local var_106_16 = var_106_14 <= 0 and var_106_11 or var_106_11 * (var_106_15 / var_106_14)

				if var_106_16 > 0 and var_106_11 < var_106_16 then
					arg_103_1.talkMaxDuration = var_106_16

					if var_106_16 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_10
					end
				end

				arg_103_1.text_.text = var_106_13
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_17 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_17 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_10) / var_106_17

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_10 + var_106_17 and arg_103_1.time_ < var_106_10 + var_106_17 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play423172025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423172025
		arg_107_1.duration_ = 7.53

		local var_107_0 = {
			zh = 7.533,
			ja = 5.733
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
				arg_107_0:Play423172026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["3054"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos3054 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("3054", 3)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_1" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(0, -275, -280)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos3054, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_110_7 = arg_107_1.actors_["3054"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				local var_110_9 = var_110_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_110_9 then
					arg_107_1.var_.alphaOldValue3054 = var_110_9.alpha
					arg_107_1.var_.characterEffect3054 = var_110_9
				end

				arg_107_1.var_.alphaOldValue3054 = 0
			end

			local var_110_10 = 0.5

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_10 then
				local var_110_11 = (arg_107_1.time_ - var_110_8) / var_110_10
				local var_110_12 = Mathf.Lerp(arg_107_1.var_.alphaOldValue3054, 1, var_110_11)

				if arg_107_1.var_.characterEffect3054 then
					arg_107_1.var_.characterEffect3054.alpha = var_110_12
				end
			end

			if arg_107_1.time_ >= var_110_8 + var_110_10 and arg_107_1.time_ < var_110_8 + var_110_10 + arg_110_0 and arg_107_1.var_.characterEffect3054 then
				arg_107_1.var_.characterEffect3054.alpha = 1
			end

			local var_110_13 = 0
			local var_110_14 = 0.8

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_15 = arg_107_1:FormatText(StoryNameCfg[1339].name)

				arg_107_1.leftNameTxt_.text = var_110_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_16 = arg_107_1:GetWordFromCfg(423172025)
				local var_110_17 = arg_107_1:FormatText(var_110_16.content)

				arg_107_1.text_.text = var_110_17

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_18 = 32
				local var_110_19 = utf8.len(var_110_17)
				local var_110_20 = var_110_18 <= 0 and var_110_14 or var_110_14 * (var_110_19 / var_110_18)

				if var_110_20 > 0 and var_110_14 < var_110_20 then
					arg_107_1.talkMaxDuration = var_110_20

					if var_110_20 + var_110_13 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_13
					end
				end

				arg_107_1.text_.text = var_110_17
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172025", "story_v_out_423172.awb") ~= 0 then
					local var_110_21 = manager.audio:GetVoiceLength("story_v_out_423172", "423172025", "story_v_out_423172.awb") / 1000

					if var_110_21 + var_110_13 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_13
					end

					if var_110_16.prefab_name ~= "" and arg_107_1.actors_[var_110_16.prefab_name] ~= nil then
						local var_110_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_16.prefab_name].transform, "story_v_out_423172", "423172025", "story_v_out_423172.awb")

						arg_107_1:RecordAudio("423172025", var_110_22)
						arg_107_1:RecordAudio("423172025", var_110_22)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_423172", "423172025", "story_v_out_423172.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_423172", "423172025", "story_v_out_423172.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_23 = math.max(var_110_14, arg_107_1.talkMaxDuration)

			if var_110_13 <= arg_107_1.time_ and arg_107_1.time_ < var_110_13 + var_110_23 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_13) / var_110_23

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_13 + var_110_23 and arg_107_1.time_ < var_110_13 + var_110_23 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423172026
		arg_111_1.duration_ = 6.93

		local var_111_0 = {
			zh = 6.933,
			ja = 5.7
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
				arg_111_0:Play423172027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.6

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[1339].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(423172026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172026", "story_v_out_423172.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172026", "story_v_out_423172.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_423172", "423172026", "story_v_out_423172.awb")

						arg_111_1:RecordAudio("423172026", var_114_9)
						arg_111_1:RecordAudio("423172026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423172", "423172026", "story_v_out_423172.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423172", "423172026", "story_v_out_423172.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play423172027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423172027
		arg_115_1.duration_ = 6.5

		local var_115_0 = {
			zh = 6.5,
			ja = 4.066
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
				arg_115_0:Play423172028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.675

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[1339].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(423172027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172027", "story_v_out_423172.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172027", "story_v_out_423172.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_423172", "423172027", "story_v_out_423172.awb")

						arg_115_1:RecordAudio("423172027", var_118_9)
						arg_115_1:RecordAudio("423172027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_423172", "423172027", "story_v_out_423172.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_423172", "423172027", "story_v_out_423172.awb")
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
	Play423172028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423172028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play423172029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.166666666666667
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_2 = "play"
				local var_122_3 = "effect"

				arg_119_1:AudioAction(var_122_2, var_122_3, "se_story_1310", "se_story_1310_footstep03", "")
			end

			local var_122_4 = arg_119_1.actors_["3054"].transform
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.var_.moveOldPos3054 = var_122_4.localPosition
				var_122_4.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("3054", 7)

				local var_122_6 = var_122_4.childCount

				for iter_122_0 = 0, var_122_6 - 1 do
					local var_122_7 = var_122_4:GetChild(iter_122_0)

					if var_122_7.name == "split_1" or not string.find(var_122_7.name, "split") then
						var_122_7.gameObject:SetActive(true)
					else
						var_122_7.gameObject:SetActive(false)
					end
				end
			end

			local var_122_8 = 0.001

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_8 then
				local var_122_9 = (arg_119_1.time_ - var_122_5) / var_122_8
				local var_122_10 = Vector3.New(0, -2000, 0)

				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos3054, var_122_10, var_122_9)
			end

			if arg_119_1.time_ >= var_122_5 + var_122_8 and arg_119_1.time_ < var_122_5 + var_122_8 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_11 = 0
			local var_122_12 = 1.75

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_13 = arg_119_1:GetWordFromCfg(423172028)
				local var_122_14 = arg_119_1:FormatText(var_122_13.content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_15 = 70
				local var_122_16 = utf8.len(var_122_14)
				local var_122_17 = var_122_15 <= 0 and var_122_12 or var_122_12 * (var_122_16 / var_122_15)

				if var_122_17 > 0 and var_122_12 < var_122_17 then
					arg_119_1.talkMaxDuration = var_122_17

					if var_122_17 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_17 + var_122_11
					end
				end

				arg_119_1.text_.text = var_122_14
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_12, arg_119_1.talkMaxDuration)

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_11) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_11 + var_122_18 and arg_119_1.time_ < var_122_11 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 423172029
		arg_123_1.duration_ = 3.87

		local var_123_0 = {
			zh = 2.1,
			ja = 3.866
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
				arg_123_0:Play423172030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1083"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1083 == nil then
				arg_123_1.var_.actorSpriteComps1083 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps1083 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 1, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1083 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1083 = nil
			end

			local var_126_8 = arg_123_1.actors_["1083"].transform
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.var_.moveOldPos1083 = var_126_8.localPosition
				var_126_8.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1083", 4)

				local var_126_10 = var_126_8.childCount

				for iter_126_4 = 0, var_126_10 - 1 do
					local var_126_11 = var_126_8:GetChild(iter_126_4)

					if var_126_11.name == "split_7" or not string.find(var_126_11.name, "split") then
						var_126_11.gameObject:SetActive(true)
					else
						var_126_11.gameObject:SetActive(false)
					end
				end
			end

			local var_126_12 = 0.001

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_9) / var_126_12
				local var_126_14 = Vector3.New(390, -345, -345)

				var_126_8.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1083, var_126_14, var_126_13)
			end

			if arg_123_1.time_ >= var_126_9 + var_126_12 and arg_123_1.time_ < var_126_9 + var_126_12 + arg_126_0 then
				var_126_8.localPosition = Vector3.New(390, -345, -345)
			end

			local var_126_15 = 0
			local var_126_16 = 0.15

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[1332].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(423172029)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 6
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172029", "story_v_out_423172.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_423172", "423172029", "story_v_out_423172.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_423172", "423172029", "story_v_out_423172.awb")

						arg_123_1:RecordAudio("423172029", var_126_24)
						arg_123_1:RecordAudio("423172029", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_423172", "423172029", "story_v_out_423172.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_423172", "423172029", "story_v_out_423172.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play423172030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423172030
		arg_127_1.duration_ = 8.7

		local var_127_0 = {
			zh = 8.7,
			ja = 7.7
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
				arg_127_0:Play423172031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["3054"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps3054 == nil then
				arg_127_1.var_.actorSpriteComps3054 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps3054 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps3054 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps3054 = nil
			end

			local var_130_8 = arg_127_1.actors_["1083"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1083 == nil then
				arg_127_1.var_.actorSpriteComps1083 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 0.2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps1083 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1083 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1083 = nil
			end

			local var_130_16 = arg_127_1.actors_["3054"].transform
			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1.var_.moveOldPos3054 = var_130_16.localPosition
				var_130_16.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("3054", 2)

				local var_130_18 = var_130_16.childCount

				for iter_130_8 = 0, var_130_18 - 1 do
					local var_130_19 = var_130_16:GetChild(iter_130_8)

					if var_130_19.name == "split_2" or not string.find(var_130_19.name, "split") then
						var_130_19.gameObject:SetActive(true)
					else
						var_130_19.gameObject:SetActive(false)
					end
				end
			end

			local var_130_20 = 0.001

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_20 then
				local var_130_21 = (arg_127_1.time_ - var_130_17) / var_130_20
				local var_130_22 = Vector3.New(-390, -275, -280)

				var_130_16.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos3054, var_130_22, var_130_21)
			end

			if arg_127_1.time_ >= var_130_17 + var_130_20 and arg_127_1.time_ < var_130_17 + var_130_20 + arg_130_0 then
				var_130_16.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_130_23 = 0
			local var_130_24 = 0.95

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_25 = arg_127_1:FormatText(StoryNameCfg[1339].name)

				arg_127_1.leftNameTxt_.text = var_130_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_26 = arg_127_1:GetWordFromCfg(423172030)
				local var_130_27 = arg_127_1:FormatText(var_130_26.content)

				arg_127_1.text_.text = var_130_27

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_28 = 39
				local var_130_29 = utf8.len(var_130_27)
				local var_130_30 = var_130_28 <= 0 and var_130_24 or var_130_24 * (var_130_29 / var_130_28)

				if var_130_30 > 0 and var_130_24 < var_130_30 then
					arg_127_1.talkMaxDuration = var_130_30

					if var_130_30 + var_130_23 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_30 + var_130_23
					end
				end

				arg_127_1.text_.text = var_130_27
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172030", "story_v_out_423172.awb") ~= 0 then
					local var_130_31 = manager.audio:GetVoiceLength("story_v_out_423172", "423172030", "story_v_out_423172.awb") / 1000

					if var_130_31 + var_130_23 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_31 + var_130_23
					end

					if var_130_26.prefab_name ~= "" and arg_127_1.actors_[var_130_26.prefab_name] ~= nil then
						local var_130_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_26.prefab_name].transform, "story_v_out_423172", "423172030", "story_v_out_423172.awb")

						arg_127_1:RecordAudio("423172030", var_130_32)
						arg_127_1:RecordAudio("423172030", var_130_32)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_423172", "423172030", "story_v_out_423172.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_423172", "423172030", "story_v_out_423172.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_33 = math.max(var_130_24, arg_127_1.talkMaxDuration)

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_33 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_23) / var_130_33

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_23 + var_130_33 and arg_127_1.time_ < var_130_23 + var_130_33 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423172031
		arg_131_1.duration_ = 7.97

		local var_131_0 = {
			zh = 7.966,
			ja = 6.233
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play423172032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.75

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[1339].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(423172031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172031", "story_v_out_423172.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172031", "story_v_out_423172.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_423172", "423172031", "story_v_out_423172.awb")

						arg_131_1:RecordAudio("423172031", var_134_9)
						arg_131_1:RecordAudio("423172031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_423172", "423172031", "story_v_out_423172.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_423172", "423172031", "story_v_out_423172.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play423172032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423172032
		arg_135_1.duration_ = 7.2

		local var_135_0 = {
			zh = 6.033,
			ja = 7.2
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
				arg_135_0:Play423172033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1083"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1083 == nil then
				arg_135_1.var_.actorSpriteComps1083 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps1083 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 1, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1083 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1083 = nil
			end

			local var_138_8 = arg_135_1.actors_["3054"]
			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps3054 == nil then
				arg_135_1.var_.actorSpriteComps3054 = var_138_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_10 = 0.2

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_10 and not isNil(var_138_8) then
				local var_138_11 = (arg_135_1.time_ - var_138_9) / var_138_10

				if arg_135_1.var_.actorSpriteComps3054 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_138_5 then
							if arg_135_1.isInRecall_ then
								local var_138_12 = Mathf.Lerp(iter_138_5.color.r, arg_135_1.hightColor2.r, var_138_11)
								local var_138_13 = Mathf.Lerp(iter_138_5.color.g, arg_135_1.hightColor2.g, var_138_11)
								local var_138_14 = Mathf.Lerp(iter_138_5.color.b, arg_135_1.hightColor2.b, var_138_11)

								iter_138_5.color = Color.New(var_138_12, var_138_13, var_138_14)
							else
								local var_138_15 = Mathf.Lerp(iter_138_5.color.r, 0.5, var_138_11)

								iter_138_5.color = Color.New(var_138_15, var_138_15, var_138_15)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_9 + var_138_10 and arg_135_1.time_ < var_138_9 + var_138_10 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps3054 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_138_7 then
						if arg_135_1.isInRecall_ then
							iter_138_7.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps3054 = nil
			end

			local var_138_16 = arg_135_1.actors_["1083"].transform
			local var_138_17 = 0

			if var_138_17 < arg_135_1.time_ and arg_135_1.time_ <= var_138_17 + arg_138_0 then
				arg_135_1.var_.moveOldPos1083 = var_138_16.localPosition
				var_138_16.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1083", 4)

				local var_138_18 = var_138_16.childCount

				for iter_138_8 = 0, var_138_18 - 1 do
					local var_138_19 = var_138_16:GetChild(iter_138_8)

					if var_138_19.name == "split_7" or not string.find(var_138_19.name, "split") then
						var_138_19.gameObject:SetActive(true)
					else
						var_138_19.gameObject:SetActive(false)
					end
				end
			end

			local var_138_20 = 0.001

			if var_138_17 <= arg_135_1.time_ and arg_135_1.time_ < var_138_17 + var_138_20 then
				local var_138_21 = (arg_135_1.time_ - var_138_17) / var_138_20
				local var_138_22 = Vector3.New(390, -345, -345)

				var_138_16.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1083, var_138_22, var_138_21)
			end

			if arg_135_1.time_ >= var_138_17 + var_138_20 and arg_135_1.time_ < var_138_17 + var_138_20 + arg_138_0 then
				var_138_16.localPosition = Vector3.New(390, -345, -345)
			end

			local var_138_23 = 0
			local var_138_24 = 0.55

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_25 = arg_135_1:FormatText(StoryNameCfg[1332].name)

				arg_135_1.leftNameTxt_.text = var_138_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_26 = arg_135_1:GetWordFromCfg(423172032)
				local var_138_27 = arg_135_1:FormatText(var_138_26.content)

				arg_135_1.text_.text = var_138_27

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_28 = 22
				local var_138_29 = utf8.len(var_138_27)
				local var_138_30 = var_138_28 <= 0 and var_138_24 or var_138_24 * (var_138_29 / var_138_28)

				if var_138_30 > 0 and var_138_24 < var_138_30 then
					arg_135_1.talkMaxDuration = var_138_30

					if var_138_30 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_30 + var_138_23
					end
				end

				arg_135_1.text_.text = var_138_27
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172032", "story_v_out_423172.awb") ~= 0 then
					local var_138_31 = manager.audio:GetVoiceLength("story_v_out_423172", "423172032", "story_v_out_423172.awb") / 1000

					if var_138_31 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_23
					end

					if var_138_26.prefab_name ~= "" and arg_135_1.actors_[var_138_26.prefab_name] ~= nil then
						local var_138_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_26.prefab_name].transform, "story_v_out_423172", "423172032", "story_v_out_423172.awb")

						arg_135_1:RecordAudio("423172032", var_138_32)
						arg_135_1:RecordAudio("423172032", var_138_32)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_423172", "423172032", "story_v_out_423172.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_423172", "423172032", "story_v_out_423172.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_33 = math.max(var_138_24, arg_135_1.talkMaxDuration)

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_33 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_23) / var_138_33

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_23 + var_138_33 and arg_135_1.time_ < var_138_23 + var_138_33 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play423172033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423172033
		arg_139_1.duration_ = 4.03

		local var_139_0 = {
			zh = 4.033,
			ja = 3.5
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play423172034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["3054"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps3054 == nil then
				arg_139_1.var_.actorSpriteComps3054 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps3054 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 1, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps3054 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps3054 = nil
			end

			local var_142_8 = arg_139_1.actors_["1083"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1083 == nil then
				arg_139_1.var_.actorSpriteComps1083 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_10 = 0.2

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.actorSpriteComps1083 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								local var_142_12 = Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, var_142_11)
								local var_142_13 = Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, var_142_11)
								local var_142_14 = Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, var_142_11)

								iter_142_5.color = Color.New(var_142_12, var_142_13, var_142_14)
							else
								local var_142_15 = Mathf.Lerp(iter_142_5.color.r, 0.5, var_142_11)

								iter_142_5.color = Color.New(var_142_15, var_142_15, var_142_15)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1083 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_142_7 then
						if arg_139_1.isInRecall_ then
							iter_142_7.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1083 = nil
			end

			local var_142_16 = arg_139_1.actors_["3054"].transform
			local var_142_17 = 0

			if var_142_17 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				arg_139_1.var_.moveOldPos3054 = var_142_16.localPosition
				var_142_16.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("3054", 2)

				local var_142_18 = var_142_16.childCount

				for iter_142_8 = 0, var_142_18 - 1 do
					local var_142_19 = var_142_16:GetChild(iter_142_8)

					if var_142_19.name == "" or not string.find(var_142_19.name, "split") then
						var_142_19.gameObject:SetActive(true)
					else
						var_142_19.gameObject:SetActive(false)
					end
				end
			end

			local var_142_20 = 0.001

			if var_142_17 <= arg_139_1.time_ and arg_139_1.time_ < var_142_17 + var_142_20 then
				local var_142_21 = (arg_139_1.time_ - var_142_17) / var_142_20
				local var_142_22 = Vector3.New(-390, -275, -280)

				var_142_16.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos3054, var_142_22, var_142_21)
			end

			if arg_139_1.time_ >= var_142_17 + var_142_20 and arg_139_1.time_ < var_142_17 + var_142_20 + arg_142_0 then
				var_142_16.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_142_23 = 0.034
			local var_142_24 = 1

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				local var_142_25 = "play"
				local var_142_26 = "effect"

				arg_139_1:AudioAction(var_142_25, var_142_26, "se_story_1311", "se_story_1311_thunder01", "")
			end

			local var_142_27 = 0.2
			local var_142_28 = 0.3

			if var_142_27 < arg_139_1.time_ and arg_139_1.time_ <= var_142_27 + arg_142_0 then
				local var_142_29 = "play"
				local var_142_30 = "music"

				arg_139_1:AudioAction(var_142_29, var_142_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_142_31 = ""
				local var_142_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_142_32 ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_32 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_32

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_32
						arg_139_1.bgmTxt2_.text = var_142_32
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_142_33 = 0
			local var_142_34 = 0.3

			if var_142_33 < arg_139_1.time_ and arg_139_1.time_ <= var_142_33 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_35 = arg_139_1:FormatText(StoryNameCfg[1339].name)

				arg_139_1.leftNameTxt_.text = var_142_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_36 = arg_139_1:GetWordFromCfg(423172033)
				local var_142_37 = arg_139_1:FormatText(var_142_36.content)

				arg_139_1.text_.text = var_142_37

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_38 = 12
				local var_142_39 = utf8.len(var_142_37)
				local var_142_40 = var_142_38 <= 0 and var_142_34 or var_142_34 * (var_142_39 / var_142_38)

				if var_142_40 > 0 and var_142_34 < var_142_40 then
					arg_139_1.talkMaxDuration = var_142_40

					if var_142_40 + var_142_33 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_40 + var_142_33
					end
				end

				arg_139_1.text_.text = var_142_37
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172033", "story_v_out_423172.awb") ~= 0 then
					local var_142_41 = manager.audio:GetVoiceLength("story_v_out_423172", "423172033", "story_v_out_423172.awb") / 1000

					if var_142_41 + var_142_33 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_41 + var_142_33
					end

					if var_142_36.prefab_name ~= "" and arg_139_1.actors_[var_142_36.prefab_name] ~= nil then
						local var_142_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_36.prefab_name].transform, "story_v_out_423172", "423172033", "story_v_out_423172.awb")

						arg_139_1:RecordAudio("423172033", var_142_42)
						arg_139_1:RecordAudio("423172033", var_142_42)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_423172", "423172033", "story_v_out_423172.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_423172", "423172033", "story_v_out_423172.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_43 = math.max(var_142_34, arg_139_1.talkMaxDuration)

			if var_142_33 <= arg_139_1.time_ and arg_139_1.time_ < var_142_33 + var_142_43 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_33) / var_142_43

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_33 + var_142_43 and arg_139_1.time_ < var_142_33 + var_142_43 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play423172034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 423172034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play423172035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["3054"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps3054 == nil then
				arg_144_1.var_.actorSpriteComps3054 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps3054 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps3054 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps3054 = nil
			end

			local var_147_8 = arg_144_1.actors_["3054"].transform
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.var_.moveOldPos3054 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("3054", 7)

				local var_147_10 = var_147_8.childCount

				for iter_147_4 = 0, var_147_10 - 1 do
					local var_147_11 = var_147_8:GetChild(iter_147_4)

					if var_147_11.name == "" or not string.find(var_147_11.name, "split") then
						var_147_11.gameObject:SetActive(true)
					else
						var_147_11.gameObject:SetActive(false)
					end
				end
			end

			local var_147_12 = 0.001

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_9) / var_147_12
				local var_147_14 = Vector3.New(0, -2000, 0)

				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3054, var_147_14, var_147_13)
			end

			if arg_144_1.time_ >= var_147_9 + var_147_12 and arg_144_1.time_ < var_147_9 + var_147_12 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_15 = arg_144_1.actors_["1083"].transform
			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1.var_.moveOldPos1083 = var_147_15.localPosition
				var_147_15.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1083", 7)

				local var_147_17 = var_147_15.childCount

				for iter_147_5 = 0, var_147_17 - 1 do
					local var_147_18 = var_147_15:GetChild(iter_147_5)

					if var_147_18.name == "" or not string.find(var_147_18.name, "split") then
						var_147_18.gameObject:SetActive(true)
					else
						var_147_18.gameObject:SetActive(false)
					end
				end
			end

			local var_147_19 = 0.001

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_19 then
				local var_147_20 = (arg_144_1.time_ - var_147_16) / var_147_19
				local var_147_21 = Vector3.New(0, -2000, 0)

				var_147_15.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1083, var_147_21, var_147_20)
			end

			if arg_144_1.time_ >= var_147_16 + var_147_19 and arg_144_1.time_ < var_147_16 + var_147_19 + arg_147_0 then
				var_147_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_22 = 0
			local var_147_23 = 1.025

			if var_147_22 < arg_144_1.time_ and arg_144_1.time_ <= var_147_22 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_24 = arg_144_1:GetWordFromCfg(423172034)
				local var_147_25 = arg_144_1:FormatText(var_147_24.content)

				arg_144_1.text_.text = var_147_25

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_26 = 41
				local var_147_27 = utf8.len(var_147_25)
				local var_147_28 = var_147_26 <= 0 and var_147_23 or var_147_23 * (var_147_27 / var_147_26)

				if var_147_28 > 0 and var_147_23 < var_147_28 then
					arg_144_1.talkMaxDuration = var_147_28

					if var_147_28 + var_147_22 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_28 + var_147_22
					end
				end

				arg_144_1.text_.text = var_147_25
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_29 = math.max(var_147_23, arg_144_1.talkMaxDuration)

			if var_147_22 <= arg_144_1.time_ and arg_144_1.time_ < var_147_22 + var_147_29 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_22) / var_147_29

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_22 + var_147_29 and arg_144_1.time_ < var_147_22 + var_147_29 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_144_1:InitPlayNodeList()
	end,
	Play423172035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 423172035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play423172036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 1.7

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(423172035)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 68
				local var_151_5 = utf8.len(var_151_3)
				local var_151_6 = var_151_4 <= 0 and var_151_1 or var_151_1 * (var_151_5 / var_151_4)

				if var_151_6 > 0 and var_151_1 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_7 and arg_148_1.time_ < var_151_0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play423172036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 423172036
		arg_152_1.duration_ = 5.47

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play423172037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_1 = 0.1

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_1 then
				local var_155_2 = (arg_152_1.time_ - var_155_0) / var_155_1
				local var_155_3 = Color.New(0, 0, 0)

				var_155_3.a = Mathf.Lerp(0, 1, var_155_2)
				arg_152_1.mask_.color = var_155_3
			end

			if arg_152_1.time_ >= var_155_0 + var_155_1 and arg_152_1.time_ < var_155_0 + var_155_1 + arg_155_0 then
				local var_155_4 = Color.New(0, 0, 0)

				var_155_4.a = 1
				arg_152_1.mask_.color = var_155_4
			end

			local var_155_5 = 0.166666666666667

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_6 = 0.0666666666666667

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6
				local var_155_8 = Color.New(1, 1, 1)

				var_155_8.a = Mathf.Lerp(1, 0, var_155_7)
				arg_152_1.mask_.color = var_155_8
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 then
				local var_155_9 = Color.New(1, 1, 1)
				local var_155_10 = 0

				arg_152_1.mask_.enabled = false
				var_155_9.a = var_155_10
				arg_152_1.mask_.color = var_155_9
			end

			local var_155_11 = 0.266666666666667

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_12 = 0.0666666666666667

			if var_155_11 <= arg_152_1.time_ and arg_152_1.time_ < var_155_11 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_11) / var_155_12
				local var_155_14 = Color.New(1, 1, 1)

				var_155_14.a = Mathf.Lerp(1, 0, var_155_13)
				arg_152_1.mask_.color = var_155_14
			end

			if arg_152_1.time_ >= var_155_11 + var_155_12 and arg_152_1.time_ < var_155_11 + var_155_12 + arg_155_0 then
				local var_155_15 = Color.New(1, 1, 1)
				local var_155_16 = 0

				arg_152_1.mask_.enabled = false
				var_155_15.a = var_155_16
				arg_152_1.mask_.color = var_155_15
			end

			local var_155_17 = 0.333333333333333

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_18 = 0.0666666666666667

			if var_155_17 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_18 then
				local var_155_19 = (arg_152_1.time_ - var_155_17) / var_155_18
				local var_155_20 = Color.New(1, 1, 1)

				var_155_20.a = Mathf.Lerp(1, 0, var_155_19)
				arg_152_1.mask_.color = var_155_20
			end

			if arg_152_1.time_ >= var_155_17 + var_155_18 and arg_152_1.time_ < var_155_17 + var_155_18 + arg_155_0 then
				local var_155_21 = Color.New(1, 1, 1)
				local var_155_22 = 0

				arg_152_1.mask_.enabled = false
				var_155_21.a = var_155_22
				arg_152_1.mask_.color = var_155_21
			end

			local var_155_23 = 0.4

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_24 = 0.0666666666666667

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_24 then
				local var_155_25 = (arg_152_1.time_ - var_155_23) / var_155_24
				local var_155_26 = Color.New(1, 1, 1)

				var_155_26.a = Mathf.Lerp(1, 0, var_155_25)
				arg_152_1.mask_.color = var_155_26
			end

			if arg_152_1.time_ >= var_155_23 + var_155_24 and arg_152_1.time_ < var_155_23 + var_155_24 + arg_155_0 then
				local var_155_27 = Color.New(1, 1, 1)
				local var_155_28 = 0

				arg_152_1.mask_.enabled = false
				var_155_27.a = var_155_28
				arg_152_1.mask_.color = var_155_27
			end

			local var_155_29 = manager.ui.mainCamera.transform
			local var_155_30 = 0.166666666666667

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				local var_155_31 = arg_152_1.var_.effecthuangyuanshandian
				local var_155_32
				local var_155_33 = var_155_29

				if not var_155_31 then
					var_155_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_155_33)
					var_155_31.name = "huangyuanshandian"
					arg_152_1.var_.effecthuangyuanshandian = var_155_31
				else
					var_155_31.transform:SetParent(var_155_33)
				end

				var_155_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_155_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_155_34 = manager.ui.mainCamera.transform
			local var_155_35 = 1.16666666666667

			if var_155_35 < arg_152_1.time_ and arg_152_1.time_ <= var_155_35 + arg_155_0 then
				local var_155_36 = arg_152_1.var_.effecthuangyuanshandian

				if var_155_36 then
					Object.Destroy(var_155_36)

					arg_152_1.var_.effecthuangyuanshandian = nil
				end
			end

			local var_155_37 = 0

			if var_155_37 < arg_152_1.time_ and arg_152_1.time_ <= var_155_37 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			local var_155_38 = 0.466666666666667

			if arg_152_1.time_ >= var_155_37 + var_155_38 and arg_152_1.time_ < var_155_37 + var_155_38 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_39 = 0
			local var_155_40 = 1

			if var_155_39 < arg_152_1.time_ and arg_152_1.time_ <= var_155_39 + arg_155_0 then
				local var_155_41 = "play"
				local var_155_42 = "effect"

				arg_152_1:AudioAction(var_155_41, var_155_42, "se_story_144", "se_story_144_thunder", "")
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_43 = 0.466666666666667
			local var_155_44 = 0.95

			if var_155_43 < arg_152_1.time_ and arg_152_1.time_ <= var_155_43 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_45 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_45:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_46 = arg_152_1:GetWordFromCfg(423172036)
				local var_155_47 = arg_152_1:FormatText(var_155_46.content)

				arg_152_1.text_.text = var_155_47

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_48 = 38
				local var_155_49 = utf8.len(var_155_47)
				local var_155_50 = var_155_48 <= 0 and var_155_44 or var_155_44 * (var_155_49 / var_155_48)

				if var_155_50 > 0 and var_155_44 < var_155_50 then
					arg_152_1.talkMaxDuration = var_155_50
					var_155_43 = var_155_43 + 0.3

					if var_155_50 + var_155_43 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_50 + var_155_43
					end
				end

				arg_152_1.text_.text = var_155_47
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_51 = var_155_43 + 0.3
			local var_155_52 = math.max(var_155_44, arg_152_1.talkMaxDuration)

			if var_155_51 <= arg_152_1.time_ and arg_152_1.time_ < var_155_51 + var_155_52 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_51) / var_155_52

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_51 + var_155_52 and arg_152_1.time_ < var_155_51 + var_155_52 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play423172037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 423172037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play423172038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = manager.ui.mainCamera.transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				local var_161_2 = arg_158_1.var_.effectzuolunshouqiang1
				local var_161_3
				local var_161_4 = var_161_0

				if not var_161_2 then
					var_161_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_161_4)
					var_161_2.name = "zuolunshouqiang1"
					arg_158_1.var_.effectzuolunshouqiang1 = var_161_2
				else
					var_161_2.transform:SetParent(var_161_4)
				end

				var_161_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_161_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_161_5 = manager.ui.mainCamera.transform
			local var_161_6 = 1.5

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				local var_161_7 = arg_158_1.var_.effectzuolunshouqiang1

				if var_161_7 then
					Object.Destroy(var_161_7)

					arg_158_1.var_.effectzuolunshouqiang1 = nil
				end
			end

			local var_161_8 = manager.ui.mainCamera.transform
			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_8.localPosition
			end

			local var_161_10 = 0.6

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_10 then
				local var_161_11 = (arg_158_1.time_ - var_161_9) / 0.066
				local var_161_12, var_161_13 = math.modf(var_161_11)

				var_161_8.localPosition = Vector3.New(var_161_13 * 0.02, var_161_13 * 0.02, var_161_13 * 0.02) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= var_161_9 + var_161_10 and arg_158_1.time_ < var_161_9 + var_161_10 + arg_161_0 then
				var_161_8.localPosition = arg_158_1.var_.shakeOldPos
			end

			local var_161_14 = 0
			local var_161_15 = 1

			if var_161_14 < arg_158_1.time_ and arg_158_1.time_ <= var_161_14 + arg_161_0 then
				local var_161_16 = "play"
				local var_161_17 = "effect"

				arg_158_1:AudioAction(var_161_16, var_161_17, "se_story_144", "se_story_144_gun07", "")
			end

			local var_161_18 = 0
			local var_161_19 = 0.1

			if var_161_18 < arg_158_1.time_ and arg_158_1.time_ <= var_161_18 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_20 = arg_158_1:GetWordFromCfg(423172037)
				local var_161_21 = arg_158_1:FormatText(var_161_20.content)

				arg_158_1.text_.text = var_161_21

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_22 = 4
				local var_161_23 = utf8.len(var_161_21)
				local var_161_24 = var_161_22 <= 0 and var_161_19 or var_161_19 * (var_161_23 / var_161_22)

				if var_161_24 > 0 and var_161_19 < var_161_24 then
					arg_158_1.talkMaxDuration = var_161_24

					if var_161_24 + var_161_18 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_24 + var_161_18
					end
				end

				arg_158_1.text_.text = var_161_21
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_25 = math.max(var_161_19, arg_158_1.talkMaxDuration)

			if var_161_18 <= arg_158_1.time_ and arg_158_1.time_ < var_161_18 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_18) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_18 + var_161_25 and arg_158_1.time_ < var_161_18 + var_161_25 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play423172038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 423172038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play423172039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.733333333333333
			local var_165_1 = 1

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				local var_165_2 = "play"
				local var_165_3 = "effect"

				arg_162_1:AudioAction(var_165_2, var_165_3, "se_story_140", "se_story_140_foley_down", "")
			end

			local var_165_4 = 0
			local var_165_5 = 1.4

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(423172038)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_8 = 56
				local var_165_9 = utf8.len(var_165_7)
				local var_165_10 = var_165_8 <= 0 and var_165_5 or var_165_5 * (var_165_9 / var_165_8)

				if var_165_10 > 0 and var_165_5 < var_165_10 then
					arg_162_1.talkMaxDuration = var_165_10

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_11 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_11 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_11

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_11 and arg_162_1.time_ < var_165_4 + var_165_11 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play423172039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 423172039
		arg_166_1.duration_ = 7.68

		local var_166_0 = {
			zh = 6.875,
			ja = 7.675
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
				arg_166_0:Play423172040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = "SS2304"

			if arg_166_1.bgs_[var_169_0] == nil then
				local var_169_1 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_0)
				var_169_1.name = var_169_0
				var_169_1.transform.parent = arg_166_1.stage_.transform
				var_169_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_0] = var_169_1
			end

			local var_169_2 = 2

			if var_169_2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				local var_169_3 = manager.ui.mainCamera.transform.localPosition
				local var_169_4 = Vector3.New(0, 0, 10) + Vector3.New(var_169_3.x, var_169_3.y, 0)
				local var_169_5 = arg_166_1.bgs_.SS2304

				var_169_5.transform.localPosition = var_169_4
				var_169_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_6 = var_169_5:GetComponent("SpriteRenderer")

				if var_169_6 and var_169_6.sprite then
					local var_169_7 = (var_169_5.transform.localPosition - var_169_3).z
					local var_169_8 = manager.ui.mainCameraCom_
					local var_169_9 = 2 * var_169_7 * Mathf.Tan(var_169_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_10 = var_169_9 * var_169_8.aspect
					local var_169_11 = var_169_6.sprite.bounds.size.x
					local var_169_12 = var_169_6.sprite.bounds.size.y
					local var_169_13 = var_169_10 / var_169_11
					local var_169_14 = var_169_9 / var_169_12
					local var_169_15 = var_169_14 < var_169_13 and var_169_13 or var_169_14

					var_169_5.transform.localScale = Vector3.New(var_169_15, var_169_15, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "SS2304" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_16 = 3.775

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_17 = 0.3

			if arg_166_1.time_ >= var_169_16 + var_169_17 and arg_166_1.time_ < var_169_16 + var_169_17 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_18 = 0

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_19 = 2

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_19 then
				local var_169_20 = (arg_166_1.time_ - var_169_18) / var_169_19
				local var_169_21 = Color.New(0, 0, 0)

				var_169_21.a = Mathf.Lerp(0, 1, var_169_20)
				arg_166_1.mask_.color = var_169_21
			end

			if arg_166_1.time_ >= var_169_18 + var_169_19 and arg_166_1.time_ < var_169_18 + var_169_19 + arg_169_0 then
				local var_169_22 = Color.New(0, 0, 0)

				var_169_22.a = 1
				arg_166_1.mask_.color = var_169_22
			end

			local var_169_23 = 2

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_24 = 2

			if var_169_23 <= arg_166_1.time_ and arg_166_1.time_ < var_169_23 + var_169_24 then
				local var_169_25 = (arg_166_1.time_ - var_169_23) / var_169_24
				local var_169_26 = Color.New(0, 0, 0)

				var_169_26.a = Mathf.Lerp(1, 0, var_169_25)
				arg_166_1.mask_.color = var_169_26
			end

			if arg_166_1.time_ >= var_169_23 + var_169_24 and arg_166_1.time_ < var_169_23 + var_169_24 + arg_169_0 then
				local var_169_27 = Color.New(0, 0, 0)
				local var_169_28 = 0

				arg_166_1.mask_.enabled = false
				var_169_27.a = var_169_28
				arg_166_1.mask_.color = var_169_27
			end

			local var_169_29 = arg_166_1.bgs_.SS2304.transform
			local var_169_30 = 2

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 then
				arg_166_1.var_.moveOldPosSS2304 = var_169_29.localPosition
			end

			local var_169_31 = 2

			if var_169_30 <= arg_166_1.time_ and arg_166_1.time_ < var_169_30 + var_169_31 then
				local var_169_32 = (arg_166_1.time_ - var_169_30) / var_169_31
				local var_169_33 = Vector3.New(1, 0, 1.2)

				var_169_29.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPosSS2304, var_169_33, var_169_32)
			end

			if arg_166_1.time_ >= var_169_30 + var_169_31 and arg_166_1.time_ < var_169_30 + var_169_31 + arg_169_0 then
				var_169_29.localPosition = Vector3.New(1, 0, 1.2)
			end

			local var_169_34 = 1.63333333333333
			local var_169_35 = 1

			if var_169_34 < arg_166_1.time_ and arg_166_1.time_ <= var_169_34 + arg_169_0 then
				local var_169_36 = "play"
				local var_169_37 = "effect"

				arg_166_1:AudioAction(var_169_36, var_169_37, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_169_38 = 1.63333333333333
			local var_169_39 = 1

			if var_169_38 < arg_166_1.time_ and arg_166_1.time_ <= var_169_38 + arg_169_0 then
				local var_169_40 = "play"
				local var_169_41 = "effect"

				arg_166_1:AudioAction(var_169_40, var_169_41, "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_42 = 3.775
			local var_169_43 = 0.225

			if var_169_42 < arg_166_1.time_ and arg_166_1.time_ <= var_169_42 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_44 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_44:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_45 = arg_166_1:FormatText(StoryNameCfg[1332].name)

				arg_166_1.leftNameTxt_.text = var_169_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_46 = arg_166_1:GetWordFromCfg(423172039)
				local var_169_47 = arg_166_1:FormatText(var_169_46.content)

				arg_166_1.text_.text = var_169_47

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_48 = 9
				local var_169_49 = utf8.len(var_169_47)
				local var_169_50 = var_169_48 <= 0 and var_169_43 or var_169_43 * (var_169_49 / var_169_48)

				if var_169_50 > 0 and var_169_43 < var_169_50 then
					arg_166_1.talkMaxDuration = var_169_50
					var_169_42 = var_169_42 + 0.3

					if var_169_50 + var_169_42 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_50 + var_169_42
					end
				end

				arg_166_1.text_.text = var_169_47
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172039", "story_v_out_423172.awb") ~= 0 then
					local var_169_51 = manager.audio:GetVoiceLength("story_v_out_423172", "423172039", "story_v_out_423172.awb") / 1000

					if var_169_51 + var_169_42 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_51 + var_169_42
					end

					if var_169_46.prefab_name ~= "" and arg_166_1.actors_[var_169_46.prefab_name] ~= nil then
						local var_169_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_46.prefab_name].transform, "story_v_out_423172", "423172039", "story_v_out_423172.awb")

						arg_166_1:RecordAudio("423172039", var_169_52)
						arg_166_1:RecordAudio("423172039", var_169_52)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_423172", "423172039", "story_v_out_423172.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_423172", "423172039", "story_v_out_423172.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_53 = var_169_42 + 0.3
			local var_169_54 = math.max(var_169_43, arg_166_1.talkMaxDuration)

			if var_169_53 <= arg_166_1.time_ and arg_166_1.time_ < var_169_53 + var_169_54 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_53) / var_169_54

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_53 + var_169_54 and arg_166_1.time_ < var_169_53 + var_169_54 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0, 0.7),
					endPos = Vector3.New(1, 0, 1.2),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play423172040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 423172040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play423172041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1.075

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_2 = arg_172_1:GetWordFromCfg(423172040)
				local var_175_3 = arg_172_1:FormatText(var_175_2.content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 43
				local var_175_5 = utf8.len(var_175_3)
				local var_175_6 = var_175_4 <= 0 and var_175_1 or var_175_1 * (var_175_5 / var_175_4)

				if var_175_6 > 0 and var_175_1 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_7 and arg_172_1.time_ < var_175_0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play423172041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 423172041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play423172042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 1.425

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_2 = arg_176_1:GetWordFromCfg(423172041)
				local var_179_3 = arg_176_1:FormatText(var_179_2.content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 57
				local var_179_5 = utf8.len(var_179_3)
				local var_179_6 = var_179_4 <= 0 and var_179_1 or var_179_1 * (var_179_5 / var_179_4)

				if var_179_6 > 0 and var_179_1 < var_179_6 then
					arg_176_1.talkMaxDuration = var_179_6

					if var_179_6 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_7 and arg_176_1.time_ < var_179_0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play423172042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 423172042
		arg_180_1.duration_ = 7.67

		local var_180_0 = {
			zh = 7.66666666666667,
			ja = 7.33266666666667
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
				arg_180_0:Play423172043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.bgs_.SS2304.transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPosSS2304 = var_183_0.localPosition
			end

			local var_183_2 = 3.5

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, 1, 10)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPosSS2304, var_183_4, var_183_3)
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			local var_183_6 = 3.5

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_7 = 1.96666666666667
			local var_183_8 = 0.45

			if var_183_7 < arg_180_1.time_ and arg_180_1.time_ <= var_183_7 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_9 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_9:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_10 = arg_180_1:FormatText(StoryNameCfg[1339].name)

				arg_180_1.leftNameTxt_.text = var_183_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_11 = arg_180_1:GetWordFromCfg(423172042)
				local var_183_12 = arg_180_1:FormatText(var_183_11.content)

				arg_180_1.text_.text = var_183_12

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 18
				local var_183_14 = utf8.len(var_183_12)
				local var_183_15 = var_183_13 <= 0 and var_183_8 or var_183_8 * (var_183_14 / var_183_13)

				if var_183_15 > 0 and var_183_8 < var_183_15 then
					arg_180_1.talkMaxDuration = var_183_15
					var_183_7 = var_183_7 + 0.3

					if var_183_15 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_15 + var_183_7
					end
				end

				arg_180_1.text_.text = var_183_12
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172042", "story_v_out_423172.awb") ~= 0 then
					local var_183_16 = manager.audio:GetVoiceLength("story_v_out_423172", "423172042", "story_v_out_423172.awb") / 1000

					if var_183_16 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_7
					end

					if var_183_11.prefab_name ~= "" and arg_180_1.actors_[var_183_11.prefab_name] ~= nil then
						local var_183_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_11.prefab_name].transform, "story_v_out_423172", "423172042", "story_v_out_423172.awb")

						arg_180_1:RecordAudio("423172042", var_183_17)
						arg_180_1:RecordAudio("423172042", var_183_17)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_423172", "423172042", "story_v_out_423172.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_423172", "423172042", "story_v_out_423172.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_18 = var_183_7 + 0.3
			local var_183_19 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_18 <= arg_180_1.time_ and arg_180_1.time_ < var_183_18 + var_183_19 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_18) / var_183_19

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_18 + var_183_19 and arg_180_1.time_ < var_183_18 + var_183_19 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0, 1.2),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play423172043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 423172043
		arg_186_1.duration_ = 9.8

		local var_186_0 = {
			zh = 9.266,
			ja = 9.8
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
				arg_186_0:Play423172044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.85

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[1339].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(423172043)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 34
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172043", "story_v_out_423172.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172043", "story_v_out_423172.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_423172", "423172043", "story_v_out_423172.awb")

						arg_186_1:RecordAudio("423172043", var_189_9)
						arg_186_1:RecordAudio("423172043", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_423172", "423172043", "story_v_out_423172.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_423172", "423172043", "story_v_out_423172.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play423172044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 423172044
		arg_190_1.duration_ = 11.7

		local var_190_0 = {
			zh = 10.4,
			ja = 11.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play423172045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.925

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[1339].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(423172044)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 37
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172044", "story_v_out_423172.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172044", "story_v_out_423172.awb") / 1000

					if var_193_8 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_0
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_423172", "423172044", "story_v_out_423172.awb")

						arg_190_1:RecordAudio("423172044", var_193_9)
						arg_190_1:RecordAudio("423172044", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_423172", "423172044", "story_v_out_423172.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_423172", "423172044", "story_v_out_423172.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_10 and arg_190_1.time_ < var_193_0 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play423172045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 423172045
		arg_194_1.duration_ = 4.57

		local var_194_0 = {
			zh = 4.233,
			ja = 4.566
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
				arg_194_0:Play423172046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.425

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[1339].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(423172045)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 17
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172045", "story_v_out_423172.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172045", "story_v_out_423172.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_423172", "423172045", "story_v_out_423172.awb")

						arg_194_1:RecordAudio("423172045", var_197_9)
						arg_194_1:RecordAudio("423172045", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_423172", "423172045", "story_v_out_423172.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_423172", "423172045", "story_v_out_423172.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play423172046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 423172046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play423172047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.bgs_.SS2304.transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2304 = var_201_0.localPosition
			end

			local var_201_2 = 2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 1, 9.5)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2304, var_201_4, var_201_3)
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.allBtn_.enabled = false
			end

			local var_201_6 = 2

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				arg_198_1.allBtn_.enabled = true
			end

			local var_201_7 = 0
			local var_201_8 = 0.85

			if var_201_7 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_9 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_9:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(423172046)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 34
				local var_201_13 = utf8.len(var_201_11)
				local var_201_14 = var_201_12 <= 0 and var_201_8 or var_201_8 * (var_201_13 / var_201_12)

				if var_201_14 > 0 and var_201_8 < var_201_14 then
					arg_198_1.talkMaxDuration = var_201_14
					var_201_7 = var_201_7 + 0.3

					if var_201_14 + var_201_7 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_7
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_15 = var_201_7 + 0.3
			local var_201_16 = math.max(var_201_8, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_16 and arg_198_1.time_ < var_201_15 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play423172047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 423172047
		arg_204_1.duration_ = 11.47

		local var_204_0 = {
			zh = 11.466,
			ja = 7.7
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
				arg_204_0:Play423172048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 1.2

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[1339].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(423172047)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172047", "story_v_out_423172.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172047", "story_v_out_423172.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_423172", "423172047", "story_v_out_423172.awb")

						arg_204_1:RecordAudio("423172047", var_207_9)
						arg_204_1:RecordAudio("423172047", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_423172", "423172047", "story_v_out_423172.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_423172", "423172047", "story_v_out_423172.awb")
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
	Play423172048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 423172048
		arg_208_1.duration_ = 10

		local var_208_0 = {
			zh = 8.3,
			ja = 10
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
				arg_208_0:Play423172049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_1 = 1

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_1 then
				local var_211_2 = (arg_208_1.time_ - var_211_0) / var_211_1
				local var_211_3 = Color.New(0, 0, 0)

				var_211_3.a = Mathf.Lerp(0, 1, var_211_2)
				arg_208_1.mask_.color = var_211_3
			end

			if arg_208_1.time_ >= var_211_0 + var_211_1 and arg_208_1.time_ < var_211_0 + var_211_1 + arg_211_0 then
				local var_211_4 = Color.New(0, 0, 0)

				var_211_4.a = 1
				arg_208_1.mask_.color = var_211_4
			end

			local var_211_5 = 1

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_6 = 1

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6
				local var_211_8 = Color.New(0, 0, 0)

				var_211_8.a = Mathf.Lerp(1, 0, var_211_7)
				arg_208_1.mask_.color = var_211_8
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 then
				local var_211_9 = Color.New(0, 0, 0)
				local var_211_10 = 0

				arg_208_1.mask_.enabled = false
				var_211_9.a = var_211_10
				arg_208_1.mask_.color = var_211_9
			end

			local var_211_11 = arg_208_1.bgs_.SS2304.transform
			local var_211_12 = 1

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.var_.moveOldPosSS2304 = var_211_11.localPosition
			end

			local var_211_13 = 3.5

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_13 then
				local var_211_14 = (arg_208_1.time_ - var_211_12) / var_211_13
				local var_211_15 = Vector3.New(0, -0.7, 0)

				var_211_11.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPosSS2304, var_211_15, var_211_14)
			end

			if arg_208_1.time_ >= var_211_12 + var_211_13 and arg_208_1.time_ < var_211_12 + var_211_13 + arg_211_0 then
				var_211_11.localPosition = Vector3.New(0, -0.7, 0)
			end

			local var_211_16 = 2

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_17 = 2.5

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_18 = 2
			local var_211_19 = 0.525

			if var_211_18 < arg_208_1.time_ and arg_208_1.time_ <= var_211_18 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_20 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_20:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_21 = arg_208_1:FormatText(StoryNameCfg[1332].name)

				arg_208_1.leftNameTxt_.text = var_211_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_22 = arg_208_1:GetWordFromCfg(423172048)
				local var_211_23 = arg_208_1:FormatText(var_211_22.content)

				arg_208_1.text_.text = var_211_23

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_24 = 21
				local var_211_25 = utf8.len(var_211_23)
				local var_211_26 = var_211_24 <= 0 and var_211_19 or var_211_19 * (var_211_25 / var_211_24)

				if var_211_26 > 0 and var_211_19 < var_211_26 then
					arg_208_1.talkMaxDuration = var_211_26
					var_211_18 = var_211_18 + 0.3

					if var_211_26 + var_211_18 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_26 + var_211_18
					end
				end

				arg_208_1.text_.text = var_211_23
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172048", "story_v_out_423172.awb") ~= 0 then
					local var_211_27 = manager.audio:GetVoiceLength("story_v_out_423172", "423172048", "story_v_out_423172.awb") / 1000

					if var_211_27 + var_211_18 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_27 + var_211_18
					end

					if var_211_22.prefab_name ~= "" and arg_208_1.actors_[var_211_22.prefab_name] ~= nil then
						local var_211_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_22.prefab_name].transform, "story_v_out_423172", "423172048", "story_v_out_423172.awb")

						arg_208_1:RecordAudio("423172048", var_211_28)
						arg_208_1:RecordAudio("423172048", var_211_28)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_423172", "423172048", "story_v_out_423172.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_423172", "423172048", "story_v_out_423172.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_29 = var_211_18 + 0.3
			local var_211_30 = math.max(var_211_19, arg_208_1.talkMaxDuration)

			if var_211_29 <= arg_208_1.time_ and arg_208_1.time_ < var_211_29 + var_211_30 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_29) / var_211_30

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_29 + var_211_30 and arg_208_1.time_ < var_211_29 + var_211_30 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -0.6, 0),
					endPos = Vector3.New(0, -0.7, 0),
					easeType = LeanTweenType.easeOutCubic
				}
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play423172049 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 423172049
		arg_214_1.duration_ = 11.37

		local var_214_0 = {
			zh = 8.466,
			ja = 11.366
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
				arg_214_0:Play423172050(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.975

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1339].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(423172049)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172049", "story_v_out_423172.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172049", "story_v_out_423172.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_423172", "423172049", "story_v_out_423172.awb")

						arg_214_1:RecordAudio("423172049", var_217_9)
						arg_214_1:RecordAudio("423172049", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_423172", "423172049", "story_v_out_423172.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_423172", "423172049", "story_v_out_423172.awb")
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
	Play423172050 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 423172050
		arg_218_1.duration_ = 12.47

		local var_218_0 = {
			zh = 10.066,
			ja = 12.466
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
				arg_218_0:Play423172051(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.925

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[1339].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(423172050)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 37
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172050", "story_v_out_423172.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172050", "story_v_out_423172.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_423172", "423172050", "story_v_out_423172.awb")

						arg_218_1:RecordAudio("423172050", var_221_9)
						arg_218_1:RecordAudio("423172050", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_423172", "423172050", "story_v_out_423172.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_423172", "423172050", "story_v_out_423172.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play423172051 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 423172051
		arg_222_1.duration_ = 3.03

		local var_222_0 = {
			zh = 3.033,
			ja = 2.666
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
				arg_222_0:Play423172052(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.175

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1339].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(423172051)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 7
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172051", "story_v_out_423172.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172051", "story_v_out_423172.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_423172", "423172051", "story_v_out_423172.awb")

						arg_222_1:RecordAudio("423172051", var_225_9)
						arg_222_1:RecordAudio("423172051", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_423172", "423172051", "story_v_out_423172.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_423172", "423172051", "story_v_out_423172.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play423172052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 423172052
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play423172053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.133333333333333
			local var_229_1 = 1

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				local var_229_2 = "play"
				local var_229_3 = "effect"

				arg_226_1:AudioAction(var_229_2, var_229_3, "se_story_140", "se_story_140_explosion01", "")
			end

			local var_229_4 = 0
			local var_229_5 = 1.35

			if var_229_4 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(423172052)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_8 = 54
				local var_229_9 = utf8.len(var_229_7)
				local var_229_10 = var_229_8 <= 0 and var_229_5 or var_229_5 * (var_229_9 / var_229_8)

				if var_229_10 > 0 and var_229_5 < var_229_10 then
					arg_226_1.talkMaxDuration = var_229_10

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_11 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_11 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_11

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_11 and arg_226_1.time_ < var_229_4 + var_229_11 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play423172053 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 423172053
		arg_230_1.duration_ = 7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play423172054(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_1 = 1

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_1 then
				local var_233_2 = (arg_230_1.time_ - var_233_0) / var_233_1
				local var_233_3 = Color.New(0, 0, 0)

				var_233_3.a = Mathf.Lerp(0, 1, var_233_2)
				arg_230_1.mask_.color = var_233_3
			end

			if arg_230_1.time_ >= var_233_0 + var_233_1 and arg_230_1.time_ < var_233_0 + var_233_1 + arg_233_0 then
				local var_233_4 = Color.New(0, 0, 0)

				var_233_4.a = 1
				arg_230_1.mask_.color = var_233_4
			end

			local var_233_5 = 1

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_6 = 1

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_6 then
				local var_233_7 = (arg_230_1.time_ - var_233_5) / var_233_6
				local var_233_8 = Color.New(0, 0, 0)

				var_233_8.a = Mathf.Lerp(1, 0, var_233_7)
				arg_230_1.mask_.color = var_233_8
			end

			if arg_230_1.time_ >= var_233_5 + var_233_6 and arg_230_1.time_ < var_233_5 + var_233_6 + arg_233_0 then
				local var_233_9 = Color.New(0, 0, 0)
				local var_233_10 = 0

				arg_230_1.mask_.enabled = false
				var_233_9.a = var_233_10
				arg_230_1.mask_.color = var_233_9
			end

			local var_233_11 = arg_230_1.bgs_.SS2304.transform
			local var_233_12 = 1

			if var_233_12 < arg_230_1.time_ and arg_230_1.time_ <= var_233_12 + arg_233_0 then
				arg_230_1.var_.moveOldPosSS2304 = var_233_11.localPosition
			end

			local var_233_13 = 2.5

			if var_233_12 <= arg_230_1.time_ and arg_230_1.time_ < var_233_12 + var_233_13 then
				local var_233_14 = (arg_230_1.time_ - var_233_12) / var_233_13
				local var_233_15 = Vector3.New(1, -1.5, -1.2)

				var_233_11.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPosSS2304, var_233_15, var_233_14)
			end

			if arg_230_1.time_ >= var_233_12 + var_233_13 and arg_230_1.time_ < var_233_12 + var_233_13 + arg_233_0 then
				var_233_11.localPosition = Vector3.New(1, -1.5, -1.2)
			end

			local var_233_16 = 2

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_17 = 1.5

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_18 = 2
			local var_233_19 = 1.175

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_20 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_20:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_21 = arg_230_1:GetWordFromCfg(423172053)
				local var_233_22 = arg_230_1:FormatText(var_233_21.content)

				arg_230_1.text_.text = var_233_22

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_23 = 47
				local var_233_24 = utf8.len(var_233_22)
				local var_233_25 = var_233_23 <= 0 and var_233_19 or var_233_19 * (var_233_24 / var_233_23)

				if var_233_25 > 0 and var_233_19 < var_233_25 then
					arg_230_1.talkMaxDuration = var_233_25
					var_233_18 = var_233_18 + 0.3

					if var_233_25 + var_233_18 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_25 + var_233_18
					end
				end

				arg_230_1.text_.text = var_233_22
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_26 = var_233_18 + 0.3
			local var_233_27 = math.max(var_233_19, arg_230_1.talkMaxDuration)

			if var_233_26 <= arg_230_1.time_ and arg_230_1.time_ < var_233_26 + var_233_27 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_26) / var_233_27

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_26 + var_233_27 and arg_230_1.time_ < var_233_26 + var_233_27 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, -1.5, -1),
					endPos = Vector3.New(1, -1.5, -1.2),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play423172054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 423172054
		arg_236_1.duration_ = 7.8

		local var_236_0 = {
			zh = 7.8,
			ja = 6.6
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
				arg_236_0:Play423172055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.65

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[1339].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(423172054)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 26
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172054", "story_v_out_423172.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172054", "story_v_out_423172.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_423172", "423172054", "story_v_out_423172.awb")

						arg_236_1:RecordAudio("423172054", var_239_9)
						arg_236_1:RecordAudio("423172054", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_423172", "423172054", "story_v_out_423172.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_423172", "423172054", "story_v_out_423172.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play423172055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 423172055
		arg_240_1.duration_ = 8.43

		local var_240_0 = {
			zh = 8.433,
			ja = 5.2
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
				arg_240_0:Play423172056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.8

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[1339].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(423172055)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172055", "story_v_out_423172.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172055", "story_v_out_423172.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_423172", "423172055", "story_v_out_423172.awb")

						arg_240_1:RecordAudio("423172055", var_243_9)
						arg_240_1:RecordAudio("423172055", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_423172", "423172055", "story_v_out_423172.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_423172", "423172055", "story_v_out_423172.awb")
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
	Play423172056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 423172056
		arg_244_1.duration_ = 9.17

		local var_244_0 = {
			zh = 6.766,
			ja = 9.166
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
				arg_244_0:Play423172057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.425

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[1332].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(423172056)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 17
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172056", "story_v_out_423172.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172056", "story_v_out_423172.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_423172", "423172056", "story_v_out_423172.awb")

						arg_244_1:RecordAudio("423172056", var_247_9)
						arg_244_1:RecordAudio("423172056", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_423172", "423172056", "story_v_out_423172.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_423172", "423172056", "story_v_out_423172.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play423172057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 423172057
		arg_248_1.duration_ = 8.17

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play423172058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_1 = 2

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_1 then
				local var_251_2 = (arg_248_1.time_ - var_251_0) / var_251_1
				local var_251_3 = Color.New(0, 0, 0)

				var_251_3.a = Mathf.Lerp(0, 1, var_251_2)
				arg_248_1.mask_.color = var_251_3
			end

			if arg_248_1.time_ >= var_251_0 + var_251_1 and arg_248_1.time_ < var_251_0 + var_251_1 + arg_251_0 then
				local var_251_4 = Color.New(0, 0, 0)

				var_251_4.a = 1
				arg_248_1.mask_.color = var_251_4
			end

			local var_251_5 = 2

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_6 = 1.5

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_6 then
				local var_251_7 = (arg_248_1.time_ - var_251_5) / var_251_6
				local var_251_8 = Color.New(0, 0, 0)

				var_251_8.a = Mathf.Lerp(1, 0, var_251_7)
				arg_248_1.mask_.color = var_251_8
			end

			if arg_248_1.time_ >= var_251_5 + var_251_6 and arg_248_1.time_ < var_251_5 + var_251_6 + arg_251_0 then
				local var_251_9 = Color.New(0, 0, 0)
				local var_251_10 = 0

				arg_248_1.mask_.enabled = false
				var_251_9.a = var_251_10
				arg_248_1.mask_.color = var_251_9
			end

			local var_251_11 = 5.06666666666667
			local var_251_12 = 1

			if var_251_11 < arg_248_1.time_ and arg_248_1.time_ <= var_251_11 + arg_251_0 then
				local var_251_13 = "play"
				local var_251_14 = "effect"

				arg_248_1:AudioAction(var_251_13, var_251_14, "se_story_144", "se_story_144_gun07", "")
			end

			if arg_248_1.frameCnt_ <= 1 then
				arg_248_1.dialog_:SetActive(false)
			end

			local var_251_15 = 3.16666666666667
			local var_251_16 = 2.1

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				arg_248_1.dialog_:SetActive(true)

				arg_248_1.dialogCg_.alpha = 0

				local var_251_17 = LeanTween.value(arg_248_1.dialog_, 0, 1, 0.3)

				var_251_17:setOnUpdate(LuaHelper.FloatAction(function(arg_252_0)
					arg_248_1.dialogCg_.alpha = arg_252_0
				end))
				var_251_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_248_1.dialog_)
					var_251_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_248_1.duration_ = arg_248_1.duration_ + 0.3

				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_18 = arg_248_1:GetWordFromCfg(423172057)
				local var_251_19 = arg_248_1:FormatText(var_251_18.content)

				arg_248_1.text_.text = var_251_19

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_20 = 84
				local var_251_21 = utf8.len(var_251_19)
				local var_251_22 = var_251_20 <= 0 and var_251_16 or var_251_16 * (var_251_21 / var_251_20)

				if var_251_22 > 0 and var_251_16 < var_251_22 then
					arg_248_1.talkMaxDuration = var_251_22
					var_251_15 = var_251_15 + 0.3

					if var_251_22 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_22 + var_251_15
					end
				end

				arg_248_1.text_.text = var_251_19
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_23 = var_251_15 + 0.3
			local var_251_24 = math.max(var_251_16, arg_248_1.talkMaxDuration)

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_24 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_23) / var_251_24

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_23 + var_251_24 and arg_248_1.time_ < var_251_23 + var_251_24 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play423172058 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 423172058
		arg_254_1.duration_ = 6.75

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play423172059(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_1 = 3

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_1 then
				local var_257_2 = (arg_254_1.time_ - var_257_0) / var_257_1
				local var_257_3 = Color.New(0, 0, 0)

				var_257_3.a = Mathf.Lerp(0, 1, var_257_2)
				arg_254_1.mask_.color = var_257_3
			end

			if arg_254_1.time_ >= var_257_0 + var_257_1 and arg_254_1.time_ < var_257_0 + var_257_1 + arg_257_0 then
				local var_257_4 = Color.New(0, 0, 0)

				var_257_4.a = 1
				arg_254_1.mask_.color = var_257_4
			end

			local var_257_5 = 3

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_6 = 1

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_6 then
				local var_257_7 = (arg_254_1.time_ - var_257_5) / var_257_6
				local var_257_8 = Color.New(0, 0, 0)

				var_257_8.a = Mathf.Lerp(1, 0, var_257_7)
				arg_254_1.mask_.color = var_257_8
			end

			if arg_254_1.time_ >= var_257_5 + var_257_6 and arg_254_1.time_ < var_257_5 + var_257_6 + arg_257_0 then
				local var_257_9 = Color.New(0, 0, 0)
				local var_257_10 = 0

				arg_254_1.mask_.enabled = false
				var_257_9.a = var_257_10
				arg_254_1.mask_.color = var_257_9
			end

			local var_257_11 = "STblack"

			if arg_254_1.bgs_[var_257_11] == nil then
				local var_257_12 = Object.Instantiate(arg_254_1.paintGo_)

				var_257_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_257_11)
				var_257_12.name = var_257_11
				var_257_12.transform.parent = arg_254_1.stage_.transform
				var_257_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.bgs_[var_257_11] = var_257_12
			end

			local var_257_13 = 3

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				local var_257_14 = manager.ui.mainCamera.transform.localPosition
				local var_257_15 = Vector3.New(0, 0, 10) + Vector3.New(var_257_14.x, var_257_14.y, 0)
				local var_257_16 = arg_254_1.bgs_.STblack

				var_257_16.transform.localPosition = var_257_15
				var_257_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_257_17 = var_257_16:GetComponent("SpriteRenderer")

				if var_257_17 and var_257_17.sprite then
					local var_257_18 = (var_257_16.transform.localPosition - var_257_14).z
					local var_257_19 = manager.ui.mainCameraCom_
					local var_257_20 = 2 * var_257_18 * Mathf.Tan(var_257_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_257_21 = var_257_20 * var_257_19.aspect
					local var_257_22 = var_257_17.sprite.bounds.size.x
					local var_257_23 = var_257_17.sprite.bounds.size.y
					local var_257_24 = var_257_21 / var_257_22
					local var_257_25 = var_257_20 / var_257_23
					local var_257_26 = var_257_25 < var_257_24 and var_257_24 or var_257_25

					var_257_16.transform.localScale = Vector3.New(var_257_26, var_257_26, 0)
				end

				for iter_257_0, iter_257_1 in pairs(arg_254_1.bgs_) do
					if iter_257_0 ~= "STblack" then
						iter_257_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_257_27 = 3

			if var_257_27 < arg_254_1.time_ and arg_254_1.time_ <= var_257_27 + arg_257_0 then
				arg_254_1.fswbg_:SetActive(true)
				arg_254_1.dialog_:SetActive(false)

				arg_254_1.fswtw_.percent = 0

				local var_257_28 = arg_254_1:GetWordFromCfg(423172058)
				local var_257_29 = arg_254_1:FormatText(var_257_28.content)

				arg_254_1.fswt_.text = var_257_29

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.fswt_)

				arg_254_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_254_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_254_1.fswtw_:SetDirty()

				arg_254_1.typewritterCharCountI18N = 0

				SetActive(arg_254_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_254_1:ShowNextGo(false)
			end

			local var_257_30 = 3.01666666666667

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.var_.oldValueTypewriter = arg_254_1.fswtw_.percent

				SetActive(arg_254_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_254_1:ShowNextGo(false)
			end

			local var_257_31 = 56
			local var_257_32 = 3.73333333333333
			local var_257_33 = arg_254_1:GetWordFromCfg(423172058)
			local var_257_34 = arg_254_1:FormatText(var_257_33.content)
			local var_257_35, var_257_36 = arg_254_1:GetPercentByPara(var_257_34, 1)

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0

				local var_257_37 = var_257_31 <= 0 and var_257_32 or var_257_32 * ((var_257_36 - arg_254_1.typewritterCharCountI18N) / var_257_31)

				if var_257_37 > 0 and var_257_32 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end
			end

			local var_257_38 = 3.73333333333333
			local var_257_39 = math.max(var_257_38, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_39 then
				local var_257_40 = (arg_254_1.time_ - var_257_30) / var_257_39

				arg_254_1.fswtw_.percent = Mathf.Lerp(arg_254_1.var_.oldValueTypewriter, var_257_35, var_257_40)
				arg_254_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_254_1.fswtw_:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_39 and arg_254_1.time_ < var_257_30 + var_257_39 + arg_257_0 then
				arg_254_1.fswtw_.percent = var_257_35

				arg_254_1.fswtw_:SetDirty()
				arg_254_1:ShowNextGo(true)

				arg_254_1.typewritterCharCountI18N = var_257_36
			end

			local var_257_41 = 3

			if var_257_41 < arg_254_1.time_ and arg_254_1.time_ <= var_257_41 + arg_257_0 then
				local var_257_42 = arg_254_1.fswbg_.transform:Find("textbox/adapt/content") or arg_254_1.fswbg_.transform:Find("textbox/content")
				local var_257_43 = arg_254_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_257_44 = var_257_42:GetComponent("Text")
				local var_257_45 = var_257_42:GetComponent("RectTransform")

				var_257_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_257_45.offsetMin = Vector2.New(0, 0)
				var_257_45.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play423172059 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 423172059
		arg_258_1.duration_ = 8.5

		local var_258_0 = {
			zh = 6.466,
			ja = 8.5
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
				arg_258_0:Play423172060(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				local var_261_1 = manager.ui.mainCamera.transform.localPosition
				local var_261_2 = Vector3.New(0, 0, 10) + Vector3.New(var_261_1.x, var_261_1.y, 0)
				local var_261_3 = arg_258_1.bgs_.ST0113a

				var_261_3.transform.localPosition = var_261_2
				var_261_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_4 = var_261_3:GetComponent("SpriteRenderer")

				if var_261_4 and var_261_4.sprite then
					local var_261_5 = (var_261_3.transform.localPosition - var_261_1).z
					local var_261_6 = manager.ui.mainCameraCom_
					local var_261_7 = 2 * var_261_5 * Mathf.Tan(var_261_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_261_8 = var_261_7 * var_261_6.aspect
					local var_261_9 = var_261_4.sprite.bounds.size.x
					local var_261_10 = var_261_4.sprite.bounds.size.y
					local var_261_11 = var_261_8 / var_261_9
					local var_261_12 = var_261_7 / var_261_10
					local var_261_13 = var_261_12 < var_261_11 and var_261_11 or var_261_12

					var_261_3.transform.localScale = Vector3.New(var_261_13, var_261_13, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "ST0113a" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_15 = 1

			if var_261_14 <= arg_258_1.time_ and arg_258_1.time_ < var_261_14 + var_261_15 then
				local var_261_16 = (arg_258_1.time_ - var_261_14) / var_261_15
				local var_261_17 = Color.New(0, 0, 0)

				var_261_17.a = Mathf.Lerp(0, 1, var_261_16)
				arg_258_1.mask_.color = var_261_17
			end

			if arg_258_1.time_ >= var_261_14 + var_261_15 and arg_258_1.time_ < var_261_14 + var_261_15 + arg_261_0 then
				local var_261_18 = Color.New(0, 0, 0)

				var_261_18.a = 1
				arg_258_1.mask_.color = var_261_18
			end

			local var_261_19 = 1

			if var_261_19 < arg_258_1.time_ and arg_258_1.time_ <= var_261_19 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_20 = 1

			if var_261_19 <= arg_258_1.time_ and arg_258_1.time_ < var_261_19 + var_261_20 then
				local var_261_21 = (arg_258_1.time_ - var_261_19) / var_261_20
				local var_261_22 = Color.New(0, 0, 0)

				var_261_22.a = Mathf.Lerp(1, 0, var_261_21)
				arg_258_1.mask_.color = var_261_22
			end

			if arg_258_1.time_ >= var_261_19 + var_261_20 and arg_258_1.time_ < var_261_19 + var_261_20 + arg_261_0 then
				local var_261_23 = Color.New(0, 0, 0)
				local var_261_24 = 0

				arg_258_1.mask_.enabled = false
				var_261_23.a = var_261_24
				arg_258_1.mask_.color = var_261_23
			end

			local var_261_25 = 1

			if var_261_25 < arg_258_1.time_ and arg_258_1.time_ <= var_261_25 + arg_261_0 then
				arg_258_1.fswbg_:SetActive(false)
				arg_258_1.dialog_:SetActive(false)
				SetActive(arg_258_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_258_1:ShowNextGo(false)
			end

			local var_261_26 = arg_258_1.actors_["3054"].transform
			local var_261_27 = 2

			if var_261_27 < arg_258_1.time_ and arg_258_1.time_ <= var_261_27 + arg_261_0 then
				arg_258_1.var_.moveOldPos3054 = var_261_26.localPosition
				var_261_26.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("3054", 3)

				local var_261_28 = var_261_26.childCount

				for iter_261_2 = 0, var_261_28 - 1 do
					local var_261_29 = var_261_26:GetChild(iter_261_2)

					if var_261_29.name == "split_1" or not string.find(var_261_29.name, "split") then
						var_261_29.gameObject:SetActive(true)
					else
						var_261_29.gameObject:SetActive(false)
					end
				end
			end

			local var_261_30 = 0.001

			if var_261_27 <= arg_258_1.time_ and arg_258_1.time_ < var_261_27 + var_261_30 then
				local var_261_31 = (arg_258_1.time_ - var_261_27) / var_261_30
				local var_261_32 = Vector3.New(0, -275, -280)

				var_261_26.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos3054, var_261_32, var_261_31)
			end

			if arg_258_1.time_ >= var_261_27 + var_261_30 and arg_258_1.time_ < var_261_27 + var_261_30 + arg_261_0 then
				var_261_26.localPosition = Vector3.New(0, -275, -280)
			end

			local var_261_33 = arg_258_1.actors_["3054"]
			local var_261_34 = 2

			if var_261_34 < arg_258_1.time_ and arg_258_1.time_ <= var_261_34 + arg_261_0 and not isNil(var_261_33) and arg_258_1.var_.actorSpriteComps3054 == nil then
				arg_258_1.var_.actorSpriteComps3054 = var_261_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_35 = 0.2

			if var_261_34 <= arg_258_1.time_ and arg_258_1.time_ < var_261_34 + var_261_35 and not isNil(var_261_33) then
				local var_261_36 = (arg_258_1.time_ - var_261_34) / var_261_35

				if arg_258_1.var_.actorSpriteComps3054 then
					for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_261_4 then
							if arg_258_1.isInRecall_ then
								local var_261_37 = Mathf.Lerp(iter_261_4.color.r, arg_258_1.hightColor1.r, var_261_36)
								local var_261_38 = Mathf.Lerp(iter_261_4.color.g, arg_258_1.hightColor1.g, var_261_36)
								local var_261_39 = Mathf.Lerp(iter_261_4.color.b, arg_258_1.hightColor1.b, var_261_36)

								iter_261_4.color = Color.New(var_261_37, var_261_38, var_261_39)
							else
								local var_261_40 = Mathf.Lerp(iter_261_4.color.r, 1, var_261_36)

								iter_261_4.color = Color.New(var_261_40, var_261_40, var_261_40)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_34 + var_261_35 and arg_258_1.time_ < var_261_34 + var_261_35 + arg_261_0 and not isNil(var_261_33) and arg_258_1.var_.actorSpriteComps3054 then
				for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_261_6 then
						if arg_258_1.isInRecall_ then
							iter_261_6.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps3054 = nil
			end

			local var_261_41 = 2
			local var_261_42 = 0.325

			if var_261_41 < arg_258_1.time_ and arg_258_1.time_ <= var_261_41 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_43 = arg_258_1:FormatText(StoryNameCfg[1339].name)

				arg_258_1.leftNameTxt_.text = var_261_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_44 = arg_258_1:GetWordFromCfg(423172059)
				local var_261_45 = arg_258_1:FormatText(var_261_44.content)

				arg_258_1.text_.text = var_261_45

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_46 = 13
				local var_261_47 = utf8.len(var_261_45)
				local var_261_48 = var_261_46 <= 0 and var_261_42 or var_261_42 * (var_261_47 / var_261_46)

				if var_261_48 > 0 and var_261_42 < var_261_48 then
					arg_258_1.talkMaxDuration = var_261_48

					if var_261_48 + var_261_41 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_48 + var_261_41
					end
				end

				arg_258_1.text_.text = var_261_45
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172059", "story_v_out_423172.awb") ~= 0 then
					local var_261_49 = manager.audio:GetVoiceLength("story_v_out_423172", "423172059", "story_v_out_423172.awb") / 1000

					if var_261_49 + var_261_41 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_49 + var_261_41
					end

					if var_261_44.prefab_name ~= "" and arg_258_1.actors_[var_261_44.prefab_name] ~= nil then
						local var_261_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_44.prefab_name].transform, "story_v_out_423172", "423172059", "story_v_out_423172.awb")

						arg_258_1:RecordAudio("423172059", var_261_50)
						arg_258_1:RecordAudio("423172059", var_261_50)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_423172", "423172059", "story_v_out_423172.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_423172", "423172059", "story_v_out_423172.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_51 = math.max(var_261_42, arg_258_1.talkMaxDuration)

			if var_261_41 <= arg_258_1.time_ and arg_258_1.time_ < var_261_41 + var_261_51 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_41) / var_261_51

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_41 + var_261_51 and arg_258_1.time_ < var_261_41 + var_261_51 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play423172060 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 423172060
		arg_262_1.duration_ = 14.03

		local var_262_0 = {
			zh = 14.033,
			ja = 11.3
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play423172061(arg_262_1)
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

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[1339].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:GetWordFromCfg(423172060)
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172060", "story_v_out_423172.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172060", "story_v_out_423172.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_out_423172", "423172060", "story_v_out_423172.awb")

						arg_262_1:RecordAudio("423172060", var_265_9)
						arg_262_1:RecordAudio("423172060", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_423172", "423172060", "story_v_out_423172.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_423172", "423172060", "story_v_out_423172.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play423172061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 423172061
		arg_266_1.duration_ = 12.8

		local var_266_0 = {
			zh = 12.8,
			ja = 10.133
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
				arg_266_0:Play423172062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 1.125

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[1339].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:GetWordFromCfg(423172061)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172061", "story_v_out_423172.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172061", "story_v_out_423172.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_423172", "423172061", "story_v_out_423172.awb")

						arg_266_1:RecordAudio("423172061", var_269_9)
						arg_266_1:RecordAudio("423172061", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_423172", "423172061", "story_v_out_423172.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_423172", "423172061", "story_v_out_423172.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play423172062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 423172062
		arg_270_1.duration_ = 11.7

		local var_270_0 = {
			zh = 11.7,
			ja = 11.366
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
				arg_270_0:Play423172063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.975

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[1339].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:GetWordFromCfg(423172062)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172062", "story_v_out_423172.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172062", "story_v_out_423172.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_423172", "423172062", "story_v_out_423172.awb")

						arg_270_1:RecordAudio("423172062", var_273_9)
						arg_270_1:RecordAudio("423172062", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_423172", "423172062", "story_v_out_423172.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_423172", "423172062", "story_v_out_423172.awb")
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
	Play423172063 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 423172063
		arg_274_1.duration_ = 13.63

		local var_274_0 = {
			zh = 11.966,
			ja = 13.633
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
				arg_274_0:Play423172064(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 1.2

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[1339].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_3 = arg_274_1:GetWordFromCfg(423172063)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172063", "story_v_out_423172.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172063", "story_v_out_423172.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_423172", "423172063", "story_v_out_423172.awb")

						arg_274_1:RecordAudio("423172063", var_277_9)
						arg_274_1:RecordAudio("423172063", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_423172", "423172063", "story_v_out_423172.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_423172", "423172063", "story_v_out_423172.awb")
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
	Play423172064 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 423172064
		arg_278_1.duration_ = 7.37

		local var_278_0 = {
			zh = 7.233,
			ja = 7.366
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play423172065(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.725

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[1339].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(423172064)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172064", "story_v_out_423172.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172064", "story_v_out_423172.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_423172", "423172064", "story_v_out_423172.awb")

						arg_278_1:RecordAudio("423172064", var_281_9)
						arg_278_1:RecordAudio("423172064", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_423172", "423172064", "story_v_out_423172.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_423172", "423172064", "story_v_out_423172.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play423172065 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 423172065
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play423172066(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["3054"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos3054 = var_285_0.localPosition
				var_285_0.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("3054", 7)

				local var_285_2 = var_285_0.childCount

				for iter_285_0 = 0, var_285_2 - 1 do
					local var_285_3 = var_285_0:GetChild(iter_285_0)

					if var_285_3.name == "split_2" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_4 then
				local var_285_5 = (arg_282_1.time_ - var_285_1) / var_285_4
				local var_285_6 = Vector3.New(0, -2000, 0)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos3054, var_285_6, var_285_5)
			end

			if arg_282_1.time_ >= var_285_1 + var_285_4 and arg_282_1.time_ < var_285_1 + var_285_4 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_7 = 0
			local var_285_8 = 1.3

			if var_285_7 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_9 = arg_282_1:GetWordFromCfg(423172065)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 52
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_8 or var_285_8 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_8 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_7 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_7
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_8, arg_282_1.talkMaxDuration)

			if var_285_7 <= arg_282_1.time_ and arg_282_1.time_ < var_285_7 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_7) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_7 + var_285_14 and arg_282_1.time_ < var_285_7 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play423172066 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 423172066
		arg_286_1.duration_ = 10.1

		local var_286_0 = {
			zh = 10.1,
			ja = 7.3
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
				arg_286_0:Play423172067(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["3054"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos3054 = var_289_0.localPosition
				var_289_0.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("3054", 3)

				local var_289_2 = var_289_0.childCount

				for iter_289_0 = 0, var_289_2 - 1 do
					local var_289_3 = var_289_0:GetChild(iter_289_0)

					if var_289_3.name == "split_4" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_4 then
				local var_289_5 = (arg_286_1.time_ - var_289_1) / var_289_4
				local var_289_6 = Vector3.New(0, -275, -280)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos3054, var_289_6, var_289_5)
			end

			if arg_286_1.time_ >= var_289_1 + var_289_4 and arg_286_1.time_ < var_289_1 + var_289_4 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_289_7 = arg_286_1.actors_["3054"]
			local var_289_8 = 0

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.actorSpriteComps3054 == nil then
				arg_286_1.var_.actorSpriteComps3054 = var_289_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_9 = 0.2

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_9 and not isNil(var_289_7) then
				local var_289_10 = (arg_286_1.time_ - var_289_8) / var_289_9

				if arg_286_1.var_.actorSpriteComps3054 then
					for iter_289_1, iter_289_2 in pairs(arg_286_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_289_2 then
							if arg_286_1.isInRecall_ then
								local var_289_11 = Mathf.Lerp(iter_289_2.color.r, arg_286_1.hightColor1.r, var_289_10)
								local var_289_12 = Mathf.Lerp(iter_289_2.color.g, arg_286_1.hightColor1.g, var_289_10)
								local var_289_13 = Mathf.Lerp(iter_289_2.color.b, arg_286_1.hightColor1.b, var_289_10)

								iter_289_2.color = Color.New(var_289_11, var_289_12, var_289_13)
							else
								local var_289_14 = Mathf.Lerp(iter_289_2.color.r, 1, var_289_10)

								iter_289_2.color = Color.New(var_289_14, var_289_14, var_289_14)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_8 + var_289_9 and arg_286_1.time_ < var_289_8 + var_289_9 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.actorSpriteComps3054 then
				for iter_289_3, iter_289_4 in pairs(arg_286_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_289_4 then
						if arg_286_1.isInRecall_ then
							iter_289_4.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps3054 = nil
			end

			local var_289_15 = 0
			local var_289_16 = 0.575

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[1339].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(423172066)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 23
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172066", "story_v_out_423172.awb") ~= 0 then
					local var_289_23 = manager.audio:GetVoiceLength("story_v_out_423172", "423172066", "story_v_out_423172.awb") / 1000

					if var_289_23 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_15
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_out_423172", "423172066", "story_v_out_423172.awb")

						arg_286_1:RecordAudio("423172066", var_289_24)
						arg_286_1:RecordAudio("423172066", var_289_24)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_423172", "423172066", "story_v_out_423172.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_423172", "423172066", "story_v_out_423172.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_25 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_25 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_25

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_25 and arg_286_1.time_ < var_289_15 + var_289_25 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172067 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 423172067
		arg_290_1.duration_ = 1.87

		local var_290_0 = {
			zh = 1.866,
			ja = 1.733
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play423172068(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.125

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[1339].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_3 = arg_290_1:GetWordFromCfg(423172067)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172067", "story_v_out_423172.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172067", "story_v_out_423172.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_423172", "423172067", "story_v_out_423172.awb")

						arg_290_1:RecordAudio("423172067", var_293_9)
						arg_290_1:RecordAudio("423172067", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_423172", "423172067", "story_v_out_423172.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_423172", "423172067", "story_v_out_423172.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play423172068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 423172068
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play423172069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["3054"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos3054 = var_297_0.localPosition
				var_297_0.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("3054", 7)

				local var_297_2 = var_297_0.childCount

				for iter_297_0 = 0, var_297_2 - 1 do
					local var_297_3 = var_297_0:GetChild(iter_297_0)

					if var_297_3.name == "split_2" or not string.find(var_297_3.name, "split") then
						var_297_3.gameObject:SetActive(true)
					else
						var_297_3.gameObject:SetActive(false)
					end
				end
			end

			local var_297_4 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_4 then
				local var_297_5 = (arg_294_1.time_ - var_297_1) / var_297_4
				local var_297_6 = Vector3.New(0, -2000, 0)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos3054, var_297_6, var_297_5)
			end

			if arg_294_1.time_ >= var_297_1 + var_297_4 and arg_294_1.time_ < var_297_1 + var_297_4 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_297_7 = 0
			local var_297_8 = 1

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				local var_297_9 = "play"
				local var_297_10 = "effect"

				arg_294_1:AudioAction(var_297_9, var_297_10, "se_story_144", "se_story_144_footstep_rain01", "")
			end

			local var_297_11 = 1.46666666666667
			local var_297_12 = 1

			if var_297_11 < arg_294_1.time_ and arg_294_1.time_ <= var_297_11 + arg_297_0 then
				local var_297_13 = "play"
				local var_297_14 = "effect"

				arg_294_1:AudioAction(var_297_13, var_297_14, "se_story_144", "se_story_144_down", "")
			end

			local var_297_15 = 0
			local var_297_16 = 0.675

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_17 = arg_294_1:GetWordFromCfg(423172068)
				local var_297_18 = arg_294_1:FormatText(var_297_17.content)

				arg_294_1.text_.text = var_297_18

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_19 = 27
				local var_297_20 = utf8.len(var_297_18)
				local var_297_21 = var_297_19 <= 0 and var_297_16 or var_297_16 * (var_297_20 / var_297_19)

				if var_297_21 > 0 and var_297_16 < var_297_21 then
					arg_294_1.talkMaxDuration = var_297_21

					if var_297_21 + var_297_15 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_21 + var_297_15
					end
				end

				arg_294_1.text_.text = var_297_18
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_22 = math.max(var_297_16, arg_294_1.talkMaxDuration)

			if var_297_15 <= arg_294_1.time_ and arg_294_1.time_ < var_297_15 + var_297_22 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_15) / var_297_22

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_15 + var_297_22 and arg_294_1.time_ < var_297_15 + var_297_22 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play423172069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 423172069
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
			arg_298_1.auto_ = false
		end

		function arg_298_1.playNext_(arg_300_0)
			arg_298_1.onStoryFinished_()
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.725

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(423172069)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 29
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I24f",
		"TextureConfig/Background/ST0113a",
		"TextureConfig/Background/SS2304",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_423172.awb"
	}
}
