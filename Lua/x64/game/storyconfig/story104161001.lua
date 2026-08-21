return {
	Play416101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416101001
		arg_1_1.duration_ = 8.17

		local var_1_0 = {
			zh = 5.932999999999,
			ja = 8.165999999999
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
				arg_1_0:Play416101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 1.999999999999

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I13f"

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
				local var_4_7 = arg_1_1.bgs_.I13f

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
					if iter_4_0 ~= "I13f" then
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

			local var_4_24 = "10108"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

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

			local var_4_28 = arg_1_1.actors_["10108"]
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10108 == nil then
				arg_1_1.var_.actorSpriteComps10108 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.125

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10108 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10108 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10108 = nil
			end

			local var_4_36 = arg_1_1.actors_["10108"].transform
			local var_4_37 = 1.66666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10108 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10108", 3)

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
				local var_4_42 = Vector3.New(0, -399.6, -130)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10108, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_4_43 = arg_1_1.actors_["10108"]
			local var_4_44 = 1.66666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10108 = var_4_45.alpha
					arg_1_1.var_.characterEffect10108 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10108 = 0
			end

			local var_4_46 = 0.857666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10108, 1, var_4_47)

				if arg_1_1.var_.characterEffect10108 then
					arg_1_1.var_.characterEffect10108.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10108 then
				arg_1_1.var_.characterEffect10108.alpha = 1
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

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 1.999999999999
			local var_4_62 = 0.425

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[1083].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416101001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 17
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101001", "story_v_out_416101.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416101", "416101001", "story_v_out_416101.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416101", "416101001", "story_v_out_416101.awb")

						arg_1_1:RecordAudio("416101001", var_4_71)
						arg_1_1:RecordAudio("416101001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416101", "416101001", "story_v_out_416101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416101", "416101001", "story_v_out_416101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10108"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10108 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10108", 7)

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

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10108, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = 0
			local var_12_8 = 1.675

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_9 = arg_9_1:GetWordFromCfg(416101002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 67
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_8 or var_12_8 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_8 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_7
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_8, arg_9_1.talkMaxDuration)

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_7) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_7 + var_12_14 and arg_9_1.time_ < var_12_7 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.775

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

				local var_16_2 = arg_13_1:GetWordFromCfg(416101003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 71
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
	Play416101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416101004
		arg_17_1.duration_ = 3.47

		local var_17_0 = {
			zh = 3.466,
			ja = 2.066
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
				arg_17_0:Play416101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10108"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10108 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10108", 3)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(0, -399.6, -130)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10108, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_20_7 = arg_17_1.actors_["10108"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10108 == nil then
				arg_17_1.var_.actorSpriteComps10108 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.125

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps10108 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								local var_20_11 = Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, var_20_10)
								local var_20_12 = Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, var_20_10)
								local var_20_13 = Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, var_20_10)

								iter_20_2.color = Color.New(var_20_11, var_20_12, var_20_13)
							else
								local var_20_14 = Mathf.Lerp(iter_20_2.color.r, 1, var_20_10)

								iter_20_2.color = Color.New(var_20_14, var_20_14, var_20_14)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10108 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10108 = nil
			end

			local var_20_15 = 0
			local var_20_16 = 0.3

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[1083].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(416101004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101004", "story_v_out_416101.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101004", "story_v_out_416101.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_416101", "416101004", "story_v_out_416101.awb")

						arg_17_1:RecordAudio("416101004", var_20_24)
						arg_17_1:RecordAudio("416101004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416101", "416101004", "story_v_out_416101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416101", "416101004", "story_v_out_416101.awb")
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
				actorName = "10108",
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
	Play416101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416101005
		arg_21_1.duration_ = 6.5

		local var_21_0 = {
			zh = 6.5,
			ja = 2.7
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
				arg_21_0:Play416101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10108"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10108 == nil then
				arg_21_1.var_.actorSpriteComps10108 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.125

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10108 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10108 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10108 = nil
			end

			local var_24_8 = arg_21_1.actors_["10108"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos10108 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(-390, -399.6, -110)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10108, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(-390, -399.6, -110)
			end

			local var_24_15 = "1148"

			if arg_21_1.actors_[var_24_15] == nil then
				local var_24_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_24_16) then
					local var_24_17 = Object.Instantiate(var_24_16, arg_21_1.canvasGo_.transform)

					var_24_17.transform:SetSiblingIndex(1)

					var_24_17.name = var_24_15
					var_24_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_15] = var_24_17

					local var_24_18 = var_24_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_5, iter_24_6 in ipairs(var_24_18) do
							iter_24_6.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_19 = arg_21_1.actors_["1148"].transform
			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_19.localPosition
				var_24_19.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 4)

				local var_24_21 = var_24_19.childCount

				for iter_24_7 = 0, var_24_21 - 1 do
					local var_24_22 = var_24_19:GetChild(iter_24_7)

					if var_24_22.name == "split_6" or not string.find(var_24_22.name, "split") then
						var_24_22.gameObject:SetActive(true)
					else
						var_24_22.gameObject:SetActive(false)
					end
				end
			end

			local var_24_23 = 0.001

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_23 then
				local var_24_24 = (arg_21_1.time_ - var_24_20) / var_24_23
				local var_24_25 = Vector3.New(390, -429, -180)

				var_24_19.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, var_24_25, var_24_24)
			end

			if arg_21_1.time_ >= var_24_20 + var_24_23 and arg_21_1.time_ < var_24_20 + var_24_23 + arg_24_0 then
				var_24_19.localPosition = Vector3.New(390, -429, -180)
			end

			local var_24_26 = arg_21_1.actors_["1148"]
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 and not isNil(var_24_26) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = var_24_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_28 = 0.125

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 and not isNil(var_24_26) then
				local var_24_29 = (arg_21_1.time_ - var_24_27) / var_24_28

				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_9 then
							if arg_21_1.isInRecall_ then
								local var_24_30 = Mathf.Lerp(iter_24_9.color.r, arg_21_1.hightColor1.r, var_24_29)
								local var_24_31 = Mathf.Lerp(iter_24_9.color.g, arg_21_1.hightColor1.g, var_24_29)
								local var_24_32 = Mathf.Lerp(iter_24_9.color.b, arg_21_1.hightColor1.b, var_24_29)

								iter_24_9.color = Color.New(var_24_30, var_24_31, var_24_32)
							else
								local var_24_33 = Mathf.Lerp(iter_24_9.color.r, 1, var_24_29)

								iter_24_9.color = Color.New(var_24_33, var_24_33, var_24_33)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 and not isNil(var_24_26) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_10, iter_24_11 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_11 then
						if arg_21_1.isInRecall_ then
							iter_24_11.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_34 = 0
			local var_24_35 = 0.375

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_36 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_37 = arg_21_1:GetWordFromCfg(416101005)
				local var_24_38 = arg_21_1:FormatText(var_24_37.content)

				arg_21_1.text_.text = var_24_38

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_39 = 15
				local var_24_40 = utf8.len(var_24_38)
				local var_24_41 = var_24_39 <= 0 and var_24_35 or var_24_35 * (var_24_40 / var_24_39)

				if var_24_41 > 0 and var_24_35 < var_24_41 then
					arg_21_1.talkMaxDuration = var_24_41

					if var_24_41 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_41 + var_24_34
					end
				end

				arg_21_1.text_.text = var_24_38
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101005", "story_v_out_416101.awb") ~= 0 then
					local var_24_42 = manager.audio:GetVoiceLength("story_v_out_416101", "416101005", "story_v_out_416101.awb") / 1000

					if var_24_42 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_34
					end

					if var_24_37.prefab_name ~= "" and arg_21_1.actors_[var_24_37.prefab_name] ~= nil then
						local var_24_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_37.prefab_name].transform, "story_v_out_416101", "416101005", "story_v_out_416101.awb")

						arg_21_1:RecordAudio("416101005", var_24_43)
						arg_21_1:RecordAudio("416101005", var_24_43)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416101", "416101005", "story_v_out_416101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416101", "416101005", "story_v_out_416101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_44 = math.max(var_24_35, arg_21_1.talkMaxDuration)

			if var_24_34 <= arg_21_1.time_ and arg_21_1.time_ < var_24_34 + var_24_44 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_34) / var_24_44

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_34 + var_24_44 and arg_21_1.time_ < var_24_34 + var_24_44 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
	Play416101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416101006
		arg_25_1.duration_ = 6.77

		local var_25_0 = {
			zh = 4.2,
			ja = 6.766
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
				arg_25_0:Play416101007(arg_25_1)
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

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[8].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(416101006)
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101006", "story_v_out_416101.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101006", "story_v_out_416101.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_416101", "416101006", "story_v_out_416101.awb")

						arg_25_1:RecordAudio("416101006", var_28_9)
						arg_25_1:RecordAudio("416101006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416101", "416101006", "story_v_out_416101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416101", "416101006", "story_v_out_416101.awb")
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
	Play416101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416101007
		arg_29_1.duration_ = 14.27

		local var_29_0 = {
			zh = 6.766,
			ja = 14.266
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
				arg_29_0:Play416101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10108"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10108 == nil then
				arg_29_1.var_.actorSpriteComps10108 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.125

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10108 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10108 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10108 = nil
			end

			local var_32_8 = arg_29_1.actors_["1148"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.125

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.625

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[1083].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(416101007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 25
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101007", "story_v_out_416101.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101007", "story_v_out_416101.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_416101", "416101007", "story_v_out_416101.awb")

						arg_29_1:RecordAudio("416101007", var_32_25)
						arg_29_1:RecordAudio("416101007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416101", "416101007", "story_v_out_416101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416101", "416101007", "story_v_out_416101.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416101008
		arg_33_1.duration_ = 5.77

		local var_33_0 = {
			zh = 5.766,
			ja = 4.266
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
				arg_33_0:Play416101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10108"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10108 == nil then
				arg_33_1.var_.actorSpriteComps10108 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.125

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10108 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10108 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10108 = nil
			end

			local var_36_8 = arg_33_1.actors_["1148"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.125

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor1.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor1.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor1.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 1, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.525

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(416101008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 21
				local var_36_22 = utf8.len(var_36_20)
				local var_36_23 = var_36_21 <= 0 and var_36_17 or var_36_17 * (var_36_22 / var_36_21)

				if var_36_23 > 0 and var_36_17 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23

					if var_36_23 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101008", "story_v_out_416101.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101008", "story_v_out_416101.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_416101", "416101008", "story_v_out_416101.awb")

						arg_33_1:RecordAudio("416101008", var_36_25)
						arg_33_1:RecordAudio("416101008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416101", "416101008", "story_v_out_416101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416101", "416101008", "story_v_out_416101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_26 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_26

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_26 and arg_33_1.time_ < var_36_16 + var_36_26 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416101009
		arg_37_1.duration_ = 19.17

		local var_37_0 = {
			zh = 12.466,
			ja = 19.166
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
				arg_37_0:Play416101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10108"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10108 == nil then
				arg_37_1.var_.actorSpriteComps10108 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.125

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10108 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10108 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10108 = nil
			end

			local var_40_8 = arg_37_1.actors_["1148"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.125

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 0.5, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 1.125

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[1083].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(416101009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 45
				local var_40_22 = utf8.len(var_40_20)
				local var_40_23 = var_40_21 <= 0 and var_40_17 or var_40_17 * (var_40_22 / var_40_21)

				if var_40_23 > 0 and var_40_17 < var_40_23 then
					arg_37_1.talkMaxDuration = var_40_23

					if var_40_23 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101009", "story_v_out_416101.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101009", "story_v_out_416101.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_416101", "416101009", "story_v_out_416101.awb")

						arg_37_1:RecordAudio("416101009", var_40_25)
						arg_37_1:RecordAudio("416101009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416101", "416101009", "story_v_out_416101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416101", "416101009", "story_v_out_416101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_26 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_26 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_26

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_26 and arg_37_1.time_ < var_40_16 + var_40_26 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play416101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416101010
		arg_41_1.duration_ = 8.63

		local var_41_0 = {
			zh = 6.933,
			ja = 8.633
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
				arg_41_0:Play416101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.675

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1083].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(416101010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101010", "story_v_out_416101.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101010", "story_v_out_416101.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_416101", "416101010", "story_v_out_416101.awb")

						arg_41_1:RecordAudio("416101010", var_44_9)
						arg_41_1:RecordAudio("416101010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416101", "416101010", "story_v_out_416101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416101", "416101010", "story_v_out_416101.awb")
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
	Play416101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416101011
		arg_45_1.duration_ = 10.2

		local var_45_0 = {
			zh = 5.633,
			ja = 10.2
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
				arg_45_0:Play416101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10108"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10108 == nil then
				arg_45_1.var_.actorSpriteComps10108 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.125

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10108 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10108 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10108 = nil
			end

			local var_48_8 = arg_45_1.actors_["1148"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1148 == nil then
				arg_45_1.var_.actorSpriteComps1148 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.125

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps1148 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 1, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1148 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1148 = nil
			end

			local var_48_16 = arg_45_1.actors_["1148"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 4)

				local var_48_18 = var_48_16.childCount

				for iter_48_8 = 0, var_48_18 - 1 do
					local var_48_19 = var_48_16:GetChild(iter_48_8)

					if var_48_19.name == "split_4" or not string.find(var_48_19.name, "split") then
						var_48_19.gameObject:SetActive(true)
					else
						var_48_19.gameObject:SetActive(false)
					end
				end
			end

			local var_48_20 = 0.001

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_17) / var_48_20
				local var_48_22 = Vector3.New(390, -429, -180)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_48_23 = 0
			local var_48_24 = 0.6

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(416101011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101011", "story_v_out_416101.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_416101", "416101011", "story_v_out_416101.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_416101", "416101011", "story_v_out_416101.awb")

						arg_45_1:RecordAudio("416101011", var_48_32)
						arg_45_1:RecordAudio("416101011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416101", "416101011", "story_v_out_416101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416101", "416101011", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416101012
		arg_49_1.duration_ = 6.4

		local var_49_0 = {
			zh = 5.066,
			ja = 6.4
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
				arg_49_0:Play416101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.6

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[8].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(416101012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101012", "story_v_out_416101.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101012", "story_v_out_416101.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_416101", "416101012", "story_v_out_416101.awb")

						arg_49_1:RecordAudio("416101012", var_52_9)
						arg_49_1:RecordAudio("416101012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416101", "416101012", "story_v_out_416101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416101", "416101012", "story_v_out_416101.awb")
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
	Play416101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416101013
		arg_53_1.duration_ = 3.97

		local var_53_0 = {
			zh = 3.966,
			ja = 2
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
				arg_53_0:Play416101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.375

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(416101013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101013", "story_v_out_416101.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101013", "story_v_out_416101.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_416101", "416101013", "story_v_out_416101.awb")

						arg_53_1:RecordAudio("416101013", var_56_9)
						arg_53_1:RecordAudio("416101013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416101", "416101013", "story_v_out_416101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416101", "416101013", "story_v_out_416101.awb")
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
	Play416101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416101014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play416101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10108"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10108 == nil then
				arg_57_1.var_.actorSpriteComps10108 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.125

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10108 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10108 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10108 = nil
			end

			local var_60_8 = arg_57_1.actors_["1148"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1148 == nil then
				arg_57_1.var_.actorSpriteComps1148 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.125

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps1148 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1148 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1148 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 1.225

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(416101014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 49
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_17 or var_60_17 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_17 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_23 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_23 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_23

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_23 and arg_57_1.time_ < var_60_16 + var_60_23 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416101015
		arg_61_1.duration_ = 3.57

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 3.566
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
				arg_61_0:Play416101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1148"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1148 == nil then
				arg_61_1.var_.actorSpriteComps1148 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.125

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1148 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1148 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1148 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.1

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(416101015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101015", "story_v_out_416101.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101015", "story_v_out_416101.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_416101", "416101015", "story_v_out_416101.awb")

						arg_61_1:RecordAudio("416101015", var_64_17)
						arg_61_1:RecordAudio("416101015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416101", "416101015", "story_v_out_416101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416101", "416101015", "story_v_out_416101.awb")
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
	Play416101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416101016
		arg_65_1.duration_ = 10

		local var_65_0 = {
			zh = 5.8,
			ja = 10
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
				arg_65_0:Play416101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1148"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1148 == nil then
				arg_65_1.var_.actorSpriteComps1148 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.125

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1148 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1148 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1148 = nil
			end

			local var_68_8 = arg_65_1.actors_["10108"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10108 == nil then
				arg_65_1.var_.actorSpriteComps10108 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.125

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10108 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 1, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10108 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10108 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.525

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[1083].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(416101016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 21
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101016", "story_v_out_416101.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101016", "story_v_out_416101.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_416101", "416101016", "story_v_out_416101.awb")

						arg_65_1:RecordAudio("416101016", var_68_25)
						arg_65_1:RecordAudio("416101016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416101", "416101016", "story_v_out_416101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416101", "416101016", "story_v_out_416101.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play416101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416101017
		arg_69_1.duration_ = 4.17

		local var_69_0 = {
			zh = 3.6,
			ja = 4.166
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
				arg_69_0:Play416101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10108"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10108 == nil then
				arg_69_1.var_.actorSpriteComps10108 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.125

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10108 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10108 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10108 = nil
			end

			local var_72_8 = arg_69_1.actors_["1148"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1148 == nil then
				arg_69_1.var_.actorSpriteComps1148 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.125

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps1148 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								local var_72_12 = Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor1.r, var_72_11)
								local var_72_13 = Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor1.g, var_72_11)
								local var_72_14 = Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor1.b, var_72_11)

								iter_72_5.color = Color.New(var_72_12, var_72_13, var_72_14)
							else
								local var_72_15 = Mathf.Lerp(iter_72_5.color.r, 1, var_72_11)

								iter_72_5.color = Color.New(var_72_15, var_72_15, var_72_15)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1148 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1148 = nil
			end

			local var_72_16 = 0
			local var_72_17 = 0.325

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[8].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(416101017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 13
				local var_72_22 = utf8.len(var_72_20)
				local var_72_23 = var_72_21 <= 0 and var_72_17 or var_72_17 * (var_72_22 / var_72_21)

				if var_72_23 > 0 and var_72_17 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23

					if var_72_23 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_16
					end
				end

				arg_69_1.text_.text = var_72_20
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101017", "story_v_out_416101.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101017", "story_v_out_416101.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_416101", "416101017", "story_v_out_416101.awb")

						arg_69_1:RecordAudio("416101017", var_72_25)
						arg_69_1:RecordAudio("416101017", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416101", "416101017", "story_v_out_416101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416101", "416101017", "story_v_out_416101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_26 = math.max(var_72_17, arg_69_1.talkMaxDuration)

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_26 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_16) / var_72_26

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_16 + var_72_26 and arg_69_1.time_ < var_72_16 + var_72_26 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416101018
		arg_73_1.duration_ = 10.97

		local var_73_0 = {
			zh = 6.1,
			ja = 10.966
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
				arg_73_0:Play416101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10108"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10108 == nil then
				arg_73_1.var_.actorSpriteComps10108 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.125

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10108 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10108 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10108 = nil
			end

			local var_76_8 = arg_73_1.actors_["1148"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1148 == nil then
				arg_73_1.var_.actorSpriteComps1148 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.125

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps1148 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1148 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1148 = nil
			end

			local var_76_16 = 0
			local var_76_17 = 0.6

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_18 = arg_73_1:FormatText(StoryNameCfg[1083].name)

				arg_73_1.leftNameTxt_.text = var_76_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(416101018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 24
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_17 or var_76_17 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_17 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23

					if var_76_23 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101018", "story_v_out_416101.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101018", "story_v_out_416101.awb") / 1000

					if var_76_24 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_16
					end

					if var_76_19.prefab_name ~= "" and arg_73_1.actors_[var_76_19.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_19.prefab_name].transform, "story_v_out_416101", "416101018", "story_v_out_416101.awb")

						arg_73_1:RecordAudio("416101018", var_76_25)
						arg_73_1:RecordAudio("416101018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416101", "416101018", "story_v_out_416101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416101", "416101018", "story_v_out_416101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_26 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_26 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_16) / var_76_26

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_16 + var_76_26 and arg_73_1.time_ < var_76_16 + var_76_26 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416101019
		arg_77_1.duration_ = 9.73

		local var_77_0 = {
			zh = 8.9,
			ja = 9.733
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
				arg_77_0:Play416101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.7

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1083].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(416101019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 28
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101019", "story_v_out_416101.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101019", "story_v_out_416101.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_416101", "416101019", "story_v_out_416101.awb")

						arg_77_1:RecordAudio("416101019", var_80_9)
						arg_77_1:RecordAudio("416101019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416101", "416101019", "story_v_out_416101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416101", "416101019", "story_v_out_416101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play416101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416101020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play416101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1148"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1148", 7)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(0, -2000, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_7 = arg_81_1.actors_["10108"].transform
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.var_.moveOldPos10108 = var_84_7.localPosition
				var_84_7.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10108", 7)

				local var_84_9 = var_84_7.childCount

				for iter_84_1 = 0, var_84_9 - 1 do
					local var_84_10 = var_84_7:GetChild(iter_84_1)

					if var_84_10.name == "" or not string.find(var_84_10.name, "split") then
						var_84_10.gameObject:SetActive(true)
					else
						var_84_10.gameObject:SetActive(false)
					end
				end
			end

			local var_84_11 = 0.001

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_11 then
				local var_84_12 = (arg_81_1.time_ - var_84_8) / var_84_11
				local var_84_13 = Vector3.New(0, -2000, 0)

				var_84_7.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10108, var_84_13, var_84_12)
			end

			if arg_81_1.time_ >= var_84_8 + var_84_11 and arg_81_1.time_ < var_84_8 + var_84_11 + arg_84_0 then
				var_84_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_14 = 0
			local var_84_15 = 1.025

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_16 = arg_81_1:GetWordFromCfg(416101020)
				local var_84_17 = arg_81_1:FormatText(var_84_16.content)

				arg_81_1.text_.text = var_84_17

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_18 = 41
				local var_84_19 = utf8.len(var_84_17)
				local var_84_20 = var_84_18 <= 0 and var_84_15 or var_84_15 * (var_84_19 / var_84_18)

				if var_84_20 > 0 and var_84_15 < var_84_20 then
					arg_81_1.talkMaxDuration = var_84_20

					if var_84_20 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_20 + var_84_14
					end
				end

				arg_81_1.text_.text = var_84_17
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_15, arg_81_1.talkMaxDuration)

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_14) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_14 + var_84_21 and arg_81_1.time_ < var_84_14 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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
				actorName = "10108",
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
	Play416101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416101021
		arg_85_1.duration_ = 7.23

		local var_85_0 = {
			zh = 4.2,
			ja = 7.233
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
				arg_85_0:Play416101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1148"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1148", 3)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_4" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -429, -180)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_88_7 = arg_85_1.actors_["1148"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1148 == nil then
				arg_85_1.var_.actorSpriteComps1148 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.125

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps1148 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1148 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1148 = nil
			end

			local var_88_15 = 0
			local var_88_16 = 0.425

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[8].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(416101021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 17
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101021", "story_v_out_416101.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101021", "story_v_out_416101.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_416101", "416101021", "story_v_out_416101.awb")

						arg_85_1:RecordAudio("416101021", var_88_24)
						arg_85_1:RecordAudio("416101021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416101", "416101021", "story_v_out_416101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416101", "416101021", "story_v_out_416101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play416101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416101022
		arg_89_1.duration_ = 6

		local var_89_0 = {
			zh = 3.6,
			ja = 6
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
				arg_89_0:Play416101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.475

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[8].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(416101022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101022", "story_v_out_416101.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101022", "story_v_out_416101.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_416101", "416101022", "story_v_out_416101.awb")

						arg_89_1:RecordAudio("416101022", var_92_9)
						arg_89_1:RecordAudio("416101022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416101", "416101022", "story_v_out_416101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416101", "416101022", "story_v_out_416101.awb")
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
	Play416101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416101023
		arg_93_1.duration_ = 4.3

		local var_93_0 = {
			zh = 2.966,
			ja = 4.3
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
				arg_93_0:Play416101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1148"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 3)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_6" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(0, -429, -180)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_96_7 = 0
			local var_96_8 = 0.3

			if var_96_7 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_9 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(416101023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 12
				local var_96_13 = utf8.len(var_96_11)
				local var_96_14 = var_96_12 <= 0 and var_96_8 or var_96_8 * (var_96_13 / var_96_12)

				if var_96_14 > 0 and var_96_8 < var_96_14 then
					arg_93_1.talkMaxDuration = var_96_14

					if var_96_14 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_7
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101023", "story_v_out_416101.awb") ~= 0 then
					local var_96_15 = manager.audio:GetVoiceLength("story_v_out_416101", "416101023", "story_v_out_416101.awb") / 1000

					if var_96_15 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_7
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_416101", "416101023", "story_v_out_416101.awb")

						arg_93_1:RecordAudio("416101023", var_96_16)
						arg_93_1:RecordAudio("416101023", var_96_16)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416101", "416101023", "story_v_out_416101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416101", "416101023", "story_v_out_416101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_17 = math.max(var_96_8, arg_93_1.talkMaxDuration)

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_17 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_7) / var_96_17

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_7 + var_96_17 and arg_93_1.time_ < var_96_7 + var_96_17 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play416101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416101024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1148"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1148 == nil then
				arg_97_1.var_.actorSpriteComps1148 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.125

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1148 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1148 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1148 = nil
			end

			local var_100_8 = arg_97_1.actors_["1148"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos1148 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1148", 7)

				local var_100_10 = var_100_8.childCount

				for iter_100_4 = 0, var_100_10 - 1 do
					local var_100_11 = var_100_8:GetChild(iter_100_4)

					if var_100_11.name == "" or not string.find(var_100_11.name, "split") then
						var_100_11.gameObject:SetActive(true)
					else
						var_100_11.gameObject:SetActive(false)
					end
				end
			end

			local var_100_12 = 0.001

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_12 then
				local var_100_13 = (arg_97_1.time_ - var_100_9) / var_100_12
				local var_100_14 = Vector3.New(0, -2000, 0)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1148, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_15 = 0
			local var_100_16 = 1.125

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_17 = arg_97_1:GetWordFromCfg(416101024)
				local var_100_18 = arg_97_1:FormatText(var_100_17.content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_19 = 45
				local var_100_20 = utf8.len(var_100_18)
				local var_100_21 = var_100_19 <= 0 and var_100_16 or var_100_16 * (var_100_20 / var_100_19)

				if var_100_21 > 0 and var_100_16 < var_100_21 then
					arg_97_1.talkMaxDuration = var_100_21

					if var_100_21 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_21 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_22 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_22 and arg_97_1.time_ < var_100_15 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play416101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416101025
		arg_101_1.duration_ = 10.23

		local var_101_0 = {
			zh = 7.3,
			ja = 10.233
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
				arg_101_0:Play416101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1148"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1148 == nil then
				arg_101_1.var_.actorSpriteComps1148 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.125

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps1148 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1148 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1148 = nil
			end

			local var_104_8 = arg_101_1.actors_["1148"].transform
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148 = var_104_8.localPosition
				var_104_8.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1148", 3)

				local var_104_10 = var_104_8.childCount

				for iter_104_4 = 0, var_104_10 - 1 do
					local var_104_11 = var_104_8:GetChild(iter_104_4)

					if var_104_11.name == "split_6" or not string.find(var_104_11.name, "split") then
						var_104_11.gameObject:SetActive(true)
					else
						var_104_11.gameObject:SetActive(false)
					end
				end
			end

			local var_104_12 = 0.001

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_9) / var_104_12
				local var_104_14 = Vector3.New(0, -429, -180)

				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148, var_104_14, var_104_13)
			end

			if arg_101_1.time_ >= var_104_9 + var_104_12 and arg_101_1.time_ < var_104_9 + var_104_12 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_104_15 = 0
			local var_104_16 = 0.775

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[8].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(416101025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 31
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101025", "story_v_out_416101.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101025", "story_v_out_416101.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_416101", "416101025", "story_v_out_416101.awb")

						arg_101_1:RecordAudio("416101025", var_104_24)
						arg_101_1:RecordAudio("416101025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416101", "416101025", "story_v_out_416101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416101", "416101025", "story_v_out_416101.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play416101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416101026
		arg_105_1.duration_ = 5.5

		local var_105_0 = {
			zh = 3.5,
			ja = 5.5
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
				arg_105_0:Play416101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.4

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[8].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(416101026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 16
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101026", "story_v_out_416101.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101026", "story_v_out_416101.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_416101", "416101026", "story_v_out_416101.awb")

						arg_105_1:RecordAudio("416101026", var_108_9)
						arg_105_1:RecordAudio("416101026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416101", "416101026", "story_v_out_416101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416101", "416101026", "story_v_out_416101.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play416101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416101027
		arg_109_1.duration_ = 3.4

		local var_109_0 = {
			zh = 3.4,
			ja = 3.2
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
				arg_109_0:Play416101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1148"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1148 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1148", 7)

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
				local var_112_6 = Vector3.New(0, -2000, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1148, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_7 = arg_109_1.actors_["10108"].transform
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.var_.moveOldPos10108 = var_112_7.localPosition
				var_112_7.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10108", 7)

				local var_112_9 = var_112_7.childCount

				for iter_112_1 = 0, var_112_9 - 1 do
					local var_112_10 = var_112_7:GetChild(iter_112_1)

					if var_112_10.name == "" or not string.find(var_112_10.name, "split") then
						var_112_10.gameObject:SetActive(true)
					else
						var_112_10.gameObject:SetActive(false)
					end
				end
			end

			local var_112_11 = 0.001

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_8) / var_112_11
				local var_112_13 = Vector3.New(0, -2000, 0)

				var_112_7.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10108, var_112_13, var_112_12)
			end

			if arg_109_1.time_ >= var_112_8 + var_112_11 and arg_109_1.time_ < var_112_8 + var_112_11 + arg_112_0 then
				var_112_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_14 = 0
			local var_112_15 = 0.4

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_16 = arg_109_1:FormatText(StoryNameCfg[1082].name)

				arg_109_1.leftNameTxt_.text = var_112_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_17 = arg_109_1:GetWordFromCfg(416101027)
				local var_112_18 = arg_109_1:FormatText(var_112_17.content)

				arg_109_1.text_.text = var_112_18

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 16
				local var_112_20 = utf8.len(var_112_18)
				local var_112_21 = var_112_19 <= 0 and var_112_15 or var_112_15 * (var_112_20 / var_112_19)

				if var_112_21 > 0 and var_112_15 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21

					if var_112_21 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_14
					end
				end

				arg_109_1.text_.text = var_112_18
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101027", "story_v_out_416101.awb") ~= 0 then
					local var_112_22 = manager.audio:GetVoiceLength("story_v_out_416101", "416101027", "story_v_out_416101.awb") / 1000

					if var_112_22 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_14
					end

					if var_112_17.prefab_name ~= "" and arg_109_1.actors_[var_112_17.prefab_name] ~= nil then
						local var_112_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_17.prefab_name].transform, "story_v_out_416101", "416101027", "story_v_out_416101.awb")

						arg_109_1:RecordAudio("416101027", var_112_23)
						arg_109_1:RecordAudio("416101027", var_112_23)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416101", "416101027", "story_v_out_416101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416101", "416101027", "story_v_out_416101.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_24 = math.max(var_112_15, arg_109_1.talkMaxDuration)

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_24 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_14) / var_112_24

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_14 + var_112_24 and arg_109_1.time_ < var_112_14 + var_112_24 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play416101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416101028
		arg_113_1.duration_ = 5.27

		local var_113_0 = {
			zh = 5.266,
			ja = 4.333
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
				arg_113_0:Play416101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1148"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1148 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1148", 3)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_6" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(0, -429, -180)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1148, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_116_7 = arg_113_1.actors_["1148"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1148 == nil then
				arg_113_1.var_.actorSpriteComps1148 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.125

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps1148 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1148 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1148 = nil
			end

			local var_116_15 = 0
			local var_116_16 = 0.525

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[8].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(416101028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101028", "story_v_out_416101.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101028", "story_v_out_416101.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_416101", "416101028", "story_v_out_416101.awb")

						arg_113_1:RecordAudio("416101028", var_116_24)
						arg_113_1:RecordAudio("416101028", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416101", "416101028", "story_v_out_416101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416101", "416101028", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416101029
		arg_117_1.duration_ = 3.6

		local var_117_0 = {
			zh = 3.366,
			ja = 3.6
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
				arg_117_0:Play416101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.35

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[8].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(416101029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 14
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101029", "story_v_out_416101.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101029", "story_v_out_416101.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_416101", "416101029", "story_v_out_416101.awb")

						arg_117_1:RecordAudio("416101029", var_120_9)
						arg_117_1:RecordAudio("416101029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416101", "416101029", "story_v_out_416101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416101", "416101029", "story_v_out_416101.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play416101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416101030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play416101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1148"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1148 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1148", 7)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(0, -2000, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1148, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_7 = 0
			local var_124_8 = 1.15

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(416101030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 46
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_8 or var_124_8 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_8 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_14 and arg_121_1.time_ < var_124_7 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play416101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416101031
		arg_125_1.duration_ = 3.33

		local var_125_0 = {
			zh = 2.066,
			ja = 3.333
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
				arg_125_0:Play416101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1148"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1148 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1148", 3)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "split_6" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -429, -180)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1148, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_128_7 = arg_125_1.actors_["1148"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1148 == nil then
				arg_125_1.var_.actorSpriteComps1148 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.125

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps1148 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								local var_128_11 = Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, var_128_10)
								local var_128_12 = Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, var_128_10)
								local var_128_13 = Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, var_128_10)

								iter_128_2.color = Color.New(var_128_11, var_128_12, var_128_13)
							else
								local var_128_14 = Mathf.Lerp(iter_128_2.color.r, 1, var_128_10)

								iter_128_2.color = Color.New(var_128_14, var_128_14, var_128_14)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1148 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1148 = nil
			end

			local var_128_15 = 0
			local var_128_16 = 0.225

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[8].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(416101031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 9
				local var_128_21 = utf8.len(var_128_19)
				local var_128_22 = var_128_20 <= 0 and var_128_16 or var_128_16 * (var_128_21 / var_128_20)

				if var_128_22 > 0 and var_128_16 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22

					if var_128_22 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101031", "story_v_out_416101.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101031", "story_v_out_416101.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_416101", "416101031", "story_v_out_416101.awb")

						arg_125_1:RecordAudio("416101031", var_128_24)
						arg_125_1:RecordAudio("416101031", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416101", "416101031", "story_v_out_416101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416101", "416101031", "story_v_out_416101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_25 and arg_125_1.time_ < var_128_15 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play416101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416101032
		arg_129_1.duration_ = 5.83

		local var_129_0 = {
			zh = 5.833,
			ja = 3.733
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
				arg_129_0:Play416101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1148"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1148", 3)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_1_1" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -429, -180)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_132_7 = 0
			local var_132_8 = 0.675

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_9 = arg_129_1:FormatText(StoryNameCfg[8].name)

				arg_129_1.leftNameTxt_.text = var_132_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(416101032)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 27
				local var_132_13 = utf8.len(var_132_11)
				local var_132_14 = var_132_12 <= 0 and var_132_8 or var_132_8 * (var_132_13 / var_132_12)

				if var_132_14 > 0 and var_132_8 < var_132_14 then
					arg_129_1.talkMaxDuration = var_132_14

					if var_132_14 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101032", "story_v_out_416101.awb") ~= 0 then
					local var_132_15 = manager.audio:GetVoiceLength("story_v_out_416101", "416101032", "story_v_out_416101.awb") / 1000

					if var_132_15 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_7
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_416101", "416101032", "story_v_out_416101.awb")

						arg_129_1:RecordAudio("416101032", var_132_16)
						arg_129_1:RecordAudio("416101032", var_132_16)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416101", "416101032", "story_v_out_416101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416101", "416101032", "story_v_out_416101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_17 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_17 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_17

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_17 and arg_129_1.time_ < var_132_7 + var_132_17 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play416101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416101033
		arg_133_1.duration_ = 3.2

		local var_133_0 = {
			zh = 2.6,
			ja = 3.2
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
				arg_133_0:Play416101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1148"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps1148 == nil then
				arg_133_1.var_.actorSpriteComps1148 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.125

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps1148 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps1148 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1148 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.275

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_10 = arg_133_1:FormatText(StoryNameCfg[1082].name)

				arg_133_1.leftNameTxt_.text = var_136_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_11 = arg_133_1:GetWordFromCfg(416101033)
				local var_136_12 = arg_133_1:FormatText(var_136_11.content)

				arg_133_1.text_.text = var_136_12

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 11
				local var_136_14 = utf8.len(var_136_12)
				local var_136_15 = var_136_13 <= 0 and var_136_9 or var_136_9 * (var_136_14 / var_136_13)

				if var_136_15 > 0 and var_136_9 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_12
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101033", "story_v_out_416101.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101033", "story_v_out_416101.awb") / 1000

					if var_136_16 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_8
					end

					if var_136_11.prefab_name ~= "" and arg_133_1.actors_[var_136_11.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_11.prefab_name].transform, "story_v_out_416101", "416101033", "story_v_out_416101.awb")

						arg_133_1:RecordAudio("416101033", var_136_17)
						arg_133_1:RecordAudio("416101033", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416101", "416101033", "story_v_out_416101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416101", "416101033", "story_v_out_416101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_18 and arg_133_1.time_ < var_136_8 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play416101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416101034
		arg_137_1.duration_ = 7.27

		local var_137_0 = {
			zh = 4.666,
			ja = 7.266
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
				arg_137_0:Play416101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1148"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1148 == nil then
				arg_137_1.var_.actorSpriteComps1148 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.125

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1148 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1148 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1148 = nil
			end

			local var_140_8 = arg_137_1.actors_["1148"].transform
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 3)

				local var_140_10 = var_140_8.childCount

				for iter_140_4 = 0, var_140_10 - 1 do
					local var_140_11 = var_140_8:GetChild(iter_140_4)

					if var_140_11.name == "split_1_1" or not string.find(var_140_11.name, "split") then
						var_140_11.gameObject:SetActive(true)
					else
						var_140_11.gameObject:SetActive(false)
					end
				end
			end

			local var_140_12 = 0.001

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_9) / var_140_12
				local var_140_14 = Vector3.New(0, -429, -180)

				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, var_140_14, var_140_13)
			end

			if arg_137_1.time_ >= var_140_9 + var_140_12 and arg_137_1.time_ < var_140_9 + var_140_12 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_140_15 = 0
			local var_140_16 = 0.475

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[8].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(416101034)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101034", "story_v_out_416101.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101034", "story_v_out_416101.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_416101", "416101034", "story_v_out_416101.awb")

						arg_137_1:RecordAudio("416101034", var_140_24)
						arg_137_1:RecordAudio("416101034", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416101", "416101034", "story_v_out_416101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416101", "416101034", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416101035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1148"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1148", 7)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -2000, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_7 = 0
			local var_144_8 = 1

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				local var_144_9 = "play"
				local var_144_10 = "effect"

				arg_141_1:AudioAction(var_144_9, var_144_10, "se_story_16", "se_story_16_archery", "")
			end

			local var_144_11 = 0
			local var_144_12 = 1.8

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(416101035)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 72
				local var_144_16 = utf8.len(var_144_14)
				local var_144_17 = var_144_15 <= 0 and var_144_12 or var_144_12 * (var_144_16 / var_144_15)

				if var_144_17 > 0 and var_144_12 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_18 and arg_141_1.time_ < var_144_11 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play416101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416101036
		arg_145_1.duration_ = 7.27

		local var_145_0 = {
			zh = 4.766,
			ja = 7.266
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
				arg_145_0:Play416101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1148"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1148 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1148", 3)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_6" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -429, -180)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1148, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_148_7 = arg_145_1.actors_["1148"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1148 == nil then
				arg_145_1.var_.actorSpriteComps1148 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.125

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps1148 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1148 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1148 = nil
			end

			local var_148_15 = 0
			local var_148_16 = 0.5

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[8].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(416101036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101036", "story_v_out_416101.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101036", "story_v_out_416101.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_416101", "416101036", "story_v_out_416101.awb")

						arg_145_1:RecordAudio("416101036", var_148_24)
						arg_145_1:RecordAudio("416101036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416101", "416101036", "story_v_out_416101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416101", "416101036", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416101037
		arg_149_1.duration_ = 4.07

		local var_149_0 = {
			zh = 2.8,
			ja = 4.066
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
				arg_149_0:Play416101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.3

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[8].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(416101037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 12
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101037", "story_v_out_416101.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101037", "story_v_out_416101.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_416101", "416101037", "story_v_out_416101.awb")

						arg_149_1:RecordAudio("416101037", var_152_9)
						arg_149_1:RecordAudio("416101037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416101", "416101037", "story_v_out_416101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416101", "416101037", "story_v_out_416101.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416101038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1148"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1148 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1148", 7)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(0, -2000, 0)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1148, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_7 = 0
			local var_156_8 = 1.2

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_9 = arg_153_1:GetWordFromCfg(416101038)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 48
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_8 or var_156_8 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_8 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_7 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_7
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_8, arg_153_1.talkMaxDuration)

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_7) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_7 + var_156_14 and arg_153_1.time_ < var_156_7 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play416101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416101039
		arg_157_1.duration_ = 9

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 4

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_1 = 0.3

			if arg_157_1.time_ >= var_160_0 + var_160_1 and arg_157_1.time_ < var_160_0 + var_160_1 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_2 = 2

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				local var_160_3 = manager.ui.mainCamera.transform.localPosition
				local var_160_4 = Vector3.New(0, 0, 10) + Vector3.New(var_160_3.x, var_160_3.y, 0)
				local var_160_5 = arg_157_1.bgs_.I13f

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
					if iter_160_0 ~= "I13f" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_17 = 2

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17
				local var_160_19 = Color.New(0, 0, 0)

				var_160_19.a = Mathf.Lerp(0, 1, var_160_18)
				arg_157_1.mask_.color = var_160_19
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				local var_160_20 = Color.New(0, 0, 0)

				var_160_20.a = 1
				arg_157_1.mask_.color = var_160_20
			end

			local var_160_21 = 2

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_22 = 2

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_22 then
				local var_160_23 = (arg_157_1.time_ - var_160_21) / var_160_22
				local var_160_24 = Color.New(0, 0, 0)

				var_160_24.a = Mathf.Lerp(1, 0, var_160_23)
				arg_157_1.mask_.color = var_160_24
			end

			if arg_157_1.time_ >= var_160_21 + var_160_22 and arg_157_1.time_ < var_160_21 + var_160_22 + arg_160_0 then
				local var_160_25 = Color.New(0, 0, 0)
				local var_160_26 = 0

				arg_157_1.mask_.enabled = false
				var_160_25.a = var_160_26
				arg_157_1.mask_.color = var_160_25
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_27 = 4
			local var_160_28 = 1.625

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

				local var_160_30 = arg_157_1:GetWordFromCfg(416101039)
				local var_160_31 = arg_157_1:FormatText(var_160_30.content)

				arg_157_1.text_.text = var_160_31

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_32 = 65
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

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416101040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416101040
		arg_163_1.duration_ = 4.9

		local var_163_0 = {
			zh = 4.333,
			ja = 4.9
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
				arg_163_0:Play416101041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1148"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 3)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_6" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(0, -429, -180)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_166_7 = arg_163_1.actors_["1148"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps1148 == nil then
				arg_163_1.var_.actorSpriteComps1148 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 0.125

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps1148 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps1148 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1148 = nil
			end

			local var_166_15 = 0
			local var_166_16 = 0.4

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[8].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(416101040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 16
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101040", "story_v_out_416101.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101040", "story_v_out_416101.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_416101", "416101040", "story_v_out_416101.awb")

						arg_163_1:RecordAudio("416101040", var_166_24)
						arg_163_1:RecordAudio("416101040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416101", "416101040", "story_v_out_416101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416101", "416101040", "story_v_out_416101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play416101041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416101041
		arg_167_1.duration_ = 6.33

		local var_167_0 = {
			zh = 6.333,
			ja = 4.366
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
				arg_167_0:Play416101042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.6

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[8].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(416101041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101041", "story_v_out_416101.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101041", "story_v_out_416101.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_416101", "416101041", "story_v_out_416101.awb")

						arg_167_1:RecordAudio("416101041", var_170_9)
						arg_167_1:RecordAudio("416101041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416101", "416101041", "story_v_out_416101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416101", "416101041", "story_v_out_416101.awb")
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
	Play416101042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416101042
		arg_171_1.duration_ = 8.33

		local var_171_0 = {
			zh = 5.6,
			ja = 8.333
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
				arg_171_0:Play416101043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1148"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1148 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1148", 2)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "split_6" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(-390, -429, -180)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1148, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_174_7 = arg_171_1.actors_["1148"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1148 == nil then
				arg_171_1.var_.actorSpriteComps1148 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.125

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps1148 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor2.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor2.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor2.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 0.5, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1148 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1148 = nil
			end

			local var_174_15 = arg_171_1.actors_["10108"].transform
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.moveOldPos10108 = var_174_15.localPosition
				var_174_15.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10108", 4)

				local var_174_17 = var_174_15.childCount

				for iter_174_5 = 0, var_174_17 - 1 do
					local var_174_18 = var_174_15:GetChild(iter_174_5)

					if var_174_18.name == "" or not string.find(var_174_18.name, "split") then
						var_174_18.gameObject:SetActive(true)
					else
						var_174_18.gameObject:SetActive(false)
					end
				end
			end

			local var_174_19 = 0.001

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_19 then
				local var_174_20 = (arg_171_1.time_ - var_174_16) / var_174_19
				local var_174_21 = Vector3.New(390, -399.6, -130)

				var_174_15.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10108, var_174_21, var_174_20)
			end

			if arg_171_1.time_ >= var_174_16 + var_174_19 and arg_171_1.time_ < var_174_16 + var_174_19 + arg_174_0 then
				var_174_15.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_174_22 = arg_171_1.actors_["10108"]
			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10108 == nil then
				arg_171_1.var_.actorSpriteComps10108 = var_174_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_24 = 0.125

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 and not isNil(var_174_22) then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24

				if arg_171_1.var_.actorSpriteComps10108 then
					for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_174_7 then
							if arg_171_1.isInRecall_ then
								local var_174_26 = Mathf.Lerp(iter_174_7.color.r, arg_171_1.hightColor1.r, var_174_25)
								local var_174_27 = Mathf.Lerp(iter_174_7.color.g, arg_171_1.hightColor1.g, var_174_25)
								local var_174_28 = Mathf.Lerp(iter_174_7.color.b, arg_171_1.hightColor1.b, var_174_25)

								iter_174_7.color = Color.New(var_174_26, var_174_27, var_174_28)
							else
								local var_174_29 = Mathf.Lerp(iter_174_7.color.r, 1, var_174_25)

								iter_174_7.color = Color.New(var_174_29, var_174_29, var_174_29)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10108 then
				for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_174_9 then
						if arg_171_1.isInRecall_ then
							iter_174_9.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10108 = nil
			end

			local var_174_30 = 0
			local var_174_31 = 0.5

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[1083].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(416101042)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 20
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101042", "story_v_out_416101.awb") ~= 0 then
					local var_174_38 = manager.audio:GetVoiceLength("story_v_out_416101", "416101042", "story_v_out_416101.awb") / 1000

					if var_174_38 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_38 + var_174_30
					end

					if var_174_33.prefab_name ~= "" and arg_171_1.actors_[var_174_33.prefab_name] ~= nil then
						local var_174_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_33.prefab_name].transform, "story_v_out_416101", "416101042", "story_v_out_416101.awb")

						arg_171_1:RecordAudio("416101042", var_174_39)
						arg_171_1:RecordAudio("416101042", var_174_39)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416101", "416101042", "story_v_out_416101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416101", "416101042", "story_v_out_416101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_40 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_40 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_40

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_40 and arg_171_1.time_ < var_174_30 + var_174_40 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "10108",
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
	Play416101043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416101043
		arg_175_1.duration_ = 8.23

		local var_175_0 = {
			zh = 6,
			ja = 8.233
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
				arg_175_0:Play416101044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.525

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[1083].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(416101043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101043", "story_v_out_416101.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101043", "story_v_out_416101.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_416101", "416101043", "story_v_out_416101.awb")

						arg_175_1:RecordAudio("416101043", var_178_9)
						arg_175_1:RecordAudio("416101043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416101", "416101043", "story_v_out_416101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416101", "416101043", "story_v_out_416101.awb")
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
	Play416101044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416101044
		arg_179_1.duration_ = 6.33

		local var_179_0 = {
			zh = 5.3,
			ja = 6.333
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
				arg_179_0:Play416101045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10108"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10108 == nil then
				arg_179_1.var_.actorSpriteComps10108 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.125

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps10108 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 0.5, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10108 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10108 = nil
			end

			local var_182_8 = arg_179_1.actors_["1148"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1148 == nil then
				arg_179_1.var_.actorSpriteComps1148 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.125

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps1148 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_12 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor1.r, var_182_11)
								local var_182_13 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor1.g, var_182_11)
								local var_182_14 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor1.b, var_182_11)

								iter_182_5.color = Color.New(var_182_12, var_182_13, var_182_14)
							else
								local var_182_15 = Mathf.Lerp(iter_182_5.color.r, 1, var_182_11)

								iter_182_5.color = Color.New(var_182_15, var_182_15, var_182_15)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1148 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1148 = nil
			end

			local var_182_16 = arg_179_1.actors_["1148"].transform
			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.var_.moveOldPos1148 = var_182_16.localPosition
				var_182_16.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1148", 2)

				local var_182_18 = var_182_16.childCount

				for iter_182_8 = 0, var_182_18 - 1 do
					local var_182_19 = var_182_16:GetChild(iter_182_8)

					if var_182_19.name == "split_4" or not string.find(var_182_19.name, "split") then
						var_182_19.gameObject:SetActive(true)
					else
						var_182_19.gameObject:SetActive(false)
					end
				end
			end

			local var_182_20 = 0.001

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_20 then
				local var_182_21 = (arg_179_1.time_ - var_182_17) / var_182_20
				local var_182_22 = Vector3.New(-390, -429, -180)

				var_182_16.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1148, var_182_22, var_182_21)
			end

			if arg_179_1.time_ >= var_182_17 + var_182_20 and arg_179_1.time_ < var_182_17 + var_182_20 + arg_182_0 then
				var_182_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_182_23 = 0
			local var_182_24 = 0.5

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[8].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(416101044)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 20
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101044", "story_v_out_416101.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_416101", "416101044", "story_v_out_416101.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_416101", "416101044", "story_v_out_416101.awb")

						arg_179_1:RecordAudio("416101044", var_182_32)
						arg_179_1:RecordAudio("416101044", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416101", "416101044", "story_v_out_416101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416101", "416101044", "story_v_out_416101.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play416101045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416101045
		arg_183_1.duration_ = 4.83

		local var_183_0 = {
			zh = 4.266,
			ja = 4.833
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
				arg_183_0:Play416101046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1148"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1148 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1148", 7)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(0, -2000, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1148, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_7 = arg_183_1.actors_["10108"].transform
			local var_186_8 = 0

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.var_.moveOldPos10108 = var_186_7.localPosition
				var_186_7.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10108", 7)

				local var_186_9 = var_186_7.childCount

				for iter_186_1 = 0, var_186_9 - 1 do
					local var_186_10 = var_186_7:GetChild(iter_186_1)

					if var_186_10.name == "" or not string.find(var_186_10.name, "split") then
						var_186_10.gameObject:SetActive(true)
					else
						var_186_10.gameObject:SetActive(false)
					end
				end
			end

			local var_186_11 = 0.001

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_11 then
				local var_186_12 = (arg_183_1.time_ - var_186_8) / var_186_11
				local var_186_13 = Vector3.New(0, -2000, 0)

				var_186_7.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10108, var_186_13, var_186_12)
			end

			if arg_183_1.time_ >= var_186_8 + var_186_11 and arg_183_1.time_ < var_186_8 + var_186_11 + arg_186_0 then
				var_186_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_14 = 0
			local var_186_15 = 0.525

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_16 = arg_183_1:FormatText(StoryNameCfg[1082].name)

				arg_183_1.leftNameTxt_.text = var_186_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_17 = arg_183_1:GetWordFromCfg(416101045)
				local var_186_18 = arg_183_1:FormatText(var_186_17.content)

				arg_183_1.text_.text = var_186_18

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 21
				local var_186_20 = utf8.len(var_186_18)
				local var_186_21 = var_186_19 <= 0 and var_186_15 or var_186_15 * (var_186_20 / var_186_19)

				if var_186_21 > 0 and var_186_15 < var_186_21 then
					arg_183_1.talkMaxDuration = var_186_21

					if var_186_21 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_21 + var_186_14
					end
				end

				arg_183_1.text_.text = var_186_18
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101045", "story_v_out_416101.awb") ~= 0 then
					local var_186_22 = manager.audio:GetVoiceLength("story_v_out_416101", "416101045", "story_v_out_416101.awb") / 1000

					if var_186_22 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_14
					end

					if var_186_17.prefab_name ~= "" and arg_183_1.actors_[var_186_17.prefab_name] ~= nil then
						local var_186_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_17.prefab_name].transform, "story_v_out_416101", "416101045", "story_v_out_416101.awb")

						arg_183_1:RecordAudio("416101045", var_186_23)
						arg_183_1:RecordAudio("416101045", var_186_23)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416101", "416101045", "story_v_out_416101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416101", "416101045", "story_v_out_416101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_24 = math.max(var_186_15, arg_183_1.talkMaxDuration)

			if var_186_14 <= arg_183_1.time_ and arg_183_1.time_ < var_186_14 + var_186_24 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_14) / var_186_24

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_14 + var_186_24 and arg_183_1.time_ < var_186_14 + var_186_24 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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
				actorName = "10108",
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
	Play416101046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416101046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play416101047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.55

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

				local var_190_2 = arg_187_1:GetWordFromCfg(416101046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 62
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
	Play416101047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416101047
		arg_191_1.duration_ = 5.6

		local var_191_0 = {
			zh = 4.933,
			ja = 5.6
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
				arg_191_0:Play416101048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.525

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[1082].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(416101047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101047", "story_v_out_416101.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101047", "story_v_out_416101.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_416101", "416101047", "story_v_out_416101.awb")

						arg_191_1:RecordAudio("416101047", var_194_9)
						arg_191_1:RecordAudio("416101047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416101", "416101047", "story_v_out_416101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416101", "416101047", "story_v_out_416101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play416101048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416101048
		arg_195_1.duration_ = 3.87

		local var_195_0 = {
			zh = 3.866,
			ja = 3.666
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
				arg_195_0:Play416101049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1148"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1148", 3)

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
				local var_198_6 = Vector3.New(0, -429, -180)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_198_7 = arg_195_1.actors_["1148"]
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.actorSpriteComps1148 == nil then
				arg_195_1.var_.actorSpriteComps1148 = var_198_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_9 = 0.125

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_9 and not isNil(var_198_7) then
				local var_198_10 = (arg_195_1.time_ - var_198_8) / var_198_9

				if arg_195_1.var_.actorSpriteComps1148 then
					for iter_198_1, iter_198_2 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_198_2 then
							if arg_195_1.isInRecall_ then
								local var_198_11 = Mathf.Lerp(iter_198_2.color.r, arg_195_1.hightColor1.r, var_198_10)
								local var_198_12 = Mathf.Lerp(iter_198_2.color.g, arg_195_1.hightColor1.g, var_198_10)
								local var_198_13 = Mathf.Lerp(iter_198_2.color.b, arg_195_1.hightColor1.b, var_198_10)

								iter_198_2.color = Color.New(var_198_11, var_198_12, var_198_13)
							else
								local var_198_14 = Mathf.Lerp(iter_198_2.color.r, 1, var_198_10)

								iter_198_2.color = Color.New(var_198_14, var_198_14, var_198_14)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_8 + var_198_9 and arg_195_1.time_ < var_198_8 + var_198_9 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.actorSpriteComps1148 then
				for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_198_4 then
						if arg_195_1.isInRecall_ then
							iter_198_4.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1148 = nil
			end

			local var_198_15 = 0
			local var_198_16 = 0.45

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[8].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(416101048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 18
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101048", "story_v_out_416101.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101048", "story_v_out_416101.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_416101", "416101048", "story_v_out_416101.awb")

						arg_195_1:RecordAudio("416101048", var_198_24)
						arg_195_1:RecordAudio("416101048", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416101", "416101048", "story_v_out_416101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416101", "416101048", "story_v_out_416101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play416101049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416101049
		arg_199_1.duration_ = 8.1

		local var_199_0 = {
			zh = 3.266,
			ja = 8.1
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
				arg_199_0:Play416101050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1148"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1148 == nil then
				arg_199_1.var_.actorSpriteComps1148 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.125

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps1148 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1148 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1148 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.275

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[1082].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(416101049)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101049", "story_v_out_416101.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101049", "story_v_out_416101.awb") / 1000

					if var_202_16 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_8
					end

					if var_202_11.prefab_name ~= "" and arg_199_1.actors_[var_202_11.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_11.prefab_name].transform, "story_v_out_416101", "416101049", "story_v_out_416101.awb")

						arg_199_1:RecordAudio("416101049", var_202_17)
						arg_199_1:RecordAudio("416101049", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416101", "416101049", "story_v_out_416101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416101", "416101049", "story_v_out_416101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_18 and arg_199_1.time_ < var_202_8 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416101050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416101050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416101051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1.725

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(416101050)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 69
				local var_206_5 = utf8.len(var_206_3)
				local var_206_6 = var_206_4 <= 0 and var_206_1 or var_206_1 * (var_206_5 / var_206_4)

				if var_206_6 > 0 and var_206_1 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_7 and arg_203_1.time_ < var_206_0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play416101051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416101051
		arg_207_1.duration_ = 4.3

		local var_207_0 = {
			zh = 4.3,
			ja = 3.5
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play416101052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1148"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1148 == nil then
				arg_207_1.var_.actorSpriteComps1148 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.125

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps1148 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 1, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1148 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1148 = nil
			end

			local var_210_8 = arg_207_1.actors_["1148"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos1148 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1148", 3)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "split_3" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(0, -429, -180)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1148, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_210_15 = 0
			local var_210_16 = 0.525

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[8].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(416101051)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 21
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101051", "story_v_out_416101.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101051", "story_v_out_416101.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_416101", "416101051", "story_v_out_416101.awb")

						arg_207_1:RecordAudio("416101051", var_210_24)
						arg_207_1:RecordAudio("416101051", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416101", "416101051", "story_v_out_416101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416101", "416101051", "story_v_out_416101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play416101052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416101052
		arg_211_1.duration_ = 4.87

		local var_211_0 = {
			zh = 4.866,
			ja = 3.633
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play416101053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.55

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[8].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(416101052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 22
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101052", "story_v_out_416101.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101052", "story_v_out_416101.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_416101", "416101052", "story_v_out_416101.awb")

						arg_211_1:RecordAudio("416101052", var_214_9)
						arg_211_1:RecordAudio("416101052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416101", "416101052", "story_v_out_416101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416101", "416101052", "story_v_out_416101.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play416101053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416101053
		arg_215_1.duration_ = 5.17

		local var_215_0 = {
			zh = 3.233,
			ja = 5.166
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416101054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.225

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[8].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:GetWordFromCfg(416101053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 9
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101053", "story_v_out_416101.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101053", "story_v_out_416101.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_416101", "416101053", "story_v_out_416101.awb")

						arg_215_1:RecordAudio("416101053", var_218_9)
						arg_215_1:RecordAudio("416101053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416101", "416101053", "story_v_out_416101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416101", "416101053", "story_v_out_416101.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play416101054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416101054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416101055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1148"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1148 = var_222_0.localPosition
				var_222_0.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1148", 7)

				local var_222_2 = var_222_0.childCount

				for iter_222_0 = 0, var_222_2 - 1 do
					local var_222_3 = var_222_0:GetChild(iter_222_0)

					if var_222_3.name == "" or not string.find(var_222_3.name, "split") then
						var_222_3.gameObject:SetActive(true)
					else
						var_222_3.gameObject:SetActive(false)
					end
				end
			end

			local var_222_4 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_4 then
				local var_222_5 = (arg_219_1.time_ - var_222_1) / var_222_4
				local var_222_6 = Vector3.New(0, -2000, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1148, var_222_6, var_222_5)
			end

			if arg_219_1.time_ >= var_222_1 + var_222_4 and arg_219_1.time_ < var_222_1 + var_222_4 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_7 = 0
			local var_222_8 = 1.375

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(416101054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 55
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_8 or var_222_8 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_8 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_7) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_7 + var_222_14 and arg_219_1.time_ < var_222_7 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play416101055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416101055
		arg_223_1.duration_ = 4.63

		local var_223_0 = {
			zh = 3.733,
			ja = 4.633
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
				arg_223_0:Play416101056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1148"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1148", 3)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "split_4" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(0, -429, -180)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_226_7 = arg_223_1.actors_["1148"]
			local var_226_8 = 0

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1148 == nil then
				arg_223_1.var_.actorSpriteComps1148 = var_226_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_9 = 0.125

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 and not isNil(var_226_7) then
				local var_226_10 = (arg_223_1.time_ - var_226_8) / var_226_9

				if arg_223_1.var_.actorSpriteComps1148 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								local var_226_11 = Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, var_226_10)
								local var_226_12 = Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, var_226_10)
								local var_226_13 = Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, var_226_10)

								iter_226_2.color = Color.New(var_226_11, var_226_12, var_226_13)
							else
								local var_226_14 = Mathf.Lerp(iter_226_2.color.r, 1, var_226_10)

								iter_226_2.color = Color.New(var_226_14, var_226_14, var_226_14)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1148 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_226_4 then
						if arg_223_1.isInRecall_ then
							iter_226_4.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1148 = nil
			end

			local var_226_15 = 0
			local var_226_16 = 0.3

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[8].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(416101055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 12
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101055", "story_v_out_416101.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101055", "story_v_out_416101.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_416101", "416101055", "story_v_out_416101.awb")

						arg_223_1:RecordAudio("416101055", var_226_24)
						arg_223_1:RecordAudio("416101055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416101", "416101055", "story_v_out_416101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416101", "416101055", "story_v_out_416101.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play416101056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416101056
		arg_227_1.duration_ = 7.67

		local var_227_0 = {
			zh = 4,
			ja = 7.666
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
				arg_227_0:Play416101057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1148"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1148 == nil then
				arg_227_1.var_.actorSpriteComps1148 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.125

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1148 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 0.5, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1148 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1148 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.575

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_10 = arg_227_1:FormatText(StoryNameCfg[1082].name)

				arg_227_1.leftNameTxt_.text = var_230_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_11 = arg_227_1:GetWordFromCfg(416101056)
				local var_230_12 = arg_227_1:FormatText(var_230_11.content)

				arg_227_1.text_.text = var_230_12

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 23
				local var_230_14 = utf8.len(var_230_12)
				local var_230_15 = var_230_13 <= 0 and var_230_9 or var_230_9 * (var_230_14 / var_230_13)

				if var_230_15 > 0 and var_230_9 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_12
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101056", "story_v_out_416101.awb") ~= 0 then
					local var_230_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101056", "story_v_out_416101.awb") / 1000

					if var_230_16 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_8
					end

					if var_230_11.prefab_name ~= "" and arg_227_1.actors_[var_230_11.prefab_name] ~= nil then
						local var_230_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_11.prefab_name].transform, "story_v_out_416101", "416101056", "story_v_out_416101.awb")

						arg_227_1:RecordAudio("416101056", var_230_17)
						arg_227_1:RecordAudio("416101056", var_230_17)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416101", "416101056", "story_v_out_416101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416101", "416101056", "story_v_out_416101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_18 and arg_227_1.time_ < var_230_8 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416101057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416101057
		arg_231_1.duration_ = 6

		local var_231_0 = {
			zh = 6,
			ja = 5.433
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
				arg_231_0:Play416101058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1148"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1148 == nil then
				arg_231_1.var_.actorSpriteComps1148 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.125

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1148 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1148 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1148 = nil
			end

			local var_234_8 = 0
			local var_234_9 = 0.525

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_10 = arg_231_1:FormatText(StoryNameCfg[8].name)

				arg_231_1.leftNameTxt_.text = var_234_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_11 = arg_231_1:GetWordFromCfg(416101057)
				local var_234_12 = arg_231_1:FormatText(var_234_11.content)

				arg_231_1.text_.text = var_234_12

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 21
				local var_234_14 = utf8.len(var_234_12)
				local var_234_15 = var_234_13 <= 0 and var_234_9 or var_234_9 * (var_234_14 / var_234_13)

				if var_234_15 > 0 and var_234_9 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_12
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101057", "story_v_out_416101.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101057", "story_v_out_416101.awb") / 1000

					if var_234_16 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_8
					end

					if var_234_11.prefab_name ~= "" and arg_231_1.actors_[var_234_11.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_11.prefab_name].transform, "story_v_out_416101", "416101057", "story_v_out_416101.awb")

						arg_231_1:RecordAudio("416101057", var_234_17)
						arg_231_1:RecordAudio("416101057", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416101", "416101057", "story_v_out_416101.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416101", "416101057", "story_v_out_416101.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_18 and arg_231_1.time_ < var_234_8 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416101058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416101058
		arg_235_1.duration_ = 4.6

		local var_235_0 = {
			zh = 4.6,
			ja = 4.266
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
				arg_235_0:Play416101059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1148"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1148 == nil then
				arg_235_1.var_.actorSpriteComps1148 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.125

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1148 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1148 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1148 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 0.6

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_10 = arg_235_1:FormatText(StoryNameCfg[1082].name)

				arg_235_1.leftNameTxt_.text = var_238_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_11 = arg_235_1:GetWordFromCfg(416101058)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 24
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_9 or var_238_9 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_9 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101058", "story_v_out_416101.awb") ~= 0 then
					local var_238_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101058", "story_v_out_416101.awb") / 1000

					if var_238_16 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_8
					end

					if var_238_11.prefab_name ~= "" and arg_235_1.actors_[var_238_11.prefab_name] ~= nil then
						local var_238_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_11.prefab_name].transform, "story_v_out_416101", "416101058", "story_v_out_416101.awb")

						arg_235_1:RecordAudio("416101058", var_238_17)
						arg_235_1:RecordAudio("416101058", var_238_17)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416101", "416101058", "story_v_out_416101.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416101", "416101058", "story_v_out_416101.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_18 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_18 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_18

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_18 and arg_235_1.time_ < var_238_8 + var_238_18 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416101059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416101059
		arg_239_1.duration_ = 5.53

		local var_239_0 = {
			zh = 2.833,
			ja = 5.533
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
				arg_239_0:Play416101060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.325

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[1082].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(416101059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101059", "story_v_out_416101.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101059", "story_v_out_416101.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_416101", "416101059", "story_v_out_416101.awb")

						arg_239_1:RecordAudio("416101059", var_242_9)
						arg_239_1:RecordAudio("416101059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416101", "416101059", "story_v_out_416101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416101", "416101059", "story_v_out_416101.awb")
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
	Play416101060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416101060
		arg_243_1.duration_ = 4.4

		local var_243_0 = {
			zh = 4.4,
			ja = 4.2
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
				arg_243_0:Play416101061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1148"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1148 == nil then
				arg_243_1.var_.actorSpriteComps1148 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.125

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1148 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1148 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1148 = nil
			end

			local var_246_8 = arg_243_1.actors_["1148"].transform
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.var_.moveOldPos1148 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1148", 3)

				local var_246_10 = var_246_8.childCount

				for iter_246_4 = 0, var_246_10 - 1 do
					local var_246_11 = var_246_8:GetChild(iter_246_4)

					if var_246_11.name == "split_5" or not string.find(var_246_11.name, "split") then
						var_246_11.gameObject:SetActive(true)
					else
						var_246_11.gameObject:SetActive(false)
					end
				end
			end

			local var_246_12 = 0.001

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_9) / var_246_12
				local var_246_14 = Vector3.New(0, -429, -180)

				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1148, var_246_14, var_246_13)
			end

			if arg_243_1.time_ >= var_246_9 + var_246_12 and arg_243_1.time_ < var_246_9 + var_246_12 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_246_15 = 0
			local var_246_16 = 0.325

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[8].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(416101060)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 13
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101060", "story_v_out_416101.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101060", "story_v_out_416101.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_416101", "416101060", "story_v_out_416101.awb")

						arg_243_1:RecordAudio("416101060", var_246_24)
						arg_243_1:RecordAudio("416101060", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416101", "416101060", "story_v_out_416101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416101", "416101060", "story_v_out_416101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play416101061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416101061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play416101062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1148"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1148 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1148", 7)

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

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1148, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_7 = 0
			local var_250_8 = 1.15

			if var_250_7 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(416101061)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 46
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_8 or var_250_8 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_8 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_7 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_7
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_8, arg_247_1.talkMaxDuration)

			if var_250_7 <= arg_247_1.time_ and arg_247_1.time_ < var_250_7 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_7) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_7 + var_250_14 and arg_247_1.time_ < var_250_7 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play416101062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416101062
		arg_251_1.duration_ = 8.57

		local var_251_0 = {
			zh = 3.933,
			ja = 8.566
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
				arg_251_0:Play416101063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1148"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1148 = var_254_0.localPosition
				var_254_0.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1148", 3)

				local var_254_2 = var_254_0.childCount

				for iter_254_0 = 0, var_254_2 - 1 do
					local var_254_3 = var_254_0:GetChild(iter_254_0)

					if var_254_3.name == "split_4" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_4 then
				local var_254_5 = (arg_251_1.time_ - var_254_1) / var_254_4
				local var_254_6 = Vector3.New(0, -429, -180)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1148, var_254_6, var_254_5)
			end

			if arg_251_1.time_ >= var_254_1 + var_254_4 and arg_251_1.time_ < var_254_1 + var_254_4 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_254_7 = arg_251_1.actors_["1148"]
			local var_254_8 = 0

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1148 == nil then
				arg_251_1.var_.actorSpriteComps1148 = var_254_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_9 = 0.125

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 and not isNil(var_254_7) then
				local var_254_10 = (arg_251_1.time_ - var_254_8) / var_254_9

				if arg_251_1.var_.actorSpriteComps1148 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								local var_254_11 = Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, var_254_10)
								local var_254_12 = Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, var_254_10)
								local var_254_13 = Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, var_254_10)

								iter_254_2.color = Color.New(var_254_11, var_254_12, var_254_13)
							else
								local var_254_14 = Mathf.Lerp(iter_254_2.color.r, 1, var_254_10)

								iter_254_2.color = Color.New(var_254_14, var_254_14, var_254_14)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1148 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_254_4 then
						if arg_251_1.isInRecall_ then
							iter_254_4.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1148 = nil
			end

			local var_254_15 = 0
			local var_254_16 = 0.475

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[8].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(416101062)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101062", "story_v_out_416101.awb") ~= 0 then
					local var_254_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101062", "story_v_out_416101.awb") / 1000

					if var_254_23 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_23 + var_254_15
					end

					if var_254_18.prefab_name ~= "" and arg_251_1.actors_[var_254_18.prefab_name] ~= nil then
						local var_254_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_18.prefab_name].transform, "story_v_out_416101", "416101062", "story_v_out_416101.awb")

						arg_251_1:RecordAudio("416101062", var_254_24)
						arg_251_1:RecordAudio("416101062", var_254_24)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416101", "416101062", "story_v_out_416101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416101", "416101062", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416101063
		arg_255_1.duration_ = 3.4

		local var_255_0 = {
			zh = 3.4,
			ja = 2.9
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
				arg_255_0:Play416101064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.3

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[8].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(416101063)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101063", "story_v_out_416101.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101063", "story_v_out_416101.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_416101", "416101063", "story_v_out_416101.awb")

						arg_255_1:RecordAudio("416101063", var_258_9)
						arg_255_1:RecordAudio("416101063", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416101", "416101063", "story_v_out_416101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416101", "416101063", "story_v_out_416101.awb")
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
	Play416101064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416101064
		arg_259_1.duration_ = 9.17

		local var_259_0 = {
			zh = 2.4,
			ja = 9.166
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
				arg_259_0:Play416101065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.225

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[8].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(416101064)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 9
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101064", "story_v_out_416101.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101064", "story_v_out_416101.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_416101", "416101064", "story_v_out_416101.awb")

						arg_259_1:RecordAudio("416101064", var_262_9)
						arg_259_1:RecordAudio("416101064", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416101", "416101064", "story_v_out_416101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416101", "416101064", "story_v_out_416101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play416101065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416101065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play416101066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1148"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1148 = var_266_0.localPosition
				var_266_0.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1148", 7)

				local var_266_2 = var_266_0.childCount

				for iter_266_0 = 0, var_266_2 - 1 do
					local var_266_3 = var_266_0:GetChild(iter_266_0)

					if var_266_3.name == "" or not string.find(var_266_3.name, "split") then
						var_266_3.gameObject:SetActive(true)
					else
						var_266_3.gameObject:SetActive(false)
					end
				end
			end

			local var_266_4 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_4 then
				local var_266_5 = (arg_263_1.time_ - var_266_1) / var_266_4
				local var_266_6 = Vector3.New(0, -2000, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1148, var_266_6, var_266_5)
			end

			if arg_263_1.time_ >= var_266_1 + var_266_4 and arg_263_1.time_ < var_266_1 + var_266_4 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_266_7 = 0
			local var_266_8 = 1.925

			if var_266_7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_9 = arg_263_1:GetWordFromCfg(416101065)
				local var_266_10 = arg_263_1:FormatText(var_266_9.content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 77
				local var_266_12 = utf8.len(var_266_10)
				local var_266_13 = var_266_11 <= 0 and var_266_8 or var_266_8 * (var_266_12 / var_266_11)

				if var_266_13 > 0 and var_266_8 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_7 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_7
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_8, arg_263_1.talkMaxDuration)

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_7) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_7 + var_266_14 and arg_263_1.time_ < var_266_7 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play416101066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416101066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416101067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.2

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(416101066)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 48
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416101067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416101067
		arg_271_1.duration_ = 6.73

		local var_271_0 = {
			zh = 2.7,
			ja = 6.733
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
				arg_271_0:Play416101068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10108"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos10108 = var_274_0.localPosition
				var_274_0.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10108", 3)

				local var_274_2 = var_274_0.childCount

				for iter_274_0 = 0, var_274_2 - 1 do
					local var_274_3 = var_274_0:GetChild(iter_274_0)

					if var_274_3.name == "split_3" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_4 then
				local var_274_5 = (arg_271_1.time_ - var_274_1) / var_274_4
				local var_274_6 = Vector3.New(0, -399.6, -130)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10108, var_274_6, var_274_5)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_4 and arg_271_1.time_ < var_274_1 + var_274_4 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_274_7 = arg_271_1.actors_["10108"]
			local var_274_8 = 0

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps10108 == nil then
				arg_271_1.var_.actorSpriteComps10108 = var_274_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_9 = 0.125

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 and not isNil(var_274_7) then
				local var_274_10 = (arg_271_1.time_ - var_274_8) / var_274_9

				if arg_271_1.var_.actorSpriteComps10108 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								local var_274_11 = Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor1.r, var_274_10)
								local var_274_12 = Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor1.g, var_274_10)
								local var_274_13 = Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor1.b, var_274_10)

								iter_274_2.color = Color.New(var_274_11, var_274_12, var_274_13)
							else
								local var_274_14 = Mathf.Lerp(iter_274_2.color.r, 1, var_274_10)

								iter_274_2.color = Color.New(var_274_14, var_274_14, var_274_14)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps10108 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_274_4 then
						if arg_271_1.isInRecall_ then
							iter_274_4.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10108 = nil
			end

			local var_274_15 = 0
			local var_274_16 = 0.3

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[1083].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(416101067)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101067", "story_v_out_416101.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101067", "story_v_out_416101.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_416101", "416101067", "story_v_out_416101.awb")

						arg_271_1:RecordAudio("416101067", var_274_24)
						arg_271_1:RecordAudio("416101067", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416101", "416101067", "story_v_out_416101.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416101", "416101067", "story_v_out_416101.awb")
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
				actorName = "10108",
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
	Play416101068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416101068
		arg_275_1.duration_ = 4.5

		local var_275_0 = {
			zh = 3.8,
			ja = 4.5
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
				arg_275_0:Play416101069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10108"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10108 == nil then
				arg_275_1.var_.actorSpriteComps10108 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.125

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10108 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 0.5, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10108 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10108 = nil
			end

			local var_278_8 = 0
			local var_278_9 = 0.425

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_10 = arg_275_1:FormatText(StoryNameCfg[1082].name)

				arg_275_1.leftNameTxt_.text = var_278_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_11 = arg_275_1:GetWordFromCfg(416101068)
				local var_278_12 = arg_275_1:FormatText(var_278_11.content)

				arg_275_1.text_.text = var_278_12

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 17
				local var_278_14 = utf8.len(var_278_12)
				local var_278_15 = var_278_13 <= 0 and var_278_9 or var_278_9 * (var_278_14 / var_278_13)

				if var_278_15 > 0 and var_278_9 < var_278_15 then
					arg_275_1.talkMaxDuration = var_278_15

					if var_278_15 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_15 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_12
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101068", "story_v_out_416101.awb") ~= 0 then
					local var_278_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101068", "story_v_out_416101.awb") / 1000

					if var_278_16 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_16 + var_278_8
					end

					if var_278_11.prefab_name ~= "" and arg_275_1.actors_[var_278_11.prefab_name] ~= nil then
						local var_278_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_11.prefab_name].transform, "story_v_out_416101", "416101068", "story_v_out_416101.awb")

						arg_275_1:RecordAudio("416101068", var_278_17)
						arg_275_1:RecordAudio("416101068", var_278_17)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416101", "416101068", "story_v_out_416101.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416101", "416101068", "story_v_out_416101.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_18 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_18 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_18

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_18 and arg_275_1.time_ < var_278_8 + var_278_18 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play416101069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416101069
		arg_279_1.duration_ = 9.83

		local var_279_0 = {
			zh = 2.9,
			ja = 9.833
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
				arg_279_0:Play416101070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10108"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10108 == nil then
				arg_279_1.var_.actorSpriteComps10108 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.125

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10108 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10108 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10108 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.25

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_10 = arg_279_1:FormatText(StoryNameCfg[1083].name)

				arg_279_1.leftNameTxt_.text = var_282_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_11 = arg_279_1:GetWordFromCfg(416101069)
				local var_282_12 = arg_279_1:FormatText(var_282_11.content)

				arg_279_1.text_.text = var_282_12

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 10
				local var_282_14 = utf8.len(var_282_12)
				local var_282_15 = var_282_13 <= 0 and var_282_9 or var_282_9 * (var_282_14 / var_282_13)

				if var_282_15 > 0 and var_282_9 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15

					if var_282_15 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_12
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101069", "story_v_out_416101.awb") ~= 0 then
					local var_282_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101069", "story_v_out_416101.awb") / 1000

					if var_282_16 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_16 + var_282_8
					end

					if var_282_11.prefab_name ~= "" and arg_279_1.actors_[var_282_11.prefab_name] ~= nil then
						local var_282_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_11.prefab_name].transform, "story_v_out_416101", "416101069", "story_v_out_416101.awb")

						arg_279_1:RecordAudio("416101069", var_282_17)
						arg_279_1:RecordAudio("416101069", var_282_17)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416101", "416101069", "story_v_out_416101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416101", "416101069", "story_v_out_416101.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_18 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_18 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_18

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_18 and arg_279_1.time_ < var_282_8 + var_282_18 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play416101070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416101070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play416101071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10108"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10108 = var_286_0.localPosition
				var_286_0.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10108", 7)

				local var_286_2 = var_286_0.childCount

				for iter_286_0 = 0, var_286_2 - 1 do
					local var_286_3 = var_286_0:GetChild(iter_286_0)

					if var_286_3.name == "" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_4 then
				local var_286_5 = (arg_283_1.time_ - var_286_1) / var_286_4
				local var_286_6 = Vector3.New(0, -2000, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10108, var_286_6, var_286_5)
			end

			if arg_283_1.time_ >= var_286_1 + var_286_4 and arg_283_1.time_ < var_286_1 + var_286_4 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_7 = 0
			local var_286_8 = 2

			if var_286_7 < arg_283_1.time_ and arg_283_1.time_ <= var_286_7 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_9 = arg_283_1:GetWordFromCfg(416101070)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 80
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_8 or var_286_8 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_8 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_7 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_7
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_8, arg_283_1.talkMaxDuration)

			if var_286_7 <= arg_283_1.time_ and arg_283_1.time_ < var_286_7 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_7) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_7 + var_286_14 and arg_283_1.time_ < var_286_7 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play416101071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416101071
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			zh = 4.933,
			ja = 7.3
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
				arg_287_0:Play416101072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1148"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1148 == nil then
				arg_287_1.var_.actorSpriteComps1148 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.125

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1148 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1148 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1148 = nil
			end

			local var_290_8 = arg_287_1.actors_["1148"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos1148 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1148", 3)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_4" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(0, -429, -180)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1148, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_290_15 = 0
			local var_290_16 = 0.525

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[8].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(416101071)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 21
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101071", "story_v_out_416101.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101071", "story_v_out_416101.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_416101", "416101071", "story_v_out_416101.awb")

						arg_287_1:RecordAudio("416101071", var_290_24)
						arg_287_1:RecordAudio("416101071", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416101", "416101071", "story_v_out_416101.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416101", "416101071", "story_v_out_416101.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play416101072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416101072
		arg_291_1.duration_ = 6.63

		local var_291_0 = {
			zh = 4.666,
			ja = 6.633
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play416101073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.5

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[8].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(416101072)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 20
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101072", "story_v_out_416101.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101072", "story_v_out_416101.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_416101", "416101072", "story_v_out_416101.awb")

						arg_291_1:RecordAudio("416101072", var_294_9)
						arg_291_1:RecordAudio("416101072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416101", "416101072", "story_v_out_416101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416101", "416101072", "story_v_out_416101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play416101073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416101073
		arg_295_1.duration_ = 3.27

		local var_295_0 = {
			zh = 2.5,
			ja = 3.266
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
				arg_295_0:Play416101074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.25

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[8].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(416101073)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 10
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101073", "story_v_out_416101.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101073", "story_v_out_416101.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_416101", "416101073", "story_v_out_416101.awb")

						arg_295_1:RecordAudio("416101073", var_298_9)
						arg_295_1:RecordAudio("416101073", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416101", "416101073", "story_v_out_416101.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416101", "416101073", "story_v_out_416101.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play416101074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416101074
		arg_299_1.duration_ = 11.6

		local var_299_0 = {
			zh = 4.633,
			ja = 11.6
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
				arg_299_0:Play416101075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1148"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1148 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1148", 2)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "split_4" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(-390, -429, -180)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1148, var_302_6, var_302_5)
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_302_7 = arg_299_1.actors_["1148"]
			local var_302_8 = 0

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps1148 == nil then
				arg_299_1.var_.actorSpriteComps1148 = var_302_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_9 = 0.125

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 and not isNil(var_302_7) then
				local var_302_10 = (arg_299_1.time_ - var_302_8) / var_302_9

				if arg_299_1.var_.actorSpriteComps1148 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								local var_302_11 = Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor2.r, var_302_10)
								local var_302_12 = Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor2.g, var_302_10)
								local var_302_13 = Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor2.b, var_302_10)

								iter_302_2.color = Color.New(var_302_11, var_302_12, var_302_13)
							else
								local var_302_14 = Mathf.Lerp(iter_302_2.color.r, 0.5, var_302_10)

								iter_302_2.color = Color.New(var_302_14, var_302_14, var_302_14)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps1148 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_302_4 then
						if arg_299_1.isInRecall_ then
							iter_302_4.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1148 = nil
			end

			local var_302_15 = arg_299_1.actors_["10108"]
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.actorSpriteComps10108 == nil then
				arg_299_1.var_.actorSpriteComps10108 = var_302_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_17 = 0.125

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_17 and not isNil(var_302_15) then
				local var_302_18 = (arg_299_1.time_ - var_302_16) / var_302_17

				if arg_299_1.var_.actorSpriteComps10108 then
					for iter_302_5, iter_302_6 in pairs(arg_299_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_302_6 then
							if arg_299_1.isInRecall_ then
								local var_302_19 = Mathf.Lerp(iter_302_6.color.r, arg_299_1.hightColor1.r, var_302_18)
								local var_302_20 = Mathf.Lerp(iter_302_6.color.g, arg_299_1.hightColor1.g, var_302_18)
								local var_302_21 = Mathf.Lerp(iter_302_6.color.b, arg_299_1.hightColor1.b, var_302_18)

								iter_302_6.color = Color.New(var_302_19, var_302_20, var_302_21)
							else
								local var_302_22 = Mathf.Lerp(iter_302_6.color.r, 1, var_302_18)

								iter_302_6.color = Color.New(var_302_22, var_302_22, var_302_22)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.actorSpriteComps10108 then
				for iter_302_7, iter_302_8 in pairs(arg_299_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_302_8 then
						if arg_299_1.isInRecall_ then
							iter_302_8.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10108 = nil
			end

			local var_302_23 = arg_299_1.actors_["10108"].transform
			local var_302_24 = 0

			if var_302_24 < arg_299_1.time_ and arg_299_1.time_ <= var_302_24 + arg_302_0 then
				arg_299_1.var_.moveOldPos10108 = var_302_23.localPosition
				var_302_23.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10108", 4)

				local var_302_25 = var_302_23.childCount

				for iter_302_9 = 0, var_302_25 - 1 do
					local var_302_26 = var_302_23:GetChild(iter_302_9)

					if var_302_26.name == "" or not string.find(var_302_26.name, "split") then
						var_302_26.gameObject:SetActive(true)
					else
						var_302_26.gameObject:SetActive(false)
					end
				end
			end

			local var_302_27 = 0.001

			if var_302_24 <= arg_299_1.time_ and arg_299_1.time_ < var_302_24 + var_302_27 then
				local var_302_28 = (arg_299_1.time_ - var_302_24) / var_302_27
				local var_302_29 = Vector3.New(390, -399.6, -130)

				var_302_23.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10108, var_302_29, var_302_28)
			end

			if arg_299_1.time_ >= var_302_24 + var_302_27 and arg_299_1.time_ < var_302_24 + var_302_27 + arg_302_0 then
				var_302_23.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_302_30 = 0
			local var_302_31 = 0.425

			if var_302_30 < arg_299_1.time_ and arg_299_1.time_ <= var_302_30 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_32 = arg_299_1:FormatText(StoryNameCfg[1083].name)

				arg_299_1.leftNameTxt_.text = var_302_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_33 = arg_299_1:GetWordFromCfg(416101074)
				local var_302_34 = arg_299_1:FormatText(var_302_33.content)

				arg_299_1.text_.text = var_302_34

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_35 = 17
				local var_302_36 = utf8.len(var_302_34)
				local var_302_37 = var_302_35 <= 0 and var_302_31 or var_302_31 * (var_302_36 / var_302_35)

				if var_302_37 > 0 and var_302_31 < var_302_37 then
					arg_299_1.talkMaxDuration = var_302_37

					if var_302_37 + var_302_30 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_37 + var_302_30
					end
				end

				arg_299_1.text_.text = var_302_34
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101074", "story_v_out_416101.awb") ~= 0 then
					local var_302_38 = manager.audio:GetVoiceLength("story_v_out_416101", "416101074", "story_v_out_416101.awb") / 1000

					if var_302_38 + var_302_30 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_38 + var_302_30
					end

					if var_302_33.prefab_name ~= "" and arg_299_1.actors_[var_302_33.prefab_name] ~= nil then
						local var_302_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_33.prefab_name].transform, "story_v_out_416101", "416101074", "story_v_out_416101.awb")

						arg_299_1:RecordAudio("416101074", var_302_39)
						arg_299_1:RecordAudio("416101074", var_302_39)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416101", "416101074", "story_v_out_416101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416101", "416101074", "story_v_out_416101.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_40 = math.max(var_302_31, arg_299_1.talkMaxDuration)

			if var_302_30 <= arg_299_1.time_ and arg_299_1.time_ < var_302_30 + var_302_40 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_30) / var_302_40

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_30 + var_302_40 and arg_299_1.time_ < var_302_30 + var_302_40 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play416101075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416101075
		arg_303_1.duration_ = 10.47

		local var_303_0 = {
			zh = 3.7,
			ja = 10.466
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
				arg_303_0:Play416101076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.325

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[1083].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(416101075)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101075", "story_v_out_416101.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101075", "story_v_out_416101.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_416101", "416101075", "story_v_out_416101.awb")

						arg_303_1:RecordAudio("416101075", var_306_9)
						arg_303_1:RecordAudio("416101075", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416101", "416101075", "story_v_out_416101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416101", "416101075", "story_v_out_416101.awb")
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
	Play416101076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416101076
		arg_307_1.duration_ = 5.67

		local var_307_0 = {
			zh = 3.7,
			ja = 5.666
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
				arg_307_0:Play416101077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10108"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10108 == nil then
				arg_307_1.var_.actorSpriteComps10108 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.125

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10108 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								local var_310_4 = Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor2.r, var_310_3)
								local var_310_5 = Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor2.g, var_310_3)
								local var_310_6 = Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor2.b, var_310_3)

								iter_310_1.color = Color.New(var_310_4, var_310_5, var_310_6)
							else
								local var_310_7 = Mathf.Lerp(iter_310_1.color.r, 0.5, var_310_3)

								iter_310_1.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10108 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10108 = nil
			end

			local var_310_8 = arg_307_1.actors_["1148"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1148 == nil then
				arg_307_1.var_.actorSpriteComps1148 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 0.125

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps1148 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								local var_310_12 = Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor1.r, var_310_11)
								local var_310_13 = Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor1.g, var_310_11)
								local var_310_14 = Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor1.b, var_310_11)

								iter_310_5.color = Color.New(var_310_12, var_310_13, var_310_14)
							else
								local var_310_15 = Mathf.Lerp(iter_310_5.color.r, 1, var_310_11)

								iter_310_5.color = Color.New(var_310_15, var_310_15, var_310_15)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1148 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1148 = nil
			end

			local var_310_16 = 0
			local var_310_17 = 0.475

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_18 = arg_307_1:FormatText(StoryNameCfg[8].name)

				arg_307_1.leftNameTxt_.text = var_310_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_19 = arg_307_1:GetWordFromCfg(416101076)
				local var_310_20 = arg_307_1:FormatText(var_310_19.content)

				arg_307_1.text_.text = var_310_20

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_21 = 19
				local var_310_22 = utf8.len(var_310_20)
				local var_310_23 = var_310_21 <= 0 and var_310_17 or var_310_17 * (var_310_22 / var_310_21)

				if var_310_23 > 0 and var_310_17 < var_310_23 then
					arg_307_1.talkMaxDuration = var_310_23

					if var_310_23 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_16
					end
				end

				arg_307_1.text_.text = var_310_20
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101076", "story_v_out_416101.awb") ~= 0 then
					local var_310_24 = manager.audio:GetVoiceLength("story_v_out_416101", "416101076", "story_v_out_416101.awb") / 1000

					if var_310_24 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_16
					end

					if var_310_19.prefab_name ~= "" and arg_307_1.actors_[var_310_19.prefab_name] ~= nil then
						local var_310_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_19.prefab_name].transform, "story_v_out_416101", "416101076", "story_v_out_416101.awb")

						arg_307_1:RecordAudio("416101076", var_310_25)
						arg_307_1:RecordAudio("416101076", var_310_25)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416101", "416101076", "story_v_out_416101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416101", "416101076", "story_v_out_416101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_26 = math.max(var_310_17, arg_307_1.talkMaxDuration)

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_26 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_16) / var_310_26

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_16 + var_310_26 and arg_307_1.time_ < var_310_16 + var_310_26 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play416101077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416101077
		arg_311_1.duration_ = 3.97

		local var_311_0 = {
			zh = 2.766,
			ja = 3.966
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
				arg_311_0:Play416101078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.3

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[8].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:GetWordFromCfg(416101077)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 12
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101077", "story_v_out_416101.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101077", "story_v_out_416101.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_416101", "416101077", "story_v_out_416101.awb")

						arg_311_1:RecordAudio("416101077", var_314_9)
						arg_311_1:RecordAudio("416101077", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416101", "416101077", "story_v_out_416101.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416101", "416101077", "story_v_out_416101.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play416101078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416101078
		arg_315_1.duration_ = 10.97

		local var_315_0 = {
			zh = 10.133,
			ja = 10.966
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
				arg_315_0:Play416101079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 4

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			local var_318_1 = 0.3

			if arg_315_1.time_ >= var_318_0 + var_318_1 and arg_315_1.time_ < var_318_0 + var_318_1 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			local var_318_2 = 2

			if var_318_2 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				local var_318_3 = manager.ui.mainCamera.transform.localPosition
				local var_318_4 = Vector3.New(0, 0, 10) + Vector3.New(var_318_3.x, var_318_3.y, 0)
				local var_318_5 = arg_315_1.bgs_.I13f

				var_318_5.transform.localPosition = var_318_4
				var_318_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_318_6 = var_318_5:GetComponent("SpriteRenderer")

				if var_318_6 and var_318_6.sprite then
					local var_318_7 = (var_318_5.transform.localPosition - var_318_3).z
					local var_318_8 = manager.ui.mainCameraCom_
					local var_318_9 = 2 * var_318_7 * Mathf.Tan(var_318_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_318_10 = var_318_9 * var_318_8.aspect
					local var_318_11 = var_318_6.sprite.bounds.size.x
					local var_318_12 = var_318_6.sprite.bounds.size.y
					local var_318_13 = var_318_10 / var_318_11
					local var_318_14 = var_318_9 / var_318_12
					local var_318_15 = var_318_14 < var_318_13 and var_318_13 or var_318_14

					var_318_5.transform.localScale = Vector3.New(var_318_15, var_318_15, 0)
				end

				for iter_318_0, iter_318_1 in pairs(arg_315_1.bgs_) do
					if iter_318_0 ~= "I13f" then
						iter_318_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_17 = 2

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_17 then
				local var_318_18 = (arg_315_1.time_ - var_318_16) / var_318_17
				local var_318_19 = Color.New(0, 0, 0)

				var_318_19.a = Mathf.Lerp(0, 1, var_318_18)
				arg_315_1.mask_.color = var_318_19
			end

			if arg_315_1.time_ >= var_318_16 + var_318_17 and arg_315_1.time_ < var_318_16 + var_318_17 + arg_318_0 then
				local var_318_20 = Color.New(0, 0, 0)

				var_318_20.a = 1
				arg_315_1.mask_.color = var_318_20
			end

			local var_318_21 = 2

			if var_318_21 < arg_315_1.time_ and arg_315_1.time_ <= var_318_21 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_22 = 2

			if var_318_21 <= arg_315_1.time_ and arg_315_1.time_ < var_318_21 + var_318_22 then
				local var_318_23 = (arg_315_1.time_ - var_318_21) / var_318_22
				local var_318_24 = Color.New(0, 0, 0)

				var_318_24.a = Mathf.Lerp(1, 0, var_318_23)
				arg_315_1.mask_.color = var_318_24
			end

			if arg_315_1.time_ >= var_318_21 + var_318_22 and arg_315_1.time_ < var_318_21 + var_318_22 + arg_318_0 then
				local var_318_25 = Color.New(0, 0, 0)
				local var_318_26 = 0

				arg_315_1.mask_.enabled = false
				var_318_25.a = var_318_26
				arg_315_1.mask_.color = var_318_25
			end

			local var_318_27 = arg_315_1.actors_["1148"].transform
			local var_318_28 = 1.966

			if var_318_28 < arg_315_1.time_ and arg_315_1.time_ <= var_318_28 + arg_318_0 then
				arg_315_1.var_.moveOldPos1148 = var_318_27.localPosition
				var_318_27.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1148", 7)

				local var_318_29 = var_318_27.childCount

				for iter_318_2 = 0, var_318_29 - 1 do
					local var_318_30 = var_318_27:GetChild(iter_318_2)

					if var_318_30.name == "" or not string.find(var_318_30.name, "split") then
						var_318_30.gameObject:SetActive(true)
					else
						var_318_30.gameObject:SetActive(false)
					end
				end
			end

			local var_318_31 = 0.001

			if var_318_28 <= arg_315_1.time_ and arg_315_1.time_ < var_318_28 + var_318_31 then
				local var_318_32 = (arg_315_1.time_ - var_318_28) / var_318_31
				local var_318_33 = Vector3.New(0, -2000, 0)

				var_318_27.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1148, var_318_33, var_318_32)
			end

			if arg_315_1.time_ >= var_318_28 + var_318_31 and arg_315_1.time_ < var_318_28 + var_318_31 + arg_318_0 then
				var_318_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_34 = arg_315_1.actors_["10108"].transform
			local var_318_35 = 1.966

			if var_318_35 < arg_315_1.time_ and arg_315_1.time_ <= var_318_35 + arg_318_0 then
				arg_315_1.var_.moveOldPos10108 = var_318_34.localPosition
				var_318_34.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10108", 7)

				local var_318_36 = var_318_34.childCount

				for iter_318_3 = 0, var_318_36 - 1 do
					local var_318_37 = var_318_34:GetChild(iter_318_3)

					if var_318_37.name == "" or not string.find(var_318_37.name, "split") then
						var_318_37.gameObject:SetActive(true)
					else
						var_318_37.gameObject:SetActive(false)
					end
				end
			end

			local var_318_38 = 0.001

			if var_318_35 <= arg_315_1.time_ and arg_315_1.time_ < var_318_35 + var_318_38 then
				local var_318_39 = (arg_315_1.time_ - var_318_35) / var_318_38
				local var_318_40 = Vector3.New(0, -2000, 0)

				var_318_34.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10108, var_318_40, var_318_39)
			end

			if arg_315_1.time_ >= var_318_35 + var_318_38 and arg_315_1.time_ < var_318_35 + var_318_38 + arg_318_0 then
				var_318_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_41 = 1.53333333333333
			local var_318_42 = 1

			if var_318_41 < arg_315_1.time_ and arg_315_1.time_ <= var_318_41 + arg_318_0 then
				local var_318_43 = "play"
				local var_318_44 = "effect"

				arg_315_1:AudioAction(var_318_43, var_318_44, "se_story_5", "se_story_5_back", "")
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_45 = 4
			local var_318_46 = 0.75

			if var_318_45 < arg_315_1.time_ and arg_315_1.time_ <= var_318_45 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_47 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_47:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_48 = arg_315_1:FormatText(StoryNameCfg[1082].name)

				arg_315_1.leftNameTxt_.text = var_318_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_49 = arg_315_1:GetWordFromCfg(416101078)
				local var_318_50 = arg_315_1:FormatText(var_318_49.content)

				arg_315_1.text_.text = var_318_50

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_51 = 30
				local var_318_52 = utf8.len(var_318_50)
				local var_318_53 = var_318_51 <= 0 and var_318_46 or var_318_46 * (var_318_52 / var_318_51)

				if var_318_53 > 0 and var_318_46 < var_318_53 then
					arg_315_1.talkMaxDuration = var_318_53
					var_318_45 = var_318_45 + 0.3

					if var_318_53 + var_318_45 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_53 + var_318_45
					end
				end

				arg_315_1.text_.text = var_318_50
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101078", "story_v_out_416101.awb") ~= 0 then
					local var_318_54 = manager.audio:GetVoiceLength("story_v_out_416101", "416101078", "story_v_out_416101.awb") / 1000

					if var_318_54 + var_318_45 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_54 + var_318_45
					end

					if var_318_49.prefab_name ~= "" and arg_315_1.actors_[var_318_49.prefab_name] ~= nil then
						local var_318_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_49.prefab_name].transform, "story_v_out_416101", "416101078", "story_v_out_416101.awb")

						arg_315_1:RecordAudio("416101078", var_318_55)
						arg_315_1:RecordAudio("416101078", var_318_55)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416101", "416101078", "story_v_out_416101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416101", "416101078", "story_v_out_416101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_56 = var_318_45 + 0.3
			local var_318_57 = math.max(var_318_46, arg_315_1.talkMaxDuration)

			if var_318_56 <= arg_315_1.time_ and arg_315_1.time_ < var_318_56 + var_318_57 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_56) / var_318_57

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_56 + var_318_57 and arg_315_1.time_ < var_318_56 + var_318_57 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play416101079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 416101079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play416101080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 1.875

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(416101079)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 75
				local var_324_5 = utf8.len(var_324_3)
				local var_324_6 = var_324_4 <= 0 and var_324_1 or var_324_1 * (var_324_5 / var_324_4)

				if var_324_6 > 0 and var_324_1 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_7 and arg_321_1.time_ < var_324_0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play416101080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 416101080
		arg_325_1.duration_ = 7.03

		local var_325_0 = {
			zh = 2.366,
			ja = 7.033
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
				arg_325_0:Play416101081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.325

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[1082].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(416101080)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 13
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101080", "story_v_out_416101.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101080", "story_v_out_416101.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_416101", "416101080", "story_v_out_416101.awb")

						arg_325_1:RecordAudio("416101080", var_328_9)
						arg_325_1:RecordAudio("416101080", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_416101", "416101080", "story_v_out_416101.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_416101", "416101080", "story_v_out_416101.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play416101081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 416101081
		arg_329_1.duration_ = 5.63

		local var_329_0 = {
			zh = 3.4,
			ja = 5.633
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play416101082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1148"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1148 == nil then
				arg_329_1.var_.actorSpriteComps1148 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.125

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1148 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								local var_332_4 = Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, var_332_3)
								local var_332_5 = Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, var_332_3)
								local var_332_6 = Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, var_332_3)

								iter_332_1.color = Color.New(var_332_4, var_332_5, var_332_6)
							else
								local var_332_7 = Mathf.Lerp(iter_332_1.color.r, 1, var_332_3)

								iter_332_1.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1148 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1148 = nil
			end

			local var_332_8 = arg_329_1.actors_["1148"].transform
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.var_.moveOldPos1148 = var_332_8.localPosition
				var_332_8.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1148", 3)

				local var_332_10 = var_332_8.childCount

				for iter_332_4 = 0, var_332_10 - 1 do
					local var_332_11 = var_332_8:GetChild(iter_332_4)

					if var_332_11.name == "split_4" or not string.find(var_332_11.name, "split") then
						var_332_11.gameObject:SetActive(true)
					else
						var_332_11.gameObject:SetActive(false)
					end
				end
			end

			local var_332_12 = 0.001

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_12 then
				local var_332_13 = (arg_329_1.time_ - var_332_9) / var_332_12
				local var_332_14 = Vector3.New(0, -429, -180)

				var_332_8.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1148, var_332_14, var_332_13)
			end

			if arg_329_1.time_ >= var_332_9 + var_332_12 and arg_329_1.time_ < var_332_9 + var_332_12 + arg_332_0 then
				var_332_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_332_15 = 0
			local var_332_16 = 0.4

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_17 = arg_329_1:FormatText(StoryNameCfg[8].name)

				arg_329_1.leftNameTxt_.text = var_332_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_18 = arg_329_1:GetWordFromCfg(416101081)
				local var_332_19 = arg_329_1:FormatText(var_332_18.content)

				arg_329_1.text_.text = var_332_19

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_20 = 16
				local var_332_21 = utf8.len(var_332_19)
				local var_332_22 = var_332_20 <= 0 and var_332_16 or var_332_16 * (var_332_21 / var_332_20)

				if var_332_22 > 0 and var_332_16 < var_332_22 then
					arg_329_1.talkMaxDuration = var_332_22

					if var_332_22 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_22 + var_332_15
					end
				end

				arg_329_1.text_.text = var_332_19
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101081", "story_v_out_416101.awb") ~= 0 then
					local var_332_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101081", "story_v_out_416101.awb") / 1000

					if var_332_23 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_23 + var_332_15
					end

					if var_332_18.prefab_name ~= "" and arg_329_1.actors_[var_332_18.prefab_name] ~= nil then
						local var_332_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_18.prefab_name].transform, "story_v_out_416101", "416101081", "story_v_out_416101.awb")

						arg_329_1:RecordAudio("416101081", var_332_24)
						arg_329_1:RecordAudio("416101081", var_332_24)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_416101", "416101081", "story_v_out_416101.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_416101", "416101081", "story_v_out_416101.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_25 = math.max(var_332_16, arg_329_1.talkMaxDuration)

			if var_332_15 <= arg_329_1.time_ and arg_329_1.time_ < var_332_15 + var_332_25 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_15) / var_332_25

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_15 + var_332_25 and arg_329_1.time_ < var_332_15 + var_332_25 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play416101082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416101082
		arg_333_1.duration_ = 8.67

		local var_333_0 = {
			zh = 4.466,
			ja = 8.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play416101083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1148"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1148 == nil then
				arg_333_1.var_.actorSpriteComps1148 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.125

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1148 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 0.5, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1148 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1148 = nil
			end

			local var_336_8 = 0
			local var_336_9 = 0.55

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_10 = arg_333_1:FormatText(StoryNameCfg[1082].name)

				arg_333_1.leftNameTxt_.text = var_336_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_11 = arg_333_1:GetWordFromCfg(416101082)
				local var_336_12 = arg_333_1:FormatText(var_336_11.content)

				arg_333_1.text_.text = var_336_12

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_13 = 22
				local var_336_14 = utf8.len(var_336_12)
				local var_336_15 = var_336_13 <= 0 and var_336_9 or var_336_9 * (var_336_14 / var_336_13)

				if var_336_15 > 0 and var_336_9 < var_336_15 then
					arg_333_1.talkMaxDuration = var_336_15

					if var_336_15 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_8
					end
				end

				arg_333_1.text_.text = var_336_12
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101082", "story_v_out_416101.awb") ~= 0 then
					local var_336_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101082", "story_v_out_416101.awb") / 1000

					if var_336_16 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_8
					end

					if var_336_11.prefab_name ~= "" and arg_333_1.actors_[var_336_11.prefab_name] ~= nil then
						local var_336_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_11.prefab_name].transform, "story_v_out_416101", "416101082", "story_v_out_416101.awb")

						arg_333_1:RecordAudio("416101082", var_336_17)
						arg_333_1:RecordAudio("416101082", var_336_17)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_416101", "416101082", "story_v_out_416101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_416101", "416101082", "story_v_out_416101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_18 = math.max(var_336_9, arg_333_1.talkMaxDuration)

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_18 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_8) / var_336_18

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_8 + var_336_18 and arg_333_1.time_ < var_336_8 + var_336_18 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416101083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416101083
		arg_337_1.duration_ = 6.3

		local var_337_0 = {
			zh = 5.533,
			ja = 6.3
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play416101084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.65

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[1082].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(416101083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 26
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101083", "story_v_out_416101.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101083", "story_v_out_416101.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_416101", "416101083", "story_v_out_416101.awb")

						arg_337_1:RecordAudio("416101083", var_340_9)
						arg_337_1:RecordAudio("416101083", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_416101", "416101083", "story_v_out_416101.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_416101", "416101083", "story_v_out_416101.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416101084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416101084
		arg_341_1.duration_ = 5.03

		local var_341_0 = {
			zh = 4.666,
			ja = 5.033
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play416101085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1148"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps1148 == nil then
				arg_341_1.var_.actorSpriteComps1148 = var_344_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_2 = 0.125

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.actorSpriteComps1148 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								local var_344_4 = Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor1.r, var_344_3)
								local var_344_5 = Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor1.g, var_344_3)
								local var_344_6 = Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor1.b, var_344_3)

								iter_344_1.color = Color.New(var_344_4, var_344_5, var_344_6)
							else
								local var_344_7 = Mathf.Lerp(iter_344_1.color.r, 1, var_344_3)

								iter_344_1.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps1148 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_344_3 then
						if arg_341_1.isInRecall_ then
							iter_344_3.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1148 = nil
			end

			local var_344_8 = 0
			local var_344_9 = 0.425

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_10 = arg_341_1:FormatText(StoryNameCfg[8].name)

				arg_341_1.leftNameTxt_.text = var_344_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_11 = arg_341_1:GetWordFromCfg(416101084)
				local var_344_12 = arg_341_1:FormatText(var_344_11.content)

				arg_341_1.text_.text = var_344_12

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 17
				local var_344_14 = utf8.len(var_344_12)
				local var_344_15 = var_344_13 <= 0 and var_344_9 or var_344_9 * (var_344_14 / var_344_13)

				if var_344_15 > 0 and var_344_9 < var_344_15 then
					arg_341_1.talkMaxDuration = var_344_15

					if var_344_15 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_15 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_12
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101084", "story_v_out_416101.awb") ~= 0 then
					local var_344_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101084", "story_v_out_416101.awb") / 1000

					if var_344_16 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_16 + var_344_8
					end

					if var_344_11.prefab_name ~= "" and arg_341_1.actors_[var_344_11.prefab_name] ~= nil then
						local var_344_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_11.prefab_name].transform, "story_v_out_416101", "416101084", "story_v_out_416101.awb")

						arg_341_1:RecordAudio("416101084", var_344_17)
						arg_341_1:RecordAudio("416101084", var_344_17)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416101", "416101084", "story_v_out_416101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416101", "416101084", "story_v_out_416101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_18 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_18 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_8) / var_344_18

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_8 + var_344_18 and arg_341_1.time_ < var_344_8 + var_344_18 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play416101085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416101085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play416101086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1148"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1148 = var_348_0.localPosition
				var_348_0.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1148", 7)

				local var_348_2 = var_348_0.childCount

				for iter_348_0 = 0, var_348_2 - 1 do
					local var_348_3 = var_348_0:GetChild(iter_348_0)

					if var_348_3.name == "" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_4 then
				local var_348_5 = (arg_345_1.time_ - var_348_1) / var_348_4
				local var_348_6 = Vector3.New(0, -2000, 0)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1148, var_348_6, var_348_5)
			end

			if arg_345_1.time_ >= var_348_1 + var_348_4 and arg_345_1.time_ < var_348_1 + var_348_4 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_348_7 = 0.233333333333333
			local var_348_8 = 0.933333333333333

			if var_348_7 < arg_345_1.time_ and arg_345_1.time_ <= var_348_7 + arg_348_0 then
				local var_348_9 = "play"
				local var_348_10 = "effect"

				arg_345_1:AudioAction(var_348_9, var_348_10, "se_story_138", "se_story_138_rustle", "")
			end

			local var_348_11 = 0
			local var_348_12 = 0.2

			if var_348_11 < arg_345_1.time_ and arg_345_1.time_ <= var_348_11 + arg_348_0 then
				local var_348_13 = "play"
				local var_348_14 = "music"

				arg_345_1:AudioAction(var_348_13, var_348_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_348_15 = ""
				local var_348_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_348_16 ~= "" then
					if arg_345_1.bgmTxt_.text ~= var_348_16 and arg_345_1.bgmTxt_.text ~= "" then
						if arg_345_1.bgmTxt2_.text ~= "" then
							arg_345_1.bgmTxt_.text = arg_345_1.bgmTxt2_.text
						end

						arg_345_1.bgmTxt2_.text = var_348_16

						arg_345_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_345_1.bgmTxt_.text = var_348_16
						arg_345_1.bgmTxt2_.text = var_348_16
					end

					if arg_345_1.bgmTimer then
						arg_345_1.bgmTimer:Stop()

						arg_345_1.bgmTimer = nil
					end

					if arg_345_1.settingData.show_music_name == 1 then
						arg_345_1.musicController:SetSelectedState("show")
						arg_345_1.musicAnimator_:Play("open", 0, 0)

						if arg_345_1.settingData.music_time ~= 0 then
							arg_345_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_345_1.settingData.music_time), function()
								if arg_345_1 == nil or isNil(arg_345_1.bgmTxt_) then
									return
								end

								arg_345_1.musicController:SetSelectedState("hide")
								arg_345_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_348_17 = 0
			local var_348_18 = 1.4

			if var_348_17 < arg_345_1.time_ and arg_345_1.time_ <= var_348_17 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_19 = arg_345_1:GetWordFromCfg(416101085)
				local var_348_20 = arg_345_1:FormatText(var_348_19.content)

				arg_345_1.text_.text = var_348_20

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_21 = 56
				local var_348_22 = utf8.len(var_348_20)
				local var_348_23 = var_348_21 <= 0 and var_348_18 or var_348_18 * (var_348_22 / var_348_21)

				if var_348_23 > 0 and var_348_18 < var_348_23 then
					arg_345_1.talkMaxDuration = var_348_23

					if var_348_23 + var_348_17 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_17
					end
				end

				arg_345_1.text_.text = var_348_20
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_24 = math.max(var_348_18, arg_345_1.talkMaxDuration)

			if var_348_17 <= arg_345_1.time_ and arg_345_1.time_ < var_348_17 + var_348_24 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_17) / var_348_24

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_17 + var_348_24 and arg_345_1.time_ < var_348_17 + var_348_24 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play416101086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416101086
		arg_350_1.duration_ = 6.53

		local var_350_0 = {
			zh = 4.033,
			ja = 6.533
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
				arg_350_0:Play416101087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1148"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1148 = var_353_0.localPosition
				var_353_0.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1148", 3)

				local var_353_2 = var_353_0.childCount

				for iter_353_0 = 0, var_353_2 - 1 do
					local var_353_3 = var_353_0:GetChild(iter_353_0)

					if var_353_3.name == "split_6" or not string.find(var_353_3.name, "split") then
						var_353_3.gameObject:SetActive(true)
					else
						var_353_3.gameObject:SetActive(false)
					end
				end
			end

			local var_353_4 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_4 then
				local var_353_5 = (arg_350_1.time_ - var_353_1) / var_353_4
				local var_353_6 = Vector3.New(0, -429, -180)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1148, var_353_6, var_353_5)
			end

			if arg_350_1.time_ >= var_353_1 + var_353_4 and arg_350_1.time_ < var_353_1 + var_353_4 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_353_7 = arg_350_1.actors_["1148"]
			local var_353_8 = 0

			if var_353_8 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 and not isNil(var_353_7) and arg_350_1.var_.actorSpriteComps1148 == nil then
				arg_350_1.var_.actorSpriteComps1148 = var_353_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_9 = 0.125

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_9 and not isNil(var_353_7) then
				local var_353_10 = (arg_350_1.time_ - var_353_8) / var_353_9

				if arg_350_1.var_.actorSpriteComps1148 then
					for iter_353_1, iter_353_2 in pairs(arg_350_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_353_2 then
							if arg_350_1.isInRecall_ then
								local var_353_11 = Mathf.Lerp(iter_353_2.color.r, arg_350_1.hightColor1.r, var_353_10)
								local var_353_12 = Mathf.Lerp(iter_353_2.color.g, arg_350_1.hightColor1.g, var_353_10)
								local var_353_13 = Mathf.Lerp(iter_353_2.color.b, arg_350_1.hightColor1.b, var_353_10)

								iter_353_2.color = Color.New(var_353_11, var_353_12, var_353_13)
							else
								local var_353_14 = Mathf.Lerp(iter_353_2.color.r, 1, var_353_10)

								iter_353_2.color = Color.New(var_353_14, var_353_14, var_353_14)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_8 + var_353_9 and arg_350_1.time_ < var_353_8 + var_353_9 + arg_353_0 and not isNil(var_353_7) and arg_350_1.var_.actorSpriteComps1148 then
				for iter_353_3, iter_353_4 in pairs(arg_350_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_353_4 then
						if arg_350_1.isInRecall_ then
							iter_353_4.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps1148 = nil
			end

			local var_353_15 = 0.233333333333333
			local var_353_16 = 0.733333333333333

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				local var_353_17 = "play"
				local var_353_18 = "effect"

				arg_350_1:AudioAction(var_353_17, var_353_18, "se_story_138", "se_story_138_rustle", "")
			end

			local var_353_19 = 0
			local var_353_20 = 0.35

			if var_353_19 < arg_350_1.time_ and arg_350_1.time_ <= var_353_19 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_21 = arg_350_1:FormatText(StoryNameCfg[8].name)

				arg_350_1.leftNameTxt_.text = var_353_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_22 = arg_350_1:GetWordFromCfg(416101086)
				local var_353_23 = arg_350_1:FormatText(var_353_22.content)

				arg_350_1.text_.text = var_353_23

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_24 = 14
				local var_353_25 = utf8.len(var_353_23)
				local var_353_26 = var_353_24 <= 0 and var_353_20 or var_353_20 * (var_353_25 / var_353_24)

				if var_353_26 > 0 and var_353_20 < var_353_26 then
					arg_350_1.talkMaxDuration = var_353_26

					if var_353_26 + var_353_19 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_26 + var_353_19
					end
				end

				arg_350_1.text_.text = var_353_23
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101086", "story_v_out_416101.awb") ~= 0 then
					local var_353_27 = manager.audio:GetVoiceLength("story_v_out_416101", "416101086", "story_v_out_416101.awb") / 1000

					if var_353_27 + var_353_19 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_27 + var_353_19
					end

					if var_353_22.prefab_name ~= "" and arg_350_1.actors_[var_353_22.prefab_name] ~= nil then
						local var_353_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_22.prefab_name].transform, "story_v_out_416101", "416101086", "story_v_out_416101.awb")

						arg_350_1:RecordAudio("416101086", var_353_28)
						arg_350_1:RecordAudio("416101086", var_353_28)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_416101", "416101086", "story_v_out_416101.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_416101", "416101086", "story_v_out_416101.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_29 = math.max(var_353_20, arg_350_1.talkMaxDuration)

			if var_353_19 <= arg_350_1.time_ and arg_350_1.time_ < var_353_19 + var_353_29 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_19) / var_353_29

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_19 + var_353_29 and arg_350_1.time_ < var_353_19 + var_353_29 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
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

		arg_350_1:InitPlayNodeList()
	end,
	Play416101087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416101087
		arg_354_1.duration_ = 5.63

		local var_354_0 = {
			zh = 5.633,
			ja = 5.433
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
				arg_354_0:Play416101088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1148"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1148 = var_357_0.localPosition
				var_357_0.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1148", 3)

				local var_357_2 = var_357_0.childCount

				for iter_357_0 = 0, var_357_2 - 1 do
					local var_357_3 = var_357_0:GetChild(iter_357_0)

					if var_357_3.name == "split_3" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_4 then
				local var_357_5 = (arg_354_1.time_ - var_357_1) / var_357_4
				local var_357_6 = Vector3.New(0, -429, -180)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1148, var_357_6, var_357_5)
			end

			if arg_354_1.time_ >= var_357_1 + var_357_4 and arg_354_1.time_ < var_357_1 + var_357_4 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_357_7 = 0.233333333333333
			local var_357_8 = 0.766666666666667

			if var_357_7 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				local var_357_9 = "play"
				local var_357_10 = "effect"

				arg_354_1:AudioAction(var_357_9, var_357_10, "se_story_138", "se_story_138_rustle", "")
			end

			local var_357_11 = 0
			local var_357_12 = 0.45

			if var_357_11 < arg_354_1.time_ and arg_354_1.time_ <= var_357_11 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_13 = arg_354_1:FormatText(StoryNameCfg[8].name)

				arg_354_1.leftNameTxt_.text = var_357_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_14 = arg_354_1:GetWordFromCfg(416101087)
				local var_357_15 = arg_354_1:FormatText(var_357_14.content)

				arg_354_1.text_.text = var_357_15

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_16 = 18
				local var_357_17 = utf8.len(var_357_15)
				local var_357_18 = var_357_16 <= 0 and var_357_12 or var_357_12 * (var_357_17 / var_357_16)

				if var_357_18 > 0 and var_357_12 < var_357_18 then
					arg_354_1.talkMaxDuration = var_357_18

					if var_357_18 + var_357_11 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_18 + var_357_11
					end
				end

				arg_354_1.text_.text = var_357_15
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101087", "story_v_out_416101.awb") ~= 0 then
					local var_357_19 = manager.audio:GetVoiceLength("story_v_out_416101", "416101087", "story_v_out_416101.awb") / 1000

					if var_357_19 + var_357_11 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_19 + var_357_11
					end

					if var_357_14.prefab_name ~= "" and arg_354_1.actors_[var_357_14.prefab_name] ~= nil then
						local var_357_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_14.prefab_name].transform, "story_v_out_416101", "416101087", "story_v_out_416101.awb")

						arg_354_1:RecordAudio("416101087", var_357_20)
						arg_354_1:RecordAudio("416101087", var_357_20)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416101", "416101087", "story_v_out_416101.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416101", "416101087", "story_v_out_416101.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_21 = math.max(var_357_12, arg_354_1.talkMaxDuration)

			if var_357_11 <= arg_354_1.time_ and arg_354_1.time_ < var_357_11 + var_357_21 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_11) / var_357_21

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_11 + var_357_21 and arg_354_1.time_ < var_357_11 + var_357_21 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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

		arg_354_1:InitPlayNodeList()
	end,
	Play416101088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 416101088
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play416101089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1148"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos1148 = var_361_0.localPosition
				var_361_0.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1148", 7)

				local var_361_2 = var_361_0.childCount

				for iter_361_0 = 0, var_361_2 - 1 do
					local var_361_3 = var_361_0:GetChild(iter_361_0)

					if var_361_3.name == "" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_4 then
				local var_361_5 = (arg_358_1.time_ - var_361_1) / var_361_4
				local var_361_6 = Vector3.New(0, -2000, 0)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1148, var_361_6, var_361_5)
			end

			if arg_358_1.time_ >= var_361_1 + var_361_4 and arg_358_1.time_ < var_361_1 + var_361_4 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_361_7 = 0
			local var_361_8 = 1

			if var_361_7 < arg_358_1.time_ and arg_358_1.time_ <= var_361_7 + arg_361_0 then
				local var_361_9 = "stop"
				local var_361_10 = "effect"

				arg_358_1:AudioAction(var_361_9, var_361_10, "se_story_138", "se_story_138_rustle", "")
			end

			local var_361_11 = manager.ui.mainCamera.transform
			local var_361_12 = 0

			if var_361_12 < arg_358_1.time_ and arg_358_1.time_ <= var_361_12 + arg_361_0 then
				local var_361_13 = arg_358_1.var_.effect1088
				local var_361_14
				local var_361_15 = var_361_11

				if not var_361_13 then
					var_361_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), var_361_15)
					var_361_13.name = "1088"
					arg_358_1.var_.effect1088 = var_361_13
				else
					var_361_13.transform:SetParent(var_361_15)
				end

				var_361_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_361_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_361_16 = 0

			if var_361_16 < arg_358_1.time_ and arg_358_1.time_ <= var_361_16 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = false

				arg_358_1:SetGaussion(false)
			end

			local var_361_17 = 0.3

			if var_361_16 <= arg_358_1.time_ and arg_358_1.time_ < var_361_16 + var_361_17 then
				local var_361_18 = (arg_358_1.time_ - var_361_16) / var_361_17
				local var_361_19 = Color.New(1, 1, 1)

				var_361_19.a = Mathf.Lerp(1, 0, var_361_18)
				arg_358_1.mask_.color = var_361_19
			end

			if arg_358_1.time_ >= var_361_16 + var_361_17 and arg_358_1.time_ < var_361_16 + var_361_17 + arg_361_0 then
				local var_361_20 = Color.New(1, 1, 1)
				local var_361_21 = 0

				arg_358_1.mask_.enabled = false
				var_361_20.a = var_361_21
				arg_358_1.mask_.color = var_361_20
			end

			local var_361_22 = 0.166666666666667
			local var_361_23 = 0.833333333333333

			if var_361_22 < arg_358_1.time_ and arg_358_1.time_ <= var_361_22 + arg_361_0 then
				local var_361_24 = "play"
				local var_361_25 = "effect"

				arg_358_1:AudioAction(var_361_24, var_361_25, "se_story_6", "se_story_6_black_fog", "")
			end

			local var_361_26 = 0
			local var_361_27 = 1.525

			if var_361_26 < arg_358_1.time_ and arg_358_1.time_ <= var_361_26 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_28 = arg_358_1:GetWordFromCfg(416101088)
				local var_361_29 = arg_358_1:FormatText(var_361_28.content)

				arg_358_1.text_.text = var_361_29

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_30 = 61
				local var_361_31 = utf8.len(var_361_29)
				local var_361_32 = var_361_30 <= 0 and var_361_27 or var_361_27 * (var_361_31 / var_361_30)

				if var_361_32 > 0 and var_361_27 < var_361_32 then
					arg_358_1.talkMaxDuration = var_361_32

					if var_361_32 + var_361_26 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_32 + var_361_26
					end
				end

				arg_358_1.text_.text = var_361_29
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_33 = math.max(var_361_27, arg_358_1.talkMaxDuration)

			if var_361_26 <= arg_358_1.time_ and arg_358_1.time_ < var_361_26 + var_361_33 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_26) / var_361_33

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_26 + var_361_33 and arg_358_1.time_ < var_361_26 + var_361_33 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play416101089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 416101089
		arg_362_1.duration_ = 1.47

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play416101090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1148"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps1148 == nil then
				arg_362_1.var_.actorSpriteComps1148 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.125

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps1148 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps1148 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1148 = nil
			end

			local var_365_8 = arg_362_1.actors_["1148"].transform
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 then
				arg_362_1.var_.moveOldPos1148 = var_365_8.localPosition
				var_365_8.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1148", 3)

				local var_365_10 = var_365_8.childCount

				for iter_365_4 = 0, var_365_10 - 1 do
					local var_365_11 = var_365_8:GetChild(iter_365_4)

					if var_365_11.name == "split_3" or not string.find(var_365_11.name, "split") then
						var_365_11.gameObject:SetActive(true)
					else
						var_365_11.gameObject:SetActive(false)
					end
				end
			end

			local var_365_12 = 0.001

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_12 then
				local var_365_13 = (arg_362_1.time_ - var_365_9) / var_365_12
				local var_365_14 = Vector3.New(0, -429, -180)

				var_365_8.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1148, var_365_14, var_365_13)
			end

			if arg_362_1.time_ >= var_365_9 + var_365_12 and arg_362_1.time_ < var_365_9 + var_365_12 + arg_365_0 then
				var_365_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_365_15 = 0
			local var_365_16 = 0.2

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				local var_365_17 = "play"
				local var_365_18 = "music"

				arg_362_1:AudioAction(var_365_17, var_365_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_365_19 = ""
				local var_365_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_365_20 ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_20 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_20

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_20
						arg_362_1.bgmTxt2_.text = var_365_20
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_21 = 0.466666666666667
			local var_365_22 = 1

			if var_365_21 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				local var_365_23 = "play"
				local var_365_24 = "music"

				arg_362_1:AudioAction(var_365_23, var_365_24, "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_365_25 = ""
				local var_365_26 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if var_365_26 ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_26 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_26

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_26
						arg_362_1.bgmTxt2_.text = var_365_26
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_27 = 0
			local var_365_28 = 0.1

			if var_365_27 < arg_362_1.time_ and arg_362_1.time_ <= var_365_27 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_29 = arg_362_1:FormatText(StoryNameCfg[8].name)

				arg_362_1.leftNameTxt_.text = var_365_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_30 = arg_362_1:GetWordFromCfg(416101089)
				local var_365_31 = arg_362_1:FormatText(var_365_30.content)

				arg_362_1.text_.text = var_365_31

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_32 = 4
				local var_365_33 = utf8.len(var_365_31)
				local var_365_34 = var_365_32 <= 0 and var_365_28 or var_365_28 * (var_365_33 / var_365_32)

				if var_365_34 > 0 and var_365_28 < var_365_34 then
					arg_362_1.talkMaxDuration = var_365_34

					if var_365_34 + var_365_27 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_34 + var_365_27
					end
				end

				arg_362_1.text_.text = var_365_31
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101089", "story_v_out_416101.awb") ~= 0 then
					local var_365_35 = manager.audio:GetVoiceLength("story_v_out_416101", "416101089", "story_v_out_416101.awb") / 1000

					if var_365_35 + var_365_27 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_35 + var_365_27
					end

					if var_365_30.prefab_name ~= "" and arg_362_1.actors_[var_365_30.prefab_name] ~= nil then
						local var_365_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_30.prefab_name].transform, "story_v_out_416101", "416101089", "story_v_out_416101.awb")

						arg_362_1:RecordAudio("416101089", var_365_36)
						arg_362_1:RecordAudio("416101089", var_365_36)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_416101", "416101089", "story_v_out_416101.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_416101", "416101089", "story_v_out_416101.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_37 = math.max(var_365_28, arg_362_1.talkMaxDuration)

			if var_365_27 <= arg_362_1.time_ and arg_362_1.time_ < var_365_27 + var_365_37 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_27) / var_365_37

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_27 + var_365_37 and arg_362_1.time_ < var_365_27 + var_365_37 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play416101090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 416101090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play416101091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1148"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos1148 = var_371_0.localPosition
				var_371_0.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("1148", 7)

				local var_371_2 = var_371_0.childCount

				for iter_371_0 = 0, var_371_2 - 1 do
					local var_371_3 = var_371_0:GetChild(iter_371_0)

					if var_371_3.name == "" or not string.find(var_371_3.name, "split") then
						var_371_3.gameObject:SetActive(true)
					else
						var_371_3.gameObject:SetActive(false)
					end
				end
			end

			local var_371_4 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_4 then
				local var_371_5 = (arg_368_1.time_ - var_371_1) / var_371_4
				local var_371_6 = Vector3.New(0, -2000, 0)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1148, var_371_6, var_371_5)
			end

			if arg_368_1.time_ >= var_371_1 + var_371_4 and arg_368_1.time_ < var_371_1 + var_371_4 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_371_7 = 0
			local var_371_8 = 1.95

			if var_371_7 < arg_368_1.time_ and arg_368_1.time_ <= var_371_7 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_9 = arg_368_1:GetWordFromCfg(416101090)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 78
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_8 or var_371_8 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_8 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_7 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_7
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_8, arg_368_1.talkMaxDuration)

			if var_371_7 <= arg_368_1.time_ and arg_368_1.time_ < var_371_7 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_7) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_7 + var_371_14 and arg_368_1.time_ < var_371_7 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
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

		arg_368_1:InitPlayNodeList()
	end,
	Play416101091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 416101091
		arg_372_1.duration_ = 2.5

		local var_372_0 = {
			zh = 2.2,
			ja = 2.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play416101092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1148"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos1148 = var_375_0.localPosition
				var_375_0.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1148", 3)

				local var_375_2 = var_375_0.childCount

				for iter_375_0 = 0, var_375_2 - 1 do
					local var_375_3 = var_375_0:GetChild(iter_375_0)

					if var_375_3.name == "split_6" or not string.find(var_375_3.name, "split") then
						var_375_3.gameObject:SetActive(true)
					else
						var_375_3.gameObject:SetActive(false)
					end
				end
			end

			local var_375_4 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_4 then
				local var_375_5 = (arg_372_1.time_ - var_375_1) / var_375_4
				local var_375_6 = Vector3.New(0, -429, -180)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1148, var_375_6, var_375_5)
			end

			if arg_372_1.time_ >= var_375_1 + var_375_4 and arg_372_1.time_ < var_375_1 + var_375_4 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_375_7 = arg_372_1.actors_["1148"]
			local var_375_8 = 0

			if var_375_8 < arg_372_1.time_ and arg_372_1.time_ <= var_375_8 + arg_375_0 and not isNil(var_375_7) and arg_372_1.var_.actorSpriteComps1148 == nil then
				arg_372_1.var_.actorSpriteComps1148 = var_375_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_9 = 0.125

			if var_375_8 <= arg_372_1.time_ and arg_372_1.time_ < var_375_8 + var_375_9 and not isNil(var_375_7) then
				local var_375_10 = (arg_372_1.time_ - var_375_8) / var_375_9

				if arg_372_1.var_.actorSpriteComps1148 then
					for iter_375_1, iter_375_2 in pairs(arg_372_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_375_2 then
							if arg_372_1.isInRecall_ then
								local var_375_11 = Mathf.Lerp(iter_375_2.color.r, arg_372_1.hightColor1.r, var_375_10)
								local var_375_12 = Mathf.Lerp(iter_375_2.color.g, arg_372_1.hightColor1.g, var_375_10)
								local var_375_13 = Mathf.Lerp(iter_375_2.color.b, arg_372_1.hightColor1.b, var_375_10)

								iter_375_2.color = Color.New(var_375_11, var_375_12, var_375_13)
							else
								local var_375_14 = Mathf.Lerp(iter_375_2.color.r, 1, var_375_10)

								iter_375_2.color = Color.New(var_375_14, var_375_14, var_375_14)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= var_375_8 + var_375_9 and arg_372_1.time_ < var_375_8 + var_375_9 + arg_375_0 and not isNil(var_375_7) and arg_372_1.var_.actorSpriteComps1148 then
				for iter_375_3, iter_375_4 in pairs(arg_372_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_375_4 then
						if arg_372_1.isInRecall_ then
							iter_375_4.color = arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_375_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_372_1.var_.actorSpriteComps1148 = nil
			end

			local var_375_15 = 0
			local var_375_16 = 0.15

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[8].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(416101091)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 6
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101091", "story_v_out_416101.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101091", "story_v_out_416101.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_416101", "416101091", "story_v_out_416101.awb")

						arg_372_1:RecordAudio("416101091", var_375_24)
						arg_372_1:RecordAudio("416101091", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_416101", "416101091", "story_v_out_416101.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_416101", "416101091", "story_v_out_416101.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play416101092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 416101092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play416101093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1148"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1148 = var_379_0.localPosition
				var_379_0.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1148", 7)

				local var_379_2 = var_379_0.childCount

				for iter_379_0 = 0, var_379_2 - 1 do
					local var_379_3 = var_379_0:GetChild(iter_379_0)

					if var_379_3.name == "" or not string.find(var_379_3.name, "split") then
						var_379_3.gameObject:SetActive(true)
					else
						var_379_3.gameObject:SetActive(false)
					end
				end
			end

			local var_379_4 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_4 then
				local var_379_5 = (arg_376_1.time_ - var_379_1) / var_379_4
				local var_379_6 = Vector3.New(0, -2000, 0)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1148, var_379_6, var_379_5)
			end

			if arg_376_1.time_ >= var_379_1 + var_379_4 and arg_376_1.time_ < var_379_1 + var_379_4 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_379_7 = 0
			local var_379_8 = 1

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 then
				local var_379_9 = "play"
				local var_379_10 = "effect"

				arg_376_1:AudioAction(var_379_9, var_379_10, "se_story_side_1084", "se_story_1084_run", "")
			end

			local var_379_11 = 0
			local var_379_12 = 1.175

			if var_379_11 < arg_376_1.time_ and arg_376_1.time_ <= var_379_11 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_13 = arg_376_1:GetWordFromCfg(416101092)
				local var_379_14 = arg_376_1:FormatText(var_379_13.content)

				arg_376_1.text_.text = var_379_14

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_15 = 47
				local var_379_16 = utf8.len(var_379_14)
				local var_379_17 = var_379_15 <= 0 and var_379_12 or var_379_12 * (var_379_16 / var_379_15)

				if var_379_17 > 0 and var_379_12 < var_379_17 then
					arg_376_1.talkMaxDuration = var_379_17

					if var_379_17 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_17 + var_379_11
					end
				end

				arg_376_1.text_.text = var_379_14
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_18 = math.max(var_379_12, arg_376_1.talkMaxDuration)

			if var_379_11 <= arg_376_1.time_ and arg_376_1.time_ < var_379_11 + var_379_18 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_11) / var_379_18

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_11 + var_379_18 and arg_376_1.time_ < var_379_11 + var_379_18 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
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

		arg_376_1:InitPlayNodeList()
	end,
	Play416101093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 416101093
		arg_380_1.duration_ = 5.67

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play416101094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = false

				arg_380_1:SetGaussion(false)
			end

			local var_383_1 = 0.666666666666667

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_1 then
				local var_383_2 = (arg_380_1.time_ - var_383_0) / var_383_1
				local var_383_3 = Color.New(1, 1, 1)

				var_383_3.a = Mathf.Lerp(1, 0, var_383_2)
				arg_380_1.mask_.color = var_383_3
			end

			if arg_380_1.time_ >= var_383_0 + var_383_1 and arg_380_1.time_ < var_383_0 + var_383_1 + arg_383_0 then
				local var_383_4 = Color.New(1, 1, 1)
				local var_383_5 = 0

				arg_380_1.mask_.enabled = false
				var_383_4.a = var_383_5
				arg_380_1.mask_.color = var_383_4
			end

			local var_383_6 = manager.ui.mainCamera.transform
			local var_383_7 = 0.266666666666667

			if var_383_7 < arg_380_1.time_ and arg_380_1.time_ <= var_383_7 + arg_383_0 then
				local var_383_8 = arg_380_1.var_.effect1093
				local var_383_9
				local var_383_10 = var_383_6

				if not var_383_8 then
					var_383_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_383_10)
					var_383_8.name = "1093"
					arg_380_1.var_.effect1093 = var_383_8
				else
					var_383_8.transform:SetParent(var_383_10)
				end

				var_383_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_383_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_383_11 = manager.ui.mainCamera.transform
			local var_383_12 = 1.99166666666667

			if var_383_12 < arg_380_1.time_ and arg_380_1.time_ <= var_383_12 + arg_383_0 then
				local var_383_13 = arg_380_1.var_.effect1093

				if var_383_13 then
					Object.Destroy(var_383_13)

					arg_380_1.var_.effect1093 = nil
				end
			end

			local var_383_14 = 0
			local var_383_15 = 1

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				local var_383_16 = "play"
				local var_383_17 = "effect"

				arg_380_1:AudioAction(var_383_16, var_383_17, "se_story_10", "se_story_10_light", "")
			end

			local var_383_18 = 0.9
			local var_383_19 = 1

			if var_383_18 < arg_380_1.time_ and arg_380_1.time_ <= var_383_18 + arg_383_0 then
				local var_383_20 = "play"
				local var_383_21 = "effect"

				arg_380_1:AudioAction(var_383_20, var_383_21, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			local var_383_22 = 3.2
			local var_383_23 = 0.516666666666667

			if var_383_22 < arg_380_1.time_ and arg_380_1.time_ <= var_383_22 + arg_383_0 then
				local var_383_24 = "play"
				local var_383_25 = "effect"

				arg_380_1:AudioAction(var_383_24, var_383_25, "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_26 = 0.666666666666667
			local var_383_27 = 1.325

			if var_383_26 < arg_380_1.time_ and arg_380_1.time_ <= var_383_26 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_28 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_28:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_29 = arg_380_1:GetWordFromCfg(416101093)
				local var_383_30 = arg_380_1:FormatText(var_383_29.content)

				arg_380_1.text_.text = var_383_30

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_31 = 53
				local var_383_32 = utf8.len(var_383_30)
				local var_383_33 = var_383_31 <= 0 and var_383_27 or var_383_27 * (var_383_32 / var_383_31)

				if var_383_33 > 0 and var_383_27 < var_383_33 then
					arg_380_1.talkMaxDuration = var_383_33
					var_383_26 = var_383_26 + 0.3

					if var_383_33 + var_383_26 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_33 + var_383_26
					end
				end

				arg_380_1.text_.text = var_383_30
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_34 = var_383_26 + 0.3
			local var_383_35 = math.max(var_383_27, arg_380_1.talkMaxDuration)

			if var_383_34 <= arg_380_1.time_ and arg_380_1.time_ < var_383_34 + var_383_35 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_34) / var_383_35

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_34 + var_383_35 and arg_380_1.time_ < var_383_34 + var_383_35 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play416101094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 416101094
		arg_386_1.duration_ = 5.9

		local var_386_0 = {
			zh = 5.9,
			ja = 1.9
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
				arg_386_0:Play416101095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1148"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos1148 = var_389_0.localPosition
				var_389_0.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("1148", 3)

				local var_389_2 = var_389_0.childCount

				for iter_389_0 = 0, var_389_2 - 1 do
					local var_389_3 = var_389_0:GetChild(iter_389_0)

					if var_389_3.name == "split_6" or not string.find(var_389_3.name, "split") then
						var_389_3.gameObject:SetActive(true)
					else
						var_389_3.gameObject:SetActive(false)
					end
				end
			end

			local var_389_4 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_4 then
				local var_389_5 = (arg_386_1.time_ - var_389_1) / var_389_4
				local var_389_6 = Vector3.New(0, -429, -180)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1148, var_389_6, var_389_5)
			end

			if arg_386_1.time_ >= var_389_1 + var_389_4 and arg_386_1.time_ < var_389_1 + var_389_4 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_389_7 = arg_386_1.actors_["1148"]
			local var_389_8 = 0

			if var_389_8 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 and not isNil(var_389_7) and arg_386_1.var_.actorSpriteComps1148 == nil then
				arg_386_1.var_.actorSpriteComps1148 = var_389_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_9 = 0.125

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_9 and not isNil(var_389_7) then
				local var_389_10 = (arg_386_1.time_ - var_389_8) / var_389_9

				if arg_386_1.var_.actorSpriteComps1148 then
					for iter_389_1, iter_389_2 in pairs(arg_386_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_389_2 then
							if arg_386_1.isInRecall_ then
								local var_389_11 = Mathf.Lerp(iter_389_2.color.r, arg_386_1.hightColor1.r, var_389_10)
								local var_389_12 = Mathf.Lerp(iter_389_2.color.g, arg_386_1.hightColor1.g, var_389_10)
								local var_389_13 = Mathf.Lerp(iter_389_2.color.b, arg_386_1.hightColor1.b, var_389_10)

								iter_389_2.color = Color.New(var_389_11, var_389_12, var_389_13)
							else
								local var_389_14 = Mathf.Lerp(iter_389_2.color.r, 1, var_389_10)

								iter_389_2.color = Color.New(var_389_14, var_389_14, var_389_14)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_8 + var_389_9 and arg_386_1.time_ < var_389_8 + var_389_9 + arg_389_0 and not isNil(var_389_7) and arg_386_1.var_.actorSpriteComps1148 then
				for iter_389_3, iter_389_4 in pairs(arg_386_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_389_4 then
						if arg_386_1.isInRecall_ then
							iter_389_4.color = arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_389_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps1148 = nil
			end

			local var_389_15 = 0
			local var_389_16 = 0.275

			if var_389_15 < arg_386_1.time_ and arg_386_1.time_ <= var_389_15 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_17 = arg_386_1:FormatText(StoryNameCfg[8].name)

				arg_386_1.leftNameTxt_.text = var_389_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_18 = arg_386_1:GetWordFromCfg(416101094)
				local var_389_19 = arg_386_1:FormatText(var_389_18.content)

				arg_386_1.text_.text = var_389_19

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_20 = 11
				local var_389_21 = utf8.len(var_389_19)
				local var_389_22 = var_389_20 <= 0 and var_389_16 or var_389_16 * (var_389_21 / var_389_20)

				if var_389_22 > 0 and var_389_16 < var_389_22 then
					arg_386_1.talkMaxDuration = var_389_22

					if var_389_22 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_22 + var_389_15
					end
				end

				arg_386_1.text_.text = var_389_19
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101094", "story_v_out_416101.awb") ~= 0 then
					local var_389_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101094", "story_v_out_416101.awb") / 1000

					if var_389_23 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_15
					end

					if var_389_18.prefab_name ~= "" and arg_386_1.actors_[var_389_18.prefab_name] ~= nil then
						local var_389_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_18.prefab_name].transform, "story_v_out_416101", "416101094", "story_v_out_416101.awb")

						arg_386_1:RecordAudio("416101094", var_389_24)
						arg_386_1:RecordAudio("416101094", var_389_24)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_416101", "416101094", "story_v_out_416101.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_416101", "416101094", "story_v_out_416101.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_25 = math.max(var_389_16, arg_386_1.talkMaxDuration)

			if var_389_15 <= arg_386_1.time_ and arg_386_1.time_ < var_389_15 + var_389_25 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_15) / var_389_25

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_15 + var_389_25 and arg_386_1.time_ < var_389_15 + var_389_25 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
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

		arg_386_1:InitPlayNodeList()
	end,
	Play416101095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416101095
		arg_390_1.duration_ = 11.3

		local var_390_0 = {
			zh = 5.2,
			ja = 11.3
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
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416101096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1148"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps1148 == nil then
				arg_390_1.var_.actorSpriteComps1148 = var_393_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_2 = 0.125

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.actorSpriteComps1148 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								local var_393_4 = Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor2.r, var_393_3)
								local var_393_5 = Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor2.g, var_393_3)
								local var_393_6 = Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor2.b, var_393_3)

								iter_393_1.color = Color.New(var_393_4, var_393_5, var_393_6)
							else
								local var_393_7 = Mathf.Lerp(iter_393_1.color.r, 0.5, var_393_3)

								iter_393_1.color = Color.New(var_393_7, var_393_7, var_393_7)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps1148 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_393_3 then
						if arg_390_1.isInRecall_ then
							iter_393_3.color = arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_393_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps1148 = nil
			end

			local var_393_8 = 0
			local var_393_9 = 0.5

			if var_393_8 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_10 = arg_390_1:FormatText(StoryNameCfg[1082].name)

				arg_390_1.leftNameTxt_.text = var_393_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_11 = arg_390_1:GetWordFromCfg(416101095)
				local var_393_12 = arg_390_1:FormatText(var_393_11.content)

				arg_390_1.text_.text = var_393_12

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_13 = 20
				local var_393_14 = utf8.len(var_393_12)
				local var_393_15 = var_393_13 <= 0 and var_393_9 or var_393_9 * (var_393_14 / var_393_13)

				if var_393_15 > 0 and var_393_9 < var_393_15 then
					arg_390_1.talkMaxDuration = var_393_15

					if var_393_15 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_15 + var_393_8
					end
				end

				arg_390_1.text_.text = var_393_12
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101095", "story_v_out_416101.awb") ~= 0 then
					local var_393_16 = manager.audio:GetVoiceLength("story_v_out_416101", "416101095", "story_v_out_416101.awb") / 1000

					if var_393_16 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_16 + var_393_8
					end

					if var_393_11.prefab_name ~= "" and arg_390_1.actors_[var_393_11.prefab_name] ~= nil then
						local var_393_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_11.prefab_name].transform, "story_v_out_416101", "416101095", "story_v_out_416101.awb")

						arg_390_1:RecordAudio("416101095", var_393_17)
						arg_390_1:RecordAudio("416101095", var_393_17)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416101", "416101095", "story_v_out_416101.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416101", "416101095", "story_v_out_416101.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_18 = math.max(var_393_9, arg_390_1.talkMaxDuration)

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_18 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_8) / var_393_18

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_8 + var_393_18 and arg_390_1.time_ < var_393_8 + var_393_18 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play416101096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416101096
		arg_394_1.duration_ = 4.7

		local var_394_0 = {
			zh = 3.566,
			ja = 4.7
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416101097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1148"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1148 == nil then
				arg_394_1.var_.actorSpriteComps1148 = var_397_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_2 = 0.125

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.actorSpriteComps1148 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								local var_397_4 = Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, var_397_3)
								local var_397_5 = Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, var_397_3)
								local var_397_6 = Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, var_397_3)

								iter_397_1.color = Color.New(var_397_4, var_397_5, var_397_6)
							else
								local var_397_7 = Mathf.Lerp(iter_397_1.color.r, 1, var_397_3)

								iter_397_1.color = Color.New(var_397_7, var_397_7, var_397_7)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1148 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_397_3 then
						if arg_394_1.isInRecall_ then
							iter_397_3.color = arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_397_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps1148 = nil
			end

			local var_397_8 = arg_394_1.actors_["1148"].transform
			local var_397_9 = 0

			if var_397_9 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 then
				arg_394_1.var_.moveOldPos1148 = var_397_8.localPosition
				var_397_8.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1148", 3)

				local var_397_10 = var_397_8.childCount

				for iter_397_4 = 0, var_397_10 - 1 do
					local var_397_11 = var_397_8:GetChild(iter_397_4)

					if var_397_11.name == "split_3" or not string.find(var_397_11.name, "split") then
						var_397_11.gameObject:SetActive(true)
					else
						var_397_11.gameObject:SetActive(false)
					end
				end
			end

			local var_397_12 = 0.001

			if var_397_9 <= arg_394_1.time_ and arg_394_1.time_ < var_397_9 + var_397_12 then
				local var_397_13 = (arg_394_1.time_ - var_397_9) / var_397_12
				local var_397_14 = Vector3.New(0, -429, -180)

				var_397_8.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1148, var_397_14, var_397_13)
			end

			if arg_394_1.time_ >= var_397_9 + var_397_12 and arg_394_1.time_ < var_397_9 + var_397_12 + arg_397_0 then
				var_397_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_397_15 = 0
			local var_397_16 = 0.3

			if var_397_15 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_17 = arg_394_1:FormatText(StoryNameCfg[8].name)

				arg_394_1.leftNameTxt_.text = var_397_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_18 = arg_394_1:GetWordFromCfg(416101096)
				local var_397_19 = arg_394_1:FormatText(var_397_18.content)

				arg_394_1.text_.text = var_397_19

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_20 = 12
				local var_397_21 = utf8.len(var_397_19)
				local var_397_22 = var_397_20 <= 0 and var_397_16 or var_397_16 * (var_397_21 / var_397_20)

				if var_397_22 > 0 and var_397_16 < var_397_22 then
					arg_394_1.talkMaxDuration = var_397_22

					if var_397_22 + var_397_15 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_22 + var_397_15
					end
				end

				arg_394_1.text_.text = var_397_19
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101096", "story_v_out_416101.awb") ~= 0 then
					local var_397_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101096", "story_v_out_416101.awb") / 1000

					if var_397_23 + var_397_15 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_23 + var_397_15
					end

					if var_397_18.prefab_name ~= "" and arg_394_1.actors_[var_397_18.prefab_name] ~= nil then
						local var_397_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_18.prefab_name].transform, "story_v_out_416101", "416101096", "story_v_out_416101.awb")

						arg_394_1:RecordAudio("416101096", var_397_24)
						arg_394_1:RecordAudio("416101096", var_397_24)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_416101", "416101096", "story_v_out_416101.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_416101", "416101096", "story_v_out_416101.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_25 = math.max(var_397_16, arg_394_1.talkMaxDuration)

			if var_397_15 <= arg_394_1.time_ and arg_394_1.time_ < var_397_15 + var_397_25 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_15) / var_397_25

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_15 + var_397_25 and arg_394_1.time_ < var_397_15 + var_397_25 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
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

		arg_394_1:InitPlayNodeList()
	end,
	Play416101097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416101097
		arg_398_1.duration_ = 5.7

		local var_398_0 = {
			zh = 5.333,
			ja = 5.7
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play416101098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.55

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[8].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(416101097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 22
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101097", "story_v_out_416101.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101097", "story_v_out_416101.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_416101", "416101097", "story_v_out_416101.awb")

						arg_398_1:RecordAudio("416101097", var_401_9)
						arg_398_1:RecordAudio("416101097", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416101", "416101097", "story_v_out_416101.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416101", "416101097", "story_v_out_416101.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416101098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416101098
		arg_402_1.duration_ = 10.17

		local var_402_0 = {
			zh = 4.966,
			ja = 10.166
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play416101099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1148"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos1148 = var_405_0.localPosition
				var_405_0.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("1148", 7)

				local var_405_2 = var_405_0.childCount

				for iter_405_0 = 0, var_405_2 - 1 do
					local var_405_3 = var_405_0:GetChild(iter_405_0)

					if var_405_3.name == "" or not string.find(var_405_3.name, "split") then
						var_405_3.gameObject:SetActive(true)
					else
						var_405_3.gameObject:SetActive(false)
					end
				end
			end

			local var_405_4 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_4 then
				local var_405_5 = (arg_402_1.time_ - var_405_1) / var_405_4
				local var_405_6 = Vector3.New(0, -2000, 0)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1148, var_405_6, var_405_5)
			end

			if arg_402_1.time_ >= var_405_1 + var_405_4 and arg_402_1.time_ < var_405_1 + var_405_4 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_405_7 = 0
			local var_405_8 = 0.35

			if var_405_7 < arg_402_1.time_ and arg_402_1.time_ <= var_405_7 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_9 = arg_402_1:FormatText(StoryNameCfg[36].name)

				arg_402_1.leftNameTxt_.text = var_405_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_10 = arg_402_1:GetWordFromCfg(416101098)
				local var_405_11 = arg_402_1:FormatText(var_405_10.content)

				arg_402_1.text_.text = var_405_11

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_12 = 14
				local var_405_13 = utf8.len(var_405_11)
				local var_405_14 = var_405_12 <= 0 and var_405_8 or var_405_8 * (var_405_13 / var_405_12)

				if var_405_14 > 0 and var_405_8 < var_405_14 then
					arg_402_1.talkMaxDuration = var_405_14

					if var_405_14 + var_405_7 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_14 + var_405_7
					end
				end

				arg_402_1.text_.text = var_405_11
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101098", "story_v_out_416101.awb") ~= 0 then
					local var_405_15 = manager.audio:GetVoiceLength("story_v_out_416101", "416101098", "story_v_out_416101.awb") / 1000

					if var_405_15 + var_405_7 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_15 + var_405_7
					end

					if var_405_10.prefab_name ~= "" and arg_402_1.actors_[var_405_10.prefab_name] ~= nil then
						local var_405_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_10.prefab_name].transform, "story_v_out_416101", "416101098", "story_v_out_416101.awb")

						arg_402_1:RecordAudio("416101098", var_405_16)
						arg_402_1:RecordAudio("416101098", var_405_16)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416101", "416101098", "story_v_out_416101.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416101", "416101098", "story_v_out_416101.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_17 = math.max(var_405_8, arg_402_1.talkMaxDuration)

			if var_405_7 <= arg_402_1.time_ and arg_402_1.time_ < var_405_7 + var_405_17 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_7) / var_405_17

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_7 + var_405_17 and arg_402_1.time_ < var_405_7 + var_405_17 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
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

		arg_402_1:InitPlayNodeList()
	end,
	Play416101099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416101099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play416101100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 1.575

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_2 = arg_406_1:GetWordFromCfg(416101099)
				local var_409_3 = arg_406_1:FormatText(var_409_2.content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 63
				local var_409_5 = utf8.len(var_409_3)
				local var_409_6 = var_409_4 <= 0 and var_409_1 or var_409_1 * (var_409_5 / var_409_4)

				if var_409_6 > 0 and var_409_1 < var_409_6 then
					arg_406_1.talkMaxDuration = var_409_6

					if var_409_6 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_6 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_7 and arg_406_1.time_ < var_409_0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play416101100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416101100
		arg_410_1.duration_ = 6.77

		local var_410_0 = {
			zh = 5.166,
			ja = 6.766
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play416101101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1148"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1148 = var_413_0.localPosition
				var_413_0.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1148", 3)

				local var_413_2 = var_413_0.childCount

				for iter_413_0 = 0, var_413_2 - 1 do
					local var_413_3 = var_413_0:GetChild(iter_413_0)

					if var_413_3.name == "split_3" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_4 then
				local var_413_5 = (arg_410_1.time_ - var_413_1) / var_413_4
				local var_413_6 = Vector3.New(0, -429, -180)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1148, var_413_6, var_413_5)
			end

			if arg_410_1.time_ >= var_413_1 + var_413_4 and arg_410_1.time_ < var_413_1 + var_413_4 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_413_7 = arg_410_1.actors_["1148"]
			local var_413_8 = 0

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1148 == nil then
				arg_410_1.var_.actorSpriteComps1148 = var_413_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_9 = 0.125

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_9 and not isNil(var_413_7) then
				local var_413_10 = (arg_410_1.time_ - var_413_8) / var_413_9

				if arg_410_1.var_.actorSpriteComps1148 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								local var_413_11 = Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor1.r, var_413_10)
								local var_413_12 = Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor1.g, var_413_10)
								local var_413_13 = Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor1.b, var_413_10)

								iter_413_2.color = Color.New(var_413_11, var_413_12, var_413_13)
							else
								local var_413_14 = Mathf.Lerp(iter_413_2.color.r, 1, var_413_10)

								iter_413_2.color = Color.New(var_413_14, var_413_14, var_413_14)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_8 + var_413_9 and arg_410_1.time_ < var_413_8 + var_413_9 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1148 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_413_4 then
						if arg_410_1.isInRecall_ then
							iter_413_4.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps1148 = nil
			end

			local var_413_15 = 0
			local var_413_16 = 0.575

			if var_413_15 < arg_410_1.time_ and arg_410_1.time_ <= var_413_15 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_17 = arg_410_1:FormatText(StoryNameCfg[8].name)

				arg_410_1.leftNameTxt_.text = var_413_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_18 = arg_410_1:GetWordFromCfg(416101100)
				local var_413_19 = arg_410_1:FormatText(var_413_18.content)

				arg_410_1.text_.text = var_413_19

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_20 = 23
				local var_413_21 = utf8.len(var_413_19)
				local var_413_22 = var_413_20 <= 0 and var_413_16 or var_413_16 * (var_413_21 / var_413_20)

				if var_413_22 > 0 and var_413_16 < var_413_22 then
					arg_410_1.talkMaxDuration = var_413_22

					if var_413_22 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_22 + var_413_15
					end
				end

				arg_410_1.text_.text = var_413_19
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101100", "story_v_out_416101.awb") ~= 0 then
					local var_413_23 = manager.audio:GetVoiceLength("story_v_out_416101", "416101100", "story_v_out_416101.awb") / 1000

					if var_413_23 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_23 + var_413_15
					end

					if var_413_18.prefab_name ~= "" and arg_410_1.actors_[var_413_18.prefab_name] ~= nil then
						local var_413_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_18.prefab_name].transform, "story_v_out_416101", "416101100", "story_v_out_416101.awb")

						arg_410_1:RecordAudio("416101100", var_413_24)
						arg_410_1:RecordAudio("416101100", var_413_24)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_416101", "416101100", "story_v_out_416101.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_416101", "416101100", "story_v_out_416101.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_25 = math.max(var_413_16, arg_410_1.talkMaxDuration)

			if var_413_15 <= arg_410_1.time_ and arg_410_1.time_ < var_413_15 + var_413_25 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_15) / var_413_25

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_15 + var_413_25 and arg_410_1.time_ < var_413_15 + var_413_25 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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

		arg_410_1:InitPlayNodeList()
	end,
	Play416101101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 416101101
		arg_414_1.duration_ = 10.7

		local var_414_0 = {
			zh = 6.866,
			ja = 10.7
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play416101102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1148"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1148 = var_417_0.localPosition
				var_417_0.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("1148", 7)

				local var_417_2 = var_417_0.childCount

				for iter_417_0 = 0, var_417_2 - 1 do
					local var_417_3 = var_417_0:GetChild(iter_417_0)

					if var_417_3.name == "" or not string.find(var_417_3.name, "split") then
						var_417_3.gameObject:SetActive(true)
					else
						var_417_3.gameObject:SetActive(false)
					end
				end
			end

			local var_417_4 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_4 then
				local var_417_5 = (arg_414_1.time_ - var_417_1) / var_417_4
				local var_417_6 = Vector3.New(0, -2000, 0)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1148, var_417_6, var_417_5)
			end

			if arg_414_1.time_ >= var_417_1 + var_417_4 and arg_414_1.time_ < var_417_1 + var_417_4 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_417_7 = 0
			local var_417_8 = 0.55

			if var_417_7 < arg_414_1.time_ and arg_414_1.time_ <= var_417_7 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_9 = arg_414_1:FormatText(StoryNameCfg[36].name)

				arg_414_1.leftNameTxt_.text = var_417_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(416101101)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_12 = 22
				local var_417_13 = utf8.len(var_417_11)
				local var_417_14 = var_417_12 <= 0 and var_417_8 or var_417_8 * (var_417_13 / var_417_12)

				if var_417_14 > 0 and var_417_8 < var_417_14 then
					arg_414_1.talkMaxDuration = var_417_14

					if var_417_14 + var_417_7 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_7
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101101", "story_v_out_416101.awb") ~= 0 then
					local var_417_15 = manager.audio:GetVoiceLength("story_v_out_416101", "416101101", "story_v_out_416101.awb") / 1000

					if var_417_15 + var_417_7 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_15 + var_417_7
					end

					if var_417_10.prefab_name ~= "" and arg_414_1.actors_[var_417_10.prefab_name] ~= nil then
						local var_417_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_10.prefab_name].transform, "story_v_out_416101", "416101101", "story_v_out_416101.awb")

						arg_414_1:RecordAudio("416101101", var_417_16)
						arg_414_1:RecordAudio("416101101", var_417_16)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_416101", "416101101", "story_v_out_416101.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_416101", "416101101", "story_v_out_416101.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_17 = math.max(var_417_8, arg_414_1.talkMaxDuration)

			if var_417_7 <= arg_414_1.time_ and arg_414_1.time_ < var_417_7 + var_417_17 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_7) / var_417_17

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_7 + var_417_17 and arg_414_1.time_ < var_417_7 + var_417_17 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
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

		arg_414_1:InitPlayNodeList()
	end,
	Play416101102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 416101102
		arg_418_1.duration_ = 5.2

		local var_418_0 = {
			zh = 4.4,
			ja = 5.2
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play416101103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.533333333333333
			local var_421_1 = 0.466666666666667

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				local var_421_2 = "play"
				local var_421_3 = "effect"

				arg_418_1:AudioAction(var_421_2, var_421_3, "se_story_138", "se_story_138_weaponfall", "")
			end

			local var_421_4 = 0
			local var_421_5 = 0.25

			if var_421_4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_6 = arg_418_1:FormatText(StoryNameCfg[36].name)

				arg_418_1.leftNameTxt_.text = var_421_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_7 = arg_418_1:GetWordFromCfg(416101102)
				local var_421_8 = arg_418_1:FormatText(var_421_7.content)

				arg_418_1.text_.text = var_421_8

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_9 = 10
				local var_421_10 = utf8.len(var_421_8)
				local var_421_11 = var_421_9 <= 0 and var_421_5 or var_421_5 * (var_421_10 / var_421_9)

				if var_421_11 > 0 and var_421_5 < var_421_11 then
					arg_418_1.talkMaxDuration = var_421_11

					if var_421_11 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_11 + var_421_4
					end
				end

				arg_418_1.text_.text = var_421_8
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101102", "story_v_out_416101.awb") ~= 0 then
					local var_421_12 = manager.audio:GetVoiceLength("story_v_out_416101", "416101102", "story_v_out_416101.awb") / 1000

					if var_421_12 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_12 + var_421_4
					end

					if var_421_7.prefab_name ~= "" and arg_418_1.actors_[var_421_7.prefab_name] ~= nil then
						local var_421_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_7.prefab_name].transform, "story_v_out_416101", "416101102", "story_v_out_416101.awb")

						arg_418_1:RecordAudio("416101102", var_421_13)
						arg_418_1:RecordAudio("416101102", var_421_13)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_416101", "416101102", "story_v_out_416101.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_416101", "416101102", "story_v_out_416101.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_14 = math.max(var_421_5, arg_418_1.talkMaxDuration)

			if var_421_4 <= arg_418_1.time_ and arg_418_1.time_ < var_421_4 + var_421_14 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_4) / var_421_14

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_4 + var_421_14 and arg_418_1.time_ < var_421_4 + var_421_14 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play416101103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 416101103
		arg_422_1.duration_ = 9

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play416101104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 4

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.allBtn_.enabled = false
			end

			local var_425_1 = 0.3

			if arg_422_1.time_ >= var_425_0 + var_425_1 and arg_422_1.time_ < var_425_0 + var_425_1 + arg_425_0 then
				arg_422_1.allBtn_.enabled = true
			end

			local var_425_2 = "SS1604"

			if arg_422_1.bgs_[var_425_2] == nil then
				local var_425_3 = Object.Instantiate(arg_422_1.paintGo_)

				var_425_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_425_2)
				var_425_3.name = var_425_2
				var_425_3.transform.parent = arg_422_1.stage_.transform
				var_425_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.bgs_[var_425_2] = var_425_3
			end

			local var_425_4 = 2

			if var_425_4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				local var_425_5 = manager.ui.mainCamera.transform.localPosition
				local var_425_6 = Vector3.New(0, 0, 10) + Vector3.New(var_425_5.x, var_425_5.y, 0)
				local var_425_7 = arg_422_1.bgs_.SS1604

				var_425_7.transform.localPosition = var_425_6
				var_425_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_425_8 = var_425_7:GetComponent("SpriteRenderer")

				if var_425_8 and var_425_8.sprite then
					local var_425_9 = (var_425_7.transform.localPosition - var_425_5).z
					local var_425_10 = manager.ui.mainCameraCom_
					local var_425_11 = 2 * var_425_9 * Mathf.Tan(var_425_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_425_12 = var_425_11 * var_425_10.aspect
					local var_425_13 = var_425_8.sprite.bounds.size.x
					local var_425_14 = var_425_8.sprite.bounds.size.y
					local var_425_15 = var_425_12 / var_425_13
					local var_425_16 = var_425_11 / var_425_14
					local var_425_17 = var_425_16 < var_425_15 and var_425_15 or var_425_16

					var_425_7.transform.localScale = Vector3.New(var_425_17, var_425_17, 0)
				end

				for iter_425_0, iter_425_1 in pairs(arg_422_1.bgs_) do
					if iter_425_0 ~= "SS1604" then
						iter_425_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_425_18 = 0

			if var_425_18 < arg_422_1.time_ and arg_422_1.time_ <= var_425_18 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_19 = 2

			if var_425_18 <= arg_422_1.time_ and arg_422_1.time_ < var_425_18 + var_425_19 then
				local var_425_20 = (arg_422_1.time_ - var_425_18) / var_425_19
				local var_425_21 = Color.New(0, 0, 0)

				var_425_21.a = Mathf.Lerp(0, 1, var_425_20)
				arg_422_1.mask_.color = var_425_21
			end

			if arg_422_1.time_ >= var_425_18 + var_425_19 and arg_422_1.time_ < var_425_18 + var_425_19 + arg_425_0 then
				local var_425_22 = Color.New(0, 0, 0)

				var_425_22.a = 1
				arg_422_1.mask_.color = var_425_22
			end

			local var_425_23 = 2

			if var_425_23 < arg_422_1.time_ and arg_422_1.time_ <= var_425_23 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_24 = 2

			if var_425_23 <= arg_422_1.time_ and arg_422_1.time_ < var_425_23 + var_425_24 then
				local var_425_25 = (arg_422_1.time_ - var_425_23) / var_425_24
				local var_425_26 = Color.New(0, 0, 0)

				var_425_26.a = Mathf.Lerp(1, 0, var_425_25)
				arg_422_1.mask_.color = var_425_26
			end

			if arg_422_1.time_ >= var_425_23 + var_425_24 and arg_422_1.time_ < var_425_23 + var_425_24 + arg_425_0 then
				local var_425_27 = Color.New(0, 0, 0)
				local var_425_28 = 0

				arg_422_1.mask_.enabled = false
				var_425_27.a = var_425_28
				arg_422_1.mask_.color = var_425_27
			end

			local var_425_29 = manager.ui.mainCamera.transform
			local var_425_30 = 1.8

			if var_425_30 < arg_422_1.time_ and arg_422_1.time_ <= var_425_30 + arg_425_0 then
				local var_425_31 = arg_422_1.var_.effect10932

				if var_425_31 then
					Object.Destroy(var_425_31)

					arg_422_1.var_.effect10932 = nil
				end
			end

			local var_425_32 = manager.ui.mainCamera.transform
			local var_425_33 = 2

			if var_425_33 < arg_422_1.time_ and arg_422_1.time_ <= var_425_33 + arg_425_0 then
				local var_425_34 = arg_422_1.var_.effect10932
				local var_425_35
				local var_425_36 = var_425_32

				if not var_425_34 then
					var_425_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), var_425_36)
					var_425_34.name = "10932"
					arg_422_1.var_.effect10932 = var_425_34
				else
					var_425_34.transform:SetParent(var_425_36)
				end

				var_425_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_425_34.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_37 = 4
			local var_425_38 = 1.575

			if var_425_37 < arg_422_1.time_ and arg_422_1.time_ <= var_425_37 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_39 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_39:setOnUpdate(LuaHelper.FloatAction(function(arg_426_0)
					arg_422_1.dialogCg_.alpha = arg_426_0
				end))
				var_425_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_40 = arg_422_1:GetWordFromCfg(416101103)
				local var_425_41 = arg_422_1:FormatText(var_425_40.content)

				arg_422_1.text_.text = var_425_41

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_42 = 63
				local var_425_43 = utf8.len(var_425_41)
				local var_425_44 = var_425_42 <= 0 and var_425_38 or var_425_38 * (var_425_43 / var_425_42)

				if var_425_44 > 0 and var_425_38 < var_425_44 then
					arg_422_1.talkMaxDuration = var_425_44
					var_425_37 = var_425_37 + 0.3

					if var_425_44 + var_425_37 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_44 + var_425_37
					end
				end

				arg_422_1.text_.text = var_425_41
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_45 = var_425_37 + 0.3
			local var_425_46 = math.max(var_425_38, arg_422_1.talkMaxDuration)

			if var_425_45 <= arg_422_1.time_ and arg_422_1.time_ < var_425_45 + var_425_46 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_45) / var_425_46

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_45 + var_425_46 and arg_422_1.time_ < var_425_45 + var_425_46 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play416101104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 416101104
		arg_428_1.duration_ = 8.9

		local var_428_0 = {
			zh = 7.1,
			ja = 8.9
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
				arg_428_0:Play416101105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.45

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[36].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:GetWordFromCfg(416101104)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101104", "story_v_out_416101.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101104", "story_v_out_416101.awb") / 1000

					if var_431_8 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_0
					end

					if var_431_3.prefab_name ~= "" and arg_428_1.actors_[var_431_3.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_3.prefab_name].transform, "story_v_out_416101", "416101104", "story_v_out_416101.awb")

						arg_428_1:RecordAudio("416101104", var_431_9)
						arg_428_1:RecordAudio("416101104", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_416101", "416101104", "story_v_out_416101.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_416101", "416101104", "story_v_out_416101.awb")
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
	Play416101105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 416101105
		arg_432_1.duration_ = 7.1

		local var_432_0 = {
			zh = 6.933,
			ja = 7.1
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
			arg_432_1.auto_ = false
		end

		function arg_432_1.playNext_(arg_434_0)
			arg_432_1.onStoryFinished_()
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.375

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[36].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:GetWordFromCfg(416101105)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101105", "story_v_out_416101.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101105", "story_v_out_416101.awb") / 1000

					if var_435_8 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_0
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_out_416101", "416101105", "story_v_out_416101.awb")

						arg_432_1:RecordAudio("416101105", var_435_9)
						arg_432_1:RecordAudio("416101105", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_416101", "416101105", "story_v_out_416101.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_416101", "416101105", "story_v_out_416101.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_10 and arg_432_1.time_ < var_435_0 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/SS1604"
	},
	voices = {
		"story_v_out_416101.awb"
	}
}
