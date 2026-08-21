return {
	Play416092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416092001
		arg_1_1.duration_ = 5.33

		local var_1_0 = {
			zh = 4.766,
			ja = 5.333
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
				arg_1_0:Play416092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I14f"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.I14f

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "1148"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

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

			local var_4_28 = arg_1_1.actors_["1148"].transform
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1148", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_6" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -429, -180)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -429, -180)
			end

			local var_4_35 = arg_1_1.actors_["1148"]
			local var_4_36 = 1.66666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1148 == nil then
				arg_1_1.var_.actorSpriteComps1148 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.125

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps1148 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_39 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_38)
								local var_4_40 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_38)
								local var_4_41 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_38)

								iter_4_6.color = Color.New(var_4_39, var_4_40, var_4_41)
							else
								local var_4_42 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_38)

								iter_4_6.color = Color.New(var_4_42, var_4_42, var_4_42)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1148 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1148 = nil
			end

			local var_4_43 = arg_1_1.actors_["1148"]
			local var_4_44 = 1.66666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1148 = var_4_45.alpha
					arg_1_1.var_.characterEffect1148 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1148 = 0
			end

			local var_4_46 = 0.4

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1148, 1, var_4_47)

				if arg_1_1.var_.characterEffect1148 then
					arg_1_1.var_.characterEffect1148.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1148 then
				arg_1_1.var_.characterEffect1148.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.2

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_55 = 0.466666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if var_4_60 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_60 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_60

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_60
						arg_1_1.bgmTxt2_.text = var_4_60
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

			local var_4_61 = 0
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "effect"

				arg_1_1:AudioAction(var_4_63, var_4_64, "se_story_138", "se_story_138_5220109Talk_ambience_stop", "")
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

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(416092001)
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092001", "story_v_out_416092.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_416092", "416092001", "story_v_out_416092.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_416092", "416092001", "story_v_out_416092.awb")

						arg_1_1:RecordAudio("416092001", var_4_75)
						arg_1_1:RecordAudio("416092001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416092", "416092001", "story_v_out_416092.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416092", "416092001", "story_v_out_416092.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416092002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416092002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416092003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1148"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1148 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1148", 7)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -2000, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1148, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = 0.633333333333333
			local var_12_8 = 1

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				local var_12_9 = "play"
				local var_12_10 = "effect"

				arg_9_1:AudioAction(var_12_9, var_12_10, "se_story_138", "se_story_138_lasergun", "")
			end

			local var_12_11 = 0
			local var_12_12 = 1.725

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(416092002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 69
				local var_12_16 = utf8.len(var_12_14)
				local var_12_17 = var_12_15 <= 0 and var_12_12 or var_12_12 * (var_12_16 / var_12_15)

				if var_12_17 > 0 and var_12_12 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_11
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_12, arg_9_1.talkMaxDuration)

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_11) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_11 + var_12_18 and arg_9_1.time_ < var_12_11 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416092003
		arg_13_1.duration_ = 2.43

		local var_13_0 = {
			zh = 2.433,
			ja = 2.4
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
				arg_13_0:Play416092004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1148"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1148 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1148", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_3" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -429, -180)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1148, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_16_7 = arg_13_1.actors_["1148"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1148 == nil then
				arg_13_1.var_.actorSpriteComps1148 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.125

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps1148 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 1, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1148 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1148 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.25

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(416092003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092003", "story_v_out_416092.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092003", "story_v_out_416092.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_416092", "416092003", "story_v_out_416092.awb")

						arg_13_1:RecordAudio("416092003", var_16_24)
						arg_13_1:RecordAudio("416092003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416092", "416092003", "story_v_out_416092.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416092", "416092003", "story_v_out_416092.awb")
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
				actorName = "1148",
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
	Play416092004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416092004
		arg_17_1.duration_ = 2.63

		local var_17_0 = {
			zh = 2.633,
			ja = 2.4
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
				arg_17_0:Play416092005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.25

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[8].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(416092004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092004", "story_v_out_416092.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092004", "story_v_out_416092.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_416092", "416092004", "story_v_out_416092.awb")

						arg_17_1:RecordAudio("416092004", var_20_9)
						arg_17_1:RecordAudio("416092004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416092", "416092004", "story_v_out_416092.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416092", "416092004", "story_v_out_416092.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416092005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416092005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416092006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1148"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 7)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(0, -2000, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_7 = 0
			local var_24_8 = 0.85

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(416092005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 34
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_8 or var_24_8 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_8 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_7
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_8, arg_21_1.talkMaxDuration)

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_7) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_7 + var_24_14 and arg_21_1.time_ < var_24_7 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416092006
		arg_25_1.duration_ = 2.33

		local var_25_0 = {
			zh = 2.2,
			ja = 2.333
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
				arg_25_0:Play416092007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1148"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 3)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_6" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -429, -180)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_28_7 = arg_25_1.actors_["1148"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.125

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.275

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[8].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(416092006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 11
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092006", "story_v_out_416092.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092006", "story_v_out_416092.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_416092", "416092006", "story_v_out_416092.awb")

						arg_25_1:RecordAudio("416092006", var_28_24)
						arg_25_1:RecordAudio("416092006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416092", "416092006", "story_v_out_416092.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416092", "416092006", "story_v_out_416092.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416092007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416092008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1148"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1148 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1148", 7)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -2000, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1148, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_7 = 0.766666666666667
			local var_32_8 = 0.466666666666667

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				local var_32_9 = "play"
				local var_32_10 = "effect"

				arg_29_1:AudioAction(var_32_9, var_32_10, "se_story_127", "se_story_127_hot", "")
			end

			local var_32_11 = 0
			local var_32_12 = 0.9

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:GetWordFromCfg(416092007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 36
				local var_32_16 = utf8.len(var_32_14)
				local var_32_17 = var_32_15 <= 0 and var_32_12 or var_32_12 * (var_32_16 / var_32_15)

				if var_32_17 > 0 and var_32_12 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_18 and arg_29_1.time_ < var_32_11 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416092008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416092009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.2

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(416092008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 48
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416092009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416092009
		arg_37_1.duration_ = 3

		local var_37_0 = {
			zh = 2.766,
			ja = 3
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
				arg_37_0:Play416092010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1148"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_3" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -429, -180)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_40_7 = arg_37_1.actors_["1148"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.125

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_15 = 0
			local var_40_16 = 0.25

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[8].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(416092009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092009", "story_v_out_416092.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092009", "story_v_out_416092.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_416092", "416092009", "story_v_out_416092.awb")

						arg_37_1:RecordAudio("416092009", var_40_24)
						arg_37_1:RecordAudio("416092009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416092", "416092009", "story_v_out_416092.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416092", "416092009", "story_v_out_416092.awb")
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
				actorName = "1148",
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
	Play416092010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416092010
		arg_41_1.duration_ = 7.43

		local var_41_0 = {
			zh = 3.666,
			ja = 7.433
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
				arg_41_0:Play416092011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 == nil then
				arg_41_1.var_.actorSpriteComps1148 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.125

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1148 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.275

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[36].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(416092010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 11
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092010", "story_v_out_416092.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_416092", "416092010", "story_v_out_416092.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_416092", "416092010", "story_v_out_416092.awb")

						arg_41_1:RecordAudio("416092010", var_44_17)
						arg_41_1:RecordAudio("416092010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416092", "416092010", "story_v_out_416092.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416092", "416092010", "story_v_out_416092.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416092011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416092011
		arg_45_1.duration_ = 1.7

		local var_45_0 = {
			zh = 1.7,
			ja = 1.2
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
				arg_45_0:Play416092012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1148"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1148 == nil then
				arg_45_1.var_.actorSpriteComps1148 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.125

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1148 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1148 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1148 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.125

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_10 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(416092011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 5
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_9 or var_48_9 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_9 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092011", "story_v_out_416092.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_416092", "416092011", "story_v_out_416092.awb") / 1000

					if var_48_16 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_8
					end

					if var_48_11.prefab_name ~= "" and arg_45_1.actors_[var_48_11.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_11.prefab_name].transform, "story_v_out_416092", "416092011", "story_v_out_416092.awb")

						arg_45_1:RecordAudio("416092011", var_48_17)
						arg_45_1:RecordAudio("416092011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416092", "416092011", "story_v_out_416092.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416092", "416092011", "story_v_out_416092.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_18 and arg_45_1.time_ < var_48_8 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416092012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416092012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play416092013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1148"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1148 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1148", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_6" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1148, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = 0.5
			local var_52_8 = 1

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				local var_52_9 = "play"
				local var_52_10 = "effect"

				arg_49_1:AudioAction(var_52_9, var_52_10, "se_story_138", "se_story_138_footstep", "")
			end

			local var_52_11 = 0
			local var_52_12 = 1.625

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(416092012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 65
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_12 or var_52_12 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_12 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_18 and arg_49_1.time_ < var_52_11 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416092013
		arg_53_1.duration_ = 3.93

		local var_53_0 = {
			zh = 3.233,
			ja = 3.933
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
				arg_53_0:Play416092014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "10123"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10123")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(var_56_1, arg_53_1.canvasGo_.transform)

					var_56_2.transform:SetSiblingIndex(1)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_53_1.isInRecall_ then
						for iter_56_0, iter_56_1 in ipairs(var_56_3) do
							iter_56_1.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_56_4 = arg_53_1.actors_["10123"].transform
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.var_.moveOldPos10123 = var_56_4.localPosition
				var_56_4.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10123", 3)

				local var_56_6 = var_56_4.childCount

				for iter_56_2 = 0, var_56_6 - 1 do
					local var_56_7 = var_56_4:GetChild(iter_56_2)

					if var_56_7.name == "split_6" or not string.find(var_56_7.name, "split") then
						var_56_7.gameObject:SetActive(true)
					else
						var_56_7.gameObject:SetActive(false)
					end
				end
			end

			local var_56_8 = 0.001

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_5) / var_56_8
				local var_56_10 = Vector3.New(0, -400, 0)

				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10123, var_56_10, var_56_9)
			end

			if arg_53_1.time_ >= var_56_5 + var_56_8 and arg_53_1.time_ < var_56_5 + var_56_8 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0, -400, 0)
			end

			local var_56_11 = arg_53_1.actors_["10123"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps10123 == nil then
				arg_53_1.var_.actorSpriteComps10123 = var_56_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_13 = 0.125

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.actorSpriteComps10123 then
					for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_56_4 then
							if arg_53_1.isInRecall_ then
								local var_56_15 = Mathf.Lerp(iter_56_4.color.r, arg_53_1.hightColor1.r, var_56_14)
								local var_56_16 = Mathf.Lerp(iter_56_4.color.g, arg_53_1.hightColor1.g, var_56_14)
								local var_56_17 = Mathf.Lerp(iter_56_4.color.b, arg_53_1.hightColor1.b, var_56_14)

								iter_56_4.color = Color.New(var_56_15, var_56_16, var_56_17)
							else
								local var_56_18 = Mathf.Lerp(iter_56_4.color.r, 1, var_56_14)

								iter_56_4.color = Color.New(var_56_18, var_56_18, var_56_18)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps10123 then
				for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_56_6 then
						if arg_53_1.isInRecall_ then
							iter_56_6.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10123 = nil
			end

			local var_56_19 = 0
			local var_56_20 = 0.25

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_21 = arg_53_1:FormatText(StoryNameCfg[36].name)

				arg_53_1.leftNameTxt_.text = var_56_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_22 = arg_53_1:GetWordFromCfg(416092013)
				local var_56_23 = arg_53_1:FormatText(var_56_22.content)

				arg_53_1.text_.text = var_56_23

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_24 = 10
				local var_56_25 = utf8.len(var_56_23)
				local var_56_26 = var_56_24 <= 0 and var_56_20 or var_56_20 * (var_56_25 / var_56_24)

				if var_56_26 > 0 and var_56_20 < var_56_26 then
					arg_53_1.talkMaxDuration = var_56_26

					if var_56_26 + var_56_19 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_26 + var_56_19
					end
				end

				arg_53_1.text_.text = var_56_23
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092013", "story_v_out_416092.awb") ~= 0 then
					local var_56_27 = manager.audio:GetVoiceLength("story_v_out_416092", "416092013", "story_v_out_416092.awb") / 1000

					if var_56_27 + var_56_19 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_19
					end

					if var_56_22.prefab_name ~= "" and arg_53_1.actors_[var_56_22.prefab_name] ~= nil then
						local var_56_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_22.prefab_name].transform, "story_v_out_416092", "416092013", "story_v_out_416092.awb")

						arg_53_1:RecordAudio("416092013", var_56_28)
						arg_53_1:RecordAudio("416092013", var_56_28)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416092", "416092013", "story_v_out_416092.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416092", "416092013", "story_v_out_416092.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_29 = math.max(var_56_20, arg_53_1.talkMaxDuration)

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_29 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_19) / var_56_29

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_19 + var_56_29 and arg_53_1.time_ < var_56_19 + var_56_29 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416092014
		arg_57_1.duration_ = 5.23

		local var_57_0 = {
			zh = 5.233,
			ja = 4.966
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
				arg_57_0:Play416092015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1148"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1148 == nil then
				arg_57_1.var_.actorSpriteComps1148 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.125

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1148 = nil
			end

			local var_60_8 = arg_57_1.actors_["1148"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos1148 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1148", 3)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "split_3" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(0, -429, -180)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1148, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_60_15 = arg_57_1.actors_["10123"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos10123 = var_60_15.localPosition
				var_60_15.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10123", 7)

				local var_60_17 = var_60_15.childCount

				for iter_60_5 = 0, var_60_17 - 1 do
					local var_60_18 = var_60_15:GetChild(iter_60_5)

					if var_60_18.name == "split_6" or not string.find(var_60_18.name, "split") then
						var_60_18.gameObject:SetActive(true)
					else
						var_60_18.gameObject:SetActive(false)
					end
				end
			end

			local var_60_19 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_19 then
				local var_60_20 = (arg_57_1.time_ - var_60_16) / var_60_19
				local var_60_21 = Vector3.New(0, -2000, 0)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10123, var_60_21, var_60_20)
			end

			if arg_57_1.time_ >= var_60_16 + var_60_19 and arg_57_1.time_ < var_60_16 + var_60_19 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_22 = 0
			local var_60_23 = 0.525

			if var_60_22 < arg_57_1.time_ and arg_57_1.time_ <= var_60_22 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_24 = arg_57_1:FormatText(StoryNameCfg[8].name)

				arg_57_1.leftNameTxt_.text = var_60_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_25 = arg_57_1:GetWordFromCfg(416092014)
				local var_60_26 = arg_57_1:FormatText(var_60_25.content)

				arg_57_1.text_.text = var_60_26

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_27 = 21
				local var_60_28 = utf8.len(var_60_26)
				local var_60_29 = var_60_27 <= 0 and var_60_23 or var_60_23 * (var_60_28 / var_60_27)

				if var_60_29 > 0 and var_60_23 < var_60_29 then
					arg_57_1.talkMaxDuration = var_60_29

					if var_60_29 + var_60_22 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_22
					end
				end

				arg_57_1.text_.text = var_60_26
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092014", "story_v_out_416092.awb") ~= 0 then
					local var_60_30 = manager.audio:GetVoiceLength("story_v_out_416092", "416092014", "story_v_out_416092.awb") / 1000

					if var_60_30 + var_60_22 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_22
					end

					if var_60_25.prefab_name ~= "" and arg_57_1.actors_[var_60_25.prefab_name] ~= nil then
						local var_60_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_25.prefab_name].transform, "story_v_out_416092", "416092014", "story_v_out_416092.awb")

						arg_57_1:RecordAudio("416092014", var_60_31)
						arg_57_1:RecordAudio("416092014", var_60_31)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416092", "416092014", "story_v_out_416092.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416092", "416092014", "story_v_out_416092.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_32 = math.max(var_60_23, arg_57_1.talkMaxDuration)

			if var_60_22 <= arg_57_1.time_ and arg_57_1.time_ < var_60_22 + var_60_32 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_22) / var_60_32

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_22 + var_60_32 and arg_57_1.time_ < var_60_22 + var_60_32 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416092015
		arg_61_1.duration_ = 5.63

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416092016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1148"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1148", 7)

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
				local var_64_6 = Vector3.New(0, -2000, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_7 = manager.ui.mainCamera.transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				local var_64_9 = arg_61_1.var_.effect21051
				local var_64_10
				local var_64_11 = var_64_7

				if not var_64_9 then
					var_64_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_64_11)
					var_64_9.name = "21051"
					arg_61_1.var_.effect21051 = var_64_9
				else
					var_64_9.transform:SetParent(var_64_11)
				end

				var_64_9.transform.localPosition = Vector3.New(0, -0.32, 1.45)
				var_64_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_64_12 = manager.ui.mainCamera.transform
			local var_64_13 = 0.233333333333334

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				local var_64_14 = arg_61_1.var_.effect21051

				if var_64_14 then
					Object.Destroy(var_64_14)

					arg_61_1.var_.effect21051 = nil
				end
			end

			local var_64_15 = manager.ui.mainCamera.transform
			local var_64_16 = 0.233333333333333

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				local var_64_17 = arg_61_1.var_.effect21052
				local var_64_18
				local var_64_19 = var_64_15

				if not var_64_17 then
					var_64_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_64_19)
					var_64_17.name = "21052"
					arg_61_1.var_.effect21052 = var_64_17
				else
					var_64_17.transform:SetParent(var_64_19)
				end

				var_64_17.transform.localPosition = Vector3.New(0.5, -0.26, 0)
				var_64_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_64_20 = manager.ui.mainCamera.transform
			local var_64_21 = 0.466666666666667

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				local var_64_22 = arg_61_1.var_.effect21052

				if var_64_22 then
					Object.Destroy(var_64_22)

					arg_61_1.var_.effect21052 = nil
				end
			end

			local var_64_23 = 0

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.var_.shakeOldPos = var_64_20.localPosition
			end

			local var_64_24 = 0.440613901941106

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / 0.066
				local var_64_26, var_64_27 = math.modf(var_64_25)

				var_64_20.localPosition = Vector3.New(var_64_27 * 0.13, var_64_27 * 0.13, var_64_27 * 0.13) + arg_61_1.var_.shakeOldPos
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				var_64_20.localPosition = arg_61_1.var_.shakeOldPos
			end

			local var_64_28 = 0.1
			local var_64_29 = 0.533333333333333

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 then
				local var_64_30 = "play"
				local var_64_31 = "effect"

				arg_61_1:AudioAction(var_64_30, var_64_31, "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_32 = 0.633333333333333
			local var_64_33 = 1.525

			if var_64_32 < arg_61_1.time_ and arg_61_1.time_ <= var_64_32 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_34 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_34:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_35 = arg_61_1:GetWordFromCfg(416092015)
				local var_64_36 = arg_61_1:FormatText(var_64_35.content)

				arg_61_1.text_.text = var_64_36

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_37 = 61
				local var_64_38 = utf8.len(var_64_36)
				local var_64_39 = var_64_37 <= 0 and var_64_33 or var_64_33 * (var_64_38 / var_64_37)

				if var_64_39 > 0 and var_64_33 < var_64_39 then
					arg_61_1.talkMaxDuration = var_64_39
					var_64_32 = var_64_32 + 0.3

					if var_64_39 + var_64_32 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_39 + var_64_32
					end
				end

				arg_61_1.text_.text = var_64_36
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = var_64_32 + 0.3
			local var_64_41 = math.max(var_64_33, arg_61_1.talkMaxDuration)

			if var_64_40 <= arg_61_1.time_ and arg_61_1.time_ < var_64_40 + var_64_41 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_40) / var_64_41

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_40 + var_64_41 and arg_61_1.time_ < var_64_40 + var_64_41 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416092016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416092016
		arg_67_1.duration_ = 4.33

		local var_67_0 = {
			zh = 3.166,
			ja = 4.333
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
				arg_67_0:Play416092017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1148"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1148 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1148", 3)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "split_6" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(0, -429, -180)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1148, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_70_7 = arg_67_1.actors_["1148"]
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1148 == nil then
				arg_67_1.var_.actorSpriteComps1148 = var_70_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 0.125

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 and not isNil(var_70_7) then
				local var_70_10 = (arg_67_1.time_ - var_70_8) / var_70_9

				if arg_67_1.var_.actorSpriteComps1148 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								local var_70_11 = Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor1.r, var_70_10)
								local var_70_12 = Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor1.g, var_70_10)
								local var_70_13 = Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor1.b, var_70_10)

								iter_70_2.color = Color.New(var_70_11, var_70_12, var_70_13)
							else
								local var_70_14 = Mathf.Lerp(iter_70_2.color.r, 1, var_70_10)

								iter_70_2.color = Color.New(var_70_14, var_70_14, var_70_14)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1148 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_70_4 then
						if arg_67_1.isInRecall_ then
							iter_70_4.color = arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_70_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1148 = nil
			end

			local var_70_15 = 0
			local var_70_16 = 0.275

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[8].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(416092016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 11
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092016", "story_v_out_416092.awb") ~= 0 then
					local var_70_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092016", "story_v_out_416092.awb") / 1000

					if var_70_23 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_15
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_out_416092", "416092016", "story_v_out_416092.awb")

						arg_67_1:RecordAudio("416092016", var_70_24)
						arg_67_1:RecordAudio("416092016", var_70_24)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416092", "416092016", "story_v_out_416092.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416092", "416092016", "story_v_out_416092.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_25 and arg_67_1.time_ < var_70_15 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play416092017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416092017
		arg_71_1.duration_ = 8.5

		local var_71_0 = {
			zh = 3.7,
			ja = 8.5
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
				arg_71_0:Play416092018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10123"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10123 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10123", 3)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "split_6" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -400, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10123, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_74_7 = arg_71_1.actors_["10123"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10123 == nil then
				arg_71_1.var_.actorSpriteComps10123 = var_74_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 0.125

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.actorSpriteComps10123 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								local var_74_11 = Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, var_74_10)
								local var_74_12 = Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, var_74_10)
								local var_74_13 = Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, var_74_10)

								iter_74_2.color = Color.New(var_74_11, var_74_12, var_74_13)
							else
								local var_74_14 = Mathf.Lerp(iter_74_2.color.r, 1, var_74_10)

								iter_74_2.color = Color.New(var_74_14, var_74_14, var_74_14)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10123 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_74_4 then
						if arg_71_1.isInRecall_ then
							iter_74_4.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps10123 = nil
			end

			local var_74_15 = 0
			local var_74_16 = 0.275

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[36].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(416092017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 11
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092017", "story_v_out_416092.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092017", "story_v_out_416092.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_416092", "416092017", "story_v_out_416092.awb")

						arg_71_1:RecordAudio("416092017", var_74_24)
						arg_71_1:RecordAudio("416092017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416092", "416092017", "story_v_out_416092.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416092", "416092017", "story_v_out_416092.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416092018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416092018
		arg_75_1.duration_ = 4.63

		local var_75_0 = {
			zh = 4.566,
			ja = 4.633
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
				arg_75_0:Play416092019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1148"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps1148 == nil then
				arg_75_1.var_.actorSpriteComps1148 = var_78_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_2 = 0.125

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.actorSpriteComps1148 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								local var_78_4 = Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, var_78_3)
								local var_78_5 = Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, var_78_3)
								local var_78_6 = Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, var_78_3)

								iter_78_1.color = Color.New(var_78_4, var_78_5, var_78_6)
							else
								local var_78_7 = Mathf.Lerp(iter_78_1.color.r, 1, var_78_3)

								iter_78_1.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps1148 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_78_3 then
						if arg_75_1.isInRecall_ then
							iter_78_3.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1148 = nil
			end

			local var_78_8 = arg_75_1.actors_["1148"].transform
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.var_.moveOldPos1148 = var_78_8.localPosition
				var_78_8.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1148", 4)

				local var_78_10 = var_78_8.childCount

				for iter_78_4 = 0, var_78_10 - 1 do
					local var_78_11 = var_78_8:GetChild(iter_78_4)

					if var_78_11.name == "split_3" or not string.find(var_78_11.name, "split") then
						var_78_11.gameObject:SetActive(true)
					else
						var_78_11.gameObject:SetActive(false)
					end
				end
			end

			local var_78_12 = 0.001

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_12 then
				local var_78_13 = (arg_75_1.time_ - var_78_9) / var_78_12
				local var_78_14 = Vector3.New(390, -429, -180)

				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1148, var_78_14, var_78_13)
			end

			if arg_75_1.time_ >= var_78_9 + var_78_12 and arg_75_1.time_ < var_78_9 + var_78_12 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_78_15 = arg_75_1.actors_["10123"].transform
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.var_.moveOldPos10123 = var_78_15.localPosition
				var_78_15.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10123", 2)

				local var_78_17 = var_78_15.childCount

				for iter_78_5 = 0, var_78_17 - 1 do
					local var_78_18 = var_78_15:GetChild(iter_78_5)

					if var_78_18.name == "split_6" or not string.find(var_78_18.name, "split") then
						var_78_18.gameObject:SetActive(true)
					else
						var_78_18.gameObject:SetActive(false)
					end
				end
			end

			local var_78_19 = 0.001

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_19 then
				local var_78_20 = (arg_75_1.time_ - var_78_16) / var_78_19
				local var_78_21 = Vector3.New(-390, -400, 0)

				var_78_15.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10123, var_78_21, var_78_20)
			end

			if arg_75_1.time_ >= var_78_16 + var_78_19 and arg_75_1.time_ < var_78_16 + var_78_19 + arg_78_0 then
				var_78_15.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_78_22 = arg_75_1.actors_["10123"]
			local var_78_23 = 0

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 and not isNil(var_78_22) and arg_75_1.var_.actorSpriteComps10123 == nil then
				arg_75_1.var_.actorSpriteComps10123 = var_78_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_24 = 0.125

			if var_78_23 <= arg_75_1.time_ and arg_75_1.time_ < var_78_23 + var_78_24 and not isNil(var_78_22) then
				local var_78_25 = (arg_75_1.time_ - var_78_23) / var_78_24

				if arg_75_1.var_.actorSpriteComps10123 then
					for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_78_7 then
							if arg_75_1.isInRecall_ then
								local var_78_26 = Mathf.Lerp(iter_78_7.color.r, arg_75_1.hightColor2.r, var_78_25)
								local var_78_27 = Mathf.Lerp(iter_78_7.color.g, arg_75_1.hightColor2.g, var_78_25)
								local var_78_28 = Mathf.Lerp(iter_78_7.color.b, arg_75_1.hightColor2.b, var_78_25)

								iter_78_7.color = Color.New(var_78_26, var_78_27, var_78_28)
							else
								local var_78_29 = Mathf.Lerp(iter_78_7.color.r, 0.5, var_78_25)

								iter_78_7.color = Color.New(var_78_29, var_78_29, var_78_29)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_23 + var_78_24 and arg_75_1.time_ < var_78_23 + var_78_24 + arg_78_0 and not isNil(var_78_22) and arg_75_1.var_.actorSpriteComps10123 then
				for iter_78_8, iter_78_9 in pairs(arg_75_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_78_9 then
						if arg_75_1.isInRecall_ then
							iter_78_9.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10123 = nil
			end

			local var_78_30 = 0
			local var_78_31 = 0.45

			if var_78_30 < arg_75_1.time_ and arg_75_1.time_ <= var_78_30 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_32 = arg_75_1:FormatText(StoryNameCfg[8].name)

				arg_75_1.leftNameTxt_.text = var_78_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_33 = arg_75_1:GetWordFromCfg(416092018)
				local var_78_34 = arg_75_1:FormatText(var_78_33.content)

				arg_75_1.text_.text = var_78_34

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_35 = 18
				local var_78_36 = utf8.len(var_78_34)
				local var_78_37 = var_78_35 <= 0 and var_78_31 or var_78_31 * (var_78_36 / var_78_35)

				if var_78_37 > 0 and var_78_31 < var_78_37 then
					arg_75_1.talkMaxDuration = var_78_37

					if var_78_37 + var_78_30 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_37 + var_78_30
					end
				end

				arg_75_1.text_.text = var_78_34
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092018", "story_v_out_416092.awb") ~= 0 then
					local var_78_38 = manager.audio:GetVoiceLength("story_v_out_416092", "416092018", "story_v_out_416092.awb") / 1000

					if var_78_38 + var_78_30 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_38 + var_78_30
					end

					if var_78_33.prefab_name ~= "" and arg_75_1.actors_[var_78_33.prefab_name] ~= nil then
						local var_78_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_33.prefab_name].transform, "story_v_out_416092", "416092018", "story_v_out_416092.awb")

						arg_75_1:RecordAudio("416092018", var_78_39)
						arg_75_1:RecordAudio("416092018", var_78_39)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416092", "416092018", "story_v_out_416092.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416092", "416092018", "story_v_out_416092.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_40 = math.max(var_78_31, arg_75_1.talkMaxDuration)

			if var_78_30 <= arg_75_1.time_ and arg_75_1.time_ < var_78_30 + var_78_40 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_30) / var_78_40

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_30 + var_78_40 and arg_75_1.time_ < var_78_30 + var_78_40 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416092019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416092020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1148"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1148 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1148", 7)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(0, -2000, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1148, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_7 = arg_79_1.actors_["10123"].transform
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.var_.moveOldPos10123 = var_82_7.localPosition
				var_82_7.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10123", 7)

				local var_82_9 = var_82_7.childCount

				for iter_82_1 = 0, var_82_9 - 1 do
					local var_82_10 = var_82_7:GetChild(iter_82_1)

					if var_82_10.name == "split_6" or not string.find(var_82_10.name, "split") then
						var_82_10.gameObject:SetActive(true)
					else
						var_82_10.gameObject:SetActive(false)
					end
				end
			end

			local var_82_11 = 0.001

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_8) / var_82_11
				local var_82_13 = Vector3.New(0, -2000, 0)

				var_82_7.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10123, var_82_13, var_82_12)
			end

			if arg_79_1.time_ >= var_82_8 + var_82_11 and arg_79_1.time_ < var_82_8 + var_82_11 + arg_82_0 then
				var_82_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_14 = 0
			local var_82_15 = 1.55

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_16 = arg_79_1:GetWordFromCfg(416092019)
				local var_82_17 = arg_79_1:FormatText(var_82_16.content)

				arg_79_1.text_.text = var_82_17

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_18 = 62
				local var_82_19 = utf8.len(var_82_17)
				local var_82_20 = var_82_18 <= 0 and var_82_15 or var_82_15 * (var_82_19 / var_82_18)

				if var_82_20 > 0 and var_82_15 < var_82_20 then
					arg_79_1.talkMaxDuration = var_82_20

					if var_82_20 + var_82_14 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_14
					end
				end

				arg_79_1.text_.text = var_82_17
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_21 = math.max(var_82_15, arg_79_1.talkMaxDuration)

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_21 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_14) / var_82_21

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_14 + var_82_21 and arg_79_1.time_ < var_82_14 + var_82_21 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416092020
		arg_83_1.duration_ = 9.53

		local var_83_0 = {
			zh = 7.066,
			ja = 9.533
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
				arg_83_0:Play416092021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10123"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10123 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10123", 3)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "split_6" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(0, -400, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10123, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_86_7 = arg_83_1.actors_["10123"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10123 == nil then
				arg_83_1.var_.actorSpriteComps10123 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 0.125

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps10123 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								local var_86_11 = Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, var_86_10)
								local var_86_12 = Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, var_86_10)
								local var_86_13 = Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, var_86_10)

								iter_86_2.color = Color.New(var_86_11, var_86_12, var_86_13)
							else
								local var_86_14 = Mathf.Lerp(iter_86_2.color.r, 1, var_86_10)

								iter_86_2.color = Color.New(var_86_14, var_86_14, var_86_14)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10123 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10123 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 0.65

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[36].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(416092020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 26
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092020", "story_v_out_416092.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092020", "story_v_out_416092.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_416092", "416092020", "story_v_out_416092.awb")

						arg_83_1:RecordAudio("416092020", var_86_24)
						arg_83_1:RecordAudio("416092020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_416092", "416092020", "story_v_out_416092.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_416092", "416092020", "story_v_out_416092.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_25 and arg_83_1.time_ < var_86_15 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play416092021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416092021
		arg_87_1.duration_ = 4.33

		local var_87_0 = {
			zh = 3,
			ja = 4.333
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
				arg_87_0:Play416092022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.15

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[36].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(416092021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092021", "story_v_out_416092.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092021", "story_v_out_416092.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_416092", "416092021", "story_v_out_416092.awb")

						arg_87_1:RecordAudio("416092021", var_90_9)
						arg_87_1:RecordAudio("416092021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416092", "416092021", "story_v_out_416092.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416092", "416092021", "story_v_out_416092.awb")
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
	Play416092022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416092022
		arg_91_1.duration_ = 8

		local var_91_0 = {
			zh = 3.433,
			ja = 8
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
				arg_91_0:Play416092023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1148"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1148 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1148", 4)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_3" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(390, -429, -180)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1148, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(390, -429, -180)
			end

			local var_94_7 = arg_91_1.actors_["1148"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1148 == nil then
				arg_91_1.var_.actorSpriteComps1148 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.125

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps1148 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1148 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1148 = nil
			end

			local var_94_15 = arg_91_1.actors_["10123"].transform
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.var_.moveOldPos10123 = var_94_15.localPosition
				var_94_15.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10123", 2)

				local var_94_17 = var_94_15.childCount

				for iter_94_5 = 0, var_94_17 - 1 do
					local var_94_18 = var_94_15:GetChild(iter_94_5)

					if var_94_18.name == "split_6" or not string.find(var_94_18.name, "split") then
						var_94_18.gameObject:SetActive(true)
					else
						var_94_18.gameObject:SetActive(false)
					end
				end
			end

			local var_94_19 = 0.001

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_19 then
				local var_94_20 = (arg_91_1.time_ - var_94_16) / var_94_19
				local var_94_21 = Vector3.New(-390, -400, 0)

				var_94_15.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10123, var_94_21, var_94_20)
			end

			if arg_91_1.time_ >= var_94_16 + var_94_19 and arg_91_1.time_ < var_94_16 + var_94_19 + arg_94_0 then
				var_94_15.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_94_22 = arg_91_1.actors_["10123"]
			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10123 == nil then
				arg_91_1.var_.actorSpriteComps10123 = var_94_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_24 = 0.125

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_24 and not isNil(var_94_22) then
				local var_94_25 = (arg_91_1.time_ - var_94_23) / var_94_24

				if arg_91_1.var_.actorSpriteComps10123 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								local var_94_26 = Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor2.r, var_94_25)
								local var_94_27 = Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor2.g, var_94_25)
								local var_94_28 = Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor2.b, var_94_25)

								iter_94_7.color = Color.New(var_94_26, var_94_27, var_94_28)
							else
								local var_94_29 = Mathf.Lerp(iter_94_7.color.r, 0.5, var_94_25)

								iter_94_7.color = Color.New(var_94_29, var_94_29, var_94_29)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_23 + var_94_24 and arg_91_1.time_ < var_94_23 + var_94_24 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10123 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_94_9 then
						if arg_91_1.isInRecall_ then
							iter_94_9.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10123 = nil
			end

			local var_94_30 = 0
			local var_94_31 = 0.45

			if var_94_30 < arg_91_1.time_ and arg_91_1.time_ <= var_94_30 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_32 = arg_91_1:FormatText(StoryNameCfg[8].name)

				arg_91_1.leftNameTxt_.text = var_94_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_33 = arg_91_1:GetWordFromCfg(416092022)
				local var_94_34 = arg_91_1:FormatText(var_94_33.content)

				arg_91_1.text_.text = var_94_34

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_35 = 18
				local var_94_36 = utf8.len(var_94_34)
				local var_94_37 = var_94_35 <= 0 and var_94_31 or var_94_31 * (var_94_36 / var_94_35)

				if var_94_37 > 0 and var_94_31 < var_94_37 then
					arg_91_1.talkMaxDuration = var_94_37

					if var_94_37 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_37 + var_94_30
					end
				end

				arg_91_1.text_.text = var_94_34
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092022", "story_v_out_416092.awb") ~= 0 then
					local var_94_38 = manager.audio:GetVoiceLength("story_v_out_416092", "416092022", "story_v_out_416092.awb") / 1000

					if var_94_38 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_38 + var_94_30
					end

					if var_94_33.prefab_name ~= "" and arg_91_1.actors_[var_94_33.prefab_name] ~= nil then
						local var_94_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_33.prefab_name].transform, "story_v_out_416092", "416092022", "story_v_out_416092.awb")

						arg_91_1:RecordAudio("416092022", var_94_39)
						arg_91_1:RecordAudio("416092022", var_94_39)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416092", "416092022", "story_v_out_416092.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416092", "416092022", "story_v_out_416092.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_40 = math.max(var_94_31, arg_91_1.talkMaxDuration)

			if var_94_30 <= arg_91_1.time_ and arg_91_1.time_ < var_94_30 + var_94_40 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_30) / var_94_40

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_30 + var_94_40 and arg_91_1.time_ < var_94_30 + var_94_40 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416092023
		arg_95_1.duration_ = 4.6

		local var_95_0 = {
			zh = 4.1,
			ja = 4.6
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
				arg_95_0:Play416092024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.325

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[8].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(416092023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092023", "story_v_out_416092.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092023", "story_v_out_416092.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_416092", "416092023", "story_v_out_416092.awb")

						arg_95_1:RecordAudio("416092023", var_98_9)
						arg_95_1:RecordAudio("416092023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_416092", "416092023", "story_v_out_416092.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_416092", "416092023", "story_v_out_416092.awb")
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
	Play416092024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416092024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play416092025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1148"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1148 = var_102_0.localPosition
				var_102_0.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1148", 7)

				local var_102_2 = var_102_0.childCount

				for iter_102_0 = 0, var_102_2 - 1 do
					local var_102_3 = var_102_0:GetChild(iter_102_0)

					if var_102_3.name == "" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_4 then
				local var_102_5 = (arg_99_1.time_ - var_102_1) / var_102_4
				local var_102_6 = Vector3.New(0, -2000, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1148, var_102_6, var_102_5)
			end

			if arg_99_1.time_ >= var_102_1 + var_102_4 and arg_99_1.time_ < var_102_1 + var_102_4 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_7 = 0
			local var_102_8 = 1

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				local var_102_9 = "play"
				local var_102_10 = "effect"

				arg_99_1:AudioAction(var_102_9, var_102_10, "se_story_120_00", "se_story_120_00_gun02", "")
			end

			local var_102_11 = arg_99_1.actors_["10123"].transform
			local var_102_12 = 0

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.var_.moveOldPos10123 = var_102_11.localPosition
				var_102_11.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10123", 7)

				local var_102_13 = var_102_11.childCount

				for iter_102_1 = 0, var_102_13 - 1 do
					local var_102_14 = var_102_11:GetChild(iter_102_1)

					if var_102_14.name == "split_6" or not string.find(var_102_14.name, "split") then
						var_102_14.gameObject:SetActive(true)
					else
						var_102_14.gameObject:SetActive(false)
					end
				end
			end

			local var_102_15 = 0.001

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_15 then
				local var_102_16 = (arg_99_1.time_ - var_102_12) / var_102_15
				local var_102_17 = Vector3.New(0, -2000, 0)

				var_102_11.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10123, var_102_17, var_102_16)
			end

			if arg_99_1.time_ >= var_102_12 + var_102_15 and arg_99_1.time_ < var_102_12 + var_102_15 + arg_102_0 then
				var_102_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_18 = 0
			local var_102_19 = 1.825

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_20 = arg_99_1:GetWordFromCfg(416092024)
				local var_102_21 = arg_99_1:FormatText(var_102_20.content)

				arg_99_1.text_.text = var_102_21

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_22 = 73
				local var_102_23 = utf8.len(var_102_21)
				local var_102_24 = var_102_22 <= 0 and var_102_19 or var_102_19 * (var_102_23 / var_102_22)

				if var_102_24 > 0 and var_102_19 < var_102_24 then
					arg_99_1.talkMaxDuration = var_102_24

					if var_102_24 + var_102_18 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_24 + var_102_18
					end
				end

				arg_99_1.text_.text = var_102_21
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_19, arg_99_1.talkMaxDuration)

			if var_102_18 <= arg_99_1.time_ and arg_99_1.time_ < var_102_18 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_18) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_18 + var_102_25 and arg_99_1.time_ < var_102_18 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play416092025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416092025
		arg_103_1.duration_ = 7.13

		local var_103_0 = {
			zh = 3.7,
			ja = 7.133
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
				arg_103_0:Play416092026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1148"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1148 = var_106_0.localPosition
				var_106_0.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1148", 3)

				local var_106_2 = var_106_0.childCount

				for iter_106_0 = 0, var_106_2 - 1 do
					local var_106_3 = var_106_0:GetChild(iter_106_0)

					if var_106_3.name == "split_3" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_4 then
				local var_106_5 = (arg_103_1.time_ - var_106_1) / var_106_4
				local var_106_6 = Vector3.New(0, -429, -180)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1148, var_106_6, var_106_5)
			end

			if arg_103_1.time_ >= var_106_1 + var_106_4 and arg_103_1.time_ < var_106_1 + var_106_4 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_106_7 = arg_103_1.actors_["1148"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1148 == nil then
				arg_103_1.var_.actorSpriteComps1148 = var_106_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 0.125

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.actorSpriteComps1148 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								local var_106_11 = Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor1.r, var_106_10)
								local var_106_12 = Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor1.g, var_106_10)
								local var_106_13 = Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor1.b, var_106_10)

								iter_106_2.color = Color.New(var_106_11, var_106_12, var_106_13)
							else
								local var_106_14 = Mathf.Lerp(iter_106_2.color.r, 1, var_106_10)

								iter_106_2.color = Color.New(var_106_14, var_106_14, var_106_14)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1148 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_106_4 then
						if arg_103_1.isInRecall_ then
							iter_106_4.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1148 = nil
			end

			local var_106_15 = 0
			local var_106_16 = 0.3

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[8].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(416092025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092025", "story_v_out_416092.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092025", "story_v_out_416092.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_416092", "416092025", "story_v_out_416092.awb")

						arg_103_1:RecordAudio("416092025", var_106_24)
						arg_103_1:RecordAudio("416092025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416092", "416092025", "story_v_out_416092.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416092", "416092025", "story_v_out_416092.awb")
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
				actorName = "1148",
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
	Play416092026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416092026
		arg_107_1.duration_ = 13.37

		local var_107_0 = {
			zh = 9.4,
			ja = 13.366
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
				arg_107_0:Play416092027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1148"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1148 == nil then
				arg_107_1.var_.actorSpriteComps1148 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.125

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps1148 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 0.5, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1148 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1148 = nil
			end

			local var_110_8 = arg_107_1.actors_["10123"].transform
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1.var_.moveOldPos10123 = var_110_8.localPosition
				var_110_8.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10123", 3)

				local var_110_10 = var_110_8.childCount

				for iter_110_4 = 0, var_110_10 - 1 do
					local var_110_11 = var_110_8:GetChild(iter_110_4)

					if var_110_11.name == "split_6" or not string.find(var_110_11.name, "split") then
						var_110_11.gameObject:SetActive(true)
					else
						var_110_11.gameObject:SetActive(false)
					end
				end
			end

			local var_110_12 = 0.001

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_12 then
				local var_110_13 = (arg_107_1.time_ - var_110_9) / var_110_12
				local var_110_14 = Vector3.New(0, -400, 0)

				var_110_8.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10123, var_110_14, var_110_13)
			end

			if arg_107_1.time_ >= var_110_9 + var_110_12 and arg_107_1.time_ < var_110_9 + var_110_12 + arg_110_0 then
				var_110_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_110_15 = arg_107_1.actors_["10123"]
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.actorSpriteComps10123 == nil then
				arg_107_1.var_.actorSpriteComps10123 = var_110_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_17 = 0.125

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 and not isNil(var_110_15) then
				local var_110_18 = (arg_107_1.time_ - var_110_16) / var_110_17

				if arg_107_1.var_.actorSpriteComps10123 then
					for iter_110_5, iter_110_6 in pairs(arg_107_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_110_6 then
							if arg_107_1.isInRecall_ then
								local var_110_19 = Mathf.Lerp(iter_110_6.color.r, arg_107_1.hightColor1.r, var_110_18)
								local var_110_20 = Mathf.Lerp(iter_110_6.color.g, arg_107_1.hightColor1.g, var_110_18)
								local var_110_21 = Mathf.Lerp(iter_110_6.color.b, arg_107_1.hightColor1.b, var_110_18)

								iter_110_6.color = Color.New(var_110_19, var_110_20, var_110_21)
							else
								local var_110_22 = Mathf.Lerp(iter_110_6.color.r, 1, var_110_18)

								iter_110_6.color = Color.New(var_110_22, var_110_22, var_110_22)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.actorSpriteComps10123 then
				for iter_110_7, iter_110_8 in pairs(arg_107_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_110_8 then
						if arg_107_1.isInRecall_ then
							iter_110_8.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10123 = nil
			end

			local var_110_23 = 0
			local var_110_24 = 0.775

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[36].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(416092026)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 31
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092026", "story_v_out_416092.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_416092", "416092026", "story_v_out_416092.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_416092", "416092026", "story_v_out_416092.awb")

						arg_107_1:RecordAudio("416092026", var_110_32)
						arg_107_1:RecordAudio("416092026", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416092", "416092026", "story_v_out_416092.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416092", "416092026", "story_v_out_416092.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416092027
		arg_111_1.duration_ = 4.23

		local var_111_0 = {
			zh = 3.766,
			ja = 4.233
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
				arg_111_0:Play416092028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = manager.ui.mainCamera.transform
			local var_114_1 = 0.166666666666667

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_0.localPosition
			end

			local var_114_2 = 0.433333333333333

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / 0.066
				local var_114_4, var_114_5 = math.modf(var_114_3)

				var_114_0.localPosition = Vector3.New(var_114_5 * 0.13, var_114_5 * 0.13, var_114_5 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_6 = 0
			local var_114_7 = 0.225

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[36].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(416092027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 9
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092027", "story_v_out_416092.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092027", "story_v_out_416092.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_416092", "416092027", "story_v_out_416092.awb")

						arg_111_1:RecordAudio("416092027", var_114_15)
						arg_111_1:RecordAudio("416092027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416092", "416092027", "story_v_out_416092.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416092", "416092027", "story_v_out_416092.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416092028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416092028
		arg_115_1.duration_ = 6.43

		local var_115_0 = {
			zh = 6.433,
			ja = 5.266
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
				arg_115_0:Play416092029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1148"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1148 == nil then
				arg_115_1.var_.actorSpriteComps1148 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.125

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps1148 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 1, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1148 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1148 = nil
			end

			local var_118_8 = arg_115_1.actors_["1148"].transform
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 3)

				local var_118_10 = var_118_8.childCount

				for iter_118_4 = 0, var_118_10 - 1 do
					local var_118_11 = var_118_8:GetChild(iter_118_4)

					if var_118_11.name == "split_3" or not string.find(var_118_11.name, "split") then
						var_118_11.gameObject:SetActive(true)
					else
						var_118_11.gameObject:SetActive(false)
					end
				end
			end

			local var_118_12 = 0.001

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_12 then
				local var_118_13 = (arg_115_1.time_ - var_118_9) / var_118_12
				local var_118_14 = Vector3.New(0, -429, -180)

				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, var_118_14, var_118_13)
			end

			if arg_115_1.time_ >= var_118_9 + var_118_12 and arg_115_1.time_ < var_118_9 + var_118_12 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_118_15 = arg_115_1.actors_["10123"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos10123 = var_118_15.localPosition
				var_118_15.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10123", 7)

				local var_118_17 = var_118_15.childCount

				for iter_118_5 = 0, var_118_17 - 1 do
					local var_118_18 = var_118_15:GetChild(iter_118_5)

					if var_118_18.name == "split_6" or not string.find(var_118_18.name, "split") then
						var_118_18.gameObject:SetActive(true)
					else
						var_118_18.gameObject:SetActive(false)
					end
				end
			end

			local var_118_19 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_19 then
				local var_118_20 = (arg_115_1.time_ - var_118_16) / var_118_19
				local var_118_21 = Vector3.New(0, -2000, 0)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10123, var_118_21, var_118_20)
			end

			if arg_115_1.time_ >= var_118_16 + var_118_19 and arg_115_1.time_ < var_118_16 + var_118_19 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_22 = 0
			local var_118_23 = 0.7

			if var_118_22 < arg_115_1.time_ and arg_115_1.time_ <= var_118_22 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_24 = arg_115_1:FormatText(StoryNameCfg[8].name)

				arg_115_1.leftNameTxt_.text = var_118_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_25 = arg_115_1:GetWordFromCfg(416092028)
				local var_118_26 = arg_115_1:FormatText(var_118_25.content)

				arg_115_1.text_.text = var_118_26

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_27 = 28
				local var_118_28 = utf8.len(var_118_26)
				local var_118_29 = var_118_27 <= 0 and var_118_23 or var_118_23 * (var_118_28 / var_118_27)

				if var_118_29 > 0 and var_118_23 < var_118_29 then
					arg_115_1.talkMaxDuration = var_118_29

					if var_118_29 + var_118_22 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_29 + var_118_22
					end
				end

				arg_115_1.text_.text = var_118_26
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092028", "story_v_out_416092.awb") ~= 0 then
					local var_118_30 = manager.audio:GetVoiceLength("story_v_out_416092", "416092028", "story_v_out_416092.awb") / 1000

					if var_118_30 + var_118_22 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_30 + var_118_22
					end

					if var_118_25.prefab_name ~= "" and arg_115_1.actors_[var_118_25.prefab_name] ~= nil then
						local var_118_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_25.prefab_name].transform, "story_v_out_416092", "416092028", "story_v_out_416092.awb")

						arg_115_1:RecordAudio("416092028", var_118_31)
						arg_115_1:RecordAudio("416092028", var_118_31)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416092", "416092028", "story_v_out_416092.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416092", "416092028", "story_v_out_416092.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_32 = math.max(var_118_23, arg_115_1.talkMaxDuration)

			if var_118_22 <= arg_115_1.time_ and arg_115_1.time_ < var_118_22 + var_118_32 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_22) / var_118_32

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_22 + var_118_32 and arg_115_1.time_ < var_118_22 + var_118_32 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416092029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416092029
		arg_119_1.duration_ = 9.43

		local var_119_0 = {
			zh = 8.766,
			ja = 9.433
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
				arg_119_0:Play416092030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10123"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10123 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10123", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_6" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -400, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10123, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_122_7 = arg_119_1.actors_["10123"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10123 == nil then
				arg_119_1.var_.actorSpriteComps10123 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.125

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10123 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 1, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10123 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10123 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 0.575

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[36].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(416092029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 23
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092029", "story_v_out_416092.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092029", "story_v_out_416092.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_416092", "416092029", "story_v_out_416092.awb")

						arg_119_1:RecordAudio("416092029", var_122_24)
						arg_119_1:RecordAudio("416092029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416092", "416092029", "story_v_out_416092.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416092", "416092029", "story_v_out_416092.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416092030
		arg_123_1.duration_ = 5.67

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416092031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = manager.ui.mainCamera.transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				local var_126_2 = arg_123_1.var_.effect0902
				local var_126_3
				local var_126_4 = var_126_0

				if not var_126_2 then
					var_126_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), var_126_4)
					var_126_2.name = "0902"
					arg_123_1.var_.effect0902 = var_126_2
				else
					var_126_2.transform:SetParent(var_126_4)
				end

				var_126_2.transform.localPosition = Vector3.New(0, 0, -0.07)
				var_126_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_126_5 = manager.ui.mainCameraCom_
				local var_126_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_126_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_126_7 = var_126_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_126_8 = 15
				local var_126_9 = 2 * var_126_8 * Mathf.Tan(var_126_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_126_5.aspect
				local var_126_10 = 1
				local var_126_11 = 1.7777777777777777

				if var_126_11 < var_126_5.aspect then
					var_126_10 = var_126_9 / (2 * var_126_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_126_11)
				end

				for iter_126_0, iter_126_1 in ipairs(var_126_7) do
					local var_126_12 = iter_126_1.transform.localScale

					iter_126_1.transform.localScale = Vector3.New(var_126_12.x / var_126_6 * var_126_10, var_126_12.y / var_126_6, var_126_12.z)
				end
			end

			local var_126_13 = manager.ui.mainCamera.transform
			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_13.localPosition
			end

			local var_126_15 = 1

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_15 then
				local var_126_16 = (arg_123_1.time_ - var_126_14) / 0.066
				local var_126_17, var_126_18 = math.modf(var_126_16)

				var_126_13.localPosition = Vector3.New(var_126_18 * 0.13, var_126_18 * 0.13, var_126_18 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= var_126_14 + var_126_15 and arg_123_1.time_ < var_126_14 + var_126_15 + arg_126_0 then
				var_126_13.localPosition = arg_123_1.var_.shakeOldPos
			end

			local var_126_19 = 0

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = false

				arg_123_1:SetGaussion(false)
			end

			local var_126_20 = 0.5

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_20 then
				local var_126_21 = (arg_123_1.time_ - var_126_19) / var_126_20
				local var_126_22 = Color.New(1, 1, 1)

				var_126_22.a = Mathf.Lerp(1, 0, var_126_21)
				arg_123_1.mask_.color = var_126_22
			end

			if arg_123_1.time_ >= var_126_19 + var_126_20 and arg_123_1.time_ < var_126_19 + var_126_20 + arg_126_0 then
				local var_126_23 = Color.New(1, 1, 1)
				local var_126_24 = 0

				arg_123_1.mask_.enabled = false
				var_126_23.a = var_126_24
				arg_123_1.mask_.color = var_126_23
			end

			local var_126_25 = 0
			local var_126_26 = 1

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 then
				local var_126_27 = "play"
				local var_126_28 = "effect"

				arg_123_1:AudioAction(var_126_27, var_126_28, "se_story_120_00", "se_story_120_00_lingguang02", "")
			end

			local var_126_29 = arg_123_1.actors_["10123"].transform
			local var_126_30 = 0

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.var_.moveOldPos10123 = var_126_29.localPosition
				var_126_29.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10123", 7)

				local var_126_31 = var_126_29.childCount

				for iter_126_2 = 0, var_126_31 - 1 do
					local var_126_32 = var_126_29:GetChild(iter_126_2)

					if var_126_32.name == "split_6" or not string.find(var_126_32.name, "split") then
						var_126_32.gameObject:SetActive(true)
					else
						var_126_32.gameObject:SetActive(false)
					end
				end
			end

			local var_126_33 = 0.001

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_33 then
				local var_126_34 = (arg_123_1.time_ - var_126_30) / var_126_33
				local var_126_35 = Vector3.New(0, -2000, 0)

				var_126_29.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10123, var_126_35, var_126_34)
			end

			if arg_123_1.time_ >= var_126_30 + var_126_33 and arg_123_1.time_ < var_126_30 + var_126_33 + arg_126_0 then
				var_126_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_36 = 0.666666666666667
			local var_126_37 = 1.2

			if var_126_36 < arg_123_1.time_ and arg_123_1.time_ <= var_126_36 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_38 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_38:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_39 = arg_123_1:GetWordFromCfg(416092030)
				local var_126_40 = arg_123_1:FormatText(var_126_39.content)

				arg_123_1.text_.text = var_126_40

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_41 = 48
				local var_126_42 = utf8.len(var_126_40)
				local var_126_43 = var_126_41 <= 0 and var_126_37 or var_126_37 * (var_126_42 / var_126_41)

				if var_126_43 > 0 and var_126_37 < var_126_43 then
					arg_123_1.talkMaxDuration = var_126_43
					var_126_36 = var_126_36 + 0.3

					if var_126_43 + var_126_36 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_43 + var_126_36
					end
				end

				arg_123_1.text_.text = var_126_40
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_44 = var_126_36 + 0.3
			local var_126_45 = math.max(var_126_37, arg_123_1.talkMaxDuration)

			if var_126_44 <= arg_123_1.time_ and arg_123_1.time_ < var_126_44 + var_126_45 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_44) / var_126_45

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_44 + var_126_45 and arg_123_1.time_ < var_126_44 + var_126_45 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416092031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416092032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.433333333333333
			local var_132_1 = 1

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				local var_132_2 = "play"
				local var_132_3 = "effect"

				arg_129_1:AudioAction(var_132_2, var_132_3, "se_story_17", "se_story_17_fireblast", "")
			end

			local var_132_4 = 1.23333333333333
			local var_132_5 = 0.566666666666667

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				local var_132_6 = "play"
				local var_132_7 = "effect"

				arg_129_1:AudioAction(var_132_6, var_132_7, "se_story_128", "se_story_128_break", "")
			end

			local var_132_8 = 0
			local var_132_9 = 1.8

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(416092031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 72
				local var_132_13 = utf8.len(var_132_11)
				local var_132_14 = var_132_12 <= 0 and var_132_9 or var_132_9 * (var_132_13 / var_132_12)

				if var_132_14 > 0 and var_132_9 < var_132_14 then
					arg_129_1.talkMaxDuration = var_132_14

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_15 and arg_129_1.time_ < var_132_8 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416092032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416092032
		arg_133_1.duration_ = 5.07

		local var_133_0 = {
			zh = 5.066,
			ja = 3.433
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
				arg_133_0:Play416092033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1148"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1148 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1148", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_5" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(0, -429, -180)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1148, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_136_7 = arg_133_1.actors_["1148"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1148 == nil then
				arg_133_1.var_.actorSpriteComps1148 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 0.125

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps1148 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								local var_136_11 = Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, var_136_10)
								local var_136_12 = Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, var_136_10)
								local var_136_13 = Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, var_136_10)

								iter_136_2.color = Color.New(var_136_11, var_136_12, var_136_13)
							else
								local var_136_14 = Mathf.Lerp(iter_136_2.color.r, 1, var_136_10)

								iter_136_2.color = Color.New(var_136_14, var_136_14, var_136_14)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1148 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1148 = nil
			end

			local var_136_15 = 0
			local var_136_16 = 0.35

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[8].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(416092032)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 14
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092032", "story_v_out_416092.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092032", "story_v_out_416092.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_416092", "416092032", "story_v_out_416092.awb")

						arg_133_1:RecordAudio("416092032", var_136_24)
						arg_133_1:RecordAudio("416092032", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416092", "416092032", "story_v_out_416092.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416092", "416092032", "story_v_out_416092.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play416092033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416092033
		arg_137_1.duration_ = 6.93

		local var_137_0 = {
			zh = 6.3,
			ja = 6.933
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
				arg_137_0:Play416092034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1148"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 7)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -2000, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_7 = arg_137_1.actors_["10123"].transform
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.var_.moveOldPos10123 = var_140_7.localPosition
				var_140_7.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10123", 3)

				local var_140_9 = var_140_7.childCount

				for iter_140_1 = 0, var_140_9 - 1 do
					local var_140_10 = var_140_7:GetChild(iter_140_1)

					if var_140_10.name == "split_6" or not string.find(var_140_10.name, "split") then
						var_140_10.gameObject:SetActive(true)
					else
						var_140_10.gameObject:SetActive(false)
					end
				end
			end

			local var_140_11 = 0.001

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_8) / var_140_11
				local var_140_13 = Vector3.New(0, -400, 0)

				var_140_7.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10123, var_140_13, var_140_12)
			end

			if arg_137_1.time_ >= var_140_8 + var_140_11 and arg_137_1.time_ < var_140_8 + var_140_11 + arg_140_0 then
				var_140_7.localPosition = Vector3.New(0, -400, 0)
			end

			local var_140_14 = arg_137_1.actors_["10123"]
			local var_140_15 = 0

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.actorSpriteComps10123 == nil then
				arg_137_1.var_.actorSpriteComps10123 = var_140_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_16 = 0.125

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_16 and not isNil(var_140_14) then
				local var_140_17 = (arg_137_1.time_ - var_140_15) / var_140_16

				if arg_137_1.var_.actorSpriteComps10123 then
					for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_140_3 then
							if arg_137_1.isInRecall_ then
								local var_140_18 = Mathf.Lerp(iter_140_3.color.r, arg_137_1.hightColor1.r, var_140_17)
								local var_140_19 = Mathf.Lerp(iter_140_3.color.g, arg_137_1.hightColor1.g, var_140_17)
								local var_140_20 = Mathf.Lerp(iter_140_3.color.b, arg_137_1.hightColor1.b, var_140_17)

								iter_140_3.color = Color.New(var_140_18, var_140_19, var_140_20)
							else
								local var_140_21 = Mathf.Lerp(iter_140_3.color.r, 1, var_140_17)

								iter_140_3.color = Color.New(var_140_21, var_140_21, var_140_21)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_15 + var_140_16 and arg_137_1.time_ < var_140_15 + var_140_16 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.actorSpriteComps10123 then
				for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_140_5 then
						if arg_137_1.isInRecall_ then
							iter_140_5.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10123 = nil
			end

			local var_140_22 = 0
			local var_140_23 = 0.5

			if var_140_22 < arg_137_1.time_ and arg_137_1.time_ <= var_140_22 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_24 = arg_137_1:FormatText(StoryNameCfg[36].name)

				arg_137_1.leftNameTxt_.text = var_140_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_25 = arg_137_1:GetWordFromCfg(416092033)
				local var_140_26 = arg_137_1:FormatText(var_140_25.content)

				arg_137_1.text_.text = var_140_26

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_27 = 20
				local var_140_28 = utf8.len(var_140_26)
				local var_140_29 = var_140_27 <= 0 and var_140_23 or var_140_23 * (var_140_28 / var_140_27)

				if var_140_29 > 0 and var_140_23 < var_140_29 then
					arg_137_1.talkMaxDuration = var_140_29

					if var_140_29 + var_140_22 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_29 + var_140_22
					end
				end

				arg_137_1.text_.text = var_140_26
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092033", "story_v_out_416092.awb") ~= 0 then
					local var_140_30 = manager.audio:GetVoiceLength("story_v_out_416092", "416092033", "story_v_out_416092.awb") / 1000

					if var_140_30 + var_140_22 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_30 + var_140_22
					end

					if var_140_25.prefab_name ~= "" and arg_137_1.actors_[var_140_25.prefab_name] ~= nil then
						local var_140_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_25.prefab_name].transform, "story_v_out_416092", "416092033", "story_v_out_416092.awb")

						arg_137_1:RecordAudio("416092033", var_140_31)
						arg_137_1:RecordAudio("416092033", var_140_31)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416092", "416092033", "story_v_out_416092.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416092", "416092033", "story_v_out_416092.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_32 = math.max(var_140_23, arg_137_1.talkMaxDuration)

			if var_140_22 <= arg_137_1.time_ and arg_137_1.time_ < var_140_22 + var_140_32 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_22) / var_140_32

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_22 + var_140_32 and arg_137_1.time_ < var_140_22 + var_140_32 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416092034
		arg_141_1.duration_ = 3.57

		local var_141_0 = {
			zh = 2.133,
			ja = 3.566
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
				arg_141_0:Play416092035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "10108"

			if arg_141_1.actors_[var_144_0] == nil then
				local var_144_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_144_1) then
					local var_144_2 = Object.Instantiate(var_144_1, arg_141_1.canvasGo_.transform)

					var_144_2.transform:SetSiblingIndex(1)

					var_144_2.name = var_144_0
					var_144_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_141_1.actors_[var_144_0] = var_144_2

					local var_144_3 = var_144_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_141_1.isInRecall_ then
						for iter_144_0, iter_144_1 in ipairs(var_144_3) do
							iter_144_1.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_144_4 = arg_141_1.actors_["10108"].transform
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.var_.moveOldPos10108 = var_144_4.localPosition
				var_144_4.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10108", 4)

				local var_144_6 = var_144_4.childCount

				for iter_144_2 = 0, var_144_6 - 1 do
					local var_144_7 = var_144_4:GetChild(iter_144_2)

					if var_144_7.name == "split_3" or not string.find(var_144_7.name, "split") then
						var_144_7.gameObject:SetActive(true)
					else
						var_144_7.gameObject:SetActive(false)
					end
				end
			end

			local var_144_8 = 0.001

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_8 then
				local var_144_9 = (arg_141_1.time_ - var_144_5) / var_144_8
				local var_144_10 = Vector3.New(390, -399.6, -130)

				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10108, var_144_10, var_144_9)
			end

			if arg_141_1.time_ >= var_144_5 + var_144_8 and arg_141_1.time_ < var_144_5 + var_144_8 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_144_11 = arg_141_1.actors_["10108"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10108 == nil then
				arg_141_1.var_.actorSpriteComps10108 = var_144_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_13 = 0.125

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.actorSpriteComps10108 then
					for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_144_4 then
							if arg_141_1.isInRecall_ then
								local var_144_15 = Mathf.Lerp(iter_144_4.color.r, arg_141_1.hightColor1.r, var_144_14)
								local var_144_16 = Mathf.Lerp(iter_144_4.color.g, arg_141_1.hightColor1.g, var_144_14)
								local var_144_17 = Mathf.Lerp(iter_144_4.color.b, arg_141_1.hightColor1.b, var_144_14)

								iter_144_4.color = Color.New(var_144_15, var_144_16, var_144_17)
							else
								local var_144_18 = Mathf.Lerp(iter_144_4.color.r, 1, var_144_14)

								iter_144_4.color = Color.New(var_144_18, var_144_18, var_144_18)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10108 then
				for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_144_6 then
						if arg_141_1.isInRecall_ then
							iter_144_6.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10108 = nil
			end

			local var_144_19 = arg_141_1.actors_["10123"].transform
			local var_144_20 = 0

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.var_.moveOldPos10123 = var_144_19.localPosition
				var_144_19.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10123", 2)

				local var_144_21 = var_144_19.childCount

				for iter_144_7 = 0, var_144_21 - 1 do
					local var_144_22 = var_144_19:GetChild(iter_144_7)

					if var_144_22.name == "split_6" or not string.find(var_144_22.name, "split") then
						var_144_22.gameObject:SetActive(true)
					else
						var_144_22.gameObject:SetActive(false)
					end
				end
			end

			local var_144_23 = 0.001

			if var_144_20 <= arg_141_1.time_ and arg_141_1.time_ < var_144_20 + var_144_23 then
				local var_144_24 = (arg_141_1.time_ - var_144_20) / var_144_23
				local var_144_25 = Vector3.New(-390, -400, 0)

				var_144_19.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10123, var_144_25, var_144_24)
			end

			if arg_141_1.time_ >= var_144_20 + var_144_23 and arg_141_1.time_ < var_144_20 + var_144_23 + arg_144_0 then
				var_144_19.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_144_26 = arg_141_1.actors_["10123"]
			local var_144_27 = 0

			if var_144_27 < arg_141_1.time_ and arg_141_1.time_ <= var_144_27 + arg_144_0 and not isNil(var_144_26) and arg_141_1.var_.actorSpriteComps10123 == nil then
				arg_141_1.var_.actorSpriteComps10123 = var_144_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_28 = 0.125

			if var_144_27 <= arg_141_1.time_ and arg_141_1.time_ < var_144_27 + var_144_28 and not isNil(var_144_26) then
				local var_144_29 = (arg_141_1.time_ - var_144_27) / var_144_28

				if arg_141_1.var_.actorSpriteComps10123 then
					for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_144_9 then
							if arg_141_1.isInRecall_ then
								local var_144_30 = Mathf.Lerp(iter_144_9.color.r, arg_141_1.hightColor2.r, var_144_29)
								local var_144_31 = Mathf.Lerp(iter_144_9.color.g, arg_141_1.hightColor2.g, var_144_29)
								local var_144_32 = Mathf.Lerp(iter_144_9.color.b, arg_141_1.hightColor2.b, var_144_29)

								iter_144_9.color = Color.New(var_144_30, var_144_31, var_144_32)
							else
								local var_144_33 = Mathf.Lerp(iter_144_9.color.r, 0.5, var_144_29)

								iter_144_9.color = Color.New(var_144_33, var_144_33, var_144_33)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_27 + var_144_28 and arg_141_1.time_ < var_144_27 + var_144_28 + arg_144_0 and not isNil(var_144_26) and arg_141_1.var_.actorSpriteComps10123 then
				for iter_144_10, iter_144_11 in pairs(arg_141_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_144_11 then
						if arg_141_1.isInRecall_ then
							iter_144_11.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10123 = nil
			end

			local var_144_34 = 0
			local var_144_35 = 0.175

			if var_144_34 < arg_141_1.time_ and arg_141_1.time_ <= var_144_34 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_36 = arg_141_1:FormatText(StoryNameCfg[1083].name)

				arg_141_1.leftNameTxt_.text = var_144_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_37 = arg_141_1:GetWordFromCfg(416092034)
				local var_144_38 = arg_141_1:FormatText(var_144_37.content)

				arg_141_1.text_.text = var_144_38

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_39 = 7
				local var_144_40 = utf8.len(var_144_38)
				local var_144_41 = var_144_39 <= 0 and var_144_35 or var_144_35 * (var_144_40 / var_144_39)

				if var_144_41 > 0 and var_144_35 < var_144_41 then
					arg_141_1.talkMaxDuration = var_144_41

					if var_144_41 + var_144_34 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_41 + var_144_34
					end
				end

				arg_141_1.text_.text = var_144_38
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092034", "story_v_out_416092.awb") ~= 0 then
					local var_144_42 = manager.audio:GetVoiceLength("story_v_out_416092", "416092034", "story_v_out_416092.awb") / 1000

					if var_144_42 + var_144_34 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_42 + var_144_34
					end

					if var_144_37.prefab_name ~= "" and arg_141_1.actors_[var_144_37.prefab_name] ~= nil then
						local var_144_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_37.prefab_name].transform, "story_v_out_416092", "416092034", "story_v_out_416092.awb")

						arg_141_1:RecordAudio("416092034", var_144_43)
						arg_141_1:RecordAudio("416092034", var_144_43)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416092", "416092034", "story_v_out_416092.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416092", "416092034", "story_v_out_416092.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_44 = math.max(var_144_35, arg_141_1.talkMaxDuration)

			if var_144_34 <= arg_141_1.time_ and arg_141_1.time_ < var_144_34 + var_144_44 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_34) / var_144_44

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_34 + var_144_44 and arg_141_1.time_ < var_144_34 + var_144_44 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416092035
		arg_145_1.duration_ = 5.67

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play416092036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10108"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10108 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10108", 7)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -2000, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10108, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_7 = manager.ui.mainCamera.transform
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				local var_148_9 = arg_145_1.var_.effect0903
				local var_148_10
				local var_148_11 = var_148_7

				if not var_148_9 then
					var_148_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_148_11)
					var_148_9.name = "0903"
					arg_145_1.var_.effect0903 = var_148_9
				else
					var_148_9.transform:SetParent(var_148_11)
				end

				var_148_9.transform.localPosition = Vector3.New(-0.74, 0, 13.33)
				var_148_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_148_12 = manager.ui.mainCamera.transform
			local var_148_13 = 0.666666666666667

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				local var_148_14 = arg_145_1.var_.effect0903

				if var_148_14 then
					Object.Destroy(var_148_14)

					arg_145_1.var_.effect0903 = nil
				end
			end

			local var_148_15 = manager.ui.mainCamera.transform
			local var_148_16 = 0.0666666666666667

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				local var_148_17 = arg_145_1.var_.effect0904
				local var_148_18
				local var_148_19 = var_148_15

				if not var_148_17 then
					var_148_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_148_19)
					var_148_17.name = "0904"
					arg_145_1.var_.effect0904 = var_148_17
				else
					var_148_17.transform:SetParent(var_148_19)
				end

				var_148_17.transform.localPosition = Vector3.New(0.9, 0.5, 11)
				var_148_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_148_20 = manager.ui.mainCamera.transform
			local var_148_21 = 0.666666666666667

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				local var_148_22 = arg_145_1.var_.effect0904

				if var_148_22 then
					Object.Destroy(var_148_22)

					arg_145_1.var_.effect0904 = nil
				end
			end

			local var_148_23 = manager.ui.mainCamera.transform
			local var_148_24 = 0.166666666666667

			if var_148_24 < arg_145_1.time_ and arg_145_1.time_ <= var_148_24 + arg_148_0 then
				local var_148_25 = arg_145_1.var_.effect0905
				local var_148_26
				local var_148_27 = var_148_23

				if not var_148_25 then
					var_148_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_148_27)
					var_148_25.name = "0905"
					arg_145_1.var_.effect0905 = var_148_25
				else
					var_148_25.transform:SetParent(var_148_27)
				end

				var_148_25.transform.localPosition = Vector3.New(1.79, -1.12, 10)
				var_148_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_148_28 = manager.ui.mainCamera.transform
			local var_148_29 = 0.666666666666667

			if var_148_29 < arg_145_1.time_ and arg_145_1.time_ <= var_148_29 + arg_148_0 then
				local var_148_30 = arg_145_1.var_.effect0905

				if var_148_30 then
					Object.Destroy(var_148_30)

					arg_145_1.var_.effect0905 = nil
				end
			end

			local var_148_31 = manager.ui.mainCamera.transform
			local var_148_32 = 0

			if var_148_32 < arg_145_1.time_ and arg_145_1.time_ <= var_148_32 + arg_148_0 then
				arg_145_1.var_.shakeOldPos = var_148_31.localPosition
			end

			local var_148_33 = 0.463629866872604

			if var_148_32 <= arg_145_1.time_ and arg_145_1.time_ < var_148_32 + var_148_33 then
				local var_148_34 = (arg_145_1.time_ - var_148_32) / 0.066
				local var_148_35, var_148_36 = math.modf(var_148_34)

				var_148_31.localPosition = Vector3.New(var_148_36 * 0.13, var_148_36 * 0.13, var_148_36 * 0.13) + arg_145_1.var_.shakeOldPos
			end

			if arg_145_1.time_ >= var_148_32 + var_148_33 and arg_145_1.time_ < var_148_32 + var_148_33 + arg_148_0 then
				var_148_31.localPosition = arg_145_1.var_.shakeOldPos
			end

			local var_148_37 = arg_145_1.actors_["10123"].transform
			local var_148_38 = 0

			if var_148_38 < arg_145_1.time_ and arg_145_1.time_ <= var_148_38 + arg_148_0 then
				arg_145_1.var_.moveOldPos10123 = var_148_37.localPosition
				var_148_37.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10123", 7)

				local var_148_39 = var_148_37.childCount

				for iter_148_1 = 0, var_148_39 - 1 do
					local var_148_40 = var_148_37:GetChild(iter_148_1)

					if var_148_40.name == "split_6" or not string.find(var_148_40.name, "split") then
						var_148_40.gameObject:SetActive(true)
					else
						var_148_40.gameObject:SetActive(false)
					end
				end
			end

			local var_148_41 = 0.001

			if var_148_38 <= arg_145_1.time_ and arg_145_1.time_ < var_148_38 + var_148_41 then
				local var_148_42 = (arg_145_1.time_ - var_148_38) / var_148_41
				local var_148_43 = Vector3.New(0, -2000, 0)

				var_148_37.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10123, var_148_43, var_148_42)
			end

			if arg_145_1.time_ >= var_148_38 + var_148_41 and arg_145_1.time_ < var_148_38 + var_148_41 + arg_148_0 then
				var_148_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_44 = 0
			local var_148_45 = 1

			if var_148_44 < arg_145_1.time_ and arg_145_1.time_ <= var_148_44 + arg_148_0 then
				local var_148_46 = "play"
				local var_148_47 = "effect"

				arg_145_1:AudioAction(var_148_46, var_148_47, "se_story_side_1033", "se_story_1033_gun", "")
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_48 = 0.666666666666667
			local var_148_49 = 1.25

			if var_148_48 < arg_145_1.time_ and arg_145_1.time_ <= var_148_48 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_50 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_50:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_51 = arg_145_1:GetWordFromCfg(416092035)
				local var_148_52 = arg_145_1:FormatText(var_148_51.content)

				arg_145_1.text_.text = var_148_52

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_53 = 50
				local var_148_54 = utf8.len(var_148_52)
				local var_148_55 = var_148_53 <= 0 and var_148_49 or var_148_49 * (var_148_54 / var_148_53)

				if var_148_55 > 0 and var_148_49 < var_148_55 then
					arg_145_1.talkMaxDuration = var_148_55
					var_148_48 = var_148_48 + 0.3

					if var_148_55 + var_148_48 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_55 + var_148_48
					end
				end

				arg_145_1.text_.text = var_148_52
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_56 = var_148_48 + 0.3
			local var_148_57 = math.max(var_148_49, arg_145_1.talkMaxDuration)

			if var_148_56 <= arg_145_1.time_ and arg_145_1.time_ < var_148_56 + var_148_57 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_56) / var_148_57

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_56 + var_148_57 and arg_145_1.time_ < var_148_56 + var_148_57 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416092036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play416092037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.3

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(416092036)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 52
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play416092037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416092037
		arg_155_1.duration_ = 8.93

		local var_155_0 = {
			zh = 6.566,
			ja = 8.933
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play416092038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10123"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10123 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10123", 3)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_6" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(0, -400, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10123, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_158_7 = arg_155_1.actors_["10123"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10123 == nil then
				arg_155_1.var_.actorSpriteComps10123 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.125

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10123 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10123 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10123 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 1

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				local var_158_17 = "play"
				local var_158_18 = "effect"

				arg_155_1:AudioAction(var_158_17, var_158_18, "se_story_138", "se_story_138_footstep", "")
			end

			local var_158_19 = 0
			local var_158_20 = 0.5

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_21 = arg_155_1:FormatText(StoryNameCfg[36].name)

				arg_155_1.leftNameTxt_.text = var_158_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_22 = arg_155_1:GetWordFromCfg(416092037)
				local var_158_23 = arg_155_1:FormatText(var_158_22.content)

				arg_155_1.text_.text = var_158_23

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_24 = 20
				local var_158_25 = utf8.len(var_158_23)
				local var_158_26 = var_158_24 <= 0 and var_158_20 or var_158_20 * (var_158_25 / var_158_24)

				if var_158_26 > 0 and var_158_20 < var_158_26 then
					arg_155_1.talkMaxDuration = var_158_26

					if var_158_26 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_26 + var_158_19
					end
				end

				arg_155_1.text_.text = var_158_23
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092037", "story_v_out_416092.awb") ~= 0 then
					local var_158_27 = manager.audio:GetVoiceLength("story_v_out_416092", "416092037", "story_v_out_416092.awb") / 1000

					if var_158_27 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_27 + var_158_19
					end

					if var_158_22.prefab_name ~= "" and arg_155_1.actors_[var_158_22.prefab_name] ~= nil then
						local var_158_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_22.prefab_name].transform, "story_v_out_416092", "416092037", "story_v_out_416092.awb")

						arg_155_1:RecordAudio("416092037", var_158_28)
						arg_155_1:RecordAudio("416092037", var_158_28)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416092", "416092037", "story_v_out_416092.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416092", "416092037", "story_v_out_416092.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_29 = math.max(var_158_20, arg_155_1.talkMaxDuration)

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_29 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_19) / var_158_29

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_19 + var_158_29 and arg_155_1.time_ < var_158_19 + var_158_29 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play416092038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416092038
		arg_159_1.duration_ = 6.03

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play416092039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.03333333333333

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			local var_162_1 = 0.3

			if arg_159_1.time_ >= var_162_0 + var_162_1 and arg_159_1.time_ < var_162_0 + var_162_1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_2 = "STwhite"

			if arg_159_1.bgs_[var_162_2] == nil then
				local var_162_3 = Object.Instantiate(arg_159_1.paintGo_)

				var_162_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_162_2)
				var_162_3.name = var_162_2
				var_162_3.transform.parent = arg_159_1.stage_.transform
				var_162_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.bgs_[var_162_2] = var_162_3
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				local var_162_5 = manager.ui.mainCamera.transform.localPosition
				local var_162_6 = Vector3.New(0, 0, 10) + Vector3.New(var_162_5.x, var_162_5.y, 0)
				local var_162_7 = arg_159_1.bgs_.STwhite

				var_162_7.transform.localPosition = var_162_6
				var_162_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_8 = var_162_7:GetComponent("SpriteRenderer")

				if var_162_8 and var_162_8.sprite then
					local var_162_9 = (var_162_7.transform.localPosition - var_162_5).z
					local var_162_10 = manager.ui.mainCameraCom_
					local var_162_11 = 2 * var_162_9 * Mathf.Tan(var_162_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_162_12 = var_162_11 * var_162_10.aspect
					local var_162_13 = var_162_8.sprite.bounds.size.x
					local var_162_14 = var_162_8.sprite.bounds.size.y
					local var_162_15 = var_162_12 / var_162_13
					local var_162_16 = var_162_11 / var_162_14
					local var_162_17 = var_162_16 < var_162_15 and var_162_15 or var_162_16

					var_162_7.transform.localScale = Vector3.New(var_162_17, var_162_17, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "STwhite" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_18 = 0

			if var_162_18 < arg_159_1.time_ and arg_159_1.time_ <= var_162_18 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_19 = 1.03333333333333

			if var_162_18 <= arg_159_1.time_ and arg_159_1.time_ < var_162_18 + var_162_19 then
				local var_162_20 = (arg_159_1.time_ - var_162_18) / var_162_19
				local var_162_21 = Color.New(0, 0, 0)

				var_162_21.a = Mathf.Lerp(1, 0, var_162_20)
				arg_159_1.mask_.color = var_162_21
			end

			if arg_159_1.time_ >= var_162_18 + var_162_19 and arg_159_1.time_ < var_162_18 + var_162_19 + arg_162_0 then
				local var_162_22 = Color.New(0, 0, 0)
				local var_162_23 = 0

				arg_159_1.mask_.enabled = false
				var_162_22.a = var_162_23
				arg_159_1.mask_.color = var_162_22
			end

			local var_162_24 = manager.ui.mainCamera.transform
			local var_162_25 = 0

			if var_162_25 < arg_159_1.time_ and arg_159_1.time_ <= var_162_25 + arg_162_0 then
				local var_162_26 = arg_159_1.var_.effect0902

				if var_162_26 then
					Object.Destroy(var_162_26)

					arg_159_1.var_.effect0902 = nil
				end
			end

			local var_162_27 = 1.46666666666667
			local var_162_28 = 1

			if var_162_27 < arg_159_1.time_ and arg_159_1.time_ <= var_162_27 + arg_162_0 then
				local var_162_29 = "play"
				local var_162_30 = "effect"

				arg_159_1:AudioAction(var_162_29, var_162_30, "se_story_120_04", "se_story_120_04_1076_aoe", "")
			end

			local var_162_31 = arg_159_1.actors_["10123"].transform
			local var_162_32 = 0

			if var_162_32 < arg_159_1.time_ and arg_159_1.time_ <= var_162_32 + arg_162_0 then
				arg_159_1.var_.moveOldPos10123 = var_162_31.localPosition
				var_162_31.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10123", 7)

				local var_162_33 = var_162_31.childCount

				for iter_162_2 = 0, var_162_33 - 1 do
					local var_162_34 = var_162_31:GetChild(iter_162_2)

					if var_162_34.name == "split_6" or not string.find(var_162_34.name, "split") then
						var_162_34.gameObject:SetActive(true)
					else
						var_162_34.gameObject:SetActive(false)
					end
				end
			end

			local var_162_35 = 0.001

			if var_162_32 <= arg_159_1.time_ and arg_159_1.time_ < var_162_32 + var_162_35 then
				local var_162_36 = (arg_159_1.time_ - var_162_32) / var_162_35
				local var_162_37 = Vector3.New(0, -2000, 0)

				var_162_31.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10123, var_162_37, var_162_36)
			end

			if arg_159_1.time_ >= var_162_32 + var_162_35 and arg_159_1.time_ < var_162_32 + var_162_35 + arg_162_0 then
				var_162_31.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_38 = 1.03333333333333
			local var_162_39 = 1.85

			if var_162_38 < arg_159_1.time_ and arg_159_1.time_ <= var_162_38 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_40 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_40:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_41 = arg_159_1:GetWordFromCfg(416092038)
				local var_162_42 = arg_159_1:FormatText(var_162_41.content)

				arg_159_1.text_.text = var_162_42

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_43 = 74
				local var_162_44 = utf8.len(var_162_42)
				local var_162_45 = var_162_43 <= 0 and var_162_39 or var_162_39 * (var_162_44 / var_162_43)

				if var_162_45 > 0 and var_162_39 < var_162_45 then
					arg_159_1.talkMaxDuration = var_162_45
					var_162_38 = var_162_38 + 0.3

					if var_162_45 + var_162_38 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_45 + var_162_38
					end
				end

				arg_159_1.text_.text = var_162_42
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_46 = var_162_38 + 0.3
			local var_162_47 = math.max(var_162_39, arg_159_1.talkMaxDuration)

			if var_162_46 <= arg_159_1.time_ and arg_159_1.time_ < var_162_46 + var_162_47 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_46) / var_162_47

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_46 + var_162_47 and arg_159_1.time_ < var_162_46 + var_162_47 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play416092039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416092039
		arg_165_1.duration_ = 2.67

		local var_165_0 = {
			zh = 0.999999999999,
			ja = 2.666
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
				arg_165_0:Play416092040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.125

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1083].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10108_split_3")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(416092039)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 5
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092039", "story_v_out_416092.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092039", "story_v_out_416092.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_416092", "416092039", "story_v_out_416092.awb")

						arg_165_1:RecordAudio("416092039", var_168_9)
						arg_165_1:RecordAudio("416092039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416092", "416092039", "story_v_out_416092.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416092", "416092039", "story_v_out_416092.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416092040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416092040
		arg_169_1.duration_ = 3.8

		local var_169_0 = {
			zh = 2.7,
			ja = 3.8
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
				arg_169_0:Play416092041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.275

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[8].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(416092040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 11
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092040", "story_v_out_416092.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092040", "story_v_out_416092.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_416092", "416092040", "story_v_out_416092.awb")

						arg_169_1:RecordAudio("416092040", var_172_9)
						arg_169_1:RecordAudio("416092040", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416092", "416092040", "story_v_out_416092.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416092", "416092040", "story_v_out_416092.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416092041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416092041
		arg_173_1.duration_ = 9

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416092042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 4

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_1 = 0.3

			if arg_173_1.time_ >= var_176_0 + var_176_1 and arg_173_1.time_ < var_176_0 + var_176_1 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			local var_176_2 = 2

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				local var_176_3 = manager.ui.mainCamera.transform.localPosition
				local var_176_4 = Vector3.New(0, 0, 10) + Vector3.New(var_176_3.x, var_176_3.y, 0)
				local var_176_5 = arg_173_1.bgs_.I14f

				var_176_5.transform.localPosition = var_176_4
				var_176_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_6 = var_176_5:GetComponent("SpriteRenderer")

				if var_176_6 and var_176_6.sprite then
					local var_176_7 = (var_176_5.transform.localPosition - var_176_3).z
					local var_176_8 = manager.ui.mainCameraCom_
					local var_176_9 = 2 * var_176_7 * Mathf.Tan(var_176_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_176_10 = var_176_9 * var_176_8.aspect
					local var_176_11 = var_176_6.sprite.bounds.size.x
					local var_176_12 = var_176_6.sprite.bounds.size.y
					local var_176_13 = var_176_10 / var_176_11
					local var_176_14 = var_176_9 / var_176_12
					local var_176_15 = var_176_14 < var_176_13 and var_176_13 or var_176_14

					var_176_5.transform.localScale = Vector3.New(var_176_15, var_176_15, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "I14f" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_17 = 2

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17
				local var_176_19 = Color.New(0, 0, 0)

				var_176_19.a = Mathf.Lerp(0, 1, var_176_18)
				arg_173_1.mask_.color = var_176_19
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 then
				local var_176_20 = Color.New(0, 0, 0)

				var_176_20.a = 1
				arg_173_1.mask_.color = var_176_20
			end

			local var_176_21 = 2

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_22 = 2

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 then
				local var_176_23 = (arg_173_1.time_ - var_176_21) / var_176_22
				local var_176_24 = Color.New(0, 0, 0)

				var_176_24.a = Mathf.Lerp(1, 0, var_176_23)
				arg_173_1.mask_.color = var_176_24
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 then
				local var_176_25 = Color.New(0, 0, 0)
				local var_176_26 = 0

				arg_173_1.mask_.enabled = false
				var_176_25.a = var_176_26
				arg_173_1.mask_.color = var_176_25
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_27 = 4
			local var_176_28 = 1.825

			if var_176_27 < arg_173_1.time_ and arg_173_1.time_ <= var_176_27 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_29 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_29:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_30 = arg_173_1:GetWordFromCfg(416092041)
				local var_176_31 = arg_173_1:FormatText(var_176_30.content)

				arg_173_1.text_.text = var_176_31

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_32 = 73
				local var_176_33 = utf8.len(var_176_31)
				local var_176_34 = var_176_32 <= 0 and var_176_28 or var_176_28 * (var_176_33 / var_176_32)

				if var_176_34 > 0 and var_176_28 < var_176_34 then
					arg_173_1.talkMaxDuration = var_176_34
					var_176_27 = var_176_27 + 0.3

					if var_176_34 + var_176_27 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_34 + var_176_27
					end
				end

				arg_173_1.text_.text = var_176_31
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_35 = var_176_27 + 0.3
			local var_176_36 = math.max(var_176_28, arg_173_1.talkMaxDuration)

			if var_176_35 <= arg_173_1.time_ and arg_173_1.time_ < var_176_35 + var_176_36 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_35) / var_176_36

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_35 + var_176_36 and arg_173_1.time_ < var_176_35 + var_176_36 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416092042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416092042
		arg_179_1.duration_ = 2.93

		local var_179_0 = {
			zh = 2.033,
			ja = 2.933
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
				arg_179_0:Play416092043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = "10096"

			if arg_179_1.actors_[var_182_0] == nil then
				local var_182_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_182_1) then
					local var_182_2 = Object.Instantiate(var_182_1, arg_179_1.canvasGo_.transform)

					var_182_2.transform:SetSiblingIndex(1)

					var_182_2.name = var_182_0
					var_182_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_179_1.actors_[var_182_0] = var_182_2

					local var_182_3 = var_182_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_179_1.isInRecall_ then
						for iter_182_0, iter_182_1 in ipairs(var_182_3) do
							iter_182_1.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_182_4 = arg_179_1.actors_["10096"].transform
			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.var_.moveOldPos10096 = var_182_4.localPosition
				var_182_4.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10096", 3)

				local var_182_6 = var_182_4.childCount

				for iter_182_2 = 0, var_182_6 - 1 do
					local var_182_7 = var_182_4:GetChild(iter_182_2)

					if var_182_7.name == "" or not string.find(var_182_7.name, "split") then
						var_182_7.gameObject:SetActive(true)
					else
						var_182_7.gameObject:SetActive(false)
					end
				end
			end

			local var_182_8 = 0.001

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_8 then
				local var_182_9 = (arg_179_1.time_ - var_182_5) / var_182_8
				local var_182_10 = Vector3.New(0, -350, -210)

				var_182_4.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10096, var_182_10, var_182_9)
			end

			if arg_179_1.time_ >= var_182_5 + var_182_8 and arg_179_1.time_ < var_182_5 + var_182_8 + arg_182_0 then
				var_182_4.localPosition = Vector3.New(0, -350, -210)
			end

			local var_182_11 = arg_179_1.actors_["10096"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.actorSpriteComps10096 == nil then
				arg_179_1.var_.actorSpriteComps10096 = var_182_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_13 = 0.125

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.actorSpriteComps10096 then
					for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_182_4 then
							if arg_179_1.isInRecall_ then
								local var_182_15 = Mathf.Lerp(iter_182_4.color.r, arg_179_1.hightColor1.r, var_182_14)
								local var_182_16 = Mathf.Lerp(iter_182_4.color.g, arg_179_1.hightColor1.g, var_182_14)
								local var_182_17 = Mathf.Lerp(iter_182_4.color.b, arg_179_1.hightColor1.b, var_182_14)

								iter_182_4.color = Color.New(var_182_15, var_182_16, var_182_17)
							else
								local var_182_18 = Mathf.Lerp(iter_182_4.color.r, 1, var_182_14)

								iter_182_4.color = Color.New(var_182_18, var_182_18, var_182_18)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.actorSpriteComps10096 then
				for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_182_6 then
						if arg_179_1.isInRecall_ then
							iter_182_6.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10096 = nil
			end

			local var_182_19 = 0
			local var_182_20 = 0.225

			if var_182_19 < arg_179_1.time_ and arg_179_1.time_ <= var_182_19 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_21 = arg_179_1:FormatText(StoryNameCfg[1091].name)

				arg_179_1.leftNameTxt_.text = var_182_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_22 = arg_179_1:GetWordFromCfg(416092042)
				local var_182_23 = arg_179_1:FormatText(var_182_22.content)

				arg_179_1.text_.text = var_182_23

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_24 = 9
				local var_182_25 = utf8.len(var_182_23)
				local var_182_26 = var_182_24 <= 0 and var_182_20 or var_182_20 * (var_182_25 / var_182_24)

				if var_182_26 > 0 and var_182_20 < var_182_26 then
					arg_179_1.talkMaxDuration = var_182_26

					if var_182_26 + var_182_19 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_26 + var_182_19
					end
				end

				arg_179_1.text_.text = var_182_23
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092042", "story_v_out_416092.awb") ~= 0 then
					local var_182_27 = manager.audio:GetVoiceLength("story_v_out_416092", "416092042", "story_v_out_416092.awb") / 1000

					if var_182_27 + var_182_19 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_27 + var_182_19
					end

					if var_182_22.prefab_name ~= "" and arg_179_1.actors_[var_182_22.prefab_name] ~= nil then
						local var_182_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_22.prefab_name].transform, "story_v_out_416092", "416092042", "story_v_out_416092.awb")

						arg_179_1:RecordAudio("416092042", var_182_28)
						arg_179_1:RecordAudio("416092042", var_182_28)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416092", "416092042", "story_v_out_416092.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416092", "416092042", "story_v_out_416092.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_29 = math.max(var_182_20, arg_179_1.talkMaxDuration)

			if var_182_19 <= arg_179_1.time_ and arg_179_1.time_ < var_182_19 + var_182_29 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_19) / var_182_29

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_19 + var_182_29 and arg_179_1.time_ < var_182_19 + var_182_29 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play416092043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416092043
		arg_183_1.duration_ = 6.6

		local var_183_0 = {
			zh = 4.133,
			ja = 6.6
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
				arg_183_0:Play416092044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10096"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10096 == nil then
				arg_183_1.var_.actorSpriteComps10096 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.125

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps10096 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10096 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10096 = nil
			end

			local var_186_8 = arg_183_1.actors_["10123"].transform
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.var_.moveOldPos10123 = var_186_8.localPosition
				var_186_8.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10123", 3)

				local var_186_10 = var_186_8.childCount

				for iter_186_4 = 0, var_186_10 - 1 do
					local var_186_11 = var_186_8:GetChild(iter_186_4)

					if var_186_11.name == "split_6" or not string.find(var_186_11.name, "split") then
						var_186_11.gameObject:SetActive(true)
					else
						var_186_11.gameObject:SetActive(false)
					end
				end
			end

			local var_186_12 = 0.001

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_9) / var_186_12
				local var_186_14 = Vector3.New(0, -400, 0)

				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10123, var_186_14, var_186_13)
			end

			if arg_183_1.time_ >= var_186_9 + var_186_12 and arg_183_1.time_ < var_186_9 + var_186_12 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_186_15 = arg_183_1.actors_["10123"]
			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 and not isNil(var_186_15) and arg_183_1.var_.actorSpriteComps10123 == nil then
				arg_183_1.var_.actorSpriteComps10123 = var_186_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_17 = 0.125

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 and not isNil(var_186_15) then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17

				if arg_183_1.var_.actorSpriteComps10123 then
					for iter_186_5, iter_186_6 in pairs(arg_183_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_186_6 then
							if arg_183_1.isInRecall_ then
								local var_186_19 = Mathf.Lerp(iter_186_6.color.r, arg_183_1.hightColor1.r, var_186_18)
								local var_186_20 = Mathf.Lerp(iter_186_6.color.g, arg_183_1.hightColor1.g, var_186_18)
								local var_186_21 = Mathf.Lerp(iter_186_6.color.b, arg_183_1.hightColor1.b, var_186_18)

								iter_186_6.color = Color.New(var_186_19, var_186_20, var_186_21)
							else
								local var_186_22 = Mathf.Lerp(iter_186_6.color.r, 1, var_186_18)

								iter_186_6.color = Color.New(var_186_22, var_186_22, var_186_22)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 and not isNil(var_186_15) and arg_183_1.var_.actorSpriteComps10123 then
				for iter_186_7, iter_186_8 in pairs(arg_183_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_186_8 then
						if arg_183_1.isInRecall_ then
							iter_186_8.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10123 = nil
			end

			local var_186_23 = 0
			local var_186_24 = 0.45

			if var_186_23 < arg_183_1.time_ and arg_183_1.time_ <= var_186_23 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_25 = arg_183_1:FormatText(StoryNameCfg[36].name)

				arg_183_1.leftNameTxt_.text = var_186_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_26 = arg_183_1:GetWordFromCfg(416092043)
				local var_186_27 = arg_183_1:FormatText(var_186_26.content)

				arg_183_1.text_.text = var_186_27

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_28 = 18
				local var_186_29 = utf8.len(var_186_27)
				local var_186_30 = var_186_28 <= 0 and var_186_24 or var_186_24 * (var_186_29 / var_186_28)

				if var_186_30 > 0 and var_186_24 < var_186_30 then
					arg_183_1.talkMaxDuration = var_186_30

					if var_186_30 + var_186_23 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_30 + var_186_23
					end
				end

				arg_183_1.text_.text = var_186_27
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092043", "story_v_out_416092.awb") ~= 0 then
					local var_186_31 = manager.audio:GetVoiceLength("story_v_out_416092", "416092043", "story_v_out_416092.awb") / 1000

					if var_186_31 + var_186_23 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_31 + var_186_23
					end

					if var_186_26.prefab_name ~= "" and arg_183_1.actors_[var_186_26.prefab_name] ~= nil then
						local var_186_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_26.prefab_name].transform, "story_v_out_416092", "416092043", "story_v_out_416092.awb")

						arg_183_1:RecordAudio("416092043", var_186_32)
						arg_183_1:RecordAudio("416092043", var_186_32)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416092", "416092043", "story_v_out_416092.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416092", "416092043", "story_v_out_416092.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_33 = math.max(var_186_24, arg_183_1.talkMaxDuration)

			if var_186_23 <= arg_183_1.time_ and arg_183_1.time_ < var_186_23 + var_186_33 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_23) / var_186_33

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_23 + var_186_33 and arg_183_1.time_ < var_186_23 + var_186_33 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416092044
		arg_187_1.duration_ = 8.1

		local var_187_0 = {
			zh = 8.1,
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
				arg_187_0:Play416092045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.575

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[36].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(416092044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092044", "story_v_out_416092.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092044", "story_v_out_416092.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_416092", "416092044", "story_v_out_416092.awb")

						arg_187_1:RecordAudio("416092044", var_190_9)
						arg_187_1:RecordAudio("416092044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416092", "416092044", "story_v_out_416092.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416092", "416092044", "story_v_out_416092.awb")
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
	Play416092045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416092045
		arg_191_1.duration_ = 4.8

		local var_191_0 = {
			zh = 2.933,
			ja = 4.8
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
				arg_191_0:Play416092046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10096"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10096 == nil then
				arg_191_1.var_.actorSpriteComps10096 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.125

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps10096 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10096 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10096 = nil
			end

			local var_194_8 = arg_191_1.actors_["10096"].transform
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.var_.moveOldPos10096 = var_194_8.localPosition
				var_194_8.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10096", 4)

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
				local var_194_14 = Vector3.New(390, -350, -210)

				var_194_8.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10096, var_194_14, var_194_13)
			end

			if arg_191_1.time_ >= var_194_9 + var_194_12 and arg_191_1.time_ < var_194_9 + var_194_12 + arg_194_0 then
				var_194_8.localPosition = Vector3.New(390, -350, -210)
			end

			local var_194_15 = arg_191_1.actors_["10123"].transform
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.var_.moveOldPos10123 = var_194_15.localPosition
				var_194_15.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10123", 2)

				local var_194_17 = var_194_15.childCount

				for iter_194_5 = 0, var_194_17 - 1 do
					local var_194_18 = var_194_15:GetChild(iter_194_5)

					if var_194_18.name == "split_6" or not string.find(var_194_18.name, "split") then
						var_194_18.gameObject:SetActive(true)
					else
						var_194_18.gameObject:SetActive(false)
					end
				end
			end

			local var_194_19 = 0.001

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_19 then
				local var_194_20 = (arg_191_1.time_ - var_194_16) / var_194_19
				local var_194_21 = Vector3.New(-390, -400, 0)

				var_194_15.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10123, var_194_21, var_194_20)
			end

			if arg_191_1.time_ >= var_194_16 + var_194_19 and arg_191_1.time_ < var_194_16 + var_194_19 + arg_194_0 then
				var_194_15.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_194_22 = arg_191_1.actors_["10123"]
			local var_194_23 = 0

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 and not isNil(var_194_22) and arg_191_1.var_.actorSpriteComps10123 == nil then
				arg_191_1.var_.actorSpriteComps10123 = var_194_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_24 = 0.125

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_24 and not isNil(var_194_22) then
				local var_194_25 = (arg_191_1.time_ - var_194_23) / var_194_24

				if arg_191_1.var_.actorSpriteComps10123 then
					for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_194_7 then
							if arg_191_1.isInRecall_ then
								local var_194_26 = Mathf.Lerp(iter_194_7.color.r, arg_191_1.hightColor2.r, var_194_25)
								local var_194_27 = Mathf.Lerp(iter_194_7.color.g, arg_191_1.hightColor2.g, var_194_25)
								local var_194_28 = Mathf.Lerp(iter_194_7.color.b, arg_191_1.hightColor2.b, var_194_25)

								iter_194_7.color = Color.New(var_194_26, var_194_27, var_194_28)
							else
								local var_194_29 = Mathf.Lerp(iter_194_7.color.r, 0.5, var_194_25)

								iter_194_7.color = Color.New(var_194_29, var_194_29, var_194_29)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_23 + var_194_24 and arg_191_1.time_ < var_194_23 + var_194_24 + arg_194_0 and not isNil(var_194_22) and arg_191_1.var_.actorSpriteComps10123 then
				for iter_194_8, iter_194_9 in pairs(arg_191_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_194_9 then
						if arg_191_1.isInRecall_ then
							iter_194_9.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10123 = nil
			end

			local var_194_30 = 0
			local var_194_31 = 0.375

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_32 = arg_191_1:FormatText(StoryNameCfg[1091].name)

				arg_191_1.leftNameTxt_.text = var_194_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_33 = arg_191_1:GetWordFromCfg(416092045)
				local var_194_34 = arg_191_1:FormatText(var_194_33.content)

				arg_191_1.text_.text = var_194_34

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_35 = 15
				local var_194_36 = utf8.len(var_194_34)
				local var_194_37 = var_194_35 <= 0 and var_194_31 or var_194_31 * (var_194_36 / var_194_35)

				if var_194_37 > 0 and var_194_31 < var_194_37 then
					arg_191_1.talkMaxDuration = var_194_37

					if var_194_37 + var_194_30 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_37 + var_194_30
					end
				end

				arg_191_1.text_.text = var_194_34
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092045", "story_v_out_416092.awb") ~= 0 then
					local var_194_38 = manager.audio:GetVoiceLength("story_v_out_416092", "416092045", "story_v_out_416092.awb") / 1000

					if var_194_38 + var_194_30 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_38 + var_194_30
					end

					if var_194_33.prefab_name ~= "" and arg_191_1.actors_[var_194_33.prefab_name] ~= nil then
						local var_194_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_33.prefab_name].transform, "story_v_out_416092", "416092045", "story_v_out_416092.awb")

						arg_191_1:RecordAudio("416092045", var_194_39)
						arg_191_1:RecordAudio("416092045", var_194_39)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416092", "416092045", "story_v_out_416092.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416092", "416092045", "story_v_out_416092.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_40 = math.max(var_194_31, arg_191_1.talkMaxDuration)

			if var_194_30 <= arg_191_1.time_ and arg_191_1.time_ < var_194_30 + var_194_40 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_30) / var_194_40

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_30 + var_194_40 and arg_191_1.time_ < var_194_30 + var_194_40 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416092046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play416092047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10096"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10096 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10096", 7)

				local var_198_2 = var_198_0.childCount

				for iter_198_0 = 0, var_198_2 - 1 do
					local var_198_3 = var_198_0:GetChild(iter_198_0)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_4 then
				local var_198_5 = (arg_195_1.time_ - var_198_1) / var_198_4
				local var_198_6 = Vector3.New(0, -2000, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10096, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_7 = arg_195_1.actors_["10123"].transform
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.var_.moveOldPos10123 = var_198_7.localPosition
				var_198_7.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10123", 7)

				local var_198_9 = var_198_7.childCount

				for iter_198_1 = 0, var_198_9 - 1 do
					local var_198_10 = var_198_7:GetChild(iter_198_1)

					if var_198_10.name == "split_6" or not string.find(var_198_10.name, "split") then
						var_198_10.gameObject:SetActive(true)
					else
						var_198_10.gameObject:SetActive(false)
					end
				end
			end

			local var_198_11 = 0.001

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_11 then
				local var_198_12 = (arg_195_1.time_ - var_198_8) / var_198_11
				local var_198_13 = Vector3.New(0, -2000, 0)

				var_198_7.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10123, var_198_13, var_198_12)
			end

			if arg_195_1.time_ >= var_198_8 + var_198_11 and arg_195_1.time_ < var_198_8 + var_198_11 + arg_198_0 then
				var_198_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_14 = 0
			local var_198_15 = 1.425

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_16 = arg_195_1:GetWordFromCfg(416092046)
				local var_198_17 = arg_195_1:FormatText(var_198_16.content)

				arg_195_1.text_.text = var_198_17

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_18 = 57
				local var_198_19 = utf8.len(var_198_17)
				local var_198_20 = var_198_18 <= 0 and var_198_15 or var_198_15 * (var_198_19 / var_198_18)

				if var_198_20 > 0 and var_198_15 < var_198_20 then
					arg_195_1.talkMaxDuration = var_198_20

					if var_198_20 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_20 + var_198_14
					end
				end

				arg_195_1.text_.text = var_198_17
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_21 = math.max(var_198_15, arg_195_1.talkMaxDuration)

			if var_198_14 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_21 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_14) / var_198_21

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_14 + var_198_21 and arg_195_1.time_ < var_198_14 + var_198_21 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416092047
		arg_199_1.duration_ = 5.77

		local var_199_0 = {
			zh = 5.666,
			ja = 5.766
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play416092048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10123"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10123 = var_202_0.localPosition
				var_202_0.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10123", 3)

				local var_202_2 = var_202_0.childCount

				for iter_202_0 = 0, var_202_2 - 1 do
					local var_202_3 = var_202_0:GetChild(iter_202_0)

					if var_202_3.name == "split_6" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_4 then
				local var_202_5 = (arg_199_1.time_ - var_202_1) / var_202_4
				local var_202_6 = Vector3.New(0, -400, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10123, var_202_6, var_202_5)
			end

			if arg_199_1.time_ >= var_202_1 + var_202_4 and arg_199_1.time_ < var_202_1 + var_202_4 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_202_7 = arg_199_1.actors_["10123"]
			local var_202_8 = 0

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps10123 == nil then
				arg_199_1.var_.actorSpriteComps10123 = var_202_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_9 = 0.125

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 and not isNil(var_202_7) then
				local var_202_10 = (arg_199_1.time_ - var_202_8) / var_202_9

				if arg_199_1.var_.actorSpriteComps10123 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								local var_202_11 = Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, var_202_10)
								local var_202_12 = Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, var_202_10)
								local var_202_13 = Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, var_202_10)

								iter_202_2.color = Color.New(var_202_11, var_202_12, var_202_13)
							else
								local var_202_14 = Mathf.Lerp(iter_202_2.color.r, 1, var_202_10)

								iter_202_2.color = Color.New(var_202_14, var_202_14, var_202_14)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps10123 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_202_4 then
						if arg_199_1.isInRecall_ then
							iter_202_4.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10123 = nil
			end

			local var_202_15 = 0
			local var_202_16 = 0.45

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[36].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(416092047)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 18
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092047", "story_v_out_416092.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_416092", "416092047", "story_v_out_416092.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_416092", "416092047", "story_v_out_416092.awb")

						arg_199_1:RecordAudio("416092047", var_202_24)
						arg_199_1:RecordAudio("416092047", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416092", "416092047", "story_v_out_416092.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416092", "416092047", "story_v_out_416092.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play416092048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416092048
		arg_203_1.duration_ = 6.83

		local var_203_0 = {
			zh = 3.366,
			ja = 6.833
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
			arg_203_1.auto_ = false
		end

		function arg_203_1.playNext_(arg_205_0)
			arg_203_1.onStoryFinished_()
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.3

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[36].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(416092048)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 12
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092048", "story_v_out_416092.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092048", "story_v_out_416092.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_416092", "416092048", "story_v_out_416092.awb")

						arg_203_1:RecordAudio("416092048", var_206_9)
						arg_203_1:RecordAudio("416092048", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416092", "416092048", "story_v_out_416092.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416092", "416092048", "story_v_out_416092.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_416092.awb"
	}
}
