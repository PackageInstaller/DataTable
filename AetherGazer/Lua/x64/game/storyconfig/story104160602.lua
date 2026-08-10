return {
	Play416062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416062001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 4.866,
			ja = 6.666
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
				arg_1_0:Play416062002(arg_1_1)
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

			local var_4_24 = "1086"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

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

			local var_4_28 = arg_1_1.actors_["1086"].transform
			local var_4_29 = 1.67800913522889

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos1086 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1086", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_4" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -404.2, -237.9)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1086, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_4_35 = arg_1_1.actors_["1086"]
			local var_4_36 = 1.67800913522889

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1086 == nil then
				arg_1_1.var_.actorSpriteComps1086 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.125

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps1086 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1086 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1086 = nil
			end

			local var_4_43 = arg_1_1.actors_["1086"]
			local var_4_44 = 1.67800913522889

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1086 = var_4_45.alpha
					arg_1_1.var_.characterEffect1086 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1086 = 0
			end

			local var_4_46 = 0.857666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1086, 1, var_4_47)

				if arg_1_1.var_.characterEffect1086 then
					arg_1_1.var_.characterEffect1086.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1086 then
				arg_1_1.var_.characterEffect1086.alpha = 1
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

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

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

			local var_4_61 = 2
			local var_4_62 = 0.325

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[1080].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416062001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062001", "story_v_out_416062.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416062", "416062001", "story_v_out_416062.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416062", "416062001", "story_v_out_416062.awb")

						arg_1_1:RecordAudio("416062001", var_4_71)
						arg_1_1:RecordAudio("416062001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416062", "416062001", "story_v_out_416062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416062", "416062001", "story_v_out_416062.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.67800913522889,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416062002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1086"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1086 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1086", 7)

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

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1086, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = 0
			local var_12_8 = 1.55

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

				local var_12_9 = arg_9_1:GetWordFromCfg(416062002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 62
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
				actorName = "1086",
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
	Play416062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416062003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			zh = 5.366,
			ja = 9.166
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
				arg_13_0:Play416062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1086"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1086 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1086", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -404.2, -237.9)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1086, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_16_7 = arg_13_1.actors_["1086"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1086 == nil then
				arg_13_1.var_.actorSpriteComps1086 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.125

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps1086 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1086 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1086 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.65

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[1080].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(416062003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062003", "story_v_out_416062.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062003", "story_v_out_416062.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_416062", "416062003", "story_v_out_416062.awb")

						arg_13_1:RecordAudio("416062003", var_16_24)
						arg_13_1:RecordAudio("416062003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416062", "416062003", "story_v_out_416062.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416062", "416062003", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416062004
		arg_17_1.duration_ = 7.27

		local var_17_0 = {
			zh = 3.6,
			ja = 7.266
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
				arg_17_0:Play416062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1086"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 2)

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
				local var_20_6 = Vector3.New(-390, -404.2, -237.9)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_20_7 = "1148"

			if arg_17_1.actors_[var_20_7] == nil then
				local var_20_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_20_8) then
					local var_20_9 = Object.Instantiate(var_20_8, arg_17_1.canvasGo_.transform)

					var_20_9.transform:SetSiblingIndex(1)

					var_20_9.name = var_20_7
					var_20_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_7] = var_20_9

					local var_20_10 = var_20_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_1, iter_20_2 in ipairs(var_20_10) do
							iter_20_2.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_11 = arg_17_1.actors_["1148"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1148", 4)

				local var_20_13 = var_20_11.childCount

				for iter_20_3 = 0, var_20_13 - 1 do
					local var_20_14 = var_20_11:GetChild(iter_20_3)

					if var_20_14.name == "split_5" or not string.find(var_20_14.name, "split") then
						var_20_14.gameObject:SetActive(true)
					else
						var_20_14.gameObject:SetActive(false)
					end
				end
			end

			local var_20_15 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_15 then
				local var_20_16 = (arg_17_1.time_ - var_20_12) / var_20_15
				local var_20_17 = Vector3.New(390, -429, -180)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148, var_20_17, var_20_16)
			end

			if arg_17_1.time_ >= var_20_12 + var_20_15 and arg_17_1.time_ < var_20_12 + var_20_15 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(390, -429, -180)
			end

			local var_20_18 = arg_17_1.actors_["1148"]
			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = var_20_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_20 = 0.125

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 and not isNil(var_20_18) then
				local var_20_21 = (arg_17_1.time_ - var_20_19) / var_20_20

				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_22 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor1.r, var_20_21)
								local var_20_23 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor1.g, var_20_21)
								local var_20_24 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor1.b, var_20_21)

								iter_20_5.color = Color.New(var_20_22, var_20_23, var_20_24)
							else
								local var_20_25 = Mathf.Lerp(iter_20_5.color.r, 1, var_20_21)

								iter_20_5.color = Color.New(var_20_25, var_20_25, var_20_25)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_26 = arg_17_1.actors_["1086"]
			local var_20_27 = 0

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 and not isNil(var_20_26) and arg_17_1.var_.actorSpriteComps1086 == nil then
				arg_17_1.var_.actorSpriteComps1086 = var_20_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_28 = 0.125

			if var_20_27 <= arg_17_1.time_ and arg_17_1.time_ < var_20_27 + var_20_28 and not isNil(var_20_26) then
				local var_20_29 = (arg_17_1.time_ - var_20_27) / var_20_28

				if arg_17_1.var_.actorSpriteComps1086 then
					for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_20_9 then
							if arg_17_1.isInRecall_ then
								local var_20_30 = Mathf.Lerp(iter_20_9.color.r, arg_17_1.hightColor2.r, var_20_29)
								local var_20_31 = Mathf.Lerp(iter_20_9.color.g, arg_17_1.hightColor2.g, var_20_29)
								local var_20_32 = Mathf.Lerp(iter_20_9.color.b, arg_17_1.hightColor2.b, var_20_29)

								iter_20_9.color = Color.New(var_20_30, var_20_31, var_20_32)
							else
								local var_20_33 = Mathf.Lerp(iter_20_9.color.r, 0.5, var_20_29)

								iter_20_9.color = Color.New(var_20_33, var_20_33, var_20_33)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_27 + var_20_28 and arg_17_1.time_ < var_20_27 + var_20_28 + arg_20_0 and not isNil(var_20_26) and arg_17_1.var_.actorSpriteComps1086 then
				for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_20_11 then
						if arg_17_1.isInRecall_ then
							iter_20_11.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1086 = nil
			end

			local var_20_34 = 0
			local var_20_35 = 0.35

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[8].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(416062004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 14
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062004", "story_v_out_416062.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_416062", "416062004", "story_v_out_416062.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_416062", "416062004", "story_v_out_416062.awb")

						arg_17_1:RecordAudio("416062004", var_20_43)
						arg_17_1:RecordAudio("416062004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416062", "416062004", "story_v_out_416062.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416062", "416062004", "story_v_out_416062.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play416062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416062005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 5.133,
			ja = 7.3
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
				arg_21_0:Play416062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1148"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.125

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_8 = arg_21_1.actors_["1086"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1086 == nil then
				arg_21_1.var_.actorSpriteComps1086 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.125

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1086 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1086 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1086 = nil
			end

			local var_24_16 = arg_21_1.actors_["1148"].transform
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_16.localPosition
				var_24_16.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 4)

				local var_24_18 = var_24_16.childCount

				for iter_24_8 = 0, var_24_18 - 1 do
					local var_24_19 = var_24_16:GetChild(iter_24_8)

					if var_24_19.name == "split_4" or not string.find(var_24_19.name, "split") then
						var_24_19.gameObject:SetActive(true)
					else
						var_24_19.gameObject:SetActive(false)
					end
				end
			end

			local var_24_20 = 0.001

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_20 then
				local var_24_21 = (arg_21_1.time_ - var_24_17) / var_24_20
				local var_24_22 = Vector3.New(390, -429, -180)

				var_24_16.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, var_24_22, var_24_21)
			end

			if arg_21_1.time_ >= var_24_17 + var_24_20 and arg_21_1.time_ < var_24_17 + var_24_20 + arg_24_0 then
				var_24_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_24_23 = 0
			local var_24_24 = 0.6

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(416062005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 24
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062005", "story_v_out_416062.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062005", "story_v_out_416062.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_416062", "416062005", "story_v_out_416062.awb")

						arg_21_1:RecordAudio("416062005", var_24_32)
						arg_21_1:RecordAudio("416062005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416062", "416062005", "story_v_out_416062.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416062", "416062005", "story_v_out_416062.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_33 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_33 and arg_21_1.time_ < var_24_23 + var_24_33 + arg_24_0 then
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
	Play416062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416062006
		arg_25_1.duration_ = 7.67

		local var_25_0 = {
			zh = 4.5,
			ja = 7.666
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
				arg_25_0:Play416062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1086"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1086 == nil then
				arg_25_1.var_.actorSpriteComps1086 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.125

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1086 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1086 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1086 = nil
			end

			local var_28_8 = arg_25_1.actors_["1148"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.125

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 0.5, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_16 = arg_25_1.actors_["1086"].transform
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.var_.moveOldPos1086 = var_28_16.localPosition
				var_28_16.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1086", 2)

				local var_28_18 = var_28_16.childCount

				for iter_28_8 = 0, var_28_18 - 1 do
					local var_28_19 = var_28_16:GetChild(iter_28_8)

					if var_28_19.name == "split_2" or not string.find(var_28_19.name, "split") then
						var_28_19.gameObject:SetActive(true)
					else
						var_28_19.gameObject:SetActive(false)
					end
				end
			end

			local var_28_20 = 0.001

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_17) / var_28_20
				local var_28_22 = Vector3.New(-390, -404.2, -237.9)

				var_28_16.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1086, var_28_22, var_28_21)
			end

			if arg_25_1.time_ >= var_28_17 + var_28_20 and arg_25_1.time_ < var_28_17 + var_28_20 + arg_28_0 then
				var_28_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_28_23 = 0
			local var_28_24 = 0.425

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[1080].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(416062006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 17
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062006", "story_v_out_416062.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062006", "story_v_out_416062.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_416062", "416062006", "story_v_out_416062.awb")

						arg_25_1:RecordAudio("416062006", var_28_32)
						arg_25_1:RecordAudio("416062006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416062", "416062006", "story_v_out_416062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416062", "416062006", "story_v_out_416062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416062007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416062008(arg_29_1)
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

			local var_32_7 = arg_29_1.actors_["1086"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos1086 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1086", 7)

				local var_32_9 = var_32_7.childCount

				for iter_32_1 = 0, var_32_9 - 1 do
					local var_32_10 = var_32_7:GetChild(iter_32_1)

					if var_32_10.name == "" or not string.find(var_32_10.name, "split") then
						var_32_10.gameObject:SetActive(true)
					else
						var_32_10.gameObject:SetActive(false)
					end
				end
			end

			local var_32_11 = 0.001

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_8) / var_32_11
				local var_32_13 = Vector3.New(0, -2000, 0)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1086, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_14 = 0.6
			local var_32_15 = 1

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				local var_32_16 = "play"
				local var_32_17 = "effect"

				arg_29_1:AudioAction(var_32_16, var_32_17, "se_story_222_00", "se_story_222_00_finger", "")
			end

			local var_32_18 = 0.6
			local var_32_19 = 0.666666666666667

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				local var_32_20 = "play"
				local var_32_21 = "effect"

				arg_29_1:AudioAction(var_32_20, var_32_21, "se_story_121_04", "se_story_121_04_recordopen", "")
			end

			local var_32_22 = 0
			local var_32_23 = 1.925

			if var_32_22 < arg_29_1.time_ and arg_29_1.time_ <= var_32_22 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_24 = arg_29_1:GetWordFromCfg(416062007)
				local var_32_25 = arg_29_1:FormatText(var_32_24.content)

				arg_29_1.text_.text = var_32_25

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_26 = 77
				local var_32_27 = utf8.len(var_32_25)
				local var_32_28 = var_32_26 <= 0 and var_32_23 or var_32_23 * (var_32_27 / var_32_26)

				if var_32_28 > 0 and var_32_23 < var_32_28 then
					arg_29_1.talkMaxDuration = var_32_28

					if var_32_28 + var_32_22 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_22
					end
				end

				arg_29_1.text_.text = var_32_25
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_29 = math.max(var_32_23, arg_29_1.talkMaxDuration)

			if var_32_22 <= arg_29_1.time_ and arg_29_1.time_ < var_32_22 + var_32_29 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_22) / var_32_29

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_22 + var_32_29 and arg_29_1.time_ < var_32_22 + var_32_29 + arg_32_0 then
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
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416062008
		arg_33_1.duration_ = 7.2

		local var_33_0 = {
			zh = 7.033,
			ja = 7.2
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
				arg_33_0:Play416062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1148"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.125

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_8 = arg_33_1.actors_["1148"].transform
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.var_.moveOldPos1148 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1148", 3)

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
				local var_36_14 = Vector3.New(0, -429, -180)

				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1148, var_36_14, var_36_13)
			end

			if arg_33_1.time_ >= var_36_9 + var_36_12 and arg_33_1.time_ < var_36_9 + var_36_12 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_36_15 = 0
			local var_36_16 = 0.6

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(416062008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062008", "story_v_out_416062.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062008", "story_v_out_416062.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_416062", "416062008", "story_v_out_416062.awb")

						arg_33_1:RecordAudio("416062008", var_36_24)
						arg_33_1:RecordAudio("416062008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416062", "416062008", "story_v_out_416062.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416062", "416062008", "story_v_out_416062.awb")
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
				actorName = "1148",
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
	Play416062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416062009
		arg_37_1.duration_ = 7.7

		local var_37_0 = {
			zh = 4.466,
			ja = 7.7
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
				arg_37_0:Play416062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1148"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 2)

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
				local var_40_6 = Vector3.New(-390, -429, -180)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -429, -180)
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
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor2.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor2.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor2.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 0.5, var_40_10)

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
							iter_40_4.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_15 = arg_37_1.actors_["1086"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos1086 = var_40_15.localPosition
				var_40_15.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1086", 4)

				local var_40_17 = var_40_15.childCount

				for iter_40_5 = 0, var_40_17 - 1 do
					local var_40_18 = var_40_15:GetChild(iter_40_5)

					if var_40_18.name == "split_2" or not string.find(var_40_18.name, "split") then
						var_40_18.gameObject:SetActive(true)
					else
						var_40_18.gameObject:SetActive(false)
					end
				end
			end

			local var_40_19 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_19 then
				local var_40_20 = (arg_37_1.time_ - var_40_16) / var_40_19
				local var_40_21 = Vector3.New(390, -404.2, -237.9)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1086, var_40_21, var_40_20)
			end

			if arg_37_1.time_ >= var_40_16 + var_40_19 and arg_37_1.time_ < var_40_16 + var_40_19 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_40_22 = arg_37_1.actors_["1086"]
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps1086 == nil then
				arg_37_1.var_.actorSpriteComps1086 = var_40_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_24 = 0.125

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 and not isNil(var_40_22) then
				local var_40_25 = (arg_37_1.time_ - var_40_23) / var_40_24

				if arg_37_1.var_.actorSpriteComps1086 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								local var_40_26 = Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor1.r, var_40_25)
								local var_40_27 = Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor1.g, var_40_25)
								local var_40_28 = Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor1.b, var_40_25)

								iter_40_7.color = Color.New(var_40_26, var_40_27, var_40_28)
							else
								local var_40_29 = Mathf.Lerp(iter_40_7.color.r, 1, var_40_25)

								iter_40_7.color = Color.New(var_40_29, var_40_29, var_40_29)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps1086 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_40_9 then
						if arg_37_1.isInRecall_ then
							iter_40_9.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1086 = nil
			end

			local var_40_30 = 0
			local var_40_31 = 0.55

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[1080].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(416062009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 22
				local var_40_36 = utf8.len(var_40_34)
				local var_40_37 = var_40_35 <= 0 and var_40_31 or var_40_31 * (var_40_36 / var_40_35)

				if var_40_37 > 0 and var_40_31 < var_40_37 then
					arg_37_1.talkMaxDuration = var_40_37

					if var_40_37 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_37 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_34
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062009", "story_v_out_416062.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062009", "story_v_out_416062.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_416062", "416062009", "story_v_out_416062.awb")

						arg_37_1:RecordAudio("416062009", var_40_39)
						arg_37_1:RecordAudio("416062009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416062", "416062009", "story_v_out_416062.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416062", "416062009", "story_v_out_416062.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_40 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_40 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_40

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_40 and arg_37_1.time_ < var_40_30 + var_40_40 + arg_40_0 then
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
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416062010
		arg_41_1.duration_ = 4

		local var_41_0 = {
			zh = 2.866,
			ja = 4
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
				arg_41_0:Play416062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.25

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1080].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(416062010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062010", "story_v_out_416062.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062010", "story_v_out_416062.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_416062", "416062010", "story_v_out_416062.awb")

						arg_41_1:RecordAudio("416062010", var_44_9)
						arg_41_1:RecordAudio("416062010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416062", "416062010", "story_v_out_416062.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416062", "416062010", "story_v_out_416062.awb")
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
	Play416062011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416062011
		arg_45_1.duration_ = 7.6

		local var_45_0 = {
			zh = 4.933,
			ja = 7.6
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
				arg_45_0:Play416062012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1086"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1086 == nil then
				arg_45_1.var_.actorSpriteComps1086 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.125

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1086 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1086 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1086 = nil
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

				arg_45_1:CheckSpriteTmpPos("1148", 2)

				local var_48_18 = var_48_16.childCount

				for iter_48_8 = 0, var_48_18 - 1 do
					local var_48_19 = var_48_16:GetChild(iter_48_8)

					if var_48_19.name == "split_2" or not string.find(var_48_19.name, "split") then
						var_48_19.gameObject:SetActive(true)
					else
						var_48_19.gameObject:SetActive(false)
					end
				end
			end

			local var_48_20 = 0.001

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_17) / var_48_20
				local var_48_22 = Vector3.New(-390, -429, -180)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_48_23 = 0
			local var_48_24 = 0.525

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

				local var_48_26 = arg_45_1:GetWordFromCfg(416062011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062011", "story_v_out_416062.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062011", "story_v_out_416062.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_416062", "416062011", "story_v_out_416062.awb")

						arg_45_1:RecordAudio("416062011", var_48_32)
						arg_45_1:RecordAudio("416062011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416062", "416062011", "story_v_out_416062.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416062", "416062011", "story_v_out_416062.awb")
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
	Play416062012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416062012
		arg_49_1.duration_ = 4.7

		local var_49_0 = {
			zh = 3.366,
			ja = 4.7
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
				arg_49_0:Play416062013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1148"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1148 == nil then
				arg_49_1.var_.actorSpriteComps1148 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.125

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps1148 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 0.5, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1148 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1148 = nil
			end

			local var_52_8 = arg_49_1.actors_["1086"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1086 == nil then
				arg_49_1.var_.actorSpriteComps1086 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.125

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps1086 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor1.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor1.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor1.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 1, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1086 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1086 = nil
			end

			local var_52_16 = arg_49_1.actors_["1086"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos1086 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1086", 4)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "split_4" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(390, -404.2, -237.9)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1086, var_52_22, var_52_21)
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_52_23 = 0
			local var_52_24 = 0.35

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[1080].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(416062012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 14
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062012", "story_v_out_416062.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062012", "story_v_out_416062.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_416062", "416062012", "story_v_out_416062.awb")

						arg_49_1:RecordAudio("416062012", var_52_32)
						arg_49_1:RecordAudio("416062012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416062", "416062012", "story_v_out_416062.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416062", "416062012", "story_v_out_416062.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416062013
		arg_53_1.duration_ = 6.7

		local var_53_0 = {
			zh = 6.7,
			ja = 2.733
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
				arg_53_0:Play416062014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1086"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1086 == nil then
				arg_53_1.var_.actorSpriteComps1086 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.125

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1086 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1086 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1086 = nil
			end

			local var_56_8 = arg_53_1.actors_["1148"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1148 == nil then
				arg_53_1.var_.actorSpriteComps1148 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.125

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps1148 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor1.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor1.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor1.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 1, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1148 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1148 = nil
			end

			local var_56_16 = arg_53_1.actors_["1148"].transform
			local var_56_17 = 0

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				arg_53_1.var_.moveOldPos1148 = var_56_16.localPosition
				var_56_16.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1148", 2)

				local var_56_18 = var_56_16.childCount

				for iter_56_8 = 0, var_56_18 - 1 do
					local var_56_19 = var_56_16:GetChild(iter_56_8)

					if var_56_19.name == "split_6" or not string.find(var_56_19.name, "split") then
						var_56_19.gameObject:SetActive(true)
					else
						var_56_19.gameObject:SetActive(false)
					end
				end
			end

			local var_56_20 = 0.001

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_20 then
				local var_56_21 = (arg_53_1.time_ - var_56_17) / var_56_20
				local var_56_22 = Vector3.New(-390, -429, -180)

				var_56_16.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1148, var_56_22, var_56_21)
			end

			if arg_53_1.time_ >= var_56_17 + var_56_20 and arg_53_1.time_ < var_56_17 + var_56_20 + arg_56_0 then
				var_56_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_56_23 = 0
			local var_56_24 = 0.45

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(416062013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 18
				local var_56_29 = utf8.len(var_56_27)
				local var_56_30 = var_56_28 <= 0 and var_56_24 or var_56_24 * (var_56_29 / var_56_28)

				if var_56_30 > 0 and var_56_24 < var_56_30 then
					arg_53_1.talkMaxDuration = var_56_30

					if var_56_30 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_23
					end
				end

				arg_53_1.text_.text = var_56_27
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062013", "story_v_out_416062.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062013", "story_v_out_416062.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_416062", "416062013", "story_v_out_416062.awb")

						arg_53_1:RecordAudio("416062013", var_56_32)
						arg_53_1:RecordAudio("416062013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416062", "416062013", "story_v_out_416062.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416062", "416062013", "story_v_out_416062.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_33 = math.max(var_56_24, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_33 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_33

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_33 and arg_53_1.time_ < var_56_23 + var_56_33 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play416062014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416062014
		arg_57_1.duration_ = 7.07

		local var_57_0 = {
			zh = 4.9,
			ja = 7.066
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
				arg_57_0:Play416062015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.575

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[8].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(416062014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062014", "story_v_out_416062.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062014", "story_v_out_416062.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_416062", "416062014", "story_v_out_416062.awb")

						arg_57_1:RecordAudio("416062014", var_60_9)
						arg_57_1:RecordAudio("416062014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416062", "416062014", "story_v_out_416062.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416062", "416062014", "story_v_out_416062.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416062015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416062015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416062016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1086"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1086 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1086", 7)

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

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1086, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_7 = arg_61_1.actors_["1148"].transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148 = var_64_7.localPosition
				var_64_7.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1148", 7)

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

				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148, var_64_13, var_64_12)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_11 and arg_61_1.time_ < var_64_8 + var_64_11 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_14 = 0
			local var_64_15 = 1.4

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(416062015)
				local var_64_17 = arg_61_1:FormatText(var_64_16.content)

				arg_61_1.text_.text = var_64_17

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_18 = 56
				local var_64_19 = utf8.len(var_64_17)
				local var_64_20 = var_64_18 <= 0 and var_64_15 or var_64_15 * (var_64_19 / var_64_18)

				if var_64_20 > 0 and var_64_15 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20

					if var_64_20 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_17
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_14) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_14 + var_64_21 and arg_61_1.time_ < var_64_14 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play416062016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416062016
		arg_65_1.duration_ = 5.73

		local var_65_0 = {
			zh = 2.933,
			ja = 5.733
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
				arg_65_0:Play416062017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1086"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1086 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1086", 3)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(0, -404.2, -237.9)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1086, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_68_7 = arg_65_1.actors_["1086"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps1086 == nil then
				arg_65_1.var_.actorSpriteComps1086 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.125

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps1086 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps1086 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1086 = nil
			end

			local var_68_15 = 0
			local var_68_16 = 0.35

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[1080].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(416062016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062016", "story_v_out_416062.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062016", "story_v_out_416062.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_416062", "416062016", "story_v_out_416062.awb")

						arg_65_1:RecordAudio("416062016", var_68_24)
						arg_65_1:RecordAudio("416062016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416062", "416062016", "story_v_out_416062.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416062", "416062016", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416062017
		arg_69_1.duration_ = 5.4

		local var_69_0 = {
			zh = 3.9,
			ja = 5.4
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
				arg_69_0:Play416062018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1086"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1086 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1086", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-390, -404.2, -237.9)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1086, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_72_7 = arg_69_1.actors_["1086"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1086 == nil then
				arg_69_1.var_.actorSpriteComps1086 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.125

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1086 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 0.5, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1086 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1086 = nil
			end

			local var_72_15 = arg_69_1.actors_["1148"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1148 == nil then
				arg_69_1.var_.actorSpriteComps1148 = var_72_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_17 = 0.125

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.actorSpriteComps1148 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								local var_72_19 = Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor1.r, var_72_18)
								local var_72_20 = Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor1.g, var_72_18)
								local var_72_21 = Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor1.b, var_72_18)

								iter_72_6.color = Color.New(var_72_19, var_72_20, var_72_21)
							else
								local var_72_22 = Mathf.Lerp(iter_72_6.color.r, 1, var_72_18)

								iter_72_6.color = Color.New(var_72_22, var_72_22, var_72_22)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1148 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_72_8 then
						if arg_69_1.isInRecall_ then
							iter_72_8.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1148 = nil
			end

			local var_72_23 = arg_69_1.actors_["1148"].transform
			local var_72_24 = 0

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.var_.moveOldPos1148 = var_72_23.localPosition
				var_72_23.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1148", 4)

				local var_72_25 = var_72_23.childCount

				for iter_72_9 = 0, var_72_25 - 1 do
					local var_72_26 = var_72_23:GetChild(iter_72_9)

					if var_72_26.name == "split_4" or not string.find(var_72_26.name, "split") then
						var_72_26.gameObject:SetActive(true)
					else
						var_72_26.gameObject:SetActive(false)
					end
				end
			end

			local var_72_27 = 0.001

			if var_72_24 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_27 then
				local var_72_28 = (arg_69_1.time_ - var_72_24) / var_72_27
				local var_72_29 = Vector3.New(390, -429, -180)

				var_72_23.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1148, var_72_29, var_72_28)
			end

			if arg_69_1.time_ >= var_72_24 + var_72_27 and arg_69_1.time_ < var_72_24 + var_72_27 + arg_72_0 then
				var_72_23.localPosition = Vector3.New(390, -429, -180)
			end

			local var_72_30 = 0
			local var_72_31 = 0.425

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[8].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(416062017)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 17
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062017", "story_v_out_416062.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062017", "story_v_out_416062.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_416062", "416062017", "story_v_out_416062.awb")

						arg_69_1:RecordAudio("416062017", var_72_39)
						arg_69_1:RecordAudio("416062017", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416062", "416062017", "story_v_out_416062.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416062", "416062017", "story_v_out_416062.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play416062018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416062018
		arg_73_1.duration_ = 10.63

		local var_73_0 = {
			zh = 5.766,
			ja = 10.633
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
				arg_73_0:Play416062019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1148"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1148 == nil then
				arg_73_1.var_.actorSpriteComps1148 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.125

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1148 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1148 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1148 = nil
			end

			local var_76_8 = arg_73_1.actors_["1086"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1086 == nil then
				arg_73_1.var_.actorSpriteComps1086 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.125

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps1086 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor1.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor1.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor1.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 1, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1086 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1086 = nil
			end

			local var_76_16 = 0
			local var_76_17 = 0.65

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_18 = arg_73_1:FormatText(StoryNameCfg[1080].name)

				arg_73_1.leftNameTxt_.text = var_76_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(416062018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062018", "story_v_out_416062.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062018", "story_v_out_416062.awb") / 1000

					if var_76_24 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_16
					end

					if var_76_19.prefab_name ~= "" and arg_73_1.actors_[var_76_19.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_19.prefab_name].transform, "story_v_out_416062", "416062018", "story_v_out_416062.awb")

						arg_73_1:RecordAudio("416062018", var_76_25)
						arg_73_1:RecordAudio("416062018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416062", "416062018", "story_v_out_416062.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416062", "416062018", "story_v_out_416062.awb")
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
	Play416062019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416062019
		arg_77_1.duration_ = 5.3

		local var_77_0 = {
			zh = 4.533,
			ja = 5.3
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
				arg_77_0:Play416062020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1086"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1086 == nil then
				arg_77_1.var_.actorSpriteComps1086 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.125

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1086 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1086 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1086 = nil
			end

			local var_80_8 = arg_77_1.actors_["1148"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1148 == nil then
				arg_77_1.var_.actorSpriteComps1148 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.125

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps1148 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor1.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor1.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor1.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 1, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1148 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1148 = nil
			end

			local var_80_16 = arg_77_1.actors_["1148"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos1148 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1148", 4)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "split_4" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(390, -429, -180)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1148, var_80_22, var_80_21)
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_80_23 = 0
			local var_80_24 = 0.425

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[8].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(416062019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062019", "story_v_out_416062.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062019", "story_v_out_416062.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_416062", "416062019", "story_v_out_416062.awb")

						arg_77_1:RecordAudio("416062019", var_80_32)
						arg_77_1:RecordAudio("416062019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416062", "416062019", "story_v_out_416062.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416062", "416062019", "story_v_out_416062.awb")
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
				actorName = "1148",
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
	Play416062020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416062020
		arg_81_1.duration_ = 8.6

		local var_81_0 = {
			zh = 6.033,
			ja = 8.6
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
				arg_81_0:Play416062021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1148"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1148 == nil then
				arg_81_1.var_.actorSpriteComps1148 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.125

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1148 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1148 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1148 = nil
			end

			local var_84_8 = arg_81_1.actors_["1086"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1086 == nil then
				arg_81_1.var_.actorSpriteComps1086 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.125

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps1086 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor1.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor1.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor1.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 1, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1086 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1086 = nil
			end

			local var_84_16 = arg_81_1.actors_["1086"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos1086 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1086", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_2" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-390, -404.2, -237.9)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1086, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_84_23 = 0
			local var_84_24 = 0.7

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[1080].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(416062020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062020", "story_v_out_416062.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062020", "story_v_out_416062.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_416062", "416062020", "story_v_out_416062.awb")

						arg_81_1:RecordAudio("416062020", var_84_32)
						arg_81_1:RecordAudio("416062020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416062", "416062020", "story_v_out_416062.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416062", "416062020", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416062021
		arg_85_1.duration_ = 3.37

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play416062022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1086"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1086 == nil then
				arg_85_1.var_.actorSpriteComps1086 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.125

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1086 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1086 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1086 = nil
			end

			local var_88_8 = arg_85_1.actors_["1148"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1148 == nil then
				arg_85_1.var_.actorSpriteComps1148 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.125

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps1148 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 1, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1148 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1148 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.3

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[8].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(416062021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 12
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_17 or var_88_17 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_17 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062021", "story_v_out_416062.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062021", "story_v_out_416062.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_416062", "416062021", "story_v_out_416062.awb")

						arg_85_1:RecordAudio("416062021", var_88_25)
						arg_85_1:RecordAudio("416062021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416062", "416062021", "story_v_out_416062.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416062", "416062021", "story_v_out_416062.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_16) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_16 + var_88_26 and arg_85_1.time_ < var_88_16 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play416062022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416062022
		arg_89_1.duration_ = 6.1

		local var_89_0 = {
			zh = 3.8,
			ja = 6.1
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
				arg_89_0:Play416062023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1148"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1148 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1148", 2)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_4" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(-390, -429, -180)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1148, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_92_7 = arg_89_1.actors_["1148"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1148 == nil then
				arg_89_1.var_.actorSpriteComps1148 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.125

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps1148 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 0.5, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1148 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1148 = nil
			end

			local var_92_15 = "1028"

			if arg_89_1.actors_[var_92_15] == nil then
				local var_92_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_92_16) then
					local var_92_17 = Object.Instantiate(var_92_16, arg_89_1.canvasGo_.transform)

					var_92_17.transform:SetSiblingIndex(1)

					var_92_17.name = var_92_15
					var_92_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_89_1.actors_[var_92_15] = var_92_17

					local var_92_18 = var_92_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_89_1.isInRecall_ then
						for iter_92_5, iter_92_6 in ipairs(var_92_18) do
							iter_92_6.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_92_19 = arg_89_1.actors_["1028"]
			local var_92_20 = 0

			if var_92_20 < arg_89_1.time_ and arg_89_1.time_ <= var_92_20 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.actorSpriteComps1028 == nil then
				arg_89_1.var_.actorSpriteComps1028 = var_92_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_21 = 0.125

			if var_92_20 <= arg_89_1.time_ and arg_89_1.time_ < var_92_20 + var_92_21 and not isNil(var_92_19) then
				local var_92_22 = (arg_89_1.time_ - var_92_20) / var_92_21

				if arg_89_1.var_.actorSpriteComps1028 then
					for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_92_8 then
							if arg_89_1.isInRecall_ then
								local var_92_23 = Mathf.Lerp(iter_92_8.color.r, arg_89_1.hightColor1.r, var_92_22)
								local var_92_24 = Mathf.Lerp(iter_92_8.color.g, arg_89_1.hightColor1.g, var_92_22)
								local var_92_25 = Mathf.Lerp(iter_92_8.color.b, arg_89_1.hightColor1.b, var_92_22)

								iter_92_8.color = Color.New(var_92_23, var_92_24, var_92_25)
							else
								local var_92_26 = Mathf.Lerp(iter_92_8.color.r, 1, var_92_22)

								iter_92_8.color = Color.New(var_92_26, var_92_26, var_92_26)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_20 + var_92_21 and arg_89_1.time_ < var_92_20 + var_92_21 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.actorSpriteComps1028 then
				for iter_92_9, iter_92_10 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_92_10 then
						if arg_89_1.isInRecall_ then
							iter_92_10.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1028 = nil
			end

			local var_92_27 = arg_89_1.actors_["1028"].transform
			local var_92_28 = 0

			if var_92_28 < arg_89_1.time_ and arg_89_1.time_ <= var_92_28 + arg_92_0 then
				arg_89_1.var_.moveOldPos1028 = var_92_27.localPosition
				var_92_27.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1028", 4)

				local var_92_29 = var_92_27.childCount

				for iter_92_11 = 0, var_92_29 - 1 do
					local var_92_30 = var_92_27:GetChild(iter_92_11)

					if var_92_30.name == "" or not string.find(var_92_30.name, "split") then
						var_92_30.gameObject:SetActive(true)
					else
						var_92_30.gameObject:SetActive(false)
					end
				end
			end

			local var_92_31 = 0.001

			if var_92_28 <= arg_89_1.time_ and arg_89_1.time_ < var_92_28 + var_92_31 then
				local var_92_32 = (arg_89_1.time_ - var_92_28) / var_92_31
				local var_92_33 = Vector3.New(390, -402.7, -156.1)

				var_92_27.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1028, var_92_33, var_92_32)
			end

			if arg_89_1.time_ >= var_92_28 + var_92_31 and arg_89_1.time_ < var_92_28 + var_92_31 + arg_92_0 then
				var_92_27.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_92_34 = 0
			local var_92_35 = 0.5

			if var_92_34 < arg_89_1.time_ and arg_89_1.time_ <= var_92_34 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_36 = arg_89_1:FormatText(StoryNameCfg[327].name)

				arg_89_1.leftNameTxt_.text = var_92_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_37 = arg_89_1:GetWordFromCfg(416062022)
				local var_92_38 = arg_89_1:FormatText(var_92_37.content)

				arg_89_1.text_.text = var_92_38

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_39 = 20
				local var_92_40 = utf8.len(var_92_38)
				local var_92_41 = var_92_39 <= 0 and var_92_35 or var_92_35 * (var_92_40 / var_92_39)

				if var_92_41 > 0 and var_92_35 < var_92_41 then
					arg_89_1.talkMaxDuration = var_92_41

					if var_92_41 + var_92_34 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_41 + var_92_34
					end
				end

				arg_89_1.text_.text = var_92_38
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062022", "story_v_out_416062.awb") ~= 0 then
					local var_92_42 = manager.audio:GetVoiceLength("story_v_out_416062", "416062022", "story_v_out_416062.awb") / 1000

					if var_92_42 + var_92_34 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_42 + var_92_34
					end

					if var_92_37.prefab_name ~= "" and arg_89_1.actors_[var_92_37.prefab_name] ~= nil then
						local var_92_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_37.prefab_name].transform, "story_v_out_416062", "416062022", "story_v_out_416062.awb")

						arg_89_1:RecordAudio("416062022", var_92_43)
						arg_89_1:RecordAudio("416062022", var_92_43)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416062", "416062022", "story_v_out_416062.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416062", "416062022", "story_v_out_416062.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_44 = math.max(var_92_35, arg_89_1.talkMaxDuration)

			if var_92_34 <= arg_89_1.time_ and arg_89_1.time_ < var_92_34 + var_92_44 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_34) / var_92_44

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_34 + var_92_44 and arg_89_1.time_ < var_92_34 + var_92_44 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416062023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416062023
		arg_93_1.duration_ = 9.6

		local var_93_0 = {
			zh = 5.033,
			ja = 9.6
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
				arg_93_0:Play416062024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1028"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1028 == nil then
				arg_93_1.var_.actorSpriteComps1028 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.125

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1028 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1028 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1028 = nil
			end

			local var_96_8 = arg_93_1.actors_["1148"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1148 == nil then
				arg_93_1.var_.actorSpriteComps1148 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.125

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps1148 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 1, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1148 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1148 = nil
			end

			local var_96_16 = arg_93_1.actors_["1148"].transform
			local var_96_17 = 0

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = var_96_16.localPosition
				var_96_16.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 2)

				local var_96_18 = var_96_16.childCount

				for iter_96_8 = 0, var_96_18 - 1 do
					local var_96_19 = var_96_16:GetChild(iter_96_8)

					if var_96_19.name == "split_6" or not string.find(var_96_19.name, "split") then
						var_96_19.gameObject:SetActive(true)
					else
						var_96_19.gameObject:SetActive(false)
					end
				end
			end

			local var_96_20 = 0.001

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_20 then
				local var_96_21 = (arg_93_1.time_ - var_96_17) / var_96_20
				local var_96_22 = Vector3.New(-390, -429, -180)

				var_96_16.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, var_96_22, var_96_21)
			end

			if arg_93_1.time_ >= var_96_17 + var_96_20 and arg_93_1.time_ < var_96_17 + var_96_20 + arg_96_0 then
				var_96_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_96_23 = arg_93_1.actors_["1148"].transform
			local var_96_24 = 0

			if var_96_24 < arg_93_1.time_ and arg_93_1.time_ <= var_96_24 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = var_96_23.localPosition
				var_96_23.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 2)

				local var_96_25 = var_96_23.childCount

				for iter_96_9 = 0, var_96_25 - 1 do
					local var_96_26 = var_96_23:GetChild(iter_96_9)

					if var_96_26.name == "split_1_1" or not string.find(var_96_26.name, "split") then
						var_96_26.gameObject:SetActive(true)
					else
						var_96_26.gameObject:SetActive(false)
					end
				end
			end

			local var_96_27 = 0.001

			if var_96_24 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_27 then
				local var_96_28 = (arg_93_1.time_ - var_96_24) / var_96_27
				local var_96_29 = Vector3.New(-390, -429, -180)

				var_96_23.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, var_96_29, var_96_28)
			end

			if arg_93_1.time_ >= var_96_24 + var_96_27 and arg_93_1.time_ < var_96_24 + var_96_27 + arg_96_0 then
				var_96_23.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_96_30 = 0
			local var_96_31 = 0.525

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(416062023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 21
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062023", "story_v_out_416062.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062023", "story_v_out_416062.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_416062", "416062023", "story_v_out_416062.awb")

						arg_93_1:RecordAudio("416062023", var_96_39)
						arg_93_1:RecordAudio("416062023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416062", "416062023", "story_v_out_416062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416062", "416062023", "story_v_out_416062.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
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

		arg_93_1:InitPlayNodeList()
	end,
	Play416062024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416062024
		arg_97_1.duration_ = 4.23

		local var_97_0 = {
			zh = 2.566,
			ja = 4.233
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
				arg_97_0:Play416062025(arg_97_1)
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

			local var_100_8 = arg_97_1.actors_["1028"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps1028 == nil then
				arg_97_1.var_.actorSpriteComps1028 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.125

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps1028 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 1, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps1028 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1028 = nil
			end

			local var_100_16 = 0
			local var_100_17 = 0.325

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_18 = arg_97_1:FormatText(StoryNameCfg[327].name)

				arg_97_1.leftNameTxt_.text = var_100_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_19 = arg_97_1:GetWordFromCfg(416062024)
				local var_100_20 = arg_97_1:FormatText(var_100_19.content)

				arg_97_1.text_.text = var_100_20

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_21 = 13
				local var_100_22 = utf8.len(var_100_20)
				local var_100_23 = var_100_21 <= 0 and var_100_17 or var_100_17 * (var_100_22 / var_100_21)

				if var_100_23 > 0 and var_100_17 < var_100_23 then
					arg_97_1.talkMaxDuration = var_100_23

					if var_100_23 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_16
					end
				end

				arg_97_1.text_.text = var_100_20
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062024", "story_v_out_416062.awb") ~= 0 then
					local var_100_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062024", "story_v_out_416062.awb") / 1000

					if var_100_24 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_24 + var_100_16
					end

					if var_100_19.prefab_name ~= "" and arg_97_1.actors_[var_100_19.prefab_name] ~= nil then
						local var_100_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_19.prefab_name].transform, "story_v_out_416062", "416062024", "story_v_out_416062.awb")

						arg_97_1:RecordAudio("416062024", var_100_25)
						arg_97_1:RecordAudio("416062024", var_100_25)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416062", "416062024", "story_v_out_416062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416062", "416062024", "story_v_out_416062.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_26 = math.max(var_100_17, arg_97_1.talkMaxDuration)

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_26 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_16) / var_100_26

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_16 + var_100_26 and arg_97_1.time_ < var_100_16 + var_100_26 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416062025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416062025
		arg_101_1.duration_ = 7.37

		local var_101_0 = {
			zh = 4.8,
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
				arg_101_0:Play416062026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1028"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1028 == nil then
				arg_101_1.var_.actorSpriteComps1028 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.125

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps1028 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1028 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1028 = nil
			end

			local var_104_8 = arg_101_1.actors_["1148"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1148 == nil then
				arg_101_1.var_.actorSpriteComps1148 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.125

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps1148 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								local var_104_12 = Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor1.r, var_104_11)
								local var_104_13 = Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor1.g, var_104_11)
								local var_104_14 = Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor1.b, var_104_11)

								iter_104_5.color = Color.New(var_104_12, var_104_13, var_104_14)
							else
								local var_104_15 = Mathf.Lerp(iter_104_5.color.r, 1, var_104_11)

								iter_104_5.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1148 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1148 = nil
			end

			local var_104_16 = arg_101_1.actors_["1148"].transform
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148 = var_104_16.localPosition
				var_104_16.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1148", 2)

				local var_104_18 = var_104_16.childCount

				for iter_104_8 = 0, var_104_18 - 1 do
					local var_104_19 = var_104_16:GetChild(iter_104_8)

					if var_104_19.name == "split_4" or not string.find(var_104_19.name, "split") then
						var_104_19.gameObject:SetActive(true)
					else
						var_104_19.gameObject:SetActive(false)
					end
				end
			end

			local var_104_20 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_20 then
				local var_104_21 = (arg_101_1.time_ - var_104_17) / var_104_20
				local var_104_22 = Vector3.New(-390, -429, -180)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148, var_104_22, var_104_21)
			end

			if arg_101_1.time_ >= var_104_17 + var_104_20 and arg_101_1.time_ < var_104_17 + var_104_20 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_104_23 = 0
			local var_104_24 = 0.475

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[8].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(416062025)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 19
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062025", "story_v_out_416062.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062025", "story_v_out_416062.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_416062", "416062025", "story_v_out_416062.awb")

						arg_101_1:RecordAudio("416062025", var_104_32)
						arg_101_1:RecordAudio("416062025", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416062", "416062025", "story_v_out_416062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416062", "416062025", "story_v_out_416062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
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
	Play416062026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416062026
		arg_105_1.duration_ = 6

		local var_105_0 = {
			zh = 4.666,
			ja = 6
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
				arg_105_0:Play416062027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.425

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

				local var_108_3 = arg_105_1:GetWordFromCfg(416062026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062026", "story_v_out_416062.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062026", "story_v_out_416062.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_416062", "416062026", "story_v_out_416062.awb")

						arg_105_1:RecordAudio("416062026", var_108_9)
						arg_105_1:RecordAudio("416062026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416062", "416062026", "story_v_out_416062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416062", "416062026", "story_v_out_416062.awb")
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
	Play416062027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416062027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play416062028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1148"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1148 == nil then
				arg_109_1.var_.actorSpriteComps1148 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.125

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1148 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 0.5, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1148 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1148 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.925

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(416062027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 37
				local var_112_13 = utf8.len(var_112_11)
				local var_112_14 = var_112_12 <= 0 and var_112_9 or var_112_9 * (var_112_13 / var_112_12)

				if var_112_14 > 0 and var_112_9 < var_112_14 then
					arg_109_1.talkMaxDuration = var_112_14

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_15 and arg_109_1.time_ < var_112_8 + var_112_15 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play416062028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416062028
		arg_113_1.duration_ = 4.87

		local var_113_0 = {
			zh = 3.833,
			ja = 4.866
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
				arg_113_0:Play416062029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1028"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1028 == nil then
				arg_113_1.var_.actorSpriteComps1028 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.125

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1028 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 1, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1028 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1028 = nil
			end

			local var_116_8 = arg_113_1.actors_["1028"].transform
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.var_.moveOldPos1028 = var_116_8.localPosition
				var_116_8.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1028", 4)

				local var_116_10 = var_116_8.childCount

				for iter_116_4 = 0, var_116_10 - 1 do
					local var_116_11 = var_116_8:GetChild(iter_116_4)

					if var_116_11.name == "split_6" or not string.find(var_116_11.name, "split") then
						var_116_11.gameObject:SetActive(true)
					else
						var_116_11.gameObject:SetActive(false)
					end
				end
			end

			local var_116_12 = 0.001

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_12 then
				local var_116_13 = (arg_113_1.time_ - var_116_9) / var_116_12
				local var_116_14 = Vector3.New(390, -402.7, -156.1)

				var_116_8.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1028, var_116_14, var_116_13)
			end

			if arg_113_1.time_ >= var_116_9 + var_116_12 and arg_113_1.time_ < var_116_9 + var_116_12 + arg_116_0 then
				var_116_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_116_15 = 0
			local var_116_16 = 0.4

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[327].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(416062028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062028", "story_v_out_416062.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062028", "story_v_out_416062.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_416062", "416062028", "story_v_out_416062.awb")

						arg_113_1:RecordAudio("416062028", var_116_24)
						arg_113_1:RecordAudio("416062028", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416062", "416062028", "story_v_out_416062.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416062", "416062028", "story_v_out_416062.awb")
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
				actorName = "1028",
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
	Play416062029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416062029
		arg_117_1.duration_ = 7.47

		local var_117_0 = {
			zh = 4.066,
			ja = 7.466
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
				arg_117_0:Play416062030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1148"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1148 == nil then
				arg_117_1.var_.actorSpriteComps1148 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.125

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps1148 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1148 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1148 = nil
			end

			local var_120_8 = arg_117_1.actors_["1028"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1028 == nil then
				arg_117_1.var_.actorSpriteComps1028 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 0.125

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps1028 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								local var_120_12 = Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor2.r, var_120_11)
								local var_120_13 = Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor2.g, var_120_11)
								local var_120_14 = Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor2.b, var_120_11)

								iter_120_5.color = Color.New(var_120_12, var_120_13, var_120_14)
							else
								local var_120_15 = Mathf.Lerp(iter_120_5.color.r, 0.5, var_120_11)

								iter_120_5.color = Color.New(var_120_15, var_120_15, var_120_15)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1028 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1028 = nil
			end

			local var_120_16 = arg_117_1.actors_["1148"].transform
			local var_120_17 = 0

			if var_120_17 < arg_117_1.time_ and arg_117_1.time_ <= var_120_17 + arg_120_0 then
				arg_117_1.var_.moveOldPos1148 = var_120_16.localPosition
				var_120_16.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1148", 2)

				local var_120_18 = var_120_16.childCount

				for iter_120_8 = 0, var_120_18 - 1 do
					local var_120_19 = var_120_16:GetChild(iter_120_8)

					if var_120_19.name == "split_6" or not string.find(var_120_19.name, "split") then
						var_120_19.gameObject:SetActive(true)
					else
						var_120_19.gameObject:SetActive(false)
					end
				end
			end

			local var_120_20 = 0.001

			if var_120_17 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_20 then
				local var_120_21 = (arg_117_1.time_ - var_120_17) / var_120_20
				local var_120_22 = Vector3.New(-390, -429, -180)

				var_120_16.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1148, var_120_22, var_120_21)
			end

			if arg_117_1.time_ >= var_120_17 + var_120_20 and arg_117_1.time_ < var_120_17 + var_120_20 + arg_120_0 then
				var_120_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_120_23 = 0
			local var_120_24 = 0.4

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[8].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(416062029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 16
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062029", "story_v_out_416062.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062029", "story_v_out_416062.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_416062", "416062029", "story_v_out_416062.awb")

						arg_117_1:RecordAudio("416062029", var_120_32)
						arg_117_1:RecordAudio("416062029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416062", "416062029", "story_v_out_416062.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416062", "416062029", "story_v_out_416062.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play416062030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416062030
		arg_121_1.duration_ = 3.8

		local var_121_0 = {
			zh = 3.8,
			ja = 3.6
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
				arg_121_0:Play416062031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1148"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1148 == nil then
				arg_121_1.var_.actorSpriteComps1148 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.125

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps1148 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 0.5, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1148 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1148 = nil
			end

			local var_124_8 = arg_121_1.actors_["1028"].transform
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.var_.moveOldPos1028 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1028", 7)

				local var_124_10 = var_124_8.childCount

				for iter_124_4 = 0, var_124_10 - 1 do
					local var_124_11 = var_124_8:GetChild(iter_124_4)

					if var_124_11.name == "" or not string.find(var_124_11.name, "split") then
						var_124_11.gameObject:SetActive(true)
					else
						var_124_11.gameObject:SetActive(false)
					end
				end
			end

			local var_124_12 = 0.001

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_12 then
				local var_124_13 = (arg_121_1.time_ - var_124_9) / var_124_12
				local var_124_14 = Vector3.New(0, -2000, 0)

				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1028, var_124_14, var_124_13)
			end

			if arg_121_1.time_ >= var_124_9 + var_124_12 and arg_121_1.time_ < var_124_9 + var_124_12 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_15 = arg_121_1.actors_["1086"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos1086 = var_124_15.localPosition
				var_124_15.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1086", 4)

				local var_124_17 = var_124_15.childCount

				for iter_124_5 = 0, var_124_17 - 1 do
					local var_124_18 = var_124_15:GetChild(iter_124_5)

					if var_124_18.name == "split_4" or not string.find(var_124_18.name, "split") then
						var_124_18.gameObject:SetActive(true)
					else
						var_124_18.gameObject:SetActive(false)
					end
				end
			end

			local var_124_19 = 0.001

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_19 then
				local var_124_20 = (arg_121_1.time_ - var_124_16) / var_124_19
				local var_124_21 = Vector3.New(390, -404.2, -237.9)

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1086, var_124_21, var_124_20)
			end

			if arg_121_1.time_ >= var_124_16 + var_124_19 and arg_121_1.time_ < var_124_16 + var_124_19 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_124_22 = arg_121_1.actors_["1086"]
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.actorSpriteComps1086 == nil then
				arg_121_1.var_.actorSpriteComps1086 = var_124_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_24 = 0.125

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 and not isNil(var_124_22) then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24

				if arg_121_1.var_.actorSpriteComps1086 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_124_7 then
							if arg_121_1.isInRecall_ then
								local var_124_26 = Mathf.Lerp(iter_124_7.color.r, arg_121_1.hightColor1.r, var_124_25)
								local var_124_27 = Mathf.Lerp(iter_124_7.color.g, arg_121_1.hightColor1.g, var_124_25)
								local var_124_28 = Mathf.Lerp(iter_124_7.color.b, arg_121_1.hightColor1.b, var_124_25)

								iter_124_7.color = Color.New(var_124_26, var_124_27, var_124_28)
							else
								local var_124_29 = Mathf.Lerp(iter_124_7.color.r, 1, var_124_25)

								iter_124_7.color = Color.New(var_124_29, var_124_29, var_124_29)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.actorSpriteComps1086 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_124_9 then
						if arg_121_1.isInRecall_ then
							iter_124_9.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1086 = nil
			end

			local var_124_30 = 0
			local var_124_31 = 0.375

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[1080].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(416062030)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062030", "story_v_out_416062.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062030", "story_v_out_416062.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_416062", "416062030", "story_v_out_416062.awb")

						arg_121_1:RecordAudio("416062030", var_124_39)
						arg_121_1:RecordAudio("416062030", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416062", "416062030", "story_v_out_416062.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416062", "416062030", "story_v_out_416062.awb")
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416062031
		arg_125_1.duration_ = 7.53

		local var_125_0 = {
			zh = 5,
			ja = 7.533
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
				arg_125_0:Play416062032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1086"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1086 == nil then
				arg_125_1.var_.actorSpriteComps1086 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.125

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps1086 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1086 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1086 = nil
			end

			local var_128_8 = arg_125_1.actors_["1148"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1148 == nil then
				arg_125_1.var_.actorSpriteComps1148 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.125

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps1148 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor1.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor1.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor1.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 1, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1148 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1148 = nil
			end

			local var_128_16 = arg_125_1.actors_["1148"].transform
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.var_.moveOldPos1148 = var_128_16.localPosition
				var_128_16.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1148", 2)

				local var_128_18 = var_128_16.childCount

				for iter_128_8 = 0, var_128_18 - 1 do
					local var_128_19 = var_128_16:GetChild(iter_128_8)

					if var_128_19.name == "split_3" or not string.find(var_128_19.name, "split") then
						var_128_19.gameObject:SetActive(true)
					else
						var_128_19.gameObject:SetActive(false)
					end
				end
			end

			local var_128_20 = 0.001

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_17) / var_128_20
				local var_128_22 = Vector3.New(-390, -429, -180)

				var_128_16.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1148, var_128_22, var_128_21)
			end

			if arg_125_1.time_ >= var_128_17 + var_128_20 and arg_125_1.time_ < var_128_17 + var_128_20 + arg_128_0 then
				var_128_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_128_23 = 0
			local var_128_24 = 0.575

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_25 = arg_125_1:FormatText(StoryNameCfg[8].name)

				arg_125_1.leftNameTxt_.text = var_128_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_26 = arg_125_1:GetWordFromCfg(416062031)
				local var_128_27 = arg_125_1:FormatText(var_128_26.content)

				arg_125_1.text_.text = var_128_27

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_28 = 23
				local var_128_29 = utf8.len(var_128_27)
				local var_128_30 = var_128_28 <= 0 and var_128_24 or var_128_24 * (var_128_29 / var_128_28)

				if var_128_30 > 0 and var_128_24 < var_128_30 then
					arg_125_1.talkMaxDuration = var_128_30

					if var_128_30 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_23
					end
				end

				arg_125_1.text_.text = var_128_27
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062031", "story_v_out_416062.awb") ~= 0 then
					local var_128_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062031", "story_v_out_416062.awb") / 1000

					if var_128_31 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_23
					end

					if var_128_26.prefab_name ~= "" and arg_125_1.actors_[var_128_26.prefab_name] ~= nil then
						local var_128_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_26.prefab_name].transform, "story_v_out_416062", "416062031", "story_v_out_416062.awb")

						arg_125_1:RecordAudio("416062031", var_128_32)
						arg_125_1:RecordAudio("416062031", var_128_32)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416062", "416062031", "story_v_out_416062.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416062", "416062031", "story_v_out_416062.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_33 = math.max(var_128_24, arg_125_1.talkMaxDuration)

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_33 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_33

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_33 and arg_125_1.time_ < var_128_23 + var_128_33 + arg_128_0 then
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
	Play416062032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416062032
		arg_129_1.duration_ = 9

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416062033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 4

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_1 = 0.5

			if arg_129_1.time_ >= var_132_0 + var_132_1 and arg_129_1.time_ < var_132_0 + var_132_1 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_2 = "I13h"

			if arg_129_1.bgs_[var_132_2] == nil then
				local var_132_3 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_2)
				var_132_3.name = var_132_2
				var_132_3.transform.parent = arg_129_1.stage_.transform
				var_132_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_2] = var_132_3
			end

			local var_132_4 = 2

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				local var_132_5 = manager.ui.mainCamera.transform.localPosition
				local var_132_6 = Vector3.New(0, 0, 10) + Vector3.New(var_132_5.x, var_132_5.y, 0)
				local var_132_7 = arg_129_1.bgs_.I13h

				var_132_7.transform.localPosition = var_132_6
				var_132_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_8 = var_132_7:GetComponent("SpriteRenderer")

				if var_132_8 and var_132_8.sprite then
					local var_132_9 = (var_132_7.transform.localPosition - var_132_5).z
					local var_132_10 = manager.ui.mainCameraCom_
					local var_132_11 = 2 * var_132_9 * Mathf.Tan(var_132_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_132_12 = var_132_11 * var_132_10.aspect
					local var_132_13 = var_132_8.sprite.bounds.size.x
					local var_132_14 = var_132_8.sprite.bounds.size.y
					local var_132_15 = var_132_12 / var_132_13
					local var_132_16 = var_132_11 / var_132_14
					local var_132_17 = var_132_16 < var_132_15 and var_132_15 or var_132_16

					var_132_7.transform.localScale = Vector3.New(var_132_17, var_132_17, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "I13h" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_18 = 0

			if var_132_18 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_19 = 2

			if var_132_18 <= arg_129_1.time_ and arg_129_1.time_ < var_132_18 + var_132_19 then
				local var_132_20 = (arg_129_1.time_ - var_132_18) / var_132_19
				local var_132_21 = Color.New(0, 0, 0)

				var_132_21.a = Mathf.Lerp(0, 1, var_132_20)
				arg_129_1.mask_.color = var_132_21
			end

			if arg_129_1.time_ >= var_132_18 + var_132_19 and arg_129_1.time_ < var_132_18 + var_132_19 + arg_132_0 then
				local var_132_22 = Color.New(0, 0, 0)

				var_132_22.a = 1
				arg_129_1.mask_.color = var_132_22
			end

			local var_132_23 = 2

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_24 = 2

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_24 then
				local var_132_25 = (arg_129_1.time_ - var_132_23) / var_132_24
				local var_132_26 = Color.New(0, 0, 0)

				var_132_26.a = Mathf.Lerp(1, 0, var_132_25)
				arg_129_1.mask_.color = var_132_26
			end

			if arg_129_1.time_ >= var_132_23 + var_132_24 and arg_129_1.time_ < var_132_23 + var_132_24 + arg_132_0 then
				local var_132_27 = Color.New(0, 0, 0)
				local var_132_28 = 0

				arg_129_1.mask_.enabled = false
				var_132_27.a = var_132_28
				arg_129_1.mask_.color = var_132_27
			end

			local var_132_29 = arg_129_1.actors_["1148"].transform
			local var_132_30 = 1.966

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148 = var_132_29.localPosition
				var_132_29.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1148", 7)

				local var_132_31 = var_132_29.childCount

				for iter_132_2 = 0, var_132_31 - 1 do
					local var_132_32 = var_132_29:GetChild(iter_132_2)

					if var_132_32.name == "" or not string.find(var_132_32.name, "split") then
						var_132_32.gameObject:SetActive(true)
					else
						var_132_32.gameObject:SetActive(false)
					end
				end
			end

			local var_132_33 = 0.001

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_33 then
				local var_132_34 = (arg_129_1.time_ - var_132_30) / var_132_33
				local var_132_35 = Vector3.New(0, -2000, 0)

				var_132_29.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148, var_132_35, var_132_34)
			end

			if arg_129_1.time_ >= var_132_30 + var_132_33 and arg_129_1.time_ < var_132_30 + var_132_33 + arg_132_0 then
				var_132_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_36 = arg_129_1.actors_["1086"].transform
			local var_132_37 = 1.966

			if var_132_37 < arg_129_1.time_ and arg_129_1.time_ <= var_132_37 + arg_132_0 then
				arg_129_1.var_.moveOldPos1086 = var_132_36.localPosition
				var_132_36.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1086", 7)

				local var_132_38 = var_132_36.childCount

				for iter_132_3 = 0, var_132_38 - 1 do
					local var_132_39 = var_132_36:GetChild(iter_132_3)

					if var_132_39.name == "" or not string.find(var_132_39.name, "split") then
						var_132_39.gameObject:SetActive(true)
					else
						var_132_39.gameObject:SetActive(false)
					end
				end
			end

			local var_132_40 = 0.001

			if var_132_37 <= arg_129_1.time_ and arg_129_1.time_ < var_132_37 + var_132_40 then
				local var_132_41 = (arg_129_1.time_ - var_132_37) / var_132_40
				local var_132_42 = Vector3.New(0, -2000, 0)

				var_132_36.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1086, var_132_42, var_132_41)
			end

			if arg_129_1.time_ >= var_132_37 + var_132_40 and arg_129_1.time_ < var_132_37 + var_132_40 + arg_132_0 then
				var_132_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_43 = manager.ui.mainCamera.transform
			local var_132_44 = 2.57664596547062

			if var_132_44 < arg_129_1.time_ and arg_129_1.time_ <= var_132_44 + arg_132_0 then
				local var_132_45 = arg_129_1.var_.effect2032
				local var_132_46
				local var_132_47 = var_132_43

				if not var_132_45 then
					var_132_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_132_47)
					var_132_45.name = "2032"
					arg_129_1.var_.effect2032 = var_132_45
				else
					var_132_45.transform:SetParent(var_132_47)
				end

				var_132_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_132_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_132_48 = manager.ui.mainCamera.transform
			local var_132_49 = 2.57664596547062

			if var_132_49 < arg_129_1.time_ and arg_129_1.time_ <= var_132_49 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = var_132_48.localPosition
			end

			local var_132_50 = 0.666666666666667

			if var_132_49 <= arg_129_1.time_ and arg_129_1.time_ < var_132_49 + var_132_50 then
				local var_132_51 = (arg_129_1.time_ - var_132_49) / 0.066
				local var_132_52, var_132_53 = math.modf(var_132_51)

				var_132_48.localPosition = Vector3.New(var_132_53 * 0.13, var_132_53 * 0.13, var_132_53 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= var_132_49 + var_132_50 and arg_129_1.time_ < var_132_49 + var_132_50 + arg_132_0 then
				var_132_48.localPosition = arg_129_1.var_.shakeOldPos
			end

			local var_132_54 = 0
			local var_132_55 = 0.2

			if var_132_54 < arg_129_1.time_ and arg_129_1.time_ <= var_132_54 + arg_132_0 then
				local var_132_56 = "play"
				local var_132_57 = "music"

				arg_129_1:AudioAction(var_132_56, var_132_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_132_58 = ""
				local var_132_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_132_59 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_59 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_59

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_59
						arg_129_1.bgmTxt2_.text = var_132_59
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_60 = 1.33333333333333
			local var_132_61 = 1

			if var_132_60 < arg_129_1.time_ and arg_129_1.time_ <= var_132_60 + arg_132_0 then
				local var_132_62 = "play"
				local var_132_63 = "music"

				arg_129_1:AudioAction(var_132_62, var_132_63, "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_132_64 = ""
				local var_132_65 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if var_132_65 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_65 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_65

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_65
						arg_129_1.bgmTxt2_.text = var_132_65
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_66 = 2
			local var_132_67 = 1

			if var_132_66 < arg_129_1.time_ and arg_129_1.time_ <= var_132_66 + arg_132_0 then
				local var_132_68 = "play"
				local var_132_69 = "effect"

				arg_129_1:AudioAction(var_132_68, var_132_69, "se_story_138", "se_story_138_thunderhit", "")
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_70 = 4
			local var_132_71 = 1.575

			if var_132_70 < arg_129_1.time_ and arg_129_1.time_ <= var_132_70 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_72 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_72:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_129_1.dialogCg_.alpha = arg_135_0
				end))
				var_132_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_73 = arg_129_1:GetWordFromCfg(416062032)
				local var_132_74 = arg_129_1:FormatText(var_132_73.content)

				arg_129_1.text_.text = var_132_74

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_75 = 63
				local var_132_76 = utf8.len(var_132_74)
				local var_132_77 = var_132_75 <= 0 and var_132_71 or var_132_71 * (var_132_76 / var_132_75)

				if var_132_77 > 0 and var_132_71 < var_132_77 then
					arg_129_1.talkMaxDuration = var_132_77
					var_132_70 = var_132_70 + 0.3

					if var_132_77 + var_132_70 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_77 + var_132_70
					end
				end

				arg_129_1.text_.text = var_132_74
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_78 = var_132_70 + 0.3
			local var_132_79 = math.max(var_132_71, arg_129_1.talkMaxDuration)

			if var_132_78 <= arg_129_1.time_ and arg_129_1.time_ < var_132_78 + var_132_79 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_78) / var_132_79

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_78 + var_132_79 and arg_129_1.time_ < var_132_78 + var_132_79 + arg_132_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play416062033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416062033
		arg_137_1.duration_ = 5.57

		local var_137_0 = {
			zh = 5.3,
			ja = 5.566
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
				arg_137_0:Play416062034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1028"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1028 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1028", 3)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_2" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -402.7, -156.1)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1028, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_140_7 = arg_137_1.actors_["1028"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps1028 == nil then
				arg_137_1.var_.actorSpriteComps1028 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 0.125

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps1028 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps1028 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1028 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 0.525

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[327].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(416062033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062033", "story_v_out_416062.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062033", "story_v_out_416062.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_416062", "416062033", "story_v_out_416062.awb")

						arg_137_1:RecordAudio("416062033", var_140_24)
						arg_137_1:RecordAudio("416062033", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416062", "416062033", "story_v_out_416062.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416062", "416062033", "story_v_out_416062.awb")
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
				actorName = "1028",
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
	Play416062034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416062034
		arg_141_1.duration_ = 6.77

		local var_141_0 = {
			zh = 6.766,
			ja = 6.066
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
				arg_141_0:Play416062035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1028"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1028 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1028", 2)

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
				local var_144_6 = Vector3.New(-390, -402.7, -156.1)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1028, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_144_7 = arg_141_1.actors_["1028"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1028 == nil then
				arg_141_1.var_.actorSpriteComps1028 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.125

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps1028 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor2.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor2.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor2.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 0.5, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1028 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1028 = nil
			end

			local var_144_15 = arg_141_1.actors_["1086"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos1086 = var_144_15.localPosition
				var_144_15.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1086", 4)

				local var_144_17 = var_144_15.childCount

				for iter_144_5 = 0, var_144_17 - 1 do
					local var_144_18 = var_144_15:GetChild(iter_144_5)

					if var_144_18.name == "" or not string.find(var_144_18.name, "split") then
						var_144_18.gameObject:SetActive(true)
					else
						var_144_18.gameObject:SetActive(false)
					end
				end
			end

			local var_144_19 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_19 then
				local var_144_20 = (arg_141_1.time_ - var_144_16) / var_144_19
				local var_144_21 = Vector3.New(390, -404.2, -237.9)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1086, var_144_21, var_144_20)
			end

			if arg_141_1.time_ >= var_144_16 + var_144_19 and arg_141_1.time_ < var_144_16 + var_144_19 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_144_22 = arg_141_1.actors_["1086"]
			local var_144_23 = 0

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.actorSpriteComps1086 == nil then
				arg_141_1.var_.actorSpriteComps1086 = var_144_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_24 = 0.125

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_24 and not isNil(var_144_22) then
				local var_144_25 = (arg_141_1.time_ - var_144_23) / var_144_24

				if arg_141_1.var_.actorSpriteComps1086 then
					for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_144_7 then
							if arg_141_1.isInRecall_ then
								local var_144_26 = Mathf.Lerp(iter_144_7.color.r, arg_141_1.hightColor1.r, var_144_25)
								local var_144_27 = Mathf.Lerp(iter_144_7.color.g, arg_141_1.hightColor1.g, var_144_25)
								local var_144_28 = Mathf.Lerp(iter_144_7.color.b, arg_141_1.hightColor1.b, var_144_25)

								iter_144_7.color = Color.New(var_144_26, var_144_27, var_144_28)
							else
								local var_144_29 = Mathf.Lerp(iter_144_7.color.r, 1, var_144_25)

								iter_144_7.color = Color.New(var_144_29, var_144_29, var_144_29)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_23 + var_144_24 and arg_141_1.time_ < var_144_23 + var_144_24 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.actorSpriteComps1086 then
				for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_144_9 then
						if arg_141_1.isInRecall_ then
							iter_144_9.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1086 = nil
			end

			local var_144_30 = 0
			local var_144_31 = 0.475

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_32 = arg_141_1:FormatText(StoryNameCfg[1080].name)

				arg_141_1.leftNameTxt_.text = var_144_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_33 = arg_141_1:GetWordFromCfg(416062034)
				local var_144_34 = arg_141_1:FormatText(var_144_33.content)

				arg_141_1.text_.text = var_144_34

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_35 = 19
				local var_144_36 = utf8.len(var_144_34)
				local var_144_37 = var_144_35 <= 0 and var_144_31 or var_144_31 * (var_144_36 / var_144_35)

				if var_144_37 > 0 and var_144_31 < var_144_37 then
					arg_141_1.talkMaxDuration = var_144_37

					if var_144_37 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_37 + var_144_30
					end
				end

				arg_141_1.text_.text = var_144_34
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062034", "story_v_out_416062.awb") ~= 0 then
					local var_144_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062034", "story_v_out_416062.awb") / 1000

					if var_144_38 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_30
					end

					if var_144_33.prefab_name ~= "" and arg_141_1.actors_[var_144_33.prefab_name] ~= nil then
						local var_144_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_33.prefab_name].transform, "story_v_out_416062", "416062034", "story_v_out_416062.awb")

						arg_141_1:RecordAudio("416062034", var_144_39)
						arg_141_1:RecordAudio("416062034", var_144_39)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416062", "416062034", "story_v_out_416062.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416062", "416062034", "story_v_out_416062.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_40 = math.max(var_144_31, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_40 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_40

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_40 and arg_141_1.time_ < var_144_30 + var_144_40 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416062035
		arg_145_1.duration_ = 7.8

		local var_145_0 = {
			zh = 4.933,
			ja = 7.8
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
				arg_145_0:Play416062036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1086"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1086 == nil then
				arg_145_1.var_.actorSpriteComps1086 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.125

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1086 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 0.5, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1086 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1086 = nil
			end

			local var_148_8 = arg_145_1.actors_["1028"]
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps1028 == nil then
				arg_145_1.var_.actorSpriteComps1028 = var_148_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_10 = 0.125

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 and not isNil(var_148_8) then
				local var_148_11 = (arg_145_1.time_ - var_148_9) / var_148_10

				if arg_145_1.var_.actorSpriteComps1028 then
					for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_148_5 then
							if arg_145_1.isInRecall_ then
								local var_148_12 = Mathf.Lerp(iter_148_5.color.r, arg_145_1.hightColor1.r, var_148_11)
								local var_148_13 = Mathf.Lerp(iter_148_5.color.g, arg_145_1.hightColor1.g, var_148_11)
								local var_148_14 = Mathf.Lerp(iter_148_5.color.b, arg_145_1.hightColor1.b, var_148_11)

								iter_148_5.color = Color.New(var_148_12, var_148_13, var_148_14)
							else
								local var_148_15 = Mathf.Lerp(iter_148_5.color.r, 1, var_148_11)

								iter_148_5.color = Color.New(var_148_15, var_148_15, var_148_15)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps1028 then
				for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_148_7 then
						if arg_145_1.isInRecall_ then
							iter_148_7.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1028 = nil
			end

			local var_148_16 = 0
			local var_148_17 = 0.5

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_18 = arg_145_1:FormatText(StoryNameCfg[327].name)

				arg_145_1.leftNameTxt_.text = var_148_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_19 = arg_145_1:GetWordFromCfg(416062035)
				local var_148_20 = arg_145_1:FormatText(var_148_19.content)

				arg_145_1.text_.text = var_148_20

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_21 = 20
				local var_148_22 = utf8.len(var_148_20)
				local var_148_23 = var_148_21 <= 0 and var_148_17 or var_148_17 * (var_148_22 / var_148_21)

				if var_148_23 > 0 and var_148_17 < var_148_23 then
					arg_145_1.talkMaxDuration = var_148_23

					if var_148_23 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_16
					end
				end

				arg_145_1.text_.text = var_148_20
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062035", "story_v_out_416062.awb") ~= 0 then
					local var_148_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062035", "story_v_out_416062.awb") / 1000

					if var_148_24 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_16
					end

					if var_148_19.prefab_name ~= "" and arg_145_1.actors_[var_148_19.prefab_name] ~= nil then
						local var_148_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_19.prefab_name].transform, "story_v_out_416062", "416062035", "story_v_out_416062.awb")

						arg_145_1:RecordAudio("416062035", var_148_25)
						arg_145_1:RecordAudio("416062035", var_148_25)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416062", "416062035", "story_v_out_416062.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416062", "416062035", "story_v_out_416062.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_26 = math.max(var_148_17, arg_145_1.talkMaxDuration)

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_16) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_16 + var_148_26 and arg_145_1.time_ < var_148_16 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416062036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416062036
		arg_149_1.duration_ = 4.57

		local var_149_0 = {
			zh = 3.5,
			ja = 4.566
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
				arg_149_0:Play416062037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1028"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1028 == nil then
				arg_149_1.var_.actorSpriteComps1028 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.125

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1028 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1028 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1028 = nil
			end

			local var_152_8 = arg_149_1.actors_["1086"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps1086 == nil then
				arg_149_1.var_.actorSpriteComps1086 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_10 = 0.125

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 and not isNil(var_152_8) then
				local var_152_11 = (arg_149_1.time_ - var_152_9) / var_152_10

				if arg_149_1.var_.actorSpriteComps1086 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								local var_152_12 = Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor1.r, var_152_11)
								local var_152_13 = Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor1.g, var_152_11)
								local var_152_14 = Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor1.b, var_152_11)

								iter_152_5.color = Color.New(var_152_12, var_152_13, var_152_14)
							else
								local var_152_15 = Mathf.Lerp(iter_152_5.color.r, 1, var_152_11)

								iter_152_5.color = Color.New(var_152_15, var_152_15, var_152_15)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps1086 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_152_7 then
						if arg_149_1.isInRecall_ then
							iter_152_7.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1086 = nil
			end

			local var_152_16 = 0
			local var_152_17 = 0.375

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_18 = arg_149_1:FormatText(StoryNameCfg[1080].name)

				arg_149_1.leftNameTxt_.text = var_152_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(416062036)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 15
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_17 or var_152_17 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_17 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_16
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062036", "story_v_out_416062.awb") ~= 0 then
					local var_152_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062036", "story_v_out_416062.awb") / 1000

					if var_152_24 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_16
					end

					if var_152_19.prefab_name ~= "" and arg_149_1.actors_[var_152_19.prefab_name] ~= nil then
						local var_152_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_19.prefab_name].transform, "story_v_out_416062", "416062036", "story_v_out_416062.awb")

						arg_149_1:RecordAudio("416062036", var_152_25)
						arg_149_1:RecordAudio("416062036", var_152_25)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416062", "416062036", "story_v_out_416062.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416062", "416062036", "story_v_out_416062.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_26 = math.max(var_152_17, arg_149_1.talkMaxDuration)

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_26 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_16) / var_152_26

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_16 + var_152_26 and arg_149_1.time_ < var_152_16 + var_152_26 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416062037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416062037
		arg_153_1.duration_ = 8.2

		local var_153_0 = {
			zh = 4.433,
			ja = 8.2
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
				arg_153_0:Play416062038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1086"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1086 == nil then
				arg_153_1.var_.actorSpriteComps1086 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.125

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1086 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 0.5, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1086 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1086 = nil
			end

			local var_156_8 = arg_153_1.actors_["1028"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1028 == nil then
				arg_153_1.var_.actorSpriteComps1028 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.125

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps1028 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor1.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor1.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor1.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 1, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1028 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1028 = nil
			end

			local var_156_16 = 0
			local var_156_17 = 0.5

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[327].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(416062037)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 20
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062037", "story_v_out_416062.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062037", "story_v_out_416062.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_416062", "416062037", "story_v_out_416062.awb")

						arg_153_1:RecordAudio("416062037", var_156_25)
						arg_153_1:RecordAudio("416062037", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416062", "416062037", "story_v_out_416062.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416062", "416062037", "story_v_out_416062.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416062038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416062038
		arg_157_1.duration_ = 5

		local var_157_0 = {
			zh = 2.766,
			ja = 5
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
				arg_157_0:Play416062039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1086"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1086 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1086", 7)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(0, -2000, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1086, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_7 = arg_157_1.actors_["1148"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1148 == nil then
				arg_157_1.var_.actorSpriteComps1148 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.125

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps1148 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 1, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1148 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1148 = nil
			end

			local var_160_15 = arg_157_1.actors_["1148"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos1148 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1148", 4)

				local var_160_17 = var_160_15.childCount

				for iter_160_5 = 0, var_160_17 - 1 do
					local var_160_18 = var_160_15:GetChild(iter_160_5)

					if var_160_18.name == "split_2" or not string.find(var_160_18.name, "split") then
						var_160_18.gameObject:SetActive(true)
					else
						var_160_18.gameObject:SetActive(false)
					end
				end
			end

			local var_160_19 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_19 then
				local var_160_20 = (arg_157_1.time_ - var_160_16) / var_160_19
				local var_160_21 = Vector3.New(390, -429, -180)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1148, var_160_21, var_160_20)
			end

			if arg_157_1.time_ >= var_160_16 + var_160_19 and arg_157_1.time_ < var_160_16 + var_160_19 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(390, -429, -180)
			end

			local var_160_22 = arg_157_1.actors_["1028"]
			local var_160_23 = 0

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps1028 == nil then
				arg_157_1.var_.actorSpriteComps1028 = var_160_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_24 = 0.125

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 and not isNil(var_160_22) then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24

				if arg_157_1.var_.actorSpriteComps1028 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								local var_160_26 = Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, var_160_25)
								local var_160_27 = Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, var_160_25)
								local var_160_28 = Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, var_160_25)

								iter_160_7.color = Color.New(var_160_26, var_160_27, var_160_28)
							else
								local var_160_29 = Mathf.Lerp(iter_160_7.color.r, 0.5, var_160_25)

								iter_160_7.color = Color.New(var_160_29, var_160_29, var_160_29)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps1028 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_160_9 then
						if arg_157_1.isInRecall_ then
							iter_160_9.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1028 = nil
			end

			local var_160_30 = 0
			local var_160_31 = 0.275

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_32 = arg_157_1:FormatText(StoryNameCfg[8].name)

				arg_157_1.leftNameTxt_.text = var_160_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(416062038)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_35 = 11
				local var_160_36 = utf8.len(var_160_34)
				local var_160_37 = var_160_35 <= 0 and var_160_31 or var_160_31 * (var_160_36 / var_160_35)

				if var_160_37 > 0 and var_160_31 < var_160_37 then
					arg_157_1.talkMaxDuration = var_160_37

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062038", "story_v_out_416062.awb") ~= 0 then
					local var_160_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062038", "story_v_out_416062.awb") / 1000

					if var_160_38 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_416062", "416062038", "story_v_out_416062.awb")

						arg_157_1:RecordAudio("416062038", var_160_39)
						arg_157_1:RecordAudio("416062038", var_160_39)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416062", "416062038", "story_v_out_416062.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416062", "416062038", "story_v_out_416062.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_40 and arg_157_1.time_ < var_160_30 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_157_1:InitPlayNodeList()
	end,
	Play416062039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416062039
		arg_161_1.duration_ = 7.23

		local var_161_0 = {
			zh = 4.366,
			ja = 7.233
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
				arg_161_0:Play416062040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1028"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1028 == nil then
				arg_161_1.var_.actorSpriteComps1028 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.125

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1028 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1028 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1028 = nil
			end

			local var_164_8 = arg_161_1.actors_["1148"]
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1148 == nil then
				arg_161_1.var_.actorSpriteComps1148 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_10 = 0.125

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 and not isNil(var_164_8) then
				local var_164_11 = (arg_161_1.time_ - var_164_9) / var_164_10

				if arg_161_1.var_.actorSpriteComps1148 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								local var_164_12 = Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor2.r, var_164_11)
								local var_164_13 = Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor2.g, var_164_11)
								local var_164_14 = Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor2.b, var_164_11)

								iter_164_5.color = Color.New(var_164_12, var_164_13, var_164_14)
							else
								local var_164_15 = Mathf.Lerp(iter_164_5.color.r, 0.5, var_164_11)

								iter_164_5.color = Color.New(var_164_15, var_164_15, var_164_15)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1148 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_164_7 then
						if arg_161_1.isInRecall_ then
							iter_164_7.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1148 = nil
			end

			local var_164_16 = arg_161_1.actors_["1148"].transform
			local var_164_17 = 0

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.var_.moveOldPos1148 = var_164_16.localPosition
				var_164_16.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1148", 4)

				local var_164_18 = var_164_16.childCount

				for iter_164_8 = 0, var_164_18 - 1 do
					local var_164_19 = var_164_16:GetChild(iter_164_8)

					if var_164_19.name == "split_2" or not string.find(var_164_19.name, "split") then
						var_164_19.gameObject:SetActive(true)
					else
						var_164_19.gameObject:SetActive(false)
					end
				end
			end

			local var_164_20 = 0.001

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_20 then
				local var_164_21 = (arg_161_1.time_ - var_164_17) / var_164_20
				local var_164_22 = Vector3.New(390, -429, -180)

				var_164_16.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1148, var_164_22, var_164_21)
			end

			if arg_161_1.time_ >= var_164_17 + var_164_20 and arg_161_1.time_ < var_164_17 + var_164_20 + arg_164_0 then
				var_164_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_164_23 = arg_161_1.actors_["1028"].transform
			local var_164_24 = 0

			if var_164_24 < arg_161_1.time_ and arg_161_1.time_ <= var_164_24 + arg_164_0 then
				arg_161_1.var_.moveOldPos1028 = var_164_23.localPosition
				var_164_23.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1028", 2)

				local var_164_25 = var_164_23.childCount

				for iter_164_9 = 0, var_164_25 - 1 do
					local var_164_26 = var_164_23:GetChild(iter_164_9)

					if var_164_26.name == "split_6" or not string.find(var_164_26.name, "split") then
						var_164_26.gameObject:SetActive(true)
					else
						var_164_26.gameObject:SetActive(false)
					end
				end
			end

			local var_164_27 = 0.001

			if var_164_24 <= arg_161_1.time_ and arg_161_1.time_ < var_164_24 + var_164_27 then
				local var_164_28 = (arg_161_1.time_ - var_164_24) / var_164_27
				local var_164_29 = Vector3.New(-390, -402.7, -156.1)

				var_164_23.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1028, var_164_29, var_164_28)
			end

			if arg_161_1.time_ >= var_164_24 + var_164_27 and arg_161_1.time_ < var_164_24 + var_164_27 + arg_164_0 then
				var_164_23.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_164_30 = 0
			local var_164_31 = 0.45

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[327].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_33 = arg_161_1:GetWordFromCfg(416062039)
				local var_164_34 = arg_161_1:FormatText(var_164_33.content)

				arg_161_1.text_.text = var_164_34

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_35 = 18
				local var_164_36 = utf8.len(var_164_34)
				local var_164_37 = var_164_35 <= 0 and var_164_31 or var_164_31 * (var_164_36 / var_164_35)

				if var_164_37 > 0 and var_164_31 < var_164_37 then
					arg_161_1.talkMaxDuration = var_164_37

					if var_164_37 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_34
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062039", "story_v_out_416062.awb") ~= 0 then
					local var_164_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062039", "story_v_out_416062.awb") / 1000

					if var_164_38 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_38 + var_164_30
					end

					if var_164_33.prefab_name ~= "" and arg_161_1.actors_[var_164_33.prefab_name] ~= nil then
						local var_164_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_33.prefab_name].transform, "story_v_out_416062", "416062039", "story_v_out_416062.awb")

						arg_161_1:RecordAudio("416062039", var_164_39)
						arg_161_1:RecordAudio("416062039", var_164_39)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416062", "416062039", "story_v_out_416062.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416062", "416062039", "story_v_out_416062.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_40 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_40 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_40

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_40 and arg_161_1.time_ < var_164_30 + var_164_40 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play416062040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416062040
		arg_165_1.duration_ = 4.17

		local var_165_0 = {
			zh = 3,
			ja = 4.166
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
				arg_165_0:Play416062041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1148"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.125

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_8 = arg_165_1.actors_["1028"]
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps1028 == nil then
				arg_165_1.var_.actorSpriteComps1028 = var_168_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_10 = 0.125

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_10 and not isNil(var_168_8) then
				local var_168_11 = (arg_165_1.time_ - var_168_9) / var_168_10

				if arg_165_1.var_.actorSpriteComps1028 then
					for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_168_5 then
							if arg_165_1.isInRecall_ then
								local var_168_12 = Mathf.Lerp(iter_168_5.color.r, arg_165_1.hightColor2.r, var_168_11)
								local var_168_13 = Mathf.Lerp(iter_168_5.color.g, arg_165_1.hightColor2.g, var_168_11)
								local var_168_14 = Mathf.Lerp(iter_168_5.color.b, arg_165_1.hightColor2.b, var_168_11)

								iter_168_5.color = Color.New(var_168_12, var_168_13, var_168_14)
							else
								local var_168_15 = Mathf.Lerp(iter_168_5.color.r, 0.5, var_168_11)

								iter_168_5.color = Color.New(var_168_15, var_168_15, var_168_15)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_9 + var_168_10 and arg_165_1.time_ < var_168_9 + var_168_10 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.actorSpriteComps1028 then
				for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_168_7 then
						if arg_165_1.isInRecall_ then
							iter_168_7.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1028 = nil
			end

			local var_168_16 = arg_165_1.actors_["1148"].transform
			local var_168_17 = 0

			if var_168_17 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				arg_165_1.var_.moveOldPos1148 = var_168_16.localPosition
				var_168_16.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1148", 4)

				local var_168_18 = var_168_16.childCount

				for iter_168_8 = 0, var_168_18 - 1 do
					local var_168_19 = var_168_16:GetChild(iter_168_8)

					if var_168_19.name == "split_1_1" or not string.find(var_168_19.name, "split") then
						var_168_19.gameObject:SetActive(true)
					else
						var_168_19.gameObject:SetActive(false)
					end
				end
			end

			local var_168_20 = 0.001

			if var_168_17 <= arg_165_1.time_ and arg_165_1.time_ < var_168_17 + var_168_20 then
				local var_168_21 = (arg_165_1.time_ - var_168_17) / var_168_20
				local var_168_22 = Vector3.New(390, -429, -180)

				var_168_16.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1148, var_168_22, var_168_21)
			end

			if arg_165_1.time_ >= var_168_17 + var_168_20 and arg_165_1.time_ < var_168_17 + var_168_20 + arg_168_0 then
				var_168_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_168_23 = 0
			local var_168_24 = 0.325

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_25 = arg_165_1:FormatText(StoryNameCfg[8].name)

				arg_165_1.leftNameTxt_.text = var_168_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_26 = arg_165_1:GetWordFromCfg(416062040)
				local var_168_27 = arg_165_1:FormatText(var_168_26.content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_28 = 13
				local var_168_29 = utf8.len(var_168_27)
				local var_168_30 = var_168_28 <= 0 and var_168_24 or var_168_24 * (var_168_29 / var_168_28)

				if var_168_30 > 0 and var_168_24 < var_168_30 then
					arg_165_1.talkMaxDuration = var_168_30

					if var_168_30 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_30 + var_168_23
					end
				end

				arg_165_1.text_.text = var_168_27
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062040", "story_v_out_416062.awb") ~= 0 then
					local var_168_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062040", "story_v_out_416062.awb") / 1000

					if var_168_31 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_31 + var_168_23
					end

					if var_168_26.prefab_name ~= "" and arg_165_1.actors_[var_168_26.prefab_name] ~= nil then
						local var_168_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_26.prefab_name].transform, "story_v_out_416062", "416062040", "story_v_out_416062.awb")

						arg_165_1:RecordAudio("416062040", var_168_32)
						arg_165_1:RecordAudio("416062040", var_168_32)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416062", "416062040", "story_v_out_416062.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416062", "416062040", "story_v_out_416062.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_33 = math.max(var_168_24, arg_165_1.talkMaxDuration)

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_33 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_23) / var_168_33

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_23 + var_168_33 and arg_165_1.time_ < var_168_23 + var_168_33 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play416062041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416062041
		arg_169_1.duration_ = 7.5

		local var_169_0 = {
			zh = 5.8,
			ja = 7.5
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
				arg_169_0:Play416062042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1028"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1028 == nil then
				arg_169_1.var_.actorSpriteComps1028 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.125

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps1028 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1028 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1028 = nil
			end

			local var_172_8 = arg_169_1.actors_["1148"]
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps1148 == nil then
				arg_169_1.var_.actorSpriteComps1148 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_10 = 0.125

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 and not isNil(var_172_8) then
				local var_172_11 = (arg_169_1.time_ - var_172_9) / var_172_10

				if arg_169_1.var_.actorSpriteComps1148 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_172_5 then
							if arg_169_1.isInRecall_ then
								local var_172_12 = Mathf.Lerp(iter_172_5.color.r, arg_169_1.hightColor2.r, var_172_11)
								local var_172_13 = Mathf.Lerp(iter_172_5.color.g, arg_169_1.hightColor2.g, var_172_11)
								local var_172_14 = Mathf.Lerp(iter_172_5.color.b, arg_169_1.hightColor2.b, var_172_11)

								iter_172_5.color = Color.New(var_172_12, var_172_13, var_172_14)
							else
								local var_172_15 = Mathf.Lerp(iter_172_5.color.r, 0.5, var_172_11)

								iter_172_5.color = Color.New(var_172_15, var_172_15, var_172_15)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps1148 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_172_7 then
						if arg_169_1.isInRecall_ then
							iter_172_7.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_16 = 0
			local var_172_17 = 0.475

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_18 = arg_169_1:FormatText(StoryNameCfg[327].name)

				arg_169_1.leftNameTxt_.text = var_172_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_19 = arg_169_1:GetWordFromCfg(416062041)
				local var_172_20 = arg_169_1:FormatText(var_172_19.content)

				arg_169_1.text_.text = var_172_20

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_21 = 19
				local var_172_22 = utf8.len(var_172_20)
				local var_172_23 = var_172_21 <= 0 and var_172_17 or var_172_17 * (var_172_22 / var_172_21)

				if var_172_23 > 0 and var_172_17 < var_172_23 then
					arg_169_1.talkMaxDuration = var_172_23

					if var_172_23 + var_172_16 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_16
					end
				end

				arg_169_1.text_.text = var_172_20
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062041", "story_v_out_416062.awb") ~= 0 then
					local var_172_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062041", "story_v_out_416062.awb") / 1000

					if var_172_24 + var_172_16 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_24 + var_172_16
					end

					if var_172_19.prefab_name ~= "" and arg_169_1.actors_[var_172_19.prefab_name] ~= nil then
						local var_172_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_19.prefab_name].transform, "story_v_out_416062", "416062041", "story_v_out_416062.awb")

						arg_169_1:RecordAudio("416062041", var_172_25)
						arg_169_1:RecordAudio("416062041", var_172_25)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416062", "416062041", "story_v_out_416062.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416062", "416062041", "story_v_out_416062.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_26 = math.max(var_172_17, arg_169_1.talkMaxDuration)

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_26 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_16) / var_172_26

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_16 + var_172_26 and arg_169_1.time_ < var_172_16 + var_172_26 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416062042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416062042
		arg_173_1.duration_ = 5.23

		local var_173_0 = {
			zh = 4.633,
			ja = 5.233
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
				arg_173_0:Play416062043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1148"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1148 == nil then
				arg_173_1.var_.actorSpriteComps1148 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.125

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1148 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1148 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1148 = nil
			end

			local var_176_8 = arg_173_1.actors_["1028"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps1028 == nil then
				arg_173_1.var_.actorSpriteComps1028 = var_176_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_10 = 0.125

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_10 and not isNil(var_176_8) then
				local var_176_11 = (arg_173_1.time_ - var_176_9) / var_176_10

				if arg_173_1.var_.actorSpriteComps1028 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								local var_176_12 = Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, var_176_11)
								local var_176_13 = Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, var_176_11)
								local var_176_14 = Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, var_176_11)

								iter_176_5.color = Color.New(var_176_12, var_176_13, var_176_14)
							else
								local var_176_15 = Mathf.Lerp(iter_176_5.color.r, 0.5, var_176_11)

								iter_176_5.color = Color.New(var_176_15, var_176_15, var_176_15)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_10 and arg_173_1.time_ < var_176_9 + var_176_10 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps1028 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_176_7 then
						if arg_173_1.isInRecall_ then
							iter_176_7.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1028 = nil
			end

			local var_176_16 = 0
			local var_176_17 = 0.375

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_18 = arg_173_1:FormatText(StoryNameCfg[8].name)

				arg_173_1.leftNameTxt_.text = var_176_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_19 = arg_173_1:GetWordFromCfg(416062042)
				local var_176_20 = arg_173_1:FormatText(var_176_19.content)

				arg_173_1.text_.text = var_176_20

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_21 = 15
				local var_176_22 = utf8.len(var_176_20)
				local var_176_23 = var_176_21 <= 0 and var_176_17 or var_176_17 * (var_176_22 / var_176_21)

				if var_176_23 > 0 and var_176_17 < var_176_23 then
					arg_173_1.talkMaxDuration = var_176_23

					if var_176_23 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_16
					end
				end

				arg_173_1.text_.text = var_176_20
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062042", "story_v_out_416062.awb") ~= 0 then
					local var_176_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062042", "story_v_out_416062.awb") / 1000

					if var_176_24 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_24 + var_176_16
					end

					if var_176_19.prefab_name ~= "" and arg_173_1.actors_[var_176_19.prefab_name] ~= nil then
						local var_176_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_19.prefab_name].transform, "story_v_out_416062", "416062042", "story_v_out_416062.awb")

						arg_173_1:RecordAudio("416062042", var_176_25)
						arg_173_1:RecordAudio("416062042", var_176_25)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416062", "416062042", "story_v_out_416062.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416062", "416062042", "story_v_out_416062.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_26 = math.max(var_176_17, arg_173_1.talkMaxDuration)

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_26 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_16) / var_176_26

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_16 + var_176_26 and arg_173_1.time_ < var_176_16 + var_176_26 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416062043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416062043
		arg_177_1.duration_ = 7.43

		local var_177_0 = {
			zh = 3.4,
			ja = 7.433
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
				arg_177_0:Play416062044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1148"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1148 == nil then
				arg_177_1.var_.actorSpriteComps1148 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.125

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1148 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 0.5, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1148 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1148 = nil
			end

			local var_180_8 = arg_177_1.actors_["1028"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1028 == nil then
				arg_177_1.var_.actorSpriteComps1028 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.125

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps1028 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor1.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor1.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor1.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 1, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps1028 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1028 = nil
			end

			local var_180_16 = 0
			local var_180_17 = 0.325

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_18 = arg_177_1:FormatText(StoryNameCfg[327].name)

				arg_177_1.leftNameTxt_.text = var_180_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:GetWordFromCfg(416062043)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 13
				local var_180_22 = utf8.len(var_180_20)
				local var_180_23 = var_180_21 <= 0 and var_180_17 or var_180_17 * (var_180_22 / var_180_21)

				if var_180_23 > 0 and var_180_17 < var_180_23 then
					arg_177_1.talkMaxDuration = var_180_23

					if var_180_23 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062043", "story_v_out_416062.awb") ~= 0 then
					local var_180_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062043", "story_v_out_416062.awb") / 1000

					if var_180_24 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_24 + var_180_16
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_416062", "416062043", "story_v_out_416062.awb")

						arg_177_1:RecordAudio("416062043", var_180_25)
						arg_177_1:RecordAudio("416062043", var_180_25)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416062", "416062043", "story_v_out_416062.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416062", "416062043", "story_v_out_416062.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_26 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_26 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_16) / var_180_26

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_16 + var_180_26 and arg_177_1.time_ < var_180_16 + var_180_26 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416062044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416062044
		arg_181_1.duration_ = 8.5

		local var_181_0 = {
			zh = 6.3,
			ja = 8.5
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
				arg_181_0:Play416062045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1148"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1148 == nil then
				arg_181_1.var_.actorSpriteComps1148 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.125

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps1148 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1148 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1148 = nil
			end

			local var_184_8 = arg_181_1.actors_["1028"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1028 == nil then
				arg_181_1.var_.actorSpriteComps1028 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.125

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps1028 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1028 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1028 = nil
			end

			local var_184_16 = 0
			local var_184_17 = 0.65

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_18 = arg_181_1:FormatText(StoryNameCfg[8].name)

				arg_181_1.leftNameTxt_.text = var_184_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:GetWordFromCfg(416062044)
				local var_184_20 = arg_181_1:FormatText(var_184_19.content)

				arg_181_1.text_.text = var_184_20

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 26
				local var_184_22 = utf8.len(var_184_20)
				local var_184_23 = var_184_21 <= 0 and var_184_17 or var_184_17 * (var_184_22 / var_184_21)

				if var_184_23 > 0 and var_184_17 < var_184_23 then
					arg_181_1.talkMaxDuration = var_184_23

					if var_184_23 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_20
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062044", "story_v_out_416062.awb") ~= 0 then
					local var_184_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062044", "story_v_out_416062.awb") / 1000

					if var_184_24 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_16
					end

					if var_184_19.prefab_name ~= "" and arg_181_1.actors_[var_184_19.prefab_name] ~= nil then
						local var_184_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_19.prefab_name].transform, "story_v_out_416062", "416062044", "story_v_out_416062.awb")

						arg_181_1:RecordAudio("416062044", var_184_25)
						arg_181_1:RecordAudio("416062044", var_184_25)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416062", "416062044", "story_v_out_416062.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416062", "416062044", "story_v_out_416062.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_16) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_16 + var_184_26 and arg_181_1.time_ < var_184_16 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play416062045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416062045
		arg_185_1.duration_ = 4.7

		local var_185_0 = {
			zh = 4.433,
			ja = 4.7
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
				arg_185_0:Play416062046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1148"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1148 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1148", 4)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_4" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(390, -429, -180)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1148, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(390, -429, -180)
			end

			local var_188_7 = 0
			local var_188_8 = 0.4

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_9 = arg_185_1:FormatText(StoryNameCfg[8].name)

				arg_185_1.leftNameTxt_.text = var_188_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(416062045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_12 = 16
				local var_188_13 = utf8.len(var_188_11)
				local var_188_14 = var_188_12 <= 0 and var_188_8 or var_188_8 * (var_188_13 / var_188_12)

				if var_188_14 > 0 and var_188_8 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_7
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062045", "story_v_out_416062.awb") ~= 0 then
					local var_188_15 = manager.audio:GetVoiceLength("story_v_out_416062", "416062045", "story_v_out_416062.awb") / 1000

					if var_188_15 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_7
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_416062", "416062045", "story_v_out_416062.awb")

						arg_185_1:RecordAudio("416062045", var_188_16)
						arg_185_1:RecordAudio("416062045", var_188_16)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416062", "416062045", "story_v_out_416062.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416062", "416062045", "story_v_out_416062.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_17 = math.max(var_188_8, arg_185_1.talkMaxDuration)

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_17 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_7) / var_188_17

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_7 + var_188_17 and arg_185_1.time_ < var_188_7 + var_188_17 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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

		arg_185_1:InitPlayNodeList()
	end,
	Play416062046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416062046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416062047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1028"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1028 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1028", 7)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -2000, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1028, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_7 = arg_189_1.actors_["1148"].transform
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148 = var_192_7.localPosition
				var_192_7.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1148", 7)

				local var_192_9 = var_192_7.childCount

				for iter_192_1 = 0, var_192_9 - 1 do
					local var_192_10 = var_192_7:GetChild(iter_192_1)

					if var_192_10.name == "" or not string.find(var_192_10.name, "split") then
						var_192_10.gameObject:SetActive(true)
					else
						var_192_10.gameObject:SetActive(false)
					end
				end
			end

			local var_192_11 = 0.001

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_11 then
				local var_192_12 = (arg_189_1.time_ - var_192_8) / var_192_11
				local var_192_13 = Vector3.New(0, -2000, 0)

				var_192_7.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148, var_192_13, var_192_12)
			end

			if arg_189_1.time_ >= var_192_8 + var_192_11 and arg_189_1.time_ < var_192_8 + var_192_11 + arg_192_0 then
				var_192_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_14 = 0
			local var_192_15 = 1.525

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_16 = arg_189_1:GetWordFromCfg(416062046)
				local var_192_17 = arg_189_1:FormatText(var_192_16.content)

				arg_189_1.text_.text = var_192_17

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_18 = 61
				local var_192_19 = utf8.len(var_192_17)
				local var_192_20 = var_192_18 <= 0 and var_192_15 or var_192_15 * (var_192_19 / var_192_18)

				if var_192_20 > 0 and var_192_15 < var_192_20 then
					arg_189_1.talkMaxDuration = var_192_20

					if var_192_20 + var_192_14 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_14
					end
				end

				arg_189_1.text_.text = var_192_17
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_21 = math.max(var_192_15, arg_189_1.talkMaxDuration)

			if var_192_14 <= arg_189_1.time_ and arg_189_1.time_ < var_192_14 + var_192_21 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_14) / var_192_21

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_14 + var_192_21 and arg_189_1.time_ < var_192_14 + var_192_21 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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

		arg_189_1:InitPlayNodeList()
	end,
	Play416062047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416062047
		arg_193_1.duration_ = 5.2

		local var_193_0 = {
			zh = 4.366,
			ja = 5.2
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416062048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1086"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1086 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1086", 3)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_2" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -404.2, -237.9)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1086, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_196_7 = arg_193_1.actors_["1086"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1086 == nil then
				arg_193_1.var_.actorSpriteComps1086 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.125

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps1086 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1086 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1086 = nil
			end

			local var_196_15 = 0
			local var_196_16 = 0.55

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[1080].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(416062047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 22
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062047", "story_v_out_416062.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062047", "story_v_out_416062.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_416062", "416062047", "story_v_out_416062.awb")

						arg_193_1:RecordAudio("416062047", var_196_24)
						arg_193_1:RecordAudio("416062047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416062", "416062047", "story_v_out_416062.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416062", "416062047", "story_v_out_416062.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416062048
		arg_197_1.duration_ = 10.07

		local var_197_0 = {
			zh = 7.066,
			ja = 10.066
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play416062049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.875

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[1080].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(416062048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062048", "story_v_out_416062.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062048", "story_v_out_416062.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_416062", "416062048", "story_v_out_416062.awb")

						arg_197_1:RecordAudio("416062048", var_200_9)
						arg_197_1:RecordAudio("416062048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416062", "416062048", "story_v_out_416062.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416062", "416062048", "story_v_out_416062.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play416062049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416062049
		arg_201_1.duration_ = 6.7

		local var_201_0 = {
			zh = 4.133,
			ja = 6.7
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
				arg_201_0:Play416062050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.525

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[1080].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(416062049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062049", "story_v_out_416062.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062049", "story_v_out_416062.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_416062", "416062049", "story_v_out_416062.awb")

						arg_201_1:RecordAudio("416062049", var_204_9)
						arg_201_1:RecordAudio("416062049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416062", "416062049", "story_v_out_416062.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416062", "416062049", "story_v_out_416062.awb")
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
	Play416062050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416062050
		arg_205_1.duration_ = 8.93

		local var_205_0 = {
			zh = 6.1,
			ja = 8.933
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
				arg_205_0:Play416062051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1086"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1086 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1086", 2)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(-390, -404.2, -237.9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1086, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_208_7 = arg_205_1.actors_["1086"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1086 == nil then
				arg_205_1.var_.actorSpriteComps1086 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.125

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1086 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor2.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor2.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor2.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 0.5, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1086 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1086 = nil
			end

			local var_208_15 = arg_205_1.actors_["1028"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1028 == nil then
				arg_205_1.var_.actorSpriteComps1028 = var_208_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_17 = 0.125

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 and not isNil(var_208_15) then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17

				if arg_205_1.var_.actorSpriteComps1028 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								local var_208_19 = Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor1.r, var_208_18)
								local var_208_20 = Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor1.g, var_208_18)
								local var_208_21 = Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor1.b, var_208_18)

								iter_208_6.color = Color.New(var_208_19, var_208_20, var_208_21)
							else
								local var_208_22 = Mathf.Lerp(iter_208_6.color.r, 1, var_208_18)

								iter_208_6.color = Color.New(var_208_22, var_208_22, var_208_22)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1028 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_208_8 then
						if arg_205_1.isInRecall_ then
							iter_208_8.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1028 = nil
			end

			local var_208_23 = arg_205_1.actors_["1028"].transform
			local var_208_24 = 0

			if var_208_24 < arg_205_1.time_ and arg_205_1.time_ <= var_208_24 + arg_208_0 then
				arg_205_1.var_.moveOldPos1028 = var_208_23.localPosition
				var_208_23.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1028", 4)

				local var_208_25 = var_208_23.childCount

				for iter_208_9 = 0, var_208_25 - 1 do
					local var_208_26 = var_208_23:GetChild(iter_208_9)

					if var_208_26.name == "split_6" or not string.find(var_208_26.name, "split") then
						var_208_26.gameObject:SetActive(true)
					else
						var_208_26.gameObject:SetActive(false)
					end
				end
			end

			local var_208_27 = 0.001

			if var_208_24 <= arg_205_1.time_ and arg_205_1.time_ < var_208_24 + var_208_27 then
				local var_208_28 = (arg_205_1.time_ - var_208_24) / var_208_27
				local var_208_29 = Vector3.New(390, -402.7, -156.1)

				var_208_23.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1028, var_208_29, var_208_28)
			end

			if arg_205_1.time_ >= var_208_24 + var_208_27 and arg_205_1.time_ < var_208_24 + var_208_27 + arg_208_0 then
				var_208_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_208_30 = 0
			local var_208_31 = 0.75

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_32 = arg_205_1:FormatText(StoryNameCfg[327].name)

				arg_205_1.leftNameTxt_.text = var_208_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_33 = arg_205_1:GetWordFromCfg(416062050)
				local var_208_34 = arg_205_1:FormatText(var_208_33.content)

				arg_205_1.text_.text = var_208_34

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_35 = 30
				local var_208_36 = utf8.len(var_208_34)
				local var_208_37 = var_208_35 <= 0 and var_208_31 or var_208_31 * (var_208_36 / var_208_35)

				if var_208_37 > 0 and var_208_31 < var_208_37 then
					arg_205_1.talkMaxDuration = var_208_37

					if var_208_37 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_37 + var_208_30
					end
				end

				arg_205_1.text_.text = var_208_34
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062050", "story_v_out_416062.awb") ~= 0 then
					local var_208_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062050", "story_v_out_416062.awb") / 1000

					if var_208_38 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_38 + var_208_30
					end

					if var_208_33.prefab_name ~= "" and arg_205_1.actors_[var_208_33.prefab_name] ~= nil then
						local var_208_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_33.prefab_name].transform, "story_v_out_416062", "416062050", "story_v_out_416062.awb")

						arg_205_1:RecordAudio("416062050", var_208_39)
						arg_205_1:RecordAudio("416062050", var_208_39)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416062", "416062050", "story_v_out_416062.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416062", "416062050", "story_v_out_416062.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_40 = math.max(var_208_31, arg_205_1.talkMaxDuration)

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_40 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_30) / var_208_40

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_30 + var_208_40 and arg_205_1.time_ < var_208_30 + var_208_40 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416062051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416062051
		arg_209_1.duration_ = 6.87

		local var_209_0 = {
			zh = 5.7,
			ja = 6.866
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
				arg_209_0:Play416062052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1028"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1028 == nil then
				arg_209_1.var_.actorSpriteComps1028 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.125

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1028 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 0.5, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1028 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1028 = nil
			end

			local var_212_8 = arg_209_1.actors_["1028"].transform
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.var_.moveOldPos1028 = var_212_8.localPosition
				var_212_8.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1028", 2)

				local var_212_10 = var_212_8.childCount

				for iter_212_4 = 0, var_212_10 - 1 do
					local var_212_11 = var_212_8:GetChild(iter_212_4)

					if var_212_11.name == "" or not string.find(var_212_11.name, "split") then
						var_212_11.gameObject:SetActive(true)
					else
						var_212_11.gameObject:SetActive(false)
					end
				end
			end

			local var_212_12 = 0.001

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_9) / var_212_12
				local var_212_14 = Vector3.New(-390, -402.7, -156.1)

				var_212_8.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1028, var_212_14, var_212_13)
			end

			if arg_209_1.time_ >= var_212_9 + var_212_12 and arg_209_1.time_ < var_212_9 + var_212_12 + arg_212_0 then
				var_212_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_212_15 = arg_209_1.actors_["1148"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps1148 == nil then
				arg_209_1.var_.actorSpriteComps1148 = var_212_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_17 = 0.125

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 and not isNil(var_212_15) then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17

				if arg_209_1.var_.actorSpriteComps1148 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								local var_212_19 = Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor1.r, var_212_18)
								local var_212_20 = Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor1.g, var_212_18)
								local var_212_21 = Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor1.b, var_212_18)

								iter_212_6.color = Color.New(var_212_19, var_212_20, var_212_21)
							else
								local var_212_22 = Mathf.Lerp(iter_212_6.color.r, 1, var_212_18)

								iter_212_6.color = Color.New(var_212_22, var_212_22, var_212_22)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps1148 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_212_8 then
						if arg_209_1.isInRecall_ then
							iter_212_8.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1148 = nil
			end

			local var_212_23 = arg_209_1.actors_["1148"].transform
			local var_212_24 = 0

			if var_212_24 < arg_209_1.time_ and arg_209_1.time_ <= var_212_24 + arg_212_0 then
				arg_209_1.var_.moveOldPos1148 = var_212_23.localPosition
				var_212_23.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1148", 4)

				local var_212_25 = var_212_23.childCount

				for iter_212_9 = 0, var_212_25 - 1 do
					local var_212_26 = var_212_23:GetChild(iter_212_9)

					if var_212_26.name == "" or not string.find(var_212_26.name, "split") then
						var_212_26.gameObject:SetActive(true)
					else
						var_212_26.gameObject:SetActive(false)
					end
				end
			end

			local var_212_27 = 0.001

			if var_212_24 <= arg_209_1.time_ and arg_209_1.time_ < var_212_24 + var_212_27 then
				local var_212_28 = (arg_209_1.time_ - var_212_24) / var_212_27
				local var_212_29 = Vector3.New(390, -429, -180)

				var_212_23.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1148, var_212_29, var_212_28)
			end

			if arg_209_1.time_ >= var_212_24 + var_212_27 and arg_209_1.time_ < var_212_24 + var_212_27 + arg_212_0 then
				var_212_23.localPosition = Vector3.New(390, -429, -180)
			end

			local var_212_30 = 0
			local var_212_31 = 0.475

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_32 = arg_209_1:FormatText(StoryNameCfg[8].name)

				arg_209_1.leftNameTxt_.text = var_212_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_33 = arg_209_1:GetWordFromCfg(416062051)
				local var_212_34 = arg_209_1:FormatText(var_212_33.content)

				arg_209_1.text_.text = var_212_34

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_35 = 19
				local var_212_36 = utf8.len(var_212_34)
				local var_212_37 = var_212_35 <= 0 and var_212_31 or var_212_31 * (var_212_36 / var_212_35)

				if var_212_37 > 0 and var_212_31 < var_212_37 then
					arg_209_1.talkMaxDuration = var_212_37

					if var_212_37 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_37 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_34
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062051", "story_v_out_416062.awb") ~= 0 then
					local var_212_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062051", "story_v_out_416062.awb") / 1000

					if var_212_38 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_30
					end

					if var_212_33.prefab_name ~= "" and arg_209_1.actors_[var_212_33.prefab_name] ~= nil then
						local var_212_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_33.prefab_name].transform, "story_v_out_416062", "416062051", "story_v_out_416062.awb")

						arg_209_1:RecordAudio("416062051", var_212_39)
						arg_209_1:RecordAudio("416062051", var_212_39)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_416062", "416062051", "story_v_out_416062.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_416062", "416062051", "story_v_out_416062.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_40 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_40 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_40

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_40 and arg_209_1.time_ < var_212_30 + var_212_40 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play416062052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416062052
		arg_213_1.duration_ = 3.93

		local var_213_0 = {
			zh = 3,
			ja = 3.933
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
				arg_213_0:Play416062053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.425

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[8].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(416062052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062052", "story_v_out_416062.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062052", "story_v_out_416062.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_416062", "416062052", "story_v_out_416062.awb")

						arg_213_1:RecordAudio("416062052", var_216_9)
						arg_213_1:RecordAudio("416062052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416062", "416062052", "story_v_out_416062.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416062", "416062052", "story_v_out_416062.awb")
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
	Play416062053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416062053
		arg_217_1.duration_ = 9

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play416062054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 2

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				local var_220_1 = manager.ui.mainCamera.transform.localPosition
				local var_220_2 = Vector3.New(0, 0, 10) + Vector3.New(var_220_1.x, var_220_1.y, 0)
				local var_220_3 = arg_217_1.bgs_.I13h

				var_220_3.transform.localPosition = var_220_2
				var_220_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_4 = var_220_3:GetComponent("SpriteRenderer")

				if var_220_4 and var_220_4.sprite then
					local var_220_5 = (var_220_3.transform.localPosition - var_220_1).z
					local var_220_6 = manager.ui.mainCameraCom_
					local var_220_7 = 2 * var_220_5 * Mathf.Tan(var_220_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_220_8 = var_220_7 * var_220_6.aspect
					local var_220_9 = var_220_4.sprite.bounds.size.x
					local var_220_10 = var_220_4.sprite.bounds.size.y
					local var_220_11 = var_220_8 / var_220_9
					local var_220_12 = var_220_7 / var_220_10
					local var_220_13 = var_220_12 < var_220_11 and var_220_11 or var_220_12

					var_220_3.transform.localScale = Vector3.New(var_220_13, var_220_13, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "I13h" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_14 = 4

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_15 = 0.3

			if arg_217_1.time_ >= var_220_14 + var_220_15 and arg_217_1.time_ < var_220_14 + var_220_15 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_17 = 2

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_17 then
				local var_220_18 = (arg_217_1.time_ - var_220_16) / var_220_17
				local var_220_19 = Color.New(0, 0, 0)

				var_220_19.a = Mathf.Lerp(0, 1, var_220_18)
				arg_217_1.mask_.color = var_220_19
			end

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 then
				local var_220_20 = Color.New(0, 0, 0)

				var_220_20.a = 1
				arg_217_1.mask_.color = var_220_20
			end

			local var_220_21 = 2

			if var_220_21 < arg_217_1.time_ and arg_217_1.time_ <= var_220_21 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_22 = 2

			if var_220_21 <= arg_217_1.time_ and arg_217_1.time_ < var_220_21 + var_220_22 then
				local var_220_23 = (arg_217_1.time_ - var_220_21) / var_220_22
				local var_220_24 = Color.New(0, 0, 0)

				var_220_24.a = Mathf.Lerp(1, 0, var_220_23)
				arg_217_1.mask_.color = var_220_24
			end

			if arg_217_1.time_ >= var_220_21 + var_220_22 and arg_217_1.time_ < var_220_21 + var_220_22 + arg_220_0 then
				local var_220_25 = Color.New(0, 0, 0)
				local var_220_26 = 0

				arg_217_1.mask_.enabled = false
				var_220_25.a = var_220_26
				arg_217_1.mask_.color = var_220_25
			end

			local var_220_27 = arg_217_1.actors_["1148"].transform
			local var_220_28 = 1.966

			if var_220_28 < arg_217_1.time_ and arg_217_1.time_ <= var_220_28 + arg_220_0 then
				arg_217_1.var_.moveOldPos1148 = var_220_27.localPosition
				var_220_27.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1148", 7)

				local var_220_29 = var_220_27.childCount

				for iter_220_2 = 0, var_220_29 - 1 do
					local var_220_30 = var_220_27:GetChild(iter_220_2)

					if var_220_30.name == "" or not string.find(var_220_30.name, "split") then
						var_220_30.gameObject:SetActive(true)
					else
						var_220_30.gameObject:SetActive(false)
					end
				end
			end

			local var_220_31 = 0.001

			if var_220_28 <= arg_217_1.time_ and arg_217_1.time_ < var_220_28 + var_220_31 then
				local var_220_32 = (arg_217_1.time_ - var_220_28) / var_220_31
				local var_220_33 = Vector3.New(0, -2000, 0)

				var_220_27.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1148, var_220_33, var_220_32)
			end

			if arg_217_1.time_ >= var_220_28 + var_220_31 and arg_217_1.time_ < var_220_28 + var_220_31 + arg_220_0 then
				var_220_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_34 = arg_217_1.actors_["1028"].transform
			local var_220_35 = 1.966

			if var_220_35 < arg_217_1.time_ and arg_217_1.time_ <= var_220_35 + arg_220_0 then
				arg_217_1.var_.moveOldPos1028 = var_220_34.localPosition
				var_220_34.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1028", 7)

				local var_220_36 = var_220_34.childCount

				for iter_220_3 = 0, var_220_36 - 1 do
					local var_220_37 = var_220_34:GetChild(iter_220_3)

					if var_220_37.name == "" or not string.find(var_220_37.name, "split") then
						var_220_37.gameObject:SetActive(true)
					else
						var_220_37.gameObject:SetActive(false)
					end
				end
			end

			local var_220_38 = 0.001

			if var_220_35 <= arg_217_1.time_ and arg_217_1.time_ < var_220_35 + var_220_38 then
				local var_220_39 = (arg_217_1.time_ - var_220_35) / var_220_38
				local var_220_40 = Vector3.New(0, -2000, 0)

				var_220_34.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1028, var_220_40, var_220_39)
			end

			if arg_217_1.time_ >= var_220_35 + var_220_38 and arg_217_1.time_ < var_220_35 + var_220_38 + arg_220_0 then
				var_220_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_41 = 4
			local var_220_42 = 0.925

			if var_220_41 < arg_217_1.time_ and arg_217_1.time_ <= var_220_41 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_43 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_43:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_44 = arg_217_1:GetWordFromCfg(416062053)
				local var_220_45 = arg_217_1:FormatText(var_220_44.content)

				arg_217_1.text_.text = var_220_45

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_46 = 37
				local var_220_47 = utf8.len(var_220_45)
				local var_220_48 = var_220_46 <= 0 and var_220_42 or var_220_42 * (var_220_47 / var_220_46)

				if var_220_48 > 0 and var_220_42 < var_220_48 then
					arg_217_1.talkMaxDuration = var_220_48
					var_220_41 = var_220_41 + 0.3

					if var_220_48 + var_220_41 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_48 + var_220_41
					end
				end

				arg_217_1.text_.text = var_220_45
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_49 = var_220_41 + 0.3
			local var_220_50 = math.max(var_220_42, arg_217_1.talkMaxDuration)

			if var_220_49 <= arg_217_1.time_ and arg_217_1.time_ < var_220_49 + var_220_50 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_49) / var_220_50

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_49 + var_220_50 and arg_217_1.time_ < var_220_49 + var_220_50 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play416062054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416062054
		arg_223_1.duration_ = 3.53

		local var_223_0 = {
			zh = 3.533,
			ja = 3.4
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
				arg_223_0:Play416062055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1086"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1086 == nil then
				arg_223_1.var_.actorSpriteComps1086 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.125

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps1086 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 1, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1086 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1086 = nil
			end

			local var_226_8 = arg_223_1.actors_["1086"].transform
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.moveOldPos1086 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1086", 3)

				local var_226_10 = var_226_8.childCount

				for iter_226_4 = 0, var_226_10 - 1 do
					local var_226_11 = var_226_8:GetChild(iter_226_4)

					if var_226_11.name == "" or not string.find(var_226_11.name, "split") then
						var_226_11.gameObject:SetActive(true)
					else
						var_226_11.gameObject:SetActive(false)
					end
				end
			end

			local var_226_12 = 0.001

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_12 then
				local var_226_13 = (arg_223_1.time_ - var_226_9) / var_226_12
				local var_226_14 = Vector3.New(0, -404.2, -237.9)

				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1086, var_226_14, var_226_13)
			end

			if arg_223_1.time_ >= var_226_9 + var_226_12 and arg_223_1.time_ < var_226_9 + var_226_12 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_226_15 = 0
			local var_226_16 = 0.475

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[1080].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(416062054)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062054", "story_v_out_416062.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_416062", "416062054", "story_v_out_416062.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_416062", "416062054", "story_v_out_416062.awb")

						arg_223_1:RecordAudio("416062054", var_226_24)
						arg_223_1:RecordAudio("416062054", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416062", "416062054", "story_v_out_416062.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416062", "416062054", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416062055
		arg_227_1.duration_ = 4.37

		local var_227_0 = {
			zh = 3.2,
			ja = 4.366
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
				arg_227_0:Play416062056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1086"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1086 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1086", 2)

				local var_230_2 = var_230_0.childCount

				for iter_230_0 = 0, var_230_2 - 1 do
					local var_230_3 = var_230_0:GetChild(iter_230_0)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_4 then
				local var_230_5 = (arg_227_1.time_ - var_230_1) / var_230_4
				local var_230_6 = Vector3.New(-390, -404.2, -237.9)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1086, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_230_7 = arg_227_1.actors_["1086"]
			local var_230_8 = 0

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1086 == nil then
				arg_227_1.var_.actorSpriteComps1086 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_9 = 0.125

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 and not isNil(var_230_7) then
				local var_230_10 = (arg_227_1.time_ - var_230_8) / var_230_9

				if arg_227_1.var_.actorSpriteComps1086 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_11 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor2.r, var_230_10)
								local var_230_12 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor2.g, var_230_10)
								local var_230_13 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor2.b, var_230_10)

								iter_230_2.color = Color.New(var_230_11, var_230_12, var_230_13)
							else
								local var_230_14 = Mathf.Lerp(iter_230_2.color.r, 0.5, var_230_10)

								iter_230_2.color = Color.New(var_230_14, var_230_14, var_230_14)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1086 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1086 = nil
			end

			local var_230_15 = arg_227_1.actors_["1028"]
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1028 == nil then
				arg_227_1.var_.actorSpriteComps1028 = var_230_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_17 = 0.125

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 and not isNil(var_230_15) then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17

				if arg_227_1.var_.actorSpriteComps1028 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								local var_230_19 = Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor1.r, var_230_18)
								local var_230_20 = Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor1.g, var_230_18)
								local var_230_21 = Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor1.b, var_230_18)

								iter_230_6.color = Color.New(var_230_19, var_230_20, var_230_21)
							else
								local var_230_22 = Mathf.Lerp(iter_230_6.color.r, 1, var_230_18)

								iter_230_6.color = Color.New(var_230_22, var_230_22, var_230_22)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1028 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_230_8 then
						if arg_227_1.isInRecall_ then
							iter_230_8.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1028 = nil
			end

			local var_230_23 = arg_227_1.actors_["1028"].transform
			local var_230_24 = 0

			if var_230_24 < arg_227_1.time_ and arg_227_1.time_ <= var_230_24 + arg_230_0 then
				arg_227_1.var_.moveOldPos1028 = var_230_23.localPosition
				var_230_23.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1028", 4)

				local var_230_25 = var_230_23.childCount

				for iter_230_9 = 0, var_230_25 - 1 do
					local var_230_26 = var_230_23:GetChild(iter_230_9)

					if var_230_26.name == "" or not string.find(var_230_26.name, "split") then
						var_230_26.gameObject:SetActive(true)
					else
						var_230_26.gameObject:SetActive(false)
					end
				end
			end

			local var_230_27 = 0.001

			if var_230_24 <= arg_227_1.time_ and arg_227_1.time_ < var_230_24 + var_230_27 then
				local var_230_28 = (arg_227_1.time_ - var_230_24) / var_230_27
				local var_230_29 = Vector3.New(390, -402.7, -156.1)

				var_230_23.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1028, var_230_29, var_230_28)
			end

			if arg_227_1.time_ >= var_230_24 + var_230_27 and arg_227_1.time_ < var_230_24 + var_230_27 + arg_230_0 then
				var_230_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_230_30 = 0
			local var_230_31 = 0.35

			if var_230_30 < arg_227_1.time_ and arg_227_1.time_ <= var_230_30 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_32 = arg_227_1:FormatText(StoryNameCfg[327].name)

				arg_227_1.leftNameTxt_.text = var_230_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_33 = arg_227_1:GetWordFromCfg(416062055)
				local var_230_34 = arg_227_1:FormatText(var_230_33.content)

				arg_227_1.text_.text = var_230_34

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_35 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062055", "story_v_out_416062.awb") ~= 0 then
					local var_230_38 = manager.audio:GetVoiceLength("story_v_out_416062", "416062055", "story_v_out_416062.awb") / 1000

					if var_230_38 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_38 + var_230_30
					end

					if var_230_33.prefab_name ~= "" and arg_227_1.actors_[var_230_33.prefab_name] ~= nil then
						local var_230_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_33.prefab_name].transform, "story_v_out_416062", "416062055", "story_v_out_416062.awb")

						arg_227_1:RecordAudio("416062055", var_230_39)
						arg_227_1:RecordAudio("416062055", var_230_39)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416062", "416062055", "story_v_out_416062.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416062", "416062055", "story_v_out_416062.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416062056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416062056
		arg_231_1.duration_ = 10.3

		local var_231_0 = {
			zh = 7,
			ja = 10.3
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
				arg_231_0:Play416062057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1086"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1086 == nil then
				arg_231_1.var_.actorSpriteComps1086 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.125

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1086 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1086 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1086 = nil
			end

			local var_234_8 = arg_231_1.actors_["1028"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1028 == nil then
				arg_231_1.var_.actorSpriteComps1028 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.125

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1028 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1028 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1028 = nil
			end

			local var_234_16 = 0
			local var_234_17 = 0.7

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_18 = arg_231_1:FormatText(StoryNameCfg[1080].name)

				arg_231_1.leftNameTxt_.text = var_234_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_19 = arg_231_1:GetWordFromCfg(416062056)
				local var_234_20 = arg_231_1:FormatText(var_234_19.content)

				arg_231_1.text_.text = var_234_20

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_21 = 28
				local var_234_22 = utf8.len(var_234_20)
				local var_234_23 = var_234_21 <= 0 and var_234_17 or var_234_17 * (var_234_22 / var_234_21)

				if var_234_23 > 0 and var_234_17 < var_234_23 then
					arg_231_1.talkMaxDuration = var_234_23

					if var_234_23 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_16
					end
				end

				arg_231_1.text_.text = var_234_20
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062056", "story_v_out_416062.awb") ~= 0 then
					local var_234_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062056", "story_v_out_416062.awb") / 1000

					if var_234_24 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_24 + var_234_16
					end

					if var_234_19.prefab_name ~= "" and arg_231_1.actors_[var_234_19.prefab_name] ~= nil then
						local var_234_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_19.prefab_name].transform, "story_v_out_416062", "416062056", "story_v_out_416062.awb")

						arg_231_1:RecordAudio("416062056", var_234_25)
						arg_231_1:RecordAudio("416062056", var_234_25)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416062", "416062056", "story_v_out_416062.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416062", "416062056", "story_v_out_416062.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_26 = math.max(var_234_17, arg_231_1.talkMaxDuration)

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_26 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_16) / var_234_26

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_16 + var_234_26 and arg_231_1.time_ < var_234_16 + var_234_26 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416062057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416062057
		arg_235_1.duration_ = 8.6

		local var_235_0 = {
			zh = 5.1,
			ja = 8.6
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
				arg_235_0:Play416062058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1028"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1028 == nil then
				arg_235_1.var_.actorSpriteComps1028 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.125

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1028 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 1, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1028 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1028 = nil
			end

			local var_238_8 = arg_235_1.actors_["1086"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1086 == nil then
				arg_235_1.var_.actorSpriteComps1086 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.125

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps1086 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								local var_238_12 = Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, var_238_11)
								local var_238_13 = Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, var_238_11)
								local var_238_14 = Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, var_238_11)

								iter_238_5.color = Color.New(var_238_12, var_238_13, var_238_14)
							else
								local var_238_15 = Mathf.Lerp(iter_238_5.color.r, 0.5, var_238_11)

								iter_238_5.color = Color.New(var_238_15, var_238_15, var_238_15)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1086 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1086 = nil
			end

			local var_238_16 = 0
			local var_238_17 = 0.55

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_18 = arg_235_1:FormatText(StoryNameCfg[327].name)

				arg_235_1.leftNameTxt_.text = var_238_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_19 = arg_235_1:GetWordFromCfg(416062057)
				local var_238_20 = arg_235_1:FormatText(var_238_19.content)

				arg_235_1.text_.text = var_238_20

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_21 = 22
				local var_238_22 = utf8.len(var_238_20)
				local var_238_23 = var_238_21 <= 0 and var_238_17 or var_238_17 * (var_238_22 / var_238_21)

				if var_238_23 > 0 and var_238_17 < var_238_23 then
					arg_235_1.talkMaxDuration = var_238_23

					if var_238_23 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_16
					end
				end

				arg_235_1.text_.text = var_238_20
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062057", "story_v_out_416062.awb") ~= 0 then
					local var_238_24 = manager.audio:GetVoiceLength("story_v_out_416062", "416062057", "story_v_out_416062.awb") / 1000

					if var_238_24 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_16
					end

					if var_238_19.prefab_name ~= "" and arg_235_1.actors_[var_238_19.prefab_name] ~= nil then
						local var_238_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_19.prefab_name].transform, "story_v_out_416062", "416062057", "story_v_out_416062.awb")

						arg_235_1:RecordAudio("416062057", var_238_25)
						arg_235_1:RecordAudio("416062057", var_238_25)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416062", "416062057", "story_v_out_416062.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416062", "416062057", "story_v_out_416062.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_26 = math.max(var_238_17, arg_235_1.talkMaxDuration)

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_26 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_16) / var_238_26

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_16 + var_238_26 and arg_235_1.time_ < var_238_16 + var_238_26 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416062058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416062058
		arg_239_1.duration_ = 10.13

		local var_239_0 = {
			zh = 7.233,
			ja = 10.133
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
				arg_239_0:Play416062059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.775

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[327].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(416062058)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062058", "story_v_out_416062.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062058", "story_v_out_416062.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_416062", "416062058", "story_v_out_416062.awb")

						arg_239_1:RecordAudio("416062058", var_242_9)
						arg_239_1:RecordAudio("416062058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416062", "416062058", "story_v_out_416062.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416062", "416062058", "story_v_out_416062.awb")
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
	Play416062059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416062059
		arg_243_1.duration_ = 9.3

		local var_243_0 = {
			zh = 8.333,
			ja = 9.3
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
				arg_243_0:Play416062060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1086"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1086 == nil then
				arg_243_1.var_.actorSpriteComps1086 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.125

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1086 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1086 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1086 = nil
			end

			local var_246_8 = arg_243_1.actors_["1028"]
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1028 == nil then
				arg_243_1.var_.actorSpriteComps1028 = var_246_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_10 = 0.125

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 and not isNil(var_246_8) then
				local var_246_11 = (arg_243_1.time_ - var_246_9) / var_246_10

				if arg_243_1.var_.actorSpriteComps1028 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1028 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_246_7 then
						if arg_243_1.isInRecall_ then
							iter_246_7.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1028 = nil
			end

			local var_246_16 = arg_243_1.actors_["1086"].transform
			local var_246_17 = 0

			if var_246_17 < arg_243_1.time_ and arg_243_1.time_ <= var_246_17 + arg_246_0 then
				arg_243_1.var_.moveOldPos1086 = var_246_16.localPosition
				var_246_16.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1086", 2)

				local var_246_18 = var_246_16.childCount

				for iter_246_8 = 0, var_246_18 - 1 do
					local var_246_19 = var_246_16:GetChild(iter_246_8)

					if var_246_19.name == "split_2" or not string.find(var_246_19.name, "split") then
						var_246_19.gameObject:SetActive(true)
					else
						var_246_19.gameObject:SetActive(false)
					end
				end
			end

			local var_246_20 = 0.001

			if var_246_17 <= arg_243_1.time_ and arg_243_1.time_ < var_246_17 + var_246_20 then
				local var_246_21 = (arg_243_1.time_ - var_246_17) / var_246_20
				local var_246_22 = Vector3.New(-390, -404.2, -237.9)

				var_246_16.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1086, var_246_22, var_246_21)
			end

			if arg_243_1.time_ >= var_246_17 + var_246_20 and arg_243_1.time_ < var_246_17 + var_246_20 + arg_246_0 then
				var_246_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_246_23 = 0
			local var_246_24 = 0.825

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_25 = arg_243_1:FormatText(StoryNameCfg[1080].name)

				arg_243_1.leftNameTxt_.text = var_246_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_26 = arg_243_1:GetWordFromCfg(416062059)
				local var_246_27 = arg_243_1:FormatText(var_246_26.content)

				arg_243_1.text_.text = var_246_27

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_28 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062059", "story_v_out_416062.awb") ~= 0 then
					local var_246_31 = manager.audio:GetVoiceLength("story_v_out_416062", "416062059", "story_v_out_416062.awb") / 1000

					if var_246_31 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_31 + var_246_23
					end

					if var_246_26.prefab_name ~= "" and arg_243_1.actors_[var_246_26.prefab_name] ~= nil then
						local var_246_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_26.prefab_name].transform, "story_v_out_416062", "416062059", "story_v_out_416062.awb")

						arg_243_1:RecordAudio("416062059", var_246_32)
						arg_243_1:RecordAudio("416062059", var_246_32)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416062", "416062059", "story_v_out_416062.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416062", "416062059", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416062060
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play416062061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 2

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				local var_250_1 = manager.ui.mainCamera.transform.localPosition
				local var_250_2 = Vector3.New(0, 0, 10) + Vector3.New(var_250_1.x, var_250_1.y, 0)
				local var_250_3 = arg_247_1.bgs_.I13f

				var_250_3.transform.localPosition = var_250_2
				var_250_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_4 = var_250_3:GetComponent("SpriteRenderer")

				if var_250_4 and var_250_4.sprite then
					local var_250_5 = (var_250_3.transform.localPosition - var_250_1).z
					local var_250_6 = manager.ui.mainCameraCom_
					local var_250_7 = 2 * var_250_5 * Mathf.Tan(var_250_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_8 = var_250_7 * var_250_6.aspect
					local var_250_9 = var_250_4.sprite.bounds.size.x
					local var_250_10 = var_250_4.sprite.bounds.size.y
					local var_250_11 = var_250_8 / var_250_9
					local var_250_12 = var_250_7 / var_250_10
					local var_250_13 = var_250_12 < var_250_11 and var_250_11 or var_250_12

					var_250_3.transform.localScale = Vector3.New(var_250_13, var_250_13, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "I13f" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_14 = 4

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			local var_250_15 = 0.3

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_16 = 0

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_17 = 2

			if var_250_16 <= arg_247_1.time_ and arg_247_1.time_ < var_250_16 + var_250_17 then
				local var_250_18 = (arg_247_1.time_ - var_250_16) / var_250_17
				local var_250_19 = Color.New(0, 0, 0)

				var_250_19.a = Mathf.Lerp(0, 1, var_250_18)
				arg_247_1.mask_.color = var_250_19
			end

			if arg_247_1.time_ >= var_250_16 + var_250_17 and arg_247_1.time_ < var_250_16 + var_250_17 + arg_250_0 then
				local var_250_20 = Color.New(0, 0, 0)

				var_250_20.a = 1
				arg_247_1.mask_.color = var_250_20
			end

			local var_250_21 = 2

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_22 = 2

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_22 then
				local var_250_23 = (arg_247_1.time_ - var_250_21) / var_250_22
				local var_250_24 = Color.New(0, 0, 0)

				var_250_24.a = Mathf.Lerp(1, 0, var_250_23)
				arg_247_1.mask_.color = var_250_24
			end

			if arg_247_1.time_ >= var_250_21 + var_250_22 and arg_247_1.time_ < var_250_21 + var_250_22 + arg_250_0 then
				local var_250_25 = Color.New(0, 0, 0)
				local var_250_26 = 0

				arg_247_1.mask_.enabled = false
				var_250_25.a = var_250_26
				arg_247_1.mask_.color = var_250_25
			end

			local var_250_27 = arg_247_1.actors_["1086"].transform
			local var_250_28 = 1.966

			if var_250_28 < arg_247_1.time_ and arg_247_1.time_ <= var_250_28 + arg_250_0 then
				arg_247_1.var_.moveOldPos1086 = var_250_27.localPosition
				var_250_27.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1086", 7)

				local var_250_29 = var_250_27.childCount

				for iter_250_2 = 0, var_250_29 - 1 do
					local var_250_30 = var_250_27:GetChild(iter_250_2)

					if var_250_30.name == "" or not string.find(var_250_30.name, "split") then
						var_250_30.gameObject:SetActive(true)
					else
						var_250_30.gameObject:SetActive(false)
					end
				end
			end

			local var_250_31 = 0.001

			if var_250_28 <= arg_247_1.time_ and arg_247_1.time_ < var_250_28 + var_250_31 then
				local var_250_32 = (arg_247_1.time_ - var_250_28) / var_250_31
				local var_250_33 = Vector3.New(0, -2000, 0)

				var_250_27.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1086, var_250_33, var_250_32)
			end

			if arg_247_1.time_ >= var_250_28 + var_250_31 and arg_247_1.time_ < var_250_28 + var_250_31 + arg_250_0 then
				var_250_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_34 = arg_247_1.actors_["1028"].transform
			local var_250_35 = 1.966

			if var_250_35 < arg_247_1.time_ and arg_247_1.time_ <= var_250_35 + arg_250_0 then
				arg_247_1.var_.moveOldPos1028 = var_250_34.localPosition
				var_250_34.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1028", 7)

				local var_250_36 = var_250_34.childCount

				for iter_250_3 = 0, var_250_36 - 1 do
					local var_250_37 = var_250_34:GetChild(iter_250_3)

					if var_250_37.name == "" or not string.find(var_250_37.name, "split") then
						var_250_37.gameObject:SetActive(true)
					else
						var_250_37.gameObject:SetActive(false)
					end
				end
			end

			local var_250_38 = 0.001

			if var_250_35 <= arg_247_1.time_ and arg_247_1.time_ < var_250_35 + var_250_38 then
				local var_250_39 = (arg_247_1.time_ - var_250_35) / var_250_38
				local var_250_40 = Vector3.New(0, -2000, 0)

				var_250_34.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1028, var_250_40, var_250_39)
			end

			if arg_247_1.time_ >= var_250_35 + var_250_38 and arg_247_1.time_ < var_250_35 + var_250_38 + arg_250_0 then
				var_250_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_41 = 4
			local var_250_42 = 1.375

			if var_250_41 < arg_247_1.time_ and arg_247_1.time_ <= var_250_41 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_43 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_43:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_44 = arg_247_1:GetWordFromCfg(416062060)
				local var_250_45 = arg_247_1:FormatText(var_250_44.content)

				arg_247_1.text_.text = var_250_45

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_46 = 55
				local var_250_47 = utf8.len(var_250_45)
				local var_250_48 = var_250_46 <= 0 and var_250_42 or var_250_42 * (var_250_47 / var_250_46)

				if var_250_48 > 0 and var_250_42 < var_250_48 then
					arg_247_1.talkMaxDuration = var_250_48
					var_250_41 = var_250_41 + 0.3

					if var_250_48 + var_250_41 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_48 + var_250_41
					end
				end

				arg_247_1.text_.text = var_250_45
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_49 = var_250_41 + 0.3
			local var_250_50 = math.max(var_250_42, arg_247_1.talkMaxDuration)

			if var_250_49 <= arg_247_1.time_ and arg_247_1.time_ < var_250_49 + var_250_50 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_49) / var_250_50

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_49 + var_250_50 and arg_247_1.time_ < var_250_49 + var_250_50 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416062061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 416062061
		arg_253_1.duration_ = 16.83

		local var_253_0 = {
			zh = 11.0993333333333,
			ja = 16.8333333333333
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
			arg_253_1.auto_ = false
		end

		function arg_253_1.playNext_(arg_255_0)
			arg_253_1.onStoryFinished_()
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = "10109"

			if arg_253_1.actors_[var_256_0] == nil then
				local var_256_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_256_1) then
					local var_256_2 = Object.Instantiate(var_256_1, arg_253_1.canvasGo_.transform)

					var_256_2.transform:SetSiblingIndex(1)

					var_256_2.name = var_256_0
					var_256_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_253_1.actors_[var_256_0] = var_256_2

					local var_256_3 = var_256_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_253_1.isInRecall_ then
						for iter_256_0, iter_256_1 in ipairs(var_256_3) do
							iter_256_1.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_256_4 = arg_253_1.actors_["10109"].transform
			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.var_.moveOldPos10109 = var_256_4.localPosition
				var_256_4.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10109", 3)

				local var_256_6 = var_256_4.childCount

				for iter_256_2 = 0, var_256_6 - 1 do
					local var_256_7 = var_256_4:GetChild(iter_256_2)

					if var_256_7.name == "" or not string.find(var_256_7.name, "split") then
						var_256_7.gameObject:SetActive(true)
					else
						var_256_7.gameObject:SetActive(false)
					end
				end
			end

			local var_256_8 = 0.001

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_8 then
				local var_256_9 = (arg_253_1.time_ - var_256_5) / var_256_8
				local var_256_10 = Vector3.New(0, -346.2, -395)

				var_256_4.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10109, var_256_10, var_256_9)
			end

			if arg_253_1.time_ >= var_256_5 + var_256_8 and arg_253_1.time_ < var_256_5 + var_256_8 + arg_256_0 then
				var_256_4.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_256_11 = arg_253_1.actors_["10109"]
			local var_256_12 = 0

			if var_256_12 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 and not isNil(var_256_11) and arg_253_1.var_.actorSpriteComps10109 == nil then
				arg_253_1.var_.actorSpriteComps10109 = var_256_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_13 = 0.125

			if var_256_12 <= arg_253_1.time_ and arg_253_1.time_ < var_256_12 + var_256_13 and not isNil(var_256_11) then
				local var_256_14 = (arg_253_1.time_ - var_256_12) / var_256_13

				if arg_253_1.var_.actorSpriteComps10109 then
					for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_256_4 then
							if arg_253_1.isInRecall_ then
								local var_256_15 = Mathf.Lerp(iter_256_4.color.r, arg_253_1.hightColor1.r, var_256_14)
								local var_256_16 = Mathf.Lerp(iter_256_4.color.g, arg_253_1.hightColor1.g, var_256_14)
								local var_256_17 = Mathf.Lerp(iter_256_4.color.b, arg_253_1.hightColor1.b, var_256_14)

								iter_256_4.color = Color.New(var_256_15, var_256_16, var_256_17)
							else
								local var_256_18 = Mathf.Lerp(iter_256_4.color.r, 1, var_256_14)

								iter_256_4.color = Color.New(var_256_18, var_256_18, var_256_18)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_12 + var_256_13 and arg_253_1.time_ < var_256_12 + var_256_13 + arg_256_0 and not isNil(var_256_11) and arg_253_1.var_.actorSpriteComps10109 then
				for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_256_6 then
						if arg_253_1.isInRecall_ then
							iter_256_6.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10109 = nil
			end

			local var_256_19 = manager.ui.mainCamera.transform
			local var_256_20 = 0

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				local var_256_21 = arg_253_1.var_.effect2061
				local var_256_22
				local var_256_23 = var_256_19

				if not var_256_21 then
					var_256_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), var_256_23)
					var_256_21.name = "2061"
					arg_253_1.var_.effect2061 = var_256_21
				else
					var_256_21.transform:SetParent(var_256_23)
				end

				var_256_21.transform.localPosition = Vector3.New(0, 0, 0.04)
				var_256_21.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_256_24 = manager.ui.mainCameraCom_
				local var_256_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_256_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_256_26 = var_256_21.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_256_27 = 15
				local var_256_28 = 2 * var_256_27 * Mathf.Tan(var_256_24.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_256_24.aspect
				local var_256_29 = 1
				local var_256_30 = 1.7777777777777777

				if var_256_30 < var_256_24.aspect then
					var_256_29 = var_256_28 / (2 * var_256_27 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_256_30)
				end

				for iter_256_7, iter_256_8 in ipairs(var_256_26) do
					local var_256_31 = iter_256_8.transform.localScale

					iter_256_8.transform.localScale = Vector3.New(var_256_31.x / var_256_25 * var_256_29, var_256_31.y / var_256_25, var_256_31.z)
				end
			end

			local var_256_32 = 0

			if var_256_32 < arg_253_1.time_ and arg_253_1.time_ <= var_256_32 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			local var_256_33 = 0.3

			if arg_253_1.time_ >= var_256_32 + var_256_33 and arg_253_1.time_ < var_256_32 + var_256_33 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_34 = arg_253_1.actors_["10109"]
			local var_256_35 = 0

			if var_256_35 < arg_253_1.time_ and arg_253_1.time_ <= var_256_35 + arg_256_0 then
				local var_256_36 = var_256_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_256_36 then
					arg_253_1.var_.alphaOldValue10109 = var_256_36.alpha
					arg_253_1.var_.characterEffect10109 = var_256_36
				end

				arg_253_1.var_.alphaOldValue10109 = 0
			end

			local var_256_37 = 0.857666666666667

			if var_256_35 <= arg_253_1.time_ and arg_253_1.time_ < var_256_35 + var_256_37 then
				local var_256_38 = (arg_253_1.time_ - var_256_35) / var_256_37
				local var_256_39 = Mathf.Lerp(arg_253_1.var_.alphaOldValue10109, 1, var_256_38)

				if arg_253_1.var_.characterEffect10109 then
					arg_253_1.var_.characterEffect10109.alpha = var_256_39
				end
			end

			if arg_253_1.time_ >= var_256_35 + var_256_37 and arg_253_1.time_ < var_256_35 + var_256_37 + arg_256_0 and arg_253_1.var_.characterEffect10109 then
				arg_253_1.var_.characterEffect10109.alpha = 1
			end

			local var_256_40 = 0.433333333333333
			local var_256_41 = 0.625

			if var_256_40 < arg_253_1.time_ and arg_253_1.time_ <= var_256_40 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_42 = arg_253_1:FormatText(StoryNameCfg[36].name)

				arg_253_1.leftNameTxt_.text = var_256_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_43 = arg_253_1:GetWordFromCfg(416062061)
				local var_256_44 = arg_253_1:FormatText(var_256_43.content)

				arg_253_1.text_.text = var_256_44

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_45 = 25
				local var_256_46 = utf8.len(var_256_44)
				local var_256_47 = var_256_45 <= 0 and var_256_41 or var_256_41 * (var_256_46 / var_256_45)

				if var_256_47 > 0 and var_256_41 < var_256_47 then
					arg_253_1.talkMaxDuration = var_256_47

					if var_256_47 + var_256_40 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_47 + var_256_40
					end
				end

				arg_253_1.text_.text = var_256_44
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062061", "story_v_out_416062.awb") ~= 0 then
					local var_256_48 = manager.audio:GetVoiceLength("story_v_out_416062", "416062061", "story_v_out_416062.awb") / 1000

					if var_256_48 + var_256_40 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_48 + var_256_40
					end

					if var_256_43.prefab_name ~= "" and arg_253_1.actors_[var_256_43.prefab_name] ~= nil then
						local var_256_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_43.prefab_name].transform, "story_v_out_416062", "416062061", "story_v_out_416062.awb")

						arg_253_1:RecordAudio("416062061", var_256_49)
						arg_253_1:RecordAudio("416062061", var_256_49)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_416062", "416062061", "story_v_out_416062.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_416062", "416062061", "story_v_out_416062.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_50 = math.max(var_256_41, arg_253_1.talkMaxDuration)

			if var_256_40 <= arg_253_1.time_ and arg_253_1.time_ < var_256_40 + var_256_50 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_40) / var_256_50

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_40 + var_256_50 and arg_253_1.time_ < var_256_40 + var_256_50 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/I13h"
	},
	voices = {
		"story_v_out_416062.awb"
	}
}
