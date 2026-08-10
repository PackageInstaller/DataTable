return {
	Play416201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416201001
		arg_1_1.duration_ = 9.73

		local var_1_0 = {
			zh = 6.3,
			ja = 9.733
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
				arg_1_0:Play416201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F09f"

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
				local var_4_5 = arg_1_1.bgs_.F09f

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
					if iter_4_0 ~= "F09f" then
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

			local var_4_22 = "1086"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(var_4_23, arg_1_1.canvasGo_.transform)

					var_4_24.transform:SetSiblingIndex(1)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_25) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_26 = arg_1_1.actors_["1086"].transform
			local var_4_27 = 1.76666666666667

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1086 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1086", 3)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(0, -404.2, -237.9)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1086, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_4_33 = arg_1_1.actors_["1086"]
			local var_4_34 = 1.76666666666667

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1086 == nil then
				arg_1_1.var_.actorSpriteComps1086 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.2

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps1086 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_37 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_36)
								local var_4_38 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_36)
								local var_4_39 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_36)

								iter_4_6.color = Color.New(var_4_37, var_4_38, var_4_39)
							else
								local var_4_40 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_36)

								iter_4_6.color = Color.New(var_4_40, var_4_40, var_4_40)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1086 then
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

			local var_4_41 = arg_1_1.actors_["1086"]
			local var_4_42 = 1.76666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_43 then
					arg_1_1.var_.alphaOldValue1086 = var_4_43.alpha
					arg_1_1.var_.characterEffect1086 = var_4_43
				end

				arg_1_1.var_.alphaOldValue1086 = 0
			end

			local var_4_44 = 0.233333333333333

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1086, 1, var_4_45)

				if arg_1_1.var_.characterEffect1086 then
					arg_1_1.var_.characterEffect1086.alpha = var_4_46
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.characterEffect1086 then
				arg_1_1.var_.characterEffect1086.alpha = 1
			end

			local var_4_47 = 0
			local var_4_48 = 0.2

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 0.466666666666667
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.4

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1080].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(416201001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201001", "story_v_out_416201.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_416201", "416201001", "story_v_out_416201.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_416201", "416201001", "story_v_out_416201.awb")

						arg_1_1:RecordAudio("416201001", var_4_69)
						arg_1_1:RecordAudio("416201001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416201", "416201001", "story_v_out_416201.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416201", "416201001", "story_v_out_416201.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416201003(arg_9_1)
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
			local var_12_8 = 1.45

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

				local var_12_9 = arg_9_1:GetWordFromCfg(416201002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 58
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
	Play416201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416201003
		arg_13_1.duration_ = 5.6

		local var_13_0 = {
			zh = 3.533,
			ja = 5.6
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
				arg_13_0:Play416201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1028"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["1028"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1028 == nil then
				arg_13_1.var_.actorSpriteComps1028 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps1028 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1028 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1028 = nil
			end

			local var_16_12 = arg_13_1.actors_["1028"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos1028 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1028", 2)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(-390, -402.7, -156.1)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1028, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_16_19 = 0
			local var_16_20 = 0.375

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[327].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(416201003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 15
				local var_16_25 = utf8.len(var_16_23)
				local var_16_26 = var_16_24 <= 0 and var_16_20 or var_16_20 * (var_16_25 / var_16_24)

				if var_16_26 > 0 and var_16_20 < var_16_26 then
					arg_13_1.talkMaxDuration = var_16_26

					if var_16_26 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_26 + var_16_19
					end
				end

				arg_13_1.text_.text = var_16_23
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201003", "story_v_out_416201.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_416201", "416201003", "story_v_out_416201.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_416201", "416201003", "story_v_out_416201.awb")

						arg_13_1:RecordAudio("416201003", var_16_28)
						arg_13_1:RecordAudio("416201003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416201", "416201003", "story_v_out_416201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416201", "416201003", "story_v_out_416201.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_29 = math.max(var_16_20, arg_13_1.talkMaxDuration)

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_29 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_29

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_29 and arg_13_1.time_ < var_16_19 + var_16_29 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play416201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416201004
		arg_17_1.duration_ = 5.3

		local var_17_0 = {
			zh = 4.366,
			ja = 5.3
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
				arg_17_0:Play416201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1086"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1086 == nil then
				arg_17_1.var_.actorSpriteComps1086 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1086 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1086 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1086 = nil
			end

			local var_20_8 = arg_17_1.actors_["1028"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1028 == nil then
				arg_17_1.var_.actorSpriteComps1028 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1028 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1028 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1028 = nil
			end

			local var_20_16 = arg_17_1.actors_["1086"].transform
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = var_20_16.localPosition
				var_20_16.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 4)

				local var_20_18 = var_20_16.childCount

				for iter_20_8 = 0, var_20_18 - 1 do
					local var_20_19 = var_20_16:GetChild(iter_20_8)

					if var_20_19.name == "" or not string.find(var_20_19.name, "split") then
						var_20_19.gameObject:SetActive(true)
					else
						var_20_19.gameObject:SetActive(false)
					end
				end
			end

			local var_20_20 = 0.001

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_20 then
				local var_20_21 = (arg_17_1.time_ - var_20_17) / var_20_20
				local var_20_22 = Vector3.New(390, -404.2, -237.9)

				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, var_20_22, var_20_21)
			end

			if arg_17_1.time_ >= var_20_17 + var_20_20 and arg_17_1.time_ < var_20_17 + var_20_20 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_20_23 = 0
			local var_20_24 = 0.525

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_25 = arg_17_1:FormatText(StoryNameCfg[1080].name)

				arg_17_1.leftNameTxt_.text = var_20_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_26 = arg_17_1:GetWordFromCfg(416201004)
				local var_20_27 = arg_17_1:FormatText(var_20_26.content)

				arg_17_1.text_.text = var_20_27

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_28 = 21
				local var_20_29 = utf8.len(var_20_27)
				local var_20_30 = var_20_28 <= 0 and var_20_24 or var_20_24 * (var_20_29 / var_20_28)

				if var_20_30 > 0 and var_20_24 < var_20_30 then
					arg_17_1.talkMaxDuration = var_20_30

					if var_20_30 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_30 + var_20_23
					end
				end

				arg_17_1.text_.text = var_20_27
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201004", "story_v_out_416201.awb") ~= 0 then
					local var_20_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201004", "story_v_out_416201.awb") / 1000

					if var_20_31 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_23
					end

					if var_20_26.prefab_name ~= "" and arg_17_1.actors_[var_20_26.prefab_name] ~= nil then
						local var_20_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_26.prefab_name].transform, "story_v_out_416201", "416201004", "story_v_out_416201.awb")

						arg_17_1:RecordAudio("416201004", var_20_32)
						arg_17_1:RecordAudio("416201004", var_20_32)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416201", "416201004", "story_v_out_416201.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416201", "416201004", "story_v_out_416201.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_33 = math.max(var_20_24, arg_17_1.talkMaxDuration)

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_33 and arg_17_1.time_ < var_20_23 + var_20_33 + arg_20_0 then
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
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play416201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416201005
		arg_21_1.duration_ = 3.73

		local var_21_0 = {
			zh = 2.2,
			ja = 3.733
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
				arg_21_0:Play416201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.225

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1080].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(416201005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201005", "story_v_out_416201.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201005", "story_v_out_416201.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_416201", "416201005", "story_v_out_416201.awb")

						arg_21_1:RecordAudio("416201005", var_24_9)
						arg_21_1:RecordAudio("416201005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416201", "416201005", "story_v_out_416201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416201", "416201005", "story_v_out_416201.awb")
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
	Play416201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416201006
		arg_25_1.duration_ = 6.4

		local var_25_0 = {
			zh = 6.1,
			ja = 6.4
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
				arg_25_0:Play416201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1028"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1028 == nil then
				arg_25_1.var_.actorSpriteComps1028 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1028 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1028 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1028 = nil
			end

			local var_28_8 = arg_25_1.actors_["1086"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1086 == nil then
				arg_25_1.var_.actorSpriteComps1086 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps1086 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps1086 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1086 = nil
			end

			local var_28_16 = 0
			local var_28_17 = 0.525

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_18 = arg_25_1:FormatText(StoryNameCfg[327].name)

				arg_25_1.leftNameTxt_.text = var_28_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(416201006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 21
				local var_28_22 = utf8.len(var_28_20)
				local var_28_23 = var_28_21 <= 0 and var_28_17 or var_28_17 * (var_28_22 / var_28_21)

				if var_28_23 > 0 and var_28_17 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201006", "story_v_out_416201.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201006", "story_v_out_416201.awb") / 1000

					if var_28_24 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_416201", "416201006", "story_v_out_416201.awb")

						arg_25_1:RecordAudio("416201006", var_28_25)
						arg_25_1:RecordAudio("416201006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416201", "416201006", "story_v_out_416201.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416201", "416201006", "story_v_out_416201.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_26 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_26

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_26 and arg_25_1.time_ < var_28_16 + var_28_26 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play416201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416201007
		arg_29_1.duration_ = 5.2

		local var_29_0 = {
			zh = 5.2,
			ja = 4.4
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
				arg_29_0:Play416201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.625

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[327].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(416201007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201007", "story_v_out_416201.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201007", "story_v_out_416201.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_416201", "416201007", "story_v_out_416201.awb")

						arg_29_1:RecordAudio("416201007", var_32_9)
						arg_29_1:RecordAudio("416201007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416201", "416201007", "story_v_out_416201.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416201", "416201007", "story_v_out_416201.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416201008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1028"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1028 == nil then
				arg_33_1.var_.actorSpriteComps1028 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1028 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1028 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1028 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 1.35

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(416201008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 54
				local var_36_13 = utf8.len(var_36_11)
				local var_36_14 = var_36_12 <= 0 and var_36_9 or var_36_9 * (var_36_13 / var_36_12)

				if var_36_14 > 0 and var_36_9 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_15 and arg_33_1.time_ < var_36_8 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416201009
		arg_37_1.duration_ = 3.93

		local var_37_0 = {
			zh = 2.6,
			ja = 3.933
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
				arg_37_0:Play416201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1028"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1028 == nil then
				arg_37_1.var_.actorSpriteComps1028 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1028 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1028 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1028 = nil
			end

			local var_40_8 = arg_37_1.actors_["1028"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos1028 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1028", 2)

				local var_40_10 = var_40_8.childCount

				for iter_40_4 = 0, var_40_10 - 1 do
					local var_40_11 = var_40_8:GetChild(iter_40_4)

					if var_40_11.name == "split_2" or not string.find(var_40_11.name, "split") then
						var_40_11.gameObject:SetActive(true)
					else
						var_40_11.gameObject:SetActive(false)
					end
				end
			end

			local var_40_12 = 0.001

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_9) / var_40_12
				local var_40_14 = Vector3.New(-390, -402.7, -156.1)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1028, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_40_15 = 0
			local var_40_16 = 0.175

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[327].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(416201009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201009", "story_v_out_416201.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201009", "story_v_out_416201.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_416201", "416201009", "story_v_out_416201.awb")

						arg_37_1:RecordAudio("416201009", var_40_24)
						arg_37_1:RecordAudio("416201009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416201", "416201009", "story_v_out_416201.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416201", "416201009", "story_v_out_416201.awb")
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
				actorName = "1028",
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
	Play416201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416201010
		arg_41_1.duration_ = 9

		local var_41_0 = {
			zh = 6.333,
			ja = 9
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
				arg_41_0:Play416201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1086"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1086 == nil then
				arg_41_1.var_.actorSpriteComps1086 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1086 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1086 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1086 = nil
			end

			local var_44_8 = arg_41_1.actors_["1028"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.7

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[1080].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(416201010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 28
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201010", "story_v_out_416201.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201010", "story_v_out_416201.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_416201", "416201010", "story_v_out_416201.awb")

						arg_41_1:RecordAudio("416201010", var_44_25)
						arg_41_1:RecordAudio("416201010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416201", "416201010", "story_v_out_416201.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416201", "416201010", "story_v_out_416201.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416201011
		arg_45_1.duration_ = 3.3

		local var_45_0 = {
			zh = 3.033,
			ja = 3.3
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
				arg_45_0:Play416201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.375

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1080].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(416201011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 15
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201011", "story_v_out_416201.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201011", "story_v_out_416201.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_416201", "416201011", "story_v_out_416201.awb")

						arg_45_1:RecordAudio("416201011", var_48_9)
						arg_45_1:RecordAudio("416201011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416201", "416201011", "story_v_out_416201.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416201", "416201011", "story_v_out_416201.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416201012
		arg_49_1.duration_ = 8.23

		local var_49_0 = {
			zh = 4.466,
			ja = 8.233
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
				arg_49_0:Play416201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1028"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1028 == nil then
				arg_49_1.var_.actorSpriteComps1028 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps1028 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1028 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1028 = nil
			end

			local var_52_8 = arg_49_1.actors_["1086"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1086 == nil then
				arg_49_1.var_.actorSpriteComps1086 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps1086 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

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
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1086 = nil
			end

			local var_52_16 = arg_49_1.actors_["1028"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos1028 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1028", 2)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(-390, -402.7, -156.1)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1028, var_52_22, var_52_21)
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_52_23 = 0
			local var_52_24 = 0.55

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[327].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(416201012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201012", "story_v_out_416201.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201012", "story_v_out_416201.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_416201", "416201012", "story_v_out_416201.awb")

						arg_49_1:RecordAudio("416201012", var_52_32)
						arg_49_1:RecordAudio("416201012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416201", "416201012", "story_v_out_416201.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416201", "416201012", "story_v_out_416201.awb")
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
				actorName = "1028",
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
	Play416201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416201013
		arg_53_1.duration_ = 7.27

		local var_53_0 = {
			zh = 3.566,
			ja = 7.266
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
				arg_53_0:Play416201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1086"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1086 == nil then
				arg_53_1.var_.actorSpriteComps1086 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1086 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

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
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1086 = nil
			end

			local var_56_8 = arg_53_1.actors_["1028"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1028 == nil then
				arg_53_1.var_.actorSpriteComps1028 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps1028 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 0.5, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1028 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1028 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 0.375

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_18 = arg_53_1:FormatText(StoryNameCfg[1080].name)

				arg_53_1.leftNameTxt_.text = var_56_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(416201013)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 15
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201013", "story_v_out_416201.awb") ~= 0 then
					local var_56_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201013", "story_v_out_416201.awb") / 1000

					if var_56_24 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_16
					end

					if var_56_19.prefab_name ~= "" and arg_53_1.actors_[var_56_19.prefab_name] ~= nil then
						local var_56_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_19.prefab_name].transform, "story_v_out_416201", "416201013", "story_v_out_416201.awb")

						arg_53_1:RecordAudio("416201013", var_56_25)
						arg_53_1:RecordAudio("416201013", var_56_25)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416201", "416201013", "story_v_out_416201.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416201", "416201013", "story_v_out_416201.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_26 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_26 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_26

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_26 and arg_53_1.time_ < var_56_16 + var_56_26 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416201014
		arg_57_1.duration_ = 4.63

		local var_57_0 = {
			zh = 3.7,
			ja = 4.633
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
				arg_57_0:Play416201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1028"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1028 == nil then
				arg_57_1.var_.actorSpriteComps1028 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1028 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1028 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1028 = nil
			end

			local var_60_8 = arg_57_1.actors_["1086"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1086 == nil then
				arg_57_1.var_.actorSpriteComps1086 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps1086 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1086 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1086 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.55

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[327].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(416201014)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 22
				local var_60_22 = utf8.len(var_60_20)
				local var_60_23 = var_60_21 <= 0 and var_60_17 or var_60_17 * (var_60_22 / var_60_21)

				if var_60_23 > 0 and var_60_17 < var_60_23 then
					arg_57_1.talkMaxDuration = var_60_23

					if var_60_23 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201014", "story_v_out_416201.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201014", "story_v_out_416201.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_416201", "416201014", "story_v_out_416201.awb")

						arg_57_1:RecordAudio("416201014", var_60_25)
						arg_57_1:RecordAudio("416201014", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416201", "416201014", "story_v_out_416201.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416201", "416201014", "story_v_out_416201.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_26 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_26 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_26

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_26 and arg_57_1.time_ < var_60_16 + var_60_26 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416201015
		arg_61_1.duration_ = 4.57

		local var_61_0 = {
			zh = 2.8,
			ja = 4.566
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
				arg_61_0:Play416201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.375

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[327].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(416201015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 15
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201015", "story_v_out_416201.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201015", "story_v_out_416201.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_416201", "416201015", "story_v_out_416201.awb")

						arg_61_1:RecordAudio("416201015", var_64_9)
						arg_61_1:RecordAudio("416201015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416201", "416201015", "story_v_out_416201.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416201", "416201015", "story_v_out_416201.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416201016
		arg_65_1.duration_ = 10.07

		local var_65_0 = {
			zh = 8.833,
			ja = 10.066
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
				arg_65_0:Play416201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1086"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1086 == nil then
				arg_65_1.var_.actorSpriteComps1086 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1086 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1086 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1086 = nil
			end

			local var_68_8 = arg_65_1.actors_["1028"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1028 == nil then
				arg_65_1.var_.actorSpriteComps1028 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps1028 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1028 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1028 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.875

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[1080].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(416201016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201016", "story_v_out_416201.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201016", "story_v_out_416201.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_416201", "416201016", "story_v_out_416201.awb")

						arg_65_1:RecordAudio("416201016", var_68_25)
						arg_65_1:RecordAudio("416201016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416201", "416201016", "story_v_out_416201.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416201", "416201016", "story_v_out_416201.awb")
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
	Play416201017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416201017
		arg_69_1.duration_ = 10

		local var_69_0 = {
			zh = 4.8,
			ja = 10
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
				arg_69_0:Play416201018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1028"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1028 == nil then
				arg_69_1.var_.actorSpriteComps1028 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1028 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1028 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1028 = nil
			end

			local var_72_8 = arg_69_1.actors_["1086"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1086 == nil then
				arg_69_1.var_.actorSpriteComps1086 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps1086 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1086 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1086 = nil
			end

			local var_72_16 = 0
			local var_72_17 = 0.625

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[327].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(416201017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201017", "story_v_out_416201.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201017", "story_v_out_416201.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_416201", "416201017", "story_v_out_416201.awb")

						arg_69_1:RecordAudio("416201017", var_72_25)
						arg_69_1:RecordAudio("416201017", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416201", "416201017", "story_v_out_416201.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416201", "416201017", "story_v_out_416201.awb")
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
	Play416201018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416201018
		arg_73_1.duration_ = 11.43

		local var_73_0 = {
			zh = 5.733,
			ja = 11.433
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
				arg_73_0:Play416201019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.75

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[327].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(416201018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 30
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201018", "story_v_out_416201.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201018", "story_v_out_416201.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_416201", "416201018", "story_v_out_416201.awb")

						arg_73_1:RecordAudio("416201018", var_76_9)
						arg_73_1:RecordAudio("416201018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416201", "416201018", "story_v_out_416201.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416201", "416201018", "story_v_out_416201.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416201019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416201019
		arg_77_1.duration_ = 7.87

		local var_77_0 = {
			zh = 7.566,
			ja = 7.866
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
				arg_77_0:Play416201020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1086"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1086 == nil then
				arg_77_1.var_.actorSpriteComps1086 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1086 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1086 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1086 = nil
			end

			local var_80_8 = arg_77_1.actors_["1028"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1028 == nil then
				arg_77_1.var_.actorSpriteComps1028 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps1028 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1028 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1028 = nil
			end

			local var_80_16 = arg_77_1.actors_["1086"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos1086 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1086", 4)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "split_5" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(390, -404.2, -237.9)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1086, var_80_22, var_80_21)
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_80_23 = 0
			local var_80_24 = 0.425

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[1080].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(416201019)
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201019", "story_v_out_416201.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201019", "story_v_out_416201.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_416201", "416201019", "story_v_out_416201.awb")

						arg_77_1:RecordAudio("416201019", var_80_32)
						arg_77_1:RecordAudio("416201019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416201", "416201019", "story_v_out_416201.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416201", "416201019", "story_v_out_416201.awb")
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
				actorName = "1086",
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
	Play416201020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416201020
		arg_81_1.duration_ = 5.8

		local var_81_0 = {
			zh = 5.8,
			ja = 3.266
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
				arg_81_0:Play416201021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1028"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1028 == nil then
				arg_81_1.var_.actorSpriteComps1028 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1028 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1028 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1028 = nil
			end

			local var_84_8 = arg_81_1.actors_["1086"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1086 == nil then
				arg_81_1.var_.actorSpriteComps1086 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps1086 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1086 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1086 = nil
			end

			local var_84_16 = arg_81_1.actors_["1028"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos1028 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1028", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_6" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-390, -402.7, -156.1)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1028, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_84_23 = 0
			local var_84_24 = 0.475

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[327].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(416201020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201020", "story_v_out_416201.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201020", "story_v_out_416201.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_416201", "416201020", "story_v_out_416201.awb")

						arg_81_1:RecordAudio("416201020", var_84_32)
						arg_81_1:RecordAudio("416201020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416201", "416201020", "story_v_out_416201.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416201", "416201020", "story_v_out_416201.awb")
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
				actorName = "1028",
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
	Play416201021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416201021
		arg_85_1.duration_ = 7.73

		local var_85_0 = {
			zh = 7.266,
			ja = 7.733
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
				arg_85_0:Play416201022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.775

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[327].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(416201021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201021", "story_v_out_416201.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201021", "story_v_out_416201.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_416201", "416201021", "story_v_out_416201.awb")

						arg_85_1:RecordAudio("416201021", var_88_9)
						arg_85_1:RecordAudio("416201021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416201", "416201021", "story_v_out_416201.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416201", "416201021", "story_v_out_416201.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play416201022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416201022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 3.4,
			ja = 4.4
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
				arg_89_0:Play416201023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1086"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1086 == nil then
				arg_89_1.var_.actorSpriteComps1086 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps1086 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1086 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1086 = nil
			end

			local var_92_8 = arg_89_1.actors_["1028"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1028 == nil then
				arg_89_1.var_.actorSpriteComps1028 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps1028 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1028 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1028 = nil
			end

			local var_92_16 = arg_89_1.actors_["1086"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos1086 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1086", 4)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "split_1" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(390, -404.2, -237.9)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1086, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_92_23 = 0
			local var_92_24 = 0.3

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[1080].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(416201022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 12
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201022", "story_v_out_416201.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201022", "story_v_out_416201.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_416201", "416201022", "story_v_out_416201.awb")

						arg_89_1:RecordAudio("416201022", var_92_32)
						arg_89_1:RecordAudio("416201022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416201", "416201022", "story_v_out_416201.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416201", "416201022", "story_v_out_416201.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play416201023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416201023
		arg_93_1.duration_ = 7.47

		local var_93_0 = {
			zh = 5.666,
			ja = 7.466
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
				arg_93_0:Play416201024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1028"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1028 == nil then
				arg_93_1.var_.actorSpriteComps1028 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1028 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1028 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1028 = nil
			end

			local var_96_8 = arg_93_1.actors_["1086"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1086 == nil then
				arg_93_1.var_.actorSpriteComps1086 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps1086 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 0.5, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1086 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1086 = nil
			end

			local var_96_16 = 0
			local var_96_17 = 0.625

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_18 = arg_93_1:FormatText(StoryNameCfg[327].name)

				arg_93_1.leftNameTxt_.text = var_96_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:GetWordFromCfg(416201023)
				local var_96_20 = arg_93_1:FormatText(var_96_19.content)

				arg_93_1.text_.text = var_96_20

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 25
				local var_96_22 = utf8.len(var_96_20)
				local var_96_23 = var_96_21 <= 0 and var_96_17 or var_96_17 * (var_96_22 / var_96_21)

				if var_96_23 > 0 and var_96_17 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23

					if var_96_23 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_20
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201023", "story_v_out_416201.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201023", "story_v_out_416201.awb") / 1000

					if var_96_24 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_16
					end

					if var_96_19.prefab_name ~= "" and arg_93_1.actors_[var_96_19.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_19.prefab_name].transform, "story_v_out_416201", "416201023", "story_v_out_416201.awb")

						arg_93_1:RecordAudio("416201023", var_96_25)
						arg_93_1:RecordAudio("416201023", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416201", "416201023", "story_v_out_416201.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416201", "416201023", "story_v_out_416201.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_26 and arg_93_1.time_ < var_96_16 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416201024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416201024
		arg_97_1.duration_ = 6

		local var_97_0 = {
			zh = 3.833,
			ja = 6
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
				arg_97_0:Play416201025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.475

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[327].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(416201024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201024", "story_v_out_416201.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201024", "story_v_out_416201.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_416201", "416201024", "story_v_out_416201.awb")

						arg_97_1:RecordAudio("416201024", var_100_9)
						arg_97_1:RecordAudio("416201024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416201", "416201024", "story_v_out_416201.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416201", "416201024", "story_v_out_416201.awb")
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
	Play416201025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416201025
		arg_101_1.duration_ = 5.57

		local var_101_0 = {
			zh = 5.566,
			ja = 5.266
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
				arg_101_0:Play416201026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1028"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1028 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1028", 2)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "split_6" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(-390, -402.7, -156.1)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1028, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_104_7 = 0
			local var_104_8 = 0.65

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_9 = arg_101_1:FormatText(StoryNameCfg[327].name)

				arg_101_1.leftNameTxt_.text = var_104_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(416201025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 26
				local var_104_13 = utf8.len(var_104_11)
				local var_104_14 = var_104_12 <= 0 and var_104_8 or var_104_8 * (var_104_13 / var_104_12)

				if var_104_14 > 0 and var_104_8 < var_104_14 then
					arg_101_1.talkMaxDuration = var_104_14

					if var_104_14 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201025", "story_v_out_416201.awb") ~= 0 then
					local var_104_15 = manager.audio:GetVoiceLength("story_v_out_416201", "416201025", "story_v_out_416201.awb") / 1000

					if var_104_15 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_7
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_416201", "416201025", "story_v_out_416201.awb")

						arg_101_1:RecordAudio("416201025", var_104_16)
						arg_101_1:RecordAudio("416201025", var_104_16)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416201", "416201025", "story_v_out_416201.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416201", "416201025", "story_v_out_416201.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_17 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_17 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_17

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_17 and arg_101_1.time_ < var_104_7 + var_104_17 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play416201026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416201026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play416201027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1028"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1028 == nil then
				arg_105_1.var_.actorSpriteComps1028 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1028 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1028 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1028 = nil
			end

			local var_108_8 = arg_105_1.actors_["1028"].transform
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.var_.moveOldPos1028 = var_108_8.localPosition
				var_108_8.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1028", 7)

				local var_108_10 = var_108_8.childCount

				for iter_108_4 = 0, var_108_10 - 1 do
					local var_108_11 = var_108_8:GetChild(iter_108_4)

					if var_108_11.name == "" or not string.find(var_108_11.name, "split") then
						var_108_11.gameObject:SetActive(true)
					else
						var_108_11.gameObject:SetActive(false)
					end
				end
			end

			local var_108_12 = 0.001

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_9) / var_108_12
				local var_108_14 = Vector3.New(0, -2000, 0)

				var_108_8.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1028, var_108_14, var_108_13)
			end

			if arg_105_1.time_ >= var_108_9 + var_108_12 and arg_105_1.time_ < var_108_9 + var_108_12 + arg_108_0 then
				var_108_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_15 = arg_105_1.actors_["1086"].transform
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.var_.moveOldPos1086 = var_108_15.localPosition
				var_108_15.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1086", 7)

				local var_108_17 = var_108_15.childCount

				for iter_108_5 = 0, var_108_17 - 1 do
					local var_108_18 = var_108_15:GetChild(iter_108_5)

					if var_108_18.name == "" or not string.find(var_108_18.name, "split") then
						var_108_18.gameObject:SetActive(true)
					else
						var_108_18.gameObject:SetActive(false)
					end
				end
			end

			local var_108_19 = 0.001

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_19 then
				local var_108_20 = (arg_105_1.time_ - var_108_16) / var_108_19
				local var_108_21 = Vector3.New(0, -2000, 0)

				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1086, var_108_21, var_108_20)
			end

			if arg_105_1.time_ >= var_108_16 + var_108_19 and arg_105_1.time_ < var_108_16 + var_108_19 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_22 = 0
			local var_108_23 = 0.9

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_24 = arg_105_1:GetWordFromCfg(416201026)
				local var_108_25 = arg_105_1:FormatText(var_108_24.content)

				arg_105_1.text_.text = var_108_25

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_26 = 36
				local var_108_27 = utf8.len(var_108_25)
				local var_108_28 = var_108_26 <= 0 and var_108_23 or var_108_23 * (var_108_27 / var_108_26)

				if var_108_28 > 0 and var_108_23 < var_108_28 then
					arg_105_1.talkMaxDuration = var_108_28

					if var_108_28 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_28 + var_108_22
					end
				end

				arg_105_1.text_.text = var_108_25
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_29 = math.max(var_108_23, arg_105_1.talkMaxDuration)

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_29 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_29

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_29 and arg_105_1.time_ < var_108_22 + var_108_29 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play416201027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416201027
		arg_109_1.duration_ = 5.13

		local var_109_0 = {
			zh = 4.9,
			ja = 5.133
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
				arg_109_0:Play416201028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1028"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1028 == nil then
				arg_109_1.var_.actorSpriteComps1028 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1028 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1028 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1028 = nil
			end

			local var_112_8 = arg_109_1.actors_["1028"].transform
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 then
				arg_109_1.var_.moveOldPos1028 = var_112_8.localPosition
				var_112_8.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1028", 3)

				local var_112_10 = var_112_8.childCount

				for iter_112_4 = 0, var_112_10 - 1 do
					local var_112_11 = var_112_8:GetChild(iter_112_4)

					if var_112_11.name == "split_6" or not string.find(var_112_11.name, "split") then
						var_112_11.gameObject:SetActive(true)
					else
						var_112_11.gameObject:SetActive(false)
					end
				end
			end

			local var_112_12 = 0.001

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_12 then
				local var_112_13 = (arg_109_1.time_ - var_112_9) / var_112_12
				local var_112_14 = Vector3.New(0, -402.7, -156.1)

				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1028, var_112_14, var_112_13)
			end

			if arg_109_1.time_ >= var_112_9 + var_112_12 and arg_109_1.time_ < var_112_9 + var_112_12 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_112_15 = 0
			local var_112_16 = 0.4

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[327].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(416201027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 16
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201027", "story_v_out_416201.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201027", "story_v_out_416201.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_416201", "416201027", "story_v_out_416201.awb")

						arg_109_1:RecordAudio("416201027", var_112_24)
						arg_109_1:RecordAudio("416201027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416201", "416201027", "story_v_out_416201.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416201", "416201027", "story_v_out_416201.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play416201028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416201028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play416201029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1028"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1028 == nil then
				arg_113_1.var_.actorSpriteComps1028 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1028 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

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
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1028 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 1.125

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(416201028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 45
				local var_116_13 = utf8.len(var_116_11)
				local var_116_14 = var_116_12 <= 0 and var_116_9 or var_116_9 * (var_116_13 / var_116_12)

				if var_116_14 > 0 and var_116_9 < var_116_14 then
					arg_113_1.talkMaxDuration = var_116_14

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_15 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_15 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_15

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_15 and arg_113_1.time_ < var_116_8 + var_116_15 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play416201029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416201029
		arg_117_1.duration_ = 3.77

		local var_117_0 = {
			zh = 3.766,
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
				arg_117_0:Play416201030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1086"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1086 == nil then
				arg_117_1.var_.actorSpriteComps1086 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps1086 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1086 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1086 = nil
			end

			local var_120_8 = arg_117_1.actors_["1086"].transform
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.var_.moveOldPos1086 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1086", 4)

				local var_120_10 = var_120_8.childCount

				for iter_120_4 = 0, var_120_10 - 1 do
					local var_120_11 = var_120_8:GetChild(iter_120_4)

					if var_120_11.name == "" or not string.find(var_120_11.name, "split") then
						var_120_11.gameObject:SetActive(true)
					else
						var_120_11.gameObject:SetActive(false)
					end
				end
			end

			local var_120_12 = 0.001

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_12 then
				local var_120_13 = (arg_117_1.time_ - var_120_9) / var_120_12
				local var_120_14 = Vector3.New(390, -404.2, -237.9)

				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1086, var_120_14, var_120_13)
			end

			if arg_117_1.time_ >= var_120_9 + var_120_12 and arg_117_1.time_ < var_120_9 + var_120_12 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_120_15 = arg_117_1.actors_["1028"].transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.var_.moveOldPos1028 = var_120_15.localPosition
				var_120_15.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1028", 2)

				local var_120_17 = var_120_15.childCount

				for iter_120_5 = 0, var_120_17 - 1 do
					local var_120_18 = var_120_15:GetChild(iter_120_5)

					if var_120_18.name == "split_6" or not string.find(var_120_18.name, "split") then
						var_120_18.gameObject:SetActive(true)
					else
						var_120_18.gameObject:SetActive(false)
					end
				end
			end

			local var_120_19 = 0.001

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_19 then
				local var_120_20 = (arg_117_1.time_ - var_120_16) / var_120_19
				local var_120_21 = Vector3.New(-390, -402.7, -156.1)

				var_120_15.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1028, var_120_21, var_120_20)
			end

			if arg_117_1.time_ >= var_120_16 + var_120_19 and arg_117_1.time_ < var_120_16 + var_120_19 + arg_120_0 then
				var_120_15.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_120_22 = 0
			local var_120_23 = 0.375

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_24 = arg_117_1:FormatText(StoryNameCfg[1080].name)

				arg_117_1.leftNameTxt_.text = var_120_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:GetWordFromCfg(416201029)
				local var_120_26 = arg_117_1:FormatText(var_120_25.content)

				arg_117_1.text_.text = var_120_26

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_27 = 15
				local var_120_28 = utf8.len(var_120_26)
				local var_120_29 = var_120_27 <= 0 and var_120_23 or var_120_23 * (var_120_28 / var_120_27)

				if var_120_29 > 0 and var_120_23 < var_120_29 then
					arg_117_1.talkMaxDuration = var_120_29

					if var_120_29 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_26
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201029", "story_v_out_416201.awb") ~= 0 then
					local var_120_30 = manager.audio:GetVoiceLength("story_v_out_416201", "416201029", "story_v_out_416201.awb") / 1000

					if var_120_30 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_22
					end

					if var_120_25.prefab_name ~= "" and arg_117_1.actors_[var_120_25.prefab_name] ~= nil then
						local var_120_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_25.prefab_name].transform, "story_v_out_416201", "416201029", "story_v_out_416201.awb")

						arg_117_1:RecordAudio("416201029", var_120_31)
						arg_117_1:RecordAudio("416201029", var_120_31)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416201", "416201029", "story_v_out_416201.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416201", "416201029", "story_v_out_416201.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_32 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 <= arg_117_1.time_ and arg_117_1.time_ < var_120_22 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_22) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_22 + var_120_32 and arg_117_1.time_ < var_120_22 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play416201030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416201030
		arg_121_1.duration_ = 6.5

		local var_121_0 = {
			zh = 4.933,
			ja = 6.5
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
				arg_121_0:Play416201031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1028"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1028 == nil then
				arg_121_1.var_.actorSpriteComps1028 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps1028 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1028 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1028 = nil
			end

			local var_124_8 = arg_121_1.actors_["1086"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1086 == nil then
				arg_121_1.var_.actorSpriteComps1086 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_10 = 0.2

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 and not isNil(var_124_8) then
				local var_124_11 = (arg_121_1.time_ - var_124_9) / var_124_10

				if arg_121_1.var_.actorSpriteComps1086 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1086 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_124_7 then
						if arg_121_1.isInRecall_ then
							iter_124_7.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1086 = nil
			end

			local var_124_16 = 0
			local var_124_17 = 0.425

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_18 = arg_121_1:FormatText(StoryNameCfg[327].name)

				arg_121_1.leftNameTxt_.text = var_124_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_19 = arg_121_1:GetWordFromCfg(416201030)
				local var_124_20 = arg_121_1:FormatText(var_124_19.content)

				arg_121_1.text_.text = var_124_20

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 17
				local var_124_22 = utf8.len(var_124_20)
				local var_124_23 = var_124_21 <= 0 and var_124_17 or var_124_17 * (var_124_22 / var_124_21)

				if var_124_23 > 0 and var_124_17 < var_124_23 then
					arg_121_1.talkMaxDuration = var_124_23

					if var_124_23 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_16
					end
				end

				arg_121_1.text_.text = var_124_20
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201030", "story_v_out_416201.awb") ~= 0 then
					local var_124_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201030", "story_v_out_416201.awb") / 1000

					if var_124_24 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_24 + var_124_16
					end

					if var_124_19.prefab_name ~= "" and arg_121_1.actors_[var_124_19.prefab_name] ~= nil then
						local var_124_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_19.prefab_name].transform, "story_v_out_416201", "416201030", "story_v_out_416201.awb")

						arg_121_1:RecordAudio("416201030", var_124_25)
						arg_121_1:RecordAudio("416201030", var_124_25)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416201", "416201030", "story_v_out_416201.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416201", "416201030", "story_v_out_416201.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_26 = math.max(var_124_17, arg_121_1.talkMaxDuration)

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_26 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_16) / var_124_26

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_16 + var_124_26 and arg_121_1.time_ < var_124_16 + var_124_26 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play416201031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416201031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play416201032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1028"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1028 == nil then
				arg_125_1.var_.actorSpriteComps1028 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps1028 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1028 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1028 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 1.375

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(416201031)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_12 = 55
				local var_128_13 = utf8.len(var_128_11)
				local var_128_14 = var_128_12 <= 0 and var_128_9 or var_128_9 * (var_128_13 / var_128_12)

				if var_128_14 > 0 and var_128_9 < var_128_14 then
					arg_125_1.talkMaxDuration = var_128_14

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_15 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_15 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_15

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_15 and arg_125_1.time_ < var_128_8 + var_128_15 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play416201032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416201032
		arg_129_1.duration_ = 5.57

		local var_129_0 = {
			zh = 5.566,
			ja = 4.1
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
				arg_129_0:Play416201033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1086"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1086 == nil then
				arg_129_1.var_.actorSpriteComps1086 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps1086 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1086 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1086 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.575

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_10 = arg_129_1:FormatText(StoryNameCfg[1080].name)

				arg_129_1.leftNameTxt_.text = var_132_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_11 = arg_129_1:GetWordFromCfg(416201032)
				local var_132_12 = arg_129_1:FormatText(var_132_11.content)

				arg_129_1.text_.text = var_132_12

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 23
				local var_132_14 = utf8.len(var_132_12)
				local var_132_15 = var_132_13 <= 0 and var_132_9 or var_132_9 * (var_132_14 / var_132_13)

				if var_132_15 > 0 and var_132_9 < var_132_15 then
					arg_129_1.talkMaxDuration = var_132_15

					if var_132_15 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_12
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201032", "story_v_out_416201.awb") ~= 0 then
					local var_132_16 = manager.audio:GetVoiceLength("story_v_out_416201", "416201032", "story_v_out_416201.awb") / 1000

					if var_132_16 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_8
					end

					if var_132_11.prefab_name ~= "" and arg_129_1.actors_[var_132_11.prefab_name] ~= nil then
						local var_132_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_11.prefab_name].transform, "story_v_out_416201", "416201032", "story_v_out_416201.awb")

						arg_129_1:RecordAudio("416201032", var_132_17)
						arg_129_1:RecordAudio("416201032", var_132_17)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416201", "416201032", "story_v_out_416201.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416201", "416201032", "story_v_out_416201.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_18 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_18 and arg_129_1.time_ < var_132_8 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416201033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416201033
		arg_133_1.duration_ = 4.57

		local var_133_0 = {
			zh = 4.566,
			ja = 4.266
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
				arg_133_0:Play416201034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1028"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps1028 == nil then
				arg_133_1.var_.actorSpriteComps1028 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps1028 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 1, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps1028 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1028 = nil
			end

			local var_136_8 = arg_133_1.actors_["1086"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps1086 == nil then
				arg_133_1.var_.actorSpriteComps1086 = var_136_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_10 = 0.2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.actorSpriteComps1086 then
					for iter_136_4, iter_136_5 in pairs(arg_133_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_136_5 then
							if arg_133_1.isInRecall_ then
								local var_136_12 = Mathf.Lerp(iter_136_5.color.r, arg_133_1.hightColor2.r, var_136_11)
								local var_136_13 = Mathf.Lerp(iter_136_5.color.g, arg_133_1.hightColor2.g, var_136_11)
								local var_136_14 = Mathf.Lerp(iter_136_5.color.b, arg_133_1.hightColor2.b, var_136_11)

								iter_136_5.color = Color.New(var_136_12, var_136_13, var_136_14)
							else
								local var_136_15 = Mathf.Lerp(iter_136_5.color.r, 0.5, var_136_11)

								iter_136_5.color = Color.New(var_136_15, var_136_15, var_136_15)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps1086 then
				for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_136_7 then
						if arg_133_1.isInRecall_ then
							iter_136_7.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1086 = nil
			end

			local var_136_16 = 0
			local var_136_17 = 0.3

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_18 = arg_133_1:FormatText(StoryNameCfg[327].name)

				arg_133_1.leftNameTxt_.text = var_136_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_19 = arg_133_1:GetWordFromCfg(416201033)
				local var_136_20 = arg_133_1:FormatText(var_136_19.content)

				arg_133_1.text_.text = var_136_20

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_21 = 12
				local var_136_22 = utf8.len(var_136_20)
				local var_136_23 = var_136_21 <= 0 and var_136_17 or var_136_17 * (var_136_22 / var_136_21)

				if var_136_23 > 0 and var_136_17 < var_136_23 then
					arg_133_1.talkMaxDuration = var_136_23

					if var_136_23 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_16
					end
				end

				arg_133_1.text_.text = var_136_20
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201033", "story_v_out_416201.awb") ~= 0 then
					local var_136_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201033", "story_v_out_416201.awb") / 1000

					if var_136_24 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_24 + var_136_16
					end

					if var_136_19.prefab_name ~= "" and arg_133_1.actors_[var_136_19.prefab_name] ~= nil then
						local var_136_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_19.prefab_name].transform, "story_v_out_416201", "416201033", "story_v_out_416201.awb")

						arg_133_1:RecordAudio("416201033", var_136_25)
						arg_133_1:RecordAudio("416201033", var_136_25)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416201", "416201033", "story_v_out_416201.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416201", "416201033", "story_v_out_416201.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_26 = math.max(var_136_17, arg_133_1.talkMaxDuration)

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_26 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_16) / var_136_26

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_16 + var_136_26 and arg_133_1.time_ < var_136_16 + var_136_26 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play416201034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416201034
		arg_137_1.duration_ = 6.27

		local var_137_0 = {
			zh = 6.266,
			ja = 6.1
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
				arg_137_0:Play416201035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1086"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1086 == nil then
				arg_137_1.var_.actorSpriteComps1086 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1086 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1086 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1086 = nil
			end

			local var_140_8 = arg_137_1.actors_["1028"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1028 == nil then
				arg_137_1.var_.actorSpriteComps1028 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps1028 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								local var_140_12 = Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, var_140_11)
								local var_140_13 = Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, var_140_11)
								local var_140_14 = Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, var_140_11)

								iter_140_5.color = Color.New(var_140_12, var_140_13, var_140_14)
							else
								local var_140_15 = Mathf.Lerp(iter_140_5.color.r, 0.5, var_140_11)

								iter_140_5.color = Color.New(var_140_15, var_140_15, var_140_15)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1028 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1028 = nil
			end

			local var_140_16 = arg_137_1.actors_["1086"].transform
			local var_140_17 = 0

			if var_140_17 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 then
				arg_137_1.var_.moveOldPos1086 = var_140_16.localPosition
				var_140_16.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1086", 4)

				local var_140_18 = var_140_16.childCount

				for iter_140_8 = 0, var_140_18 - 1 do
					local var_140_19 = var_140_16:GetChild(iter_140_8)

					if var_140_19.name == "split_2" or not string.find(var_140_19.name, "split") then
						var_140_19.gameObject:SetActive(true)
					else
						var_140_19.gameObject:SetActive(false)
					end
				end
			end

			local var_140_20 = 0.001

			if var_140_17 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_20 then
				local var_140_21 = (arg_137_1.time_ - var_140_17) / var_140_20
				local var_140_22 = Vector3.New(390, -404.2, -237.9)

				var_140_16.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1086, var_140_22, var_140_21)
			end

			if arg_137_1.time_ >= var_140_17 + var_140_20 and arg_137_1.time_ < var_140_17 + var_140_20 + arg_140_0 then
				var_140_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_140_23 = 0
			local var_140_24 = 0.675

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_25 = arg_137_1:FormatText(StoryNameCfg[1080].name)

				arg_137_1.leftNameTxt_.text = var_140_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_26 = arg_137_1:GetWordFromCfg(416201034)
				local var_140_27 = arg_137_1:FormatText(var_140_26.content)

				arg_137_1.text_.text = var_140_27

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_28 = 27
				local var_140_29 = utf8.len(var_140_27)
				local var_140_30 = var_140_28 <= 0 and var_140_24 or var_140_24 * (var_140_29 / var_140_28)

				if var_140_30 > 0 and var_140_24 < var_140_30 then
					arg_137_1.talkMaxDuration = var_140_30

					if var_140_30 + var_140_23 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_30 + var_140_23
					end
				end

				arg_137_1.text_.text = var_140_27
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201034", "story_v_out_416201.awb") ~= 0 then
					local var_140_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201034", "story_v_out_416201.awb") / 1000

					if var_140_31 + var_140_23 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_31 + var_140_23
					end

					if var_140_26.prefab_name ~= "" and arg_137_1.actors_[var_140_26.prefab_name] ~= nil then
						local var_140_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_26.prefab_name].transform, "story_v_out_416201", "416201034", "story_v_out_416201.awb")

						arg_137_1:RecordAudio("416201034", var_140_32)
						arg_137_1:RecordAudio("416201034", var_140_32)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416201", "416201034", "story_v_out_416201.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416201", "416201034", "story_v_out_416201.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_33 = math.max(var_140_24, arg_137_1.talkMaxDuration)

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_33 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_23) / var_140_33

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_23 + var_140_33 and arg_137_1.time_ < var_140_23 + var_140_33 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play416201035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416201035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416201036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1086"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1086 == nil then
				arg_141_1.var_.actorSpriteComps1086 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps1086 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1086 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1086 = nil
			end

			local var_144_8 = arg_141_1.actors_["1028"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos1028 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1028", 7)

				local var_144_10 = var_144_8.childCount

				for iter_144_4 = 0, var_144_10 - 1 do
					local var_144_11 = var_144_8:GetChild(iter_144_4)

					if var_144_11.name == "" or not string.find(var_144_11.name, "split") then
						var_144_11.gameObject:SetActive(true)
					else
						var_144_11.gameObject:SetActive(false)
					end
				end
			end

			local var_144_12 = 0.001

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_9) / var_144_12
				local var_144_14 = Vector3.New(0, -2000, 0)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1028, var_144_14, var_144_13)
			end

			if arg_141_1.time_ >= var_144_9 + var_144_12 and arg_141_1.time_ < var_144_9 + var_144_12 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_15 = arg_141_1.actors_["1086"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos1086 = var_144_15.localPosition
				var_144_15.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1086", 7)

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
				local var_144_21 = Vector3.New(0, -2000, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1086, var_144_21, var_144_20)
			end

			if arg_141_1.time_ >= var_144_16 + var_144_19 and arg_141_1.time_ < var_144_16 + var_144_19 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_22 = 0
			local var_144_23 = 1.475

			if var_144_22 < arg_141_1.time_ and arg_141_1.time_ <= var_144_22 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_24 = arg_141_1:GetWordFromCfg(416201035)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 59
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_23 or var_144_23 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_23 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28

					if var_144_28 + var_144_22 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_22
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_29 = math.max(var_144_23, arg_141_1.talkMaxDuration)

			if var_144_22 <= arg_141_1.time_ and arg_141_1.time_ < var_144_22 + var_144_29 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_22) / var_144_29

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_22 + var_144_29 and arg_141_1.time_ < var_144_22 + var_144_29 + arg_144_0 then
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
	Play416201036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416201036
		arg_145_1.duration_ = 7.97

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play416201037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "I13i"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 1.33333333333333

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.I13i

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "I13i" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_16 = 1.33333333333333

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_17 = 0.3

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_18 = 0

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_19 = 1.33333333333333

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_19 then
				local var_148_20 = (arg_145_1.time_ - var_148_18) / var_148_19
				local var_148_21 = Color.New(0, 0, 0)

				var_148_21.a = Mathf.Lerp(0, 1, var_148_20)
				arg_145_1.mask_.color = var_148_21
			end

			if arg_145_1.time_ >= var_148_18 + var_148_19 and arg_145_1.time_ < var_148_18 + var_148_19 + arg_148_0 then
				local var_148_22 = Color.New(0, 0, 0)

				var_148_22.a = 1
				arg_145_1.mask_.color = var_148_22
			end

			local var_148_23 = 1.33333333333333

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_24 = 2

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24
				local var_148_26 = Color.New(0, 0, 0)

				var_148_26.a = Mathf.Lerp(1, 0, var_148_25)
				arg_145_1.mask_.color = var_148_26
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 then
				local var_148_27 = Color.New(0, 0, 0)
				local var_148_28 = 0

				arg_145_1.mask_.enabled = false
				var_148_27.a = var_148_28
				arg_145_1.mask_.color = var_148_27
			end

			local var_148_29 = 0
			local var_148_30 = 0.2

			if var_148_29 < arg_145_1.time_ and arg_145_1.time_ <= var_148_29 + arg_148_0 then
				local var_148_31 = "play"
				local var_148_32 = "music"

				arg_145_1:AudioAction(var_148_31, var_148_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_148_33 = ""
				local var_148_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_148_34 ~= "" then
					if arg_145_1.bgmTxt_.text ~= var_148_34 and arg_145_1.bgmTxt_.text ~= "" then
						if arg_145_1.bgmTxt2_.text ~= "" then
							arg_145_1.bgmTxt_.text = arg_145_1.bgmTxt2_.text
						end

						arg_145_1.bgmTxt2_.text = var_148_34

						arg_145_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_145_1.bgmTxt_.text = var_148_34
						arg_145_1.bgmTxt2_.text = var_148_34
					end

					if arg_145_1.bgmTimer then
						arg_145_1.bgmTimer:Stop()

						arg_145_1.bgmTimer = nil
					end

					if arg_145_1.settingData.show_music_name == 1 then
						arg_145_1.musicController:SetSelectedState("show")
						arg_145_1.musicAnimator_:Play("open", 0, 0)

						if arg_145_1.settingData.music_time ~= 0 then
							arg_145_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_145_1.settingData.music_time), function()
								if arg_145_1 == nil or isNil(arg_145_1.bgmTxt_) then
									return
								end

								arg_145_1.musicController:SetSelectedState("hide")
								arg_145_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_148_35 = 0.466666666666667
			local var_148_36 = 1

			if var_148_35 < arg_145_1.time_ and arg_145_1.time_ <= var_148_35 + arg_148_0 then
				local var_148_37 = "play"
				local var_148_38 = "music"

				arg_145_1:AudioAction(var_148_37, var_148_38, "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_148_39 = ""
				local var_148_40 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if var_148_40 ~= "" then
					if arg_145_1.bgmTxt_.text ~= var_148_40 and arg_145_1.bgmTxt_.text ~= "" then
						if arg_145_1.bgmTxt2_.text ~= "" then
							arg_145_1.bgmTxt_.text = arg_145_1.bgmTxt2_.text
						end

						arg_145_1.bgmTxt2_.text = var_148_40

						arg_145_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_145_1.bgmTxt_.text = var_148_40
						arg_145_1.bgmTxt2_.text = var_148_40
					end

					if arg_145_1.bgmTimer then
						arg_145_1.bgmTimer:Stop()

						arg_145_1.bgmTimer = nil
					end

					if arg_145_1.settingData.show_music_name == 1 then
						arg_145_1.musicController:SetSelectedState("show")
						arg_145_1.musicAnimator_:Play("open", 0, 0)

						if arg_145_1.settingData.music_time ~= 0 then
							arg_145_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_145_1.settingData.music_time), function()
								if arg_145_1 == nil or isNil(arg_145_1.bgmTxt_) then
									return
								end

								arg_145_1.musicController:SetSelectedState("hide")
								arg_145_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_41 = 2.96666666666667
			local var_148_42 = 1.5

			if var_148_41 < arg_145_1.time_ and arg_145_1.time_ <= var_148_41 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_43 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_43:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_145_1.dialogCg_.alpha = arg_151_0
				end))
				var_148_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_44 = arg_145_1:GetWordFromCfg(416201036)
				local var_148_45 = arg_145_1:FormatText(var_148_44.content)

				arg_145_1.text_.text = var_148_45

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_46 = 60
				local var_148_47 = utf8.len(var_148_45)
				local var_148_48 = var_148_46 <= 0 and var_148_42 or var_148_42 * (var_148_47 / var_148_46)

				if var_148_48 > 0 and var_148_42 < var_148_48 then
					arg_145_1.talkMaxDuration = var_148_48
					var_148_41 = var_148_41 + 0.3

					if var_148_48 + var_148_41 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_48 + var_148_41
					end
				end

				arg_145_1.text_.text = var_148_45
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_49 = var_148_41 + 0.3
			local var_148_50 = math.max(var_148_42, arg_145_1.talkMaxDuration)

			if var_148_49 <= arg_145_1.time_ and arg_145_1.time_ < var_148_49 + var_148_50 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_49) / var_148_50

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_49 + var_148_50 and arg_145_1.time_ < var_148_49 + var_148_50 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416201037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416201037
		arg_153_1.duration_ = 5.67

		local var_153_0 = {
			zh = 3.766,
			ja = 5.666
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
				arg_153_0:Play416201038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "10127"

			if arg_153_1.actors_[var_156_0] == nil then
				local var_156_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_156_1) then
					local var_156_2 = Object.Instantiate(var_156_1, arg_153_1.canvasGo_.transform)

					var_156_2.transform:SetSiblingIndex(1)

					var_156_2.name = var_156_0
					var_156_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_153_1.actors_[var_156_0] = var_156_2

					local var_156_3 = var_156_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_153_1.isInRecall_ then
						for iter_156_0, iter_156_1 in ipairs(var_156_3) do
							iter_156_1.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_156_4 = arg_153_1.actors_["10127"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.actorSpriteComps10127 == nil then
				arg_153_1.var_.actorSpriteComps10127 = var_156_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.2

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.actorSpriteComps10127 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								local var_156_8 = Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, var_156_7)
								local var_156_9 = Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, var_156_7)
								local var_156_10 = Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, var_156_7)

								iter_156_3.color = Color.New(var_156_8, var_156_9, var_156_10)
							else
								local var_156_11 = Mathf.Lerp(iter_156_3.color.r, 1, var_156_7)

								iter_156_3.color = Color.New(var_156_11, var_156_11, var_156_11)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.actorSpriteComps10127 then
				for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_156_5 then
						if arg_153_1.isInRecall_ then
							iter_156_5.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10127 = nil
			end

			local var_156_12 = arg_153_1.actors_["10127"].transform
			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1.var_.moveOldPos10127 = var_156_12.localPosition
				var_156_12.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10127", 3)

				local var_156_14 = var_156_12.childCount

				for iter_156_6 = 0, var_156_14 - 1 do
					local var_156_15 = var_156_12:GetChild(iter_156_6)

					if var_156_15.name == "" or not string.find(var_156_15.name, "split") then
						var_156_15.gameObject:SetActive(true)
					else
						var_156_15.gameObject:SetActive(false)
					end
				end
			end

			local var_156_16 = 0.001

			if var_156_13 <= arg_153_1.time_ and arg_153_1.time_ < var_156_13 + var_156_16 then
				local var_156_17 = (arg_153_1.time_ - var_156_13) / var_156_16
				local var_156_18 = Vector3.New(0, -387.4, -316.5)

				var_156_12.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10127, var_156_18, var_156_17)
			end

			if arg_153_1.time_ >= var_156_13 + var_156_16 and arg_153_1.time_ < var_156_13 + var_156_16 + arg_156_0 then
				var_156_12.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_156_19 = 0
			local var_156_20 = 0.4

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_21 = arg_153_1:FormatText(StoryNameCfg[236].name)

				arg_153_1.leftNameTxt_.text = var_156_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_22 = arg_153_1:GetWordFromCfg(416201037)
				local var_156_23 = arg_153_1:FormatText(var_156_22.content)

				arg_153_1.text_.text = var_156_23

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_24 = 16
				local var_156_25 = utf8.len(var_156_23)
				local var_156_26 = var_156_24 <= 0 and var_156_20 or var_156_20 * (var_156_25 / var_156_24)

				if var_156_26 > 0 and var_156_20 < var_156_26 then
					arg_153_1.talkMaxDuration = var_156_26

					if var_156_26 + var_156_19 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_26 + var_156_19
					end
				end

				arg_153_1.text_.text = var_156_23
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201037", "story_v_out_416201.awb") ~= 0 then
					local var_156_27 = manager.audio:GetVoiceLength("story_v_out_416201", "416201037", "story_v_out_416201.awb") / 1000

					if var_156_27 + var_156_19 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_27 + var_156_19
					end

					if var_156_22.prefab_name ~= "" and arg_153_1.actors_[var_156_22.prefab_name] ~= nil then
						local var_156_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_22.prefab_name].transform, "story_v_out_416201", "416201037", "story_v_out_416201.awb")

						arg_153_1:RecordAudio("416201037", var_156_28)
						arg_153_1:RecordAudio("416201037", var_156_28)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416201", "416201037", "story_v_out_416201.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416201", "416201037", "story_v_out_416201.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_29 = math.max(var_156_20, arg_153_1.talkMaxDuration)

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_29 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_19) / var_156_29

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_19 + var_156_29 and arg_153_1.time_ < var_156_19 + var_156_29 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play416201038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416201038
		arg_157_1.duration_ = 11.97

		local var_157_0 = {
			zh = 6.4,
			ja = 11.966
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
				arg_157_0:Play416201039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = "10109"

			if arg_157_1.actors_[var_160_0] == nil then
				local var_160_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_160_1) then
					local var_160_2 = Object.Instantiate(var_160_1, arg_157_1.canvasGo_.transform)

					var_160_2.transform:SetSiblingIndex(1)

					var_160_2.name = var_160_0
					var_160_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_[var_160_0] = var_160_2

					local var_160_3 = var_160_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_157_1.isInRecall_ then
						for iter_160_0, iter_160_1 in ipairs(var_160_3) do
							iter_160_1.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_4 = arg_157_1.actors_["10109"]
			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.actorSpriteComps10109 == nil then
				arg_157_1.var_.actorSpriteComps10109 = var_160_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 0.2

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 and not isNil(var_160_4) then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6

				if arg_157_1.var_.actorSpriteComps10109 then
					for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_160_3 then
							if arg_157_1.isInRecall_ then
								local var_160_8 = Mathf.Lerp(iter_160_3.color.r, arg_157_1.hightColor1.r, var_160_7)
								local var_160_9 = Mathf.Lerp(iter_160_3.color.g, arg_157_1.hightColor1.g, var_160_7)
								local var_160_10 = Mathf.Lerp(iter_160_3.color.b, arg_157_1.hightColor1.b, var_160_7)

								iter_160_3.color = Color.New(var_160_8, var_160_9, var_160_10)
							else
								local var_160_11 = Mathf.Lerp(iter_160_3.color.r, 1, var_160_7)

								iter_160_3.color = Color.New(var_160_11, var_160_11, var_160_11)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.actorSpriteComps10109 then
				for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_160_5 then
						if arg_157_1.isInRecall_ then
							iter_160_5.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10109 = nil
			end

			local var_160_12 = arg_157_1.actors_["10127"]
			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 and not isNil(var_160_12) and arg_157_1.var_.actorSpriteComps10127 == nil then
				arg_157_1.var_.actorSpriteComps10127 = var_160_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_14 = 0.2

			if var_160_13 <= arg_157_1.time_ and arg_157_1.time_ < var_160_13 + var_160_14 and not isNil(var_160_12) then
				local var_160_15 = (arg_157_1.time_ - var_160_13) / var_160_14

				if arg_157_1.var_.actorSpriteComps10127 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								local var_160_16 = Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, var_160_15)
								local var_160_17 = Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, var_160_15)
								local var_160_18 = Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, var_160_15)

								iter_160_7.color = Color.New(var_160_16, var_160_17, var_160_18)
							else
								local var_160_19 = Mathf.Lerp(iter_160_7.color.r, 0.5, var_160_15)

								iter_160_7.color = Color.New(var_160_19, var_160_19, var_160_19)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_13 + var_160_14 and arg_157_1.time_ < var_160_13 + var_160_14 + arg_160_0 and not isNil(var_160_12) and arg_157_1.var_.actorSpriteComps10127 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_160_9 then
						if arg_157_1.isInRecall_ then
							iter_160_9.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10127 = nil
			end

			local var_160_20 = arg_157_1.actors_["10127"].transform
			local var_160_21 = 0

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.var_.moveOldPos10127 = var_160_20.localPosition
				var_160_20.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10127", 7)

				local var_160_22 = var_160_20.childCount

				for iter_160_10 = 0, var_160_22 - 1 do
					local var_160_23 = var_160_20:GetChild(iter_160_10)

					if var_160_23.name == "" or not string.find(var_160_23.name, "split") then
						var_160_23.gameObject:SetActive(true)
					else
						var_160_23.gameObject:SetActive(false)
					end
				end
			end

			local var_160_24 = 0.001

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_24 then
				local var_160_25 = (arg_157_1.time_ - var_160_21) / var_160_24
				local var_160_26 = Vector3.New(0, -2000, 0)

				var_160_20.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10127, var_160_26, var_160_25)
			end

			if arg_157_1.time_ >= var_160_21 + var_160_24 and arg_157_1.time_ < var_160_21 + var_160_24 + arg_160_0 then
				var_160_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_27 = arg_157_1.actors_["10109"].transform
			local var_160_28 = 0

			if var_160_28 < arg_157_1.time_ and arg_157_1.time_ <= var_160_28 + arg_160_0 then
				arg_157_1.var_.moveOldPos10109 = var_160_27.localPosition
				var_160_27.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10109", 3)

				local var_160_29 = var_160_27.childCount

				for iter_160_11 = 0, var_160_29 - 1 do
					local var_160_30 = var_160_27:GetChild(iter_160_11)

					if var_160_30.name == "" or not string.find(var_160_30.name, "split") then
						var_160_30.gameObject:SetActive(true)
					else
						var_160_30.gameObject:SetActive(false)
					end
				end
			end

			local var_160_31 = 0.001

			if var_160_28 <= arg_157_1.time_ and arg_157_1.time_ < var_160_28 + var_160_31 then
				local var_160_32 = (arg_157_1.time_ - var_160_28) / var_160_31
				local var_160_33 = Vector3.New(0, -346.2, -395)

				var_160_27.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10109, var_160_33, var_160_32)
			end

			if arg_157_1.time_ >= var_160_28 + var_160_31 and arg_157_1.time_ < var_160_28 + var_160_31 + arg_160_0 then
				var_160_27.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_160_34 = 0
			local var_160_35 = 0.375

			if var_160_34 < arg_157_1.time_ and arg_157_1.time_ <= var_160_34 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_36 = arg_157_1:FormatText(StoryNameCfg[36].name)

				arg_157_1.leftNameTxt_.text = var_160_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_37 = arg_157_1:GetWordFromCfg(416201038)
				local var_160_38 = arg_157_1:FormatText(var_160_37.content)

				arg_157_1.text_.text = var_160_38

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_39 = 15
				local var_160_40 = utf8.len(var_160_38)
				local var_160_41 = var_160_39 <= 0 and var_160_35 or var_160_35 * (var_160_40 / var_160_39)

				if var_160_41 > 0 and var_160_35 < var_160_41 then
					arg_157_1.talkMaxDuration = var_160_41

					if var_160_41 + var_160_34 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_41 + var_160_34
					end
				end

				arg_157_1.text_.text = var_160_38
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201038", "story_v_out_416201.awb") ~= 0 then
					local var_160_42 = manager.audio:GetVoiceLength("story_v_out_416201", "416201038", "story_v_out_416201.awb") / 1000

					if var_160_42 + var_160_34 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_42 + var_160_34
					end

					if var_160_37.prefab_name ~= "" and arg_157_1.actors_[var_160_37.prefab_name] ~= nil then
						local var_160_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_37.prefab_name].transform, "story_v_out_416201", "416201038", "story_v_out_416201.awb")

						arg_157_1:RecordAudio("416201038", var_160_43)
						arg_157_1:RecordAudio("416201038", var_160_43)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416201", "416201038", "story_v_out_416201.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416201", "416201038", "story_v_out_416201.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_44 = math.max(var_160_35, arg_157_1.talkMaxDuration)

			if var_160_34 <= arg_157_1.time_ and arg_157_1.time_ < var_160_34 + var_160_44 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_34) / var_160_44

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_34 + var_160_44 and arg_157_1.time_ < var_160_34 + var_160_44 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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
				actorName = "10109",
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
	Play416201039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416201039
		arg_161_1.duration_ = 7.67

		local var_161_0 = {
			zh = 3.666,
			ja = 7.666
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
				arg_161_0:Play416201040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10127"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10127 == nil then
				arg_161_1.var_.actorSpriteComps10127 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10127 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10127 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10127 = nil
			end

			local var_164_8 = arg_161_1.actors_["10109"]
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10109 == nil then
				arg_161_1.var_.actorSpriteComps10109 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_10 = 0.2

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 and not isNil(var_164_8) then
				local var_164_11 = (arg_161_1.time_ - var_164_9) / var_164_10

				if arg_161_1.var_.actorSpriteComps10109 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10109 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_164_7 then
						if arg_161_1.isInRecall_ then
							iter_164_7.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10109 = nil
			end

			local var_164_16 = arg_161_1.actors_["10127"].transform
			local var_164_17 = 0

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.var_.moveOldPos10127 = var_164_16.localPosition
				var_164_16.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10127", 3)

				local var_164_18 = var_164_16.childCount

				for iter_164_8 = 0, var_164_18 - 1 do
					local var_164_19 = var_164_16:GetChild(iter_164_8)

					if var_164_19.name == "split_6" or not string.find(var_164_19.name, "split") then
						var_164_19.gameObject:SetActive(true)
					else
						var_164_19.gameObject:SetActive(false)
					end
				end
			end

			local var_164_20 = 0.001

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_20 then
				local var_164_21 = (arg_161_1.time_ - var_164_17) / var_164_20
				local var_164_22 = Vector3.New(0, -387.4, -316.5)

				var_164_16.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10127, var_164_22, var_164_21)
			end

			if arg_161_1.time_ >= var_164_17 + var_164_20 and arg_161_1.time_ < var_164_17 + var_164_20 + arg_164_0 then
				var_164_16.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_164_23 = arg_161_1.actors_["10109"].transform
			local var_164_24 = 0

			if var_164_24 < arg_161_1.time_ and arg_161_1.time_ <= var_164_24 + arg_164_0 then
				arg_161_1.var_.moveOldPos10109 = var_164_23.localPosition
				var_164_23.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10109", 7)

				local var_164_25 = var_164_23.childCount

				for iter_164_9 = 0, var_164_25 - 1 do
					local var_164_26 = var_164_23:GetChild(iter_164_9)

					if var_164_26.name == "" or not string.find(var_164_26.name, "split") then
						var_164_26.gameObject:SetActive(true)
					else
						var_164_26.gameObject:SetActive(false)
					end
				end
			end

			local var_164_27 = 0.001

			if var_164_24 <= arg_161_1.time_ and arg_161_1.time_ < var_164_24 + var_164_27 then
				local var_164_28 = (arg_161_1.time_ - var_164_24) / var_164_27
				local var_164_29 = Vector3.New(0, -2000, 0)

				var_164_23.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10109, var_164_29, var_164_28)
			end

			if arg_161_1.time_ >= var_164_24 + var_164_27 and arg_161_1.time_ < var_164_24 + var_164_27 + arg_164_0 then
				var_164_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_30 = 0
			local var_164_31 = 0.45

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[236].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_33 = arg_161_1:GetWordFromCfg(416201039)
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201039", "story_v_out_416201.awb") ~= 0 then
					local var_164_38 = manager.audio:GetVoiceLength("story_v_out_416201", "416201039", "story_v_out_416201.awb") / 1000

					if var_164_38 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_38 + var_164_30
					end

					if var_164_33.prefab_name ~= "" and arg_161_1.actors_[var_164_33.prefab_name] ~= nil then
						local var_164_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_33.prefab_name].transform, "story_v_out_416201", "416201039", "story_v_out_416201.awb")

						arg_161_1:RecordAudio("416201039", var_164_39)
						arg_161_1:RecordAudio("416201039", var_164_39)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416201", "416201039", "story_v_out_416201.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416201", "416201039", "story_v_out_416201.awb")
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
				actorName = "10109",
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
	Play416201040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416201040
		arg_165_1.duration_ = 6.17

		local var_165_0 = {
			zh = 6.1,
			ja = 6.166
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
				arg_165_0:Play416201041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.675

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[236].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(416201040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201040", "story_v_out_416201.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201040", "story_v_out_416201.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_416201", "416201040", "story_v_out_416201.awb")

						arg_165_1:RecordAudio("416201040", var_168_9)
						arg_165_1:RecordAudio("416201040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416201", "416201040", "story_v_out_416201.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416201", "416201040", "story_v_out_416201.awb")
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
	Play416201041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416201041
		arg_169_1.duration_ = 6.23

		local var_169_0 = {
			zh = 5.3,
			ja = 6.233
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
				arg_169_0:Play416201042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10109"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10109 == nil then
				arg_169_1.var_.actorSpriteComps10109 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps10109 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10109 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10109 = nil
			end

			local var_172_8 = arg_169_1.actors_["10127"]
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10127 == nil then
				arg_169_1.var_.actorSpriteComps10127 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_10 = 0.2

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 and not isNil(var_172_8) then
				local var_172_11 = (arg_169_1.time_ - var_172_9) / var_172_10

				if arg_169_1.var_.actorSpriteComps10127 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10127 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_172_7 then
						if arg_169_1.isInRecall_ then
							iter_172_7.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10127 = nil
			end

			local var_172_16 = arg_169_1.actors_["10127"].transform
			local var_172_17 = 0

			if var_172_17 < arg_169_1.time_ and arg_169_1.time_ <= var_172_17 + arg_172_0 then
				arg_169_1.var_.moveOldPos10127 = var_172_16.localPosition
				var_172_16.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10127", 7)

				local var_172_18 = var_172_16.childCount

				for iter_172_8 = 0, var_172_18 - 1 do
					local var_172_19 = var_172_16:GetChild(iter_172_8)

					if var_172_19.name == "" or not string.find(var_172_19.name, "split") then
						var_172_19.gameObject:SetActive(true)
					else
						var_172_19.gameObject:SetActive(false)
					end
				end
			end

			local var_172_20 = 0.001

			if var_172_17 <= arg_169_1.time_ and arg_169_1.time_ < var_172_17 + var_172_20 then
				local var_172_21 = (arg_169_1.time_ - var_172_17) / var_172_20
				local var_172_22 = Vector3.New(0, -2000, 0)

				var_172_16.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10127, var_172_22, var_172_21)
			end

			if arg_169_1.time_ >= var_172_17 + var_172_20 and arg_169_1.time_ < var_172_17 + var_172_20 + arg_172_0 then
				var_172_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_23 = arg_169_1.actors_["10109"].transform
			local var_172_24 = 0

			if var_172_24 < arg_169_1.time_ and arg_169_1.time_ <= var_172_24 + arg_172_0 then
				arg_169_1.var_.moveOldPos10109 = var_172_23.localPosition
				var_172_23.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10109", 3)

				local var_172_25 = var_172_23.childCount

				for iter_172_9 = 0, var_172_25 - 1 do
					local var_172_26 = var_172_23:GetChild(iter_172_9)

					if var_172_26.name == "" or not string.find(var_172_26.name, "split") then
						var_172_26.gameObject:SetActive(true)
					else
						var_172_26.gameObject:SetActive(false)
					end
				end
			end

			local var_172_27 = 0.001

			if var_172_24 <= arg_169_1.time_ and arg_169_1.time_ < var_172_24 + var_172_27 then
				local var_172_28 = (arg_169_1.time_ - var_172_24) / var_172_27
				local var_172_29 = Vector3.New(0, -346.2, -395)

				var_172_23.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10109, var_172_29, var_172_28)
			end

			if arg_169_1.time_ >= var_172_24 + var_172_27 and arg_169_1.time_ < var_172_24 + var_172_27 + arg_172_0 then
				var_172_23.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_172_30 = 0
			local var_172_31 = 0.45

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_32 = arg_169_1:FormatText(StoryNameCfg[36].name)

				arg_169_1.leftNameTxt_.text = var_172_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_33 = arg_169_1:GetWordFromCfg(416201041)
				local var_172_34 = arg_169_1:FormatText(var_172_33.content)

				arg_169_1.text_.text = var_172_34

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_35 = 18
				local var_172_36 = utf8.len(var_172_34)
				local var_172_37 = var_172_35 <= 0 and var_172_31 or var_172_31 * (var_172_36 / var_172_35)

				if var_172_37 > 0 and var_172_31 < var_172_37 then
					arg_169_1.talkMaxDuration = var_172_37

					if var_172_37 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_37 + var_172_30
					end
				end

				arg_169_1.text_.text = var_172_34
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201041", "story_v_out_416201.awb") ~= 0 then
					local var_172_38 = manager.audio:GetVoiceLength("story_v_out_416201", "416201041", "story_v_out_416201.awb") / 1000

					if var_172_38 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_38 + var_172_30
					end

					if var_172_33.prefab_name ~= "" and arg_169_1.actors_[var_172_33.prefab_name] ~= nil then
						local var_172_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_33.prefab_name].transform, "story_v_out_416201", "416201041", "story_v_out_416201.awb")

						arg_169_1:RecordAudio("416201041", var_172_39)
						arg_169_1:RecordAudio("416201041", var_172_39)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416201", "416201041", "story_v_out_416201.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416201", "416201041", "story_v_out_416201.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_40 = math.max(var_172_31, arg_169_1.talkMaxDuration)

			if var_172_30 <= arg_169_1.time_ and arg_169_1.time_ < var_172_30 + var_172_40 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_30) / var_172_40

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_30 + var_172_40 and arg_169_1.time_ < var_172_30 + var_172_40 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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
				actorName = "10109",
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
	Play416201042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416201042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416201043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10109"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10109 == nil then
				arg_173_1.var_.actorSpriteComps10109 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10109 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10109 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10109 = nil
			end

			local var_176_8 = arg_173_1.actors_["10109"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos10109 = var_176_8.localPosition
				var_176_8.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10109", 7)

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

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10109, var_176_14, var_176_13)
			end

			if arg_173_1.time_ >= var_176_9 + var_176_12 and arg_173_1.time_ < var_176_9 + var_176_12 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_176_15 = 0
			local var_176_16 = 1.825

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

				local var_176_17 = arg_173_1:GetWordFromCfg(416201042)
				local var_176_18 = arg_173_1:FormatText(var_176_17.content)

				arg_173_1.text_.text = var_176_18

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_19 = 73
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
				actorName = "10109",
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
	Play416201043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416201043
		arg_177_1.duration_ = 5.63

		local var_177_0 = {
			zh = 3.166,
			ja = 5.633
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
				arg_177_0:Play416201044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10109"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10109 == nil then
				arg_177_1.var_.actorSpriteComps10109 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10109 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10109 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10109 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 0.275

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_10 = arg_177_1:FormatText(StoryNameCfg[36].name)

				arg_177_1.leftNameTxt_.text = var_180_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_11 = arg_177_1:GetWordFromCfg(416201043)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 11
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_9 or var_180_9 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_9 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201043", "story_v_out_416201.awb") ~= 0 then
					local var_180_16 = manager.audio:GetVoiceLength("story_v_out_416201", "416201043", "story_v_out_416201.awb") / 1000

					if var_180_16 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_8
					end

					if var_180_11.prefab_name ~= "" and arg_177_1.actors_[var_180_11.prefab_name] ~= nil then
						local var_180_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_11.prefab_name].transform, "story_v_out_416201", "416201043", "story_v_out_416201.awb")

						arg_177_1:RecordAudio("416201043", var_180_17)
						arg_177_1:RecordAudio("416201043", var_180_17)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416201", "416201043", "story_v_out_416201.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416201", "416201043", "story_v_out_416201.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_18 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_18 and arg_177_1.time_ < var_180_8 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416201044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416201044
		arg_181_1.duration_ = 5.87

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play416201045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10109"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10109 == nil then
				arg_181_1.var_.actorSpriteComps10109 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10109 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10109 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10109 = nil
			end

			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_9 = 0.2

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9
				local var_184_11 = Color.New(1, 1, 1)

				var_184_11.a = Mathf.Lerp(1, 0, var_184_10)
				arg_181_1.mask_.color = var_184_11
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 then
				local var_184_12 = Color.New(1, 1, 1)
				local var_184_13 = 0

				arg_181_1.mask_.enabled = false
				var_184_12.a = var_184_13
				arg_181_1.mask_.color = var_184_12
			end

			local var_184_14 = 0.2

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_15 = 0.433333333333333

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15
				local var_184_17 = Color.New(1, 1, 1)

				var_184_17.a = Mathf.Lerp(1, 0, var_184_16)
				arg_181_1.mask_.color = var_184_17
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 then
				local var_184_18 = Color.New(1, 1, 1)
				local var_184_19 = 0

				arg_181_1.mask_.enabled = false
				var_184_18.a = var_184_19
				arg_181_1.mask_.color = var_184_18
			end

			local var_184_20 = manager.ui.mainCamera.transform
			local var_184_21 = 0.333333333333333

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.var_.shakeOldPos = var_184_20.localPosition
			end

			local var_184_22 = 0.666666666666667

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_22 then
				local var_184_23 = (arg_181_1.time_ - var_184_21) / 0.066
				local var_184_24, var_184_25 = math.modf(var_184_23)

				var_184_20.localPosition = Vector3.New(var_184_25 * 0.13, var_184_25 * 0.13, var_184_25 * 0.13) + arg_181_1.var_.shakeOldPos
			end

			if arg_181_1.time_ >= var_184_21 + var_184_22 and arg_181_1.time_ < var_184_21 + var_184_22 + arg_184_0 then
				var_184_20.localPosition = arg_181_1.var_.shakeOldPos
			end

			local var_184_26 = 0
			local var_184_27 = 1

			if var_184_26 < arg_181_1.time_ and arg_181_1.time_ <= var_184_26 + arg_184_0 then
				local var_184_28 = "play"
				local var_184_29 = "effect"

				arg_181_1:AudioAction(var_184_28, var_184_29, "se_story_139", "se_story_139_monstersmash01", "")
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_30 = 0.866666666666667
			local var_184_31 = 1.4

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_32 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_32:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(416201044)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 56
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37
					var_184_30 = var_184_30 + 0.3

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_38 = var_184_30 + 0.3
			local var_184_39 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_38 <= arg_181_1.time_ and arg_181_1.time_ < var_184_38 + var_184_39 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_38) / var_184_39

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_38 + var_184_39 and arg_181_1.time_ < var_184_38 + var_184_39 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play416201045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416201045
		arg_187_1.duration_ = 7.63

		local var_187_0 = {
			zh = 3.3,
			ja = 7.633
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
				arg_187_0:Play416201046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.4

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[236].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(416201045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201045", "story_v_out_416201.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201045", "story_v_out_416201.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_416201", "416201045", "story_v_out_416201.awb")

						arg_187_1:RecordAudio("416201045", var_190_9)
						arg_187_1:RecordAudio("416201045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416201", "416201045", "story_v_out_416201.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416201", "416201045", "story_v_out_416201.awb")
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
	Play416201046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416201046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play416201047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.425

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(416201046)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 57
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play416201047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416201047
		arg_195_1.duration_ = 4.83

		local var_195_0 = {
			zh = 3.666,
			ja = 4.833
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
				arg_195_0:Play416201048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.375

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[236].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(416201047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201047", "story_v_out_416201.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201047", "story_v_out_416201.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_416201", "416201047", "story_v_out_416201.awb")

						arg_195_1:RecordAudio("416201047", var_198_9)
						arg_195_1:RecordAudio("416201047", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416201", "416201047", "story_v_out_416201.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416201", "416201047", "story_v_out_416201.awb")
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
	Play416201048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416201048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play416201049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.875

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(416201048)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 75
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416201049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416201049
		arg_203_1.duration_ = 10.63

		local var_203_0 = {
			zh = 6.133,
			ja = 10.633
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
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416201050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.825

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[236].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(416201049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201049", "story_v_out_416201.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201049", "story_v_out_416201.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_416201", "416201049", "story_v_out_416201.awb")

						arg_203_1:RecordAudio("416201049", var_206_9)
						arg_203_1:RecordAudio("416201049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416201", "416201049", "story_v_out_416201.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416201", "416201049", "story_v_out_416201.awb")
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
	Play416201050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416201050
		arg_207_1.duration_ = 5.73

		local var_207_0 = {
			zh = 3.6,
			ja = 5.733
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
				arg_207_0:Play416201051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.45

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[236].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(416201050)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 18
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201050", "story_v_out_416201.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201050", "story_v_out_416201.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_416201", "416201050", "story_v_out_416201.awb")

						arg_207_1:RecordAudio("416201050", var_210_9)
						arg_207_1:RecordAudio("416201050", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416201", "416201050", "story_v_out_416201.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416201", "416201050", "story_v_out_416201.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play416201051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416201051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play416201052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.55

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(416201051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 62
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play416201052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416201052
		arg_215_1.duration_ = 5.2

		local var_215_0 = {
			zh = 5.2,
			ja = 4.866
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
				arg_215_0:Play416201053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.425

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[36].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(416201052)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201052", "story_v_out_416201.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201052", "story_v_out_416201.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_416201", "416201052", "story_v_out_416201.awb")

						arg_215_1:RecordAudio("416201052", var_218_9)
						arg_215_1:RecordAudio("416201052", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416201", "416201052", "story_v_out_416201.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416201", "416201052", "story_v_out_416201.awb")
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
	Play416201053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416201053
		arg_219_1.duration_ = 5.57

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416201054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = manager.ui.mainCamera.transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				local var_222_2 = arg_219_1.var_.effect887
				local var_222_3
				local var_222_4 = var_222_0

				if not var_222_2 then
					var_222_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_222_4)
					var_222_2.name = "887"
					arg_219_1.var_.effect887 = var_222_2
				else
					var_222_2.transform:SetParent(var_222_4)
				end

				var_222_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_222_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_6 = 0.733333333333333

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_7 = 0.1
			local var_222_8 = 1

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				local var_222_9 = "play"
				local var_222_10 = "effect"

				arg_219_1:AudioAction(var_222_9, var_222_10, "se_story_139", "se_story_139_monstersmash02", "")
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_11 = 0.566666666666667
			local var_222_12 = 1.9

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_13 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_13:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:GetWordFromCfg(416201053)
				local var_222_15 = arg_219_1:FormatText(var_222_14.content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_16 = 76
				local var_222_17 = utf8.len(var_222_15)
				local var_222_18 = var_222_16 <= 0 and var_222_12 or var_222_12 * (var_222_17 / var_222_16)

				if var_222_18 > 0 and var_222_12 < var_222_18 then
					arg_219_1.talkMaxDuration = var_222_18
					var_222_11 = var_222_11 + 0.3

					if var_222_18 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_11
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_19 = var_222_11 + 0.3
			local var_222_20 = math.max(var_222_12, arg_219_1.talkMaxDuration)

			if var_222_19 <= arg_219_1.time_ and arg_219_1.time_ < var_222_19 + var_222_20 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_19) / var_222_20

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_19 + var_222_20 and arg_219_1.time_ < var_222_19 + var_222_20 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play416201054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 416201054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play416201055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.175

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(416201054)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 47
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play416201055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 416201055
		arg_229_1.duration_ = 9.19

		local var_229_0 = {
			zh = 7.391,
			ja = 9.191
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
				arg_229_0:Play416201056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = "STblack"

			if arg_229_1.bgs_[var_232_0] == nil then
				local var_232_1 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_232_0)
				var_232_1.name = var_232_0
				var_232_1.transform.parent = arg_229_1.stage_.transform
				var_232_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_[var_232_0] = var_232_1
			end

			local var_232_2 = 1.1

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				local var_232_3 = manager.ui.mainCamera.transform.localPosition
				local var_232_4 = Vector3.New(0, 0, 10) + Vector3.New(var_232_3.x, var_232_3.y, 0)
				local var_232_5 = arg_229_1.bgs_.STblack

				var_232_5.transform.localPosition = var_232_4
				var_232_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_6 = var_232_5:GetComponent("SpriteRenderer")

				if var_232_6 and var_232_6.sprite then
					local var_232_7 = (var_232_5.transform.localPosition - var_232_3).z
					local var_232_8 = manager.ui.mainCameraCom_
					local var_232_9 = 2 * var_232_7 * Mathf.Tan(var_232_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_10 = var_232_9 * var_232_8.aspect
					local var_232_11 = var_232_6.sprite.bounds.size.x
					local var_232_12 = var_232_6.sprite.bounds.size.y
					local var_232_13 = var_232_10 / var_232_11
					local var_232_14 = var_232_9 / var_232_12
					local var_232_15 = var_232_14 < var_232_13 and var_232_13 or var_232_14

					var_232_5.transform.localScale = Vector3.New(var_232_15, var_232_15, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "STblack" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_16 = 1.1

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_17 = 0.3

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_18 = 0

			if var_232_18 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_19 = 1.2

			if var_232_18 <= arg_229_1.time_ and arg_229_1.time_ < var_232_18 + var_232_19 then
				local var_232_20 = (arg_229_1.time_ - var_232_18) / var_232_19
				local var_232_21 = Color.New(0, 0, 0)

				var_232_21.a = Mathf.Lerp(0, 1, var_232_20)
				arg_229_1.mask_.color = var_232_21
			end

			if arg_229_1.time_ >= var_232_18 + var_232_19 and arg_229_1.time_ < var_232_18 + var_232_19 + arg_232_0 then
				local var_232_22 = Color.New(0, 0, 0)

				var_232_22.a = 1
				arg_229_1.mask_.color = var_232_22
			end

			local var_232_23 = 1.2

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_24 = 2

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_24 then
				local var_232_25 = (arg_229_1.time_ - var_232_23) / var_232_24
				local var_232_26 = Color.New(0, 0, 0)

				var_232_26.a = Mathf.Lerp(1, 0, var_232_25)
				arg_229_1.mask_.color = var_232_26
			end

			if arg_229_1.time_ >= var_232_23 + var_232_24 and arg_229_1.time_ < var_232_23 + var_232_24 + arg_232_0 then
				local var_232_27 = Color.New(0, 0, 0)
				local var_232_28 = 0

				arg_229_1.mask_.enabled = false
				var_232_27.a = var_232_28
				arg_229_1.mask_.color = var_232_27
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_29 = 2.125
			local var_232_30 = 0.475

			if var_232_29 < arg_229_1.time_ and arg_229_1.time_ <= var_232_29 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_31 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_31:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_32 = arg_229_1:FormatText(StoryNameCfg[36].name)

				arg_229_1.leftNameTxt_.text = var_232_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_33 = arg_229_1:GetWordFromCfg(416201055)
				local var_232_34 = arg_229_1:FormatText(var_232_33.content)

				arg_229_1.text_.text = var_232_34

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_35 = 19
				local var_232_36 = utf8.len(var_232_34)
				local var_232_37 = var_232_35 <= 0 and var_232_30 or var_232_30 * (var_232_36 / var_232_35)

				if var_232_37 > 0 and var_232_30 < var_232_37 then
					arg_229_1.talkMaxDuration = var_232_37
					var_232_29 = var_232_29 + 0.3

					if var_232_37 + var_232_29 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_37 + var_232_29
					end
				end

				arg_229_1.text_.text = var_232_34
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201055", "story_v_out_416201.awb") ~= 0 then
					local var_232_38 = manager.audio:GetVoiceLength("story_v_out_416201", "416201055", "story_v_out_416201.awb") / 1000

					if var_232_38 + var_232_29 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_38 + var_232_29
					end

					if var_232_33.prefab_name ~= "" and arg_229_1.actors_[var_232_33.prefab_name] ~= nil then
						local var_232_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_33.prefab_name].transform, "story_v_out_416201", "416201055", "story_v_out_416201.awb")

						arg_229_1:RecordAudio("416201055", var_232_39)
						arg_229_1:RecordAudio("416201055", var_232_39)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_416201", "416201055", "story_v_out_416201.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_416201", "416201055", "story_v_out_416201.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_40 = var_232_29 + 0.3
			local var_232_41 = math.max(var_232_30, arg_229_1.talkMaxDuration)

			if var_232_40 <= arg_229_1.time_ and arg_229_1.time_ < var_232_40 + var_232_41 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_40) / var_232_41

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_40 + var_232_41 and arg_229_1.time_ < var_232_40 + var_232_41 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play416201056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416201056
		arg_235_1.duration_ = 4.3

		local var_235_0 = {
			zh = 3.1,
			ja = 4.3
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
				arg_235_0:Play416201057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.275

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[36].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(416201056)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201056", "story_v_out_416201.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201056", "story_v_out_416201.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_416201", "416201056", "story_v_out_416201.awb")

						arg_235_1:RecordAudio("416201056", var_238_9)
						arg_235_1:RecordAudio("416201056", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416201", "416201056", "story_v_out_416201.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416201", "416201056", "story_v_out_416201.awb")
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
	Play416201057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416201057
		arg_239_1.duration_ = 7.33

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play416201058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				local var_242_1 = manager.ui.mainCamera.transform.localPosition
				local var_242_2 = Vector3.New(0, 0, 10) + Vector3.New(var_242_1.x, var_242_1.y, 0)
				local var_242_3 = arg_239_1.bgs_.I13i

				var_242_3.transform.localPosition = var_242_2
				var_242_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_4 = var_242_3:GetComponent("SpriteRenderer")

				if var_242_4 and var_242_4.sprite then
					local var_242_5 = (var_242_3.transform.localPosition - var_242_1).z
					local var_242_6 = manager.ui.mainCameraCom_
					local var_242_7 = 2 * var_242_5 * Mathf.Tan(var_242_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_242_8 = var_242_7 * var_242_6.aspect
					local var_242_9 = var_242_4.sprite.bounds.size.x
					local var_242_10 = var_242_4.sprite.bounds.size.y
					local var_242_11 = var_242_8 / var_242_9
					local var_242_12 = var_242_7 / var_242_10
					local var_242_13 = var_242_12 < var_242_11 and var_242_11 or var_242_12

					var_242_3.transform.localScale = Vector3.New(var_242_13, var_242_13, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "I13i" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_14 = 1

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_15 = 0.3

			if arg_239_1.time_ >= var_242_14 + var_242_15 and arg_239_1.time_ < var_242_14 + var_242_15 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_17 = 1

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17
				local var_242_19 = Color.New(0, 0, 0)

				var_242_19.a = Mathf.Lerp(0, 1, var_242_18)
				arg_239_1.mask_.color = var_242_19
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 then
				local var_242_20 = Color.New(0, 0, 0)

				var_242_20.a = 1
				arg_239_1.mask_.color = var_242_20
			end

			local var_242_21 = 1

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_22 = 2

			if var_242_21 <= arg_239_1.time_ and arg_239_1.time_ < var_242_21 + var_242_22 then
				local var_242_23 = (arg_239_1.time_ - var_242_21) / var_242_22
				local var_242_24 = Color.New(0, 0, 0)

				var_242_24.a = Mathf.Lerp(1, 0, var_242_23)
				arg_239_1.mask_.color = var_242_24
			end

			if arg_239_1.time_ >= var_242_21 + var_242_22 and arg_239_1.time_ < var_242_21 + var_242_22 + arg_242_0 then
				local var_242_25 = Color.New(0, 0, 0)
				local var_242_26 = 0

				arg_239_1.mask_.enabled = false
				var_242_25.a = var_242_26
				arg_239_1.mask_.color = var_242_25
			end

			local var_242_27 = arg_239_1.actors_["10109"]
			local var_242_28 = 1

			if var_242_28 < arg_239_1.time_ and arg_239_1.time_ <= var_242_28 + arg_242_0 and not isNil(var_242_27) and arg_239_1.var_.actorSpriteComps10109 == nil then
				arg_239_1.var_.actorSpriteComps10109 = var_242_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_29 = 0.2

			if var_242_28 <= arg_239_1.time_ and arg_239_1.time_ < var_242_28 + var_242_29 and not isNil(var_242_27) then
				local var_242_30 = (arg_239_1.time_ - var_242_28) / var_242_29

				if arg_239_1.var_.actorSpriteComps10109 then
					for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_242_3 then
							if arg_239_1.isInRecall_ then
								local var_242_31 = Mathf.Lerp(iter_242_3.color.r, arg_239_1.hightColor2.r, var_242_30)
								local var_242_32 = Mathf.Lerp(iter_242_3.color.g, arg_239_1.hightColor2.g, var_242_30)
								local var_242_33 = Mathf.Lerp(iter_242_3.color.b, arg_239_1.hightColor2.b, var_242_30)

								iter_242_3.color = Color.New(var_242_31, var_242_32, var_242_33)
							else
								local var_242_34 = Mathf.Lerp(iter_242_3.color.r, 0.5, var_242_30)

								iter_242_3.color = Color.New(var_242_34, var_242_34, var_242_34)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_28 + var_242_29 and arg_239_1.time_ < var_242_28 + var_242_29 + arg_242_0 and not isNil(var_242_27) and arg_239_1.var_.actorSpriteComps10109 then
				for iter_242_4, iter_242_5 in pairs(arg_239_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_242_5 then
						if arg_239_1.isInRecall_ then
							iter_242_5.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10109 = nil
			end

			local var_242_35 = 2
			local var_242_36 = 1

			if var_242_35 < arg_239_1.time_ and arg_239_1.time_ <= var_242_35 + arg_242_0 then
				local var_242_37 = "play"
				local var_242_38 = "effect"

				arg_239_1:AudioAction(var_242_37, var_242_38, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_39 = 2.33333333333333
			local var_242_40 = 2

			if var_242_39 < arg_239_1.time_ and arg_239_1.time_ <= var_242_39 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_41 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_41:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_42 = arg_239_1:GetWordFromCfg(416201057)
				local var_242_43 = arg_239_1:FormatText(var_242_42.content)

				arg_239_1.text_.text = var_242_43

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_44 = 80
				local var_242_45 = utf8.len(var_242_43)
				local var_242_46 = var_242_44 <= 0 and var_242_40 or var_242_40 * (var_242_45 / var_242_44)

				if var_242_46 > 0 and var_242_40 < var_242_46 then
					arg_239_1.talkMaxDuration = var_242_46
					var_242_39 = var_242_39 + 0.3

					if var_242_46 + var_242_39 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_46 + var_242_39
					end
				end

				arg_239_1.text_.text = var_242_43
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_47 = var_242_39 + 0.3
			local var_242_48 = math.max(var_242_40, arg_239_1.talkMaxDuration)

			if var_242_47 <= arg_239_1.time_ and arg_239_1.time_ < var_242_47 + var_242_48 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_47) / var_242_48

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_47 + var_242_48 and arg_239_1.time_ < var_242_47 + var_242_48 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416201058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 416201058
		arg_245_1.duration_ = 2.73

		local var_245_0 = {
			zh = 1.166,
			ja = 2.733
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play416201059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10127"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10127 == nil then
				arg_245_1.var_.actorSpriteComps10127 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps10127 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor1.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor1.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor1.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 1, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10127 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10127 = nil
			end

			local var_248_8 = arg_245_1.actors_["10127"].transform
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.var_.moveOldPos10127 = var_248_8.localPosition
				var_248_8.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10127", 3)

				local var_248_10 = var_248_8.childCount

				for iter_248_4 = 0, var_248_10 - 1 do
					local var_248_11 = var_248_8:GetChild(iter_248_4)

					if var_248_11.name == "split_5" or not string.find(var_248_11.name, "split") then
						var_248_11.gameObject:SetActive(true)
					else
						var_248_11.gameObject:SetActive(false)
					end
				end
			end

			local var_248_12 = 0.001

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_12 then
				local var_248_13 = (arg_245_1.time_ - var_248_9) / var_248_12
				local var_248_14 = Vector3.New(0, -387.4, -316.5)

				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10127, var_248_14, var_248_13)
			end

			if arg_245_1.time_ >= var_248_9 + var_248_12 and arg_245_1.time_ < var_248_9 + var_248_12 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_248_15 = 0
			local var_248_16 = 0.1

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_17 = arg_245_1:FormatText(StoryNameCfg[236].name)

				arg_245_1.leftNameTxt_.text = var_248_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_18 = arg_245_1:GetWordFromCfg(416201058)
				local var_248_19 = arg_245_1:FormatText(var_248_18.content)

				arg_245_1.text_.text = var_248_19

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_20 = 4
				local var_248_21 = utf8.len(var_248_19)
				local var_248_22 = var_248_20 <= 0 and var_248_16 or var_248_16 * (var_248_21 / var_248_20)

				if var_248_22 > 0 and var_248_16 < var_248_22 then
					arg_245_1.talkMaxDuration = var_248_22

					if var_248_22 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_22 + var_248_15
					end
				end

				arg_245_1.text_.text = var_248_19
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201058", "story_v_out_416201.awb") ~= 0 then
					local var_248_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201058", "story_v_out_416201.awb") / 1000

					if var_248_23 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_23 + var_248_15
					end

					if var_248_18.prefab_name ~= "" and arg_245_1.actors_[var_248_18.prefab_name] ~= nil then
						local var_248_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_18.prefab_name].transform, "story_v_out_416201", "416201058", "story_v_out_416201.awb")

						arg_245_1:RecordAudio("416201058", var_248_24)
						arg_245_1:RecordAudio("416201058", var_248_24)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_416201", "416201058", "story_v_out_416201.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_416201", "416201058", "story_v_out_416201.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_25 = math.max(var_248_16, arg_245_1.talkMaxDuration)

			if var_248_15 <= arg_245_1.time_ and arg_245_1.time_ < var_248_15 + var_248_25 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_15) / var_248_25

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_15 + var_248_25 and arg_245_1.time_ < var_248_15 + var_248_25 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play416201059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 416201059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play416201060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10127"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps10127 == nil then
				arg_249_1.var_.actorSpriteComps10127 = var_252_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.actorSpriteComps10127 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								local var_252_4 = Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor2.r, var_252_3)
								local var_252_5 = Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor2.g, var_252_3)
								local var_252_6 = Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor2.b, var_252_3)

								iter_252_1.color = Color.New(var_252_4, var_252_5, var_252_6)
							else
								local var_252_7 = Mathf.Lerp(iter_252_1.color.r, 0.5, var_252_3)

								iter_252_1.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps10127 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_252_3 then
						if arg_249_1.isInRecall_ then
							iter_252_3.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10127 = nil
			end

			local var_252_8 = arg_249_1.actors_["10127"].transform
			local var_252_9 = 0

			if var_252_9 < arg_249_1.time_ and arg_249_1.time_ <= var_252_9 + arg_252_0 then
				arg_249_1.var_.moveOldPos10127 = var_252_8.localPosition
				var_252_8.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10127", 7)

				local var_252_10 = var_252_8.childCount

				for iter_252_4 = 0, var_252_10 - 1 do
					local var_252_11 = var_252_8:GetChild(iter_252_4)

					if var_252_11.name == "" or not string.find(var_252_11.name, "split") then
						var_252_11.gameObject:SetActive(true)
					else
						var_252_11.gameObject:SetActive(false)
					end
				end
			end

			local var_252_12 = 0.001

			if var_252_9 <= arg_249_1.time_ and arg_249_1.time_ < var_252_9 + var_252_12 then
				local var_252_13 = (arg_249_1.time_ - var_252_9) / var_252_12
				local var_252_14 = Vector3.New(0, -2000, 0)

				var_252_8.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10127, var_252_14, var_252_13)
			end

			if arg_249_1.time_ >= var_252_9 + var_252_12 and arg_249_1.time_ < var_252_9 + var_252_12 + arg_252_0 then
				var_252_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_252_15 = 0
			local var_252_16 = 0.825

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_17 = arg_249_1:GetWordFromCfg(416201059)
				local var_252_18 = arg_249_1:FormatText(var_252_17.content)

				arg_249_1.text_.text = var_252_18

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_19 = 33
				local var_252_20 = utf8.len(var_252_18)
				local var_252_21 = var_252_19 <= 0 and var_252_16 or var_252_16 * (var_252_20 / var_252_19)

				if var_252_21 > 0 and var_252_16 < var_252_21 then
					arg_249_1.talkMaxDuration = var_252_21

					if var_252_21 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_21 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_18
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_22 and arg_249_1.time_ < var_252_15 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play416201060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 416201060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play416201061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.7

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(416201060)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 68
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play416201061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 416201061
		arg_257_1.duration_ = 6.73

		local var_257_0 = {
			zh = 4.3,
			ja = 6.733
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play416201062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10127"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10127 == nil then
				arg_257_1.var_.actorSpriteComps10127 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10127 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 1, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10127 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10127 = nil
			end

			local var_260_8 = arg_257_1.actors_["10127"].transform
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 then
				arg_257_1.var_.moveOldPos10127 = var_260_8.localPosition
				var_260_8.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10127", 3)

				local var_260_10 = var_260_8.childCount

				for iter_260_4 = 0, var_260_10 - 1 do
					local var_260_11 = var_260_8:GetChild(iter_260_4)

					if var_260_11.name == "" or not string.find(var_260_11.name, "split") then
						var_260_11.gameObject:SetActive(true)
					else
						var_260_11.gameObject:SetActive(false)
					end
				end
			end

			local var_260_12 = 0.001

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_12 then
				local var_260_13 = (arg_257_1.time_ - var_260_9) / var_260_12
				local var_260_14 = Vector3.New(0, -387.4, -316.5)

				var_260_8.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10127, var_260_14, var_260_13)
			end

			if arg_257_1.time_ >= var_260_9 + var_260_12 and arg_257_1.time_ < var_260_9 + var_260_12 + arg_260_0 then
				var_260_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_260_15 = 0
			local var_260_16 = 0.525

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[236].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(416201061)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 21
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201061", "story_v_out_416201.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201061", "story_v_out_416201.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_416201", "416201061", "story_v_out_416201.awb")

						arg_257_1:RecordAudio("416201061", var_260_24)
						arg_257_1:RecordAudio("416201061", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_416201", "416201061", "story_v_out_416201.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_416201", "416201061", "story_v_out_416201.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play416201062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 416201062
		arg_261_1.duration_ = 9.9

		local var_261_0 = {
			zh = 5.433,
			ja = 9.9
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play416201063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.8

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[236].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(416201062)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 32
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201062", "story_v_out_416201.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201062", "story_v_out_416201.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_416201", "416201062", "story_v_out_416201.awb")

						arg_261_1:RecordAudio("416201062", var_264_9)
						arg_261_1:RecordAudio("416201062", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_416201", "416201062", "story_v_out_416201.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_416201", "416201062", "story_v_out_416201.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play416201063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 416201063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play416201064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10127"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10127 == nil then
				arg_265_1.var_.actorSpriteComps10127 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps10127 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 0.5, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10127 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10127 = nil
			end

			local var_268_8 = arg_265_1.actors_["10127"].transform
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.var_.moveOldPos10127 = var_268_8.localPosition
				var_268_8.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10127", 7)

				local var_268_10 = var_268_8.childCount

				for iter_268_4 = 0, var_268_10 - 1 do
					local var_268_11 = var_268_8:GetChild(iter_268_4)

					if var_268_11.name == "" or not string.find(var_268_11.name, "split") then
						var_268_11.gameObject:SetActive(true)
					else
						var_268_11.gameObject:SetActive(false)
					end
				end
			end

			local var_268_12 = 0.001

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_12 then
				local var_268_13 = (arg_265_1.time_ - var_268_9) / var_268_12
				local var_268_14 = Vector3.New(0, -2000, 0)

				var_268_8.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10127, var_268_14, var_268_13)
			end

			if arg_265_1.time_ >= var_268_9 + var_268_12 and arg_265_1.time_ < var_268_9 + var_268_12 + arg_268_0 then
				var_268_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_15 = 0
			local var_268_16 = 1.3

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_17 = arg_265_1:GetWordFromCfg(416201063)
				local var_268_18 = arg_265_1:FormatText(var_268_17.content)

				arg_265_1.text_.text = var_268_18

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_19 = 52
				local var_268_20 = utf8.len(var_268_18)
				local var_268_21 = var_268_19 <= 0 and var_268_16 or var_268_16 * (var_268_20 / var_268_19)

				if var_268_21 > 0 and var_268_16 < var_268_21 then
					arg_265_1.talkMaxDuration = var_268_21

					if var_268_21 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_21 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_18
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_22 and arg_265_1.time_ < var_268_15 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play416201064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 416201064
		arg_269_1.duration_ = 6.83

		local var_269_0 = {
			zh = 3.833,
			ja = 6.833
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
				arg_269_0:Play416201065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10127"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10127 == nil then
				arg_269_1.var_.actorSpriteComps10127 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps10127 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor1.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor1.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor1.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 1, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10127 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10127 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.475

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_10 = arg_269_1:FormatText(StoryNameCfg[236].name)

				arg_269_1.leftNameTxt_.text = var_272_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_11 = arg_269_1:GetWordFromCfg(416201064)
				local var_272_12 = arg_269_1:FormatText(var_272_11.content)

				arg_269_1.text_.text = var_272_12

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 19
				local var_272_14 = utf8.len(var_272_12)
				local var_272_15 = var_272_13 <= 0 and var_272_9 or var_272_9 * (var_272_14 / var_272_13)

				if var_272_15 > 0 and var_272_9 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15

					if var_272_15 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_12
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201064", "story_v_out_416201.awb") ~= 0 then
					local var_272_16 = manager.audio:GetVoiceLength("story_v_out_416201", "416201064", "story_v_out_416201.awb") / 1000

					if var_272_16 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_16 + var_272_8
					end

					if var_272_11.prefab_name ~= "" and arg_269_1.actors_[var_272_11.prefab_name] ~= nil then
						local var_272_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_11.prefab_name].transform, "story_v_out_416201", "416201064", "story_v_out_416201.awb")

						arg_269_1:RecordAudio("416201064", var_272_17)
						arg_269_1:RecordAudio("416201064", var_272_17)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_416201", "416201064", "story_v_out_416201.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_416201", "416201064", "story_v_out_416201.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_18 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_18 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_18

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_18 and arg_269_1.time_ < var_272_8 + var_272_18 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play416201065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 416201065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play416201066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.433333333333333
			local var_276_1 = 1

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				local var_276_2 = "play"
				local var_276_3 = "effect"

				arg_273_1:AudioAction(var_276_2, var_276_3, "se_story_birthday3", "se_story_birthday3_jet2", "")
			end

			local var_276_4 = 0
			local var_276_5 = 1.8

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(416201065)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_8 = 72
				local var_276_9 = utf8.len(var_276_7)
				local var_276_10 = var_276_8 <= 0 and var_276_5 or var_276_5 * (var_276_9 / var_276_8)

				if var_276_10 > 0 and var_276_5 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_11 and arg_273_1.time_ < var_276_4 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play416201066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 416201066
		arg_277_1.duration_ = 3.03

		local var_277_0 = {
			zh = 2.2,
			ja = 3.033
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
				arg_277_0:Play416201067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.225

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[8].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(416201066)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 9
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201066", "story_v_out_416201.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201066", "story_v_out_416201.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_416201", "416201066", "story_v_out_416201.awb")

						arg_277_1:RecordAudio("416201066", var_280_9)
						arg_277_1:RecordAudio("416201066", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_416201", "416201066", "story_v_out_416201.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_416201", "416201066", "story_v_out_416201.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play416201067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 416201067
		arg_281_1.duration_ = 5.63

		local var_281_0 = {
			zh = 2.6,
			ja = 5.633
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
				arg_281_0:Play416201068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10127"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10127 == nil then
				arg_281_1.var_.actorSpriteComps10127 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps10127 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor1.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor1.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor1.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 1, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10127 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10127 = nil
			end

			local var_284_8 = arg_281_1.actors_["10127"].transform
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.var_.moveOldPos10127 = var_284_8.localPosition
				var_284_8.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10127", 3)

				local var_284_10 = var_284_8.childCount

				for iter_284_4 = 0, var_284_10 - 1 do
					local var_284_11 = var_284_8:GetChild(iter_284_4)

					if var_284_11.name == "split_5" or not string.find(var_284_11.name, "split") then
						var_284_11.gameObject:SetActive(true)
					else
						var_284_11.gameObject:SetActive(false)
					end
				end
			end

			local var_284_12 = 0.001

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_12 then
				local var_284_13 = (arg_281_1.time_ - var_284_9) / var_284_12
				local var_284_14 = Vector3.New(0, -387.4, -316.5)

				var_284_8.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10127, var_284_14, var_284_13)
			end

			if arg_281_1.time_ >= var_284_9 + var_284_12 and arg_281_1.time_ < var_284_9 + var_284_12 + arg_284_0 then
				var_284_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_284_15 = 0
			local var_284_16 = 0.325

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[236].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(416201067)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 13
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201067", "story_v_out_416201.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201067", "story_v_out_416201.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_416201", "416201067", "story_v_out_416201.awb")

						arg_281_1:RecordAudio("416201067", var_284_24)
						arg_281_1:RecordAudio("416201067", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_416201", "416201067", "story_v_out_416201.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_416201", "416201067", "story_v_out_416201.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play416201068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 416201068
		arg_285_1.duration_ = 5.43

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play416201069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10127"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10127 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10127", 7)

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

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10127, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_288_7 = 0

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_8 = 0.333333333333333

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / var_288_8
				local var_288_10 = Color.New(1, 1, 1)

				var_288_10.a = Mathf.Lerp(1, 0, var_288_9)
				arg_285_1.mask_.color = var_288_10
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 then
				local var_288_11 = Color.New(1, 1, 1)
				local var_288_12 = 0

				arg_285_1.mask_.enabled = false
				var_288_11.a = var_288_12
				arg_285_1.mask_.color = var_288_11
			end

			if arg_285_1.frameCnt_ <= 1 then
				arg_285_1.dialog_:SetActive(false)
			end

			local var_288_13 = 0.433333333333333
			local var_288_14 = 1.65

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				arg_285_1.dialog_:SetActive(true)

				arg_285_1.dialogCg_.alpha = 0

				local var_288_15 = LeanTween.value(arg_285_1.dialog_, 0, 1, 0.3)

				var_288_15:setOnUpdate(LuaHelper.FloatAction(function(arg_289_0)
					arg_285_1.dialogCg_.alpha = arg_289_0
				end))
				var_288_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_285_1.dialog_)
					var_288_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_285_1.duration_ = arg_285_1.duration_ + 0.3

				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_16 = arg_285_1:GetWordFromCfg(416201068)
				local var_288_17 = arg_285_1:FormatText(var_288_16.content)

				arg_285_1.text_.text = var_288_17

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_18 = 66
				local var_288_19 = utf8.len(var_288_17)
				local var_288_20 = var_288_18 <= 0 and var_288_14 or var_288_14 * (var_288_19 / var_288_18)

				if var_288_20 > 0 and var_288_14 < var_288_20 then
					arg_285_1.talkMaxDuration = var_288_20
					var_288_13 = var_288_13 + 0.3

					if var_288_20 + var_288_13 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_20 + var_288_13
					end
				end

				arg_285_1.text_.text = var_288_17
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_21 = var_288_13 + 0.3
			local var_288_22 = math.max(var_288_14, arg_285_1.talkMaxDuration)

			if var_288_21 <= arg_285_1.time_ and arg_285_1.time_ < var_288_21 + var_288_22 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_21) / var_288_22

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_21 + var_288_22 and arg_285_1.time_ < var_288_21 + var_288_22 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play416201069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416201069
		arg_291_1.duration_ = 4.7

		local var_291_0 = {
			zh = 2.866,
			ja = 4.7
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
				arg_291_0:Play416201070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.4

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[236].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(416201069)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201069", "story_v_out_416201.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201069", "story_v_out_416201.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_416201", "416201069", "story_v_out_416201.awb")

						arg_291_1:RecordAudio("416201069", var_294_9)
						arg_291_1:RecordAudio("416201069", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416201", "416201069", "story_v_out_416201.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416201", "416201069", "story_v_out_416201.awb")
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
	Play416201070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416201070
		arg_295_1.duration_ = 3.27

		local var_295_0 = {
			zh = 2.666,
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
				arg_295_0:Play416201071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.3

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
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_5")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(416201070)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201070", "story_v_out_416201.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201070", "story_v_out_416201.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_416201", "416201070", "story_v_out_416201.awb")

						arg_295_1:RecordAudio("416201070", var_298_9)
						arg_295_1:RecordAudio("416201070", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416201", "416201070", "story_v_out_416201.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416201", "416201070", "story_v_out_416201.awb")
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
	Play416201071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416201071
		arg_299_1.duration_ = 6.3

		local var_299_0 = {
			zh = 3.233,
			ja = 6.3
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
				arg_299_0:Play416201072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.5

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
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(416201071)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201071", "story_v_out_416201.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_416201", "416201071", "story_v_out_416201.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_416201", "416201071", "story_v_out_416201.awb")

						arg_299_1:RecordAudio("416201071", var_302_9)
						arg_299_1:RecordAudio("416201071", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416201", "416201071", "story_v_out_416201.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416201", "416201071", "story_v_out_416201.awb")
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
	Play416201072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416201072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play416201073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.2
			local var_306_1 = 1

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				local var_306_2 = "play"
				local var_306_3 = "effect"

				arg_303_1:AudioAction(var_306_2, var_306_3, "se_story_138", "se_story_138_lasergun", "")
			end

			local var_306_4 = 0
			local var_306_5 = 1.5

			if var_306_4 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(416201072)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_8 = 60
				local var_306_9 = utf8.len(var_306_7)
				local var_306_10 = var_306_8 <= 0 and var_306_5 or var_306_5 * (var_306_9 / var_306_8)

				if var_306_10 > 0 and var_306_5 < var_306_10 then
					arg_303_1.talkMaxDuration = var_306_10

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_11 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_11 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_11

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_11 and arg_303_1.time_ < var_306_4 + var_306_11 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play416201073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416201073
		arg_307_1.duration_ = 4.73

		local var_307_0 = {
			zh = 3.2,
			ja = 4.733
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
				arg_307_0:Play416201074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = "10122"

			if arg_307_1.actors_[var_310_0] == nil then
				local var_310_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_310_1) then
					local var_310_2 = Object.Instantiate(var_310_1, arg_307_1.canvasGo_.transform)

					var_310_2.transform:SetSiblingIndex(1)

					var_310_2.name = var_310_0
					var_310_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_307_1.actors_[var_310_0] = var_310_2

					local var_310_3 = var_310_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_307_1.isInRecall_ then
						for iter_310_0, iter_310_1 in ipairs(var_310_3) do
							iter_310_1.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_310_4 = arg_307_1.actors_["10122"]
			local var_310_5 = 0

			if var_310_5 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.actorSpriteComps10122 == nil then
				arg_307_1.var_.actorSpriteComps10122 = var_310_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_6 = 0.2

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 and not isNil(var_310_4) then
				local var_310_7 = (arg_307_1.time_ - var_310_5) / var_310_6

				if arg_307_1.var_.actorSpriteComps10122 then
					for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_310_3 then
							if arg_307_1.isInRecall_ then
								local var_310_8 = Mathf.Lerp(iter_310_3.color.r, arg_307_1.hightColor1.r, var_310_7)
								local var_310_9 = Mathf.Lerp(iter_310_3.color.g, arg_307_1.hightColor1.g, var_310_7)
								local var_310_10 = Mathf.Lerp(iter_310_3.color.b, arg_307_1.hightColor1.b, var_310_7)

								iter_310_3.color = Color.New(var_310_8, var_310_9, var_310_10)
							else
								local var_310_11 = Mathf.Lerp(iter_310_3.color.r, 1, var_310_7)

								iter_310_3.color = Color.New(var_310_11, var_310_11, var_310_11)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.actorSpriteComps10122 then
				for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_310_5 then
						if arg_307_1.isInRecall_ then
							iter_310_5.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10122 = nil
			end

			local var_310_12 = arg_307_1.actors_["10122"].transform
			local var_310_13 = 0

			if var_310_13 < arg_307_1.time_ and arg_307_1.time_ <= var_310_13 + arg_310_0 then
				arg_307_1.var_.moveOldPos10122 = var_310_12.localPosition
				var_310_12.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10122", 3)

				local var_310_14 = var_310_12.childCount

				for iter_310_6 = 0, var_310_14 - 1 do
					local var_310_15 = var_310_12:GetChild(iter_310_6)

					if var_310_15.name == "split_5" or not string.find(var_310_15.name, "split") then
						var_310_15.gameObject:SetActive(true)
					else
						var_310_15.gameObject:SetActive(false)
					end
				end
			end

			local var_310_16 = 0.001

			if var_310_13 <= arg_307_1.time_ and arg_307_1.time_ < var_310_13 + var_310_16 then
				local var_310_17 = (arg_307_1.time_ - var_310_13) / var_310_16
				local var_310_18 = Vector3.New(0, -380, -100)

				var_310_12.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10122, var_310_18, var_310_17)
			end

			if arg_307_1.time_ >= var_310_13 + var_310_16 and arg_307_1.time_ < var_310_13 + var_310_16 + arg_310_0 then
				var_310_12.localPosition = Vector3.New(0, -380, -100)
			end

			local var_310_19 = 0
			local var_310_20 = 0.375

			if var_310_19 < arg_307_1.time_ and arg_307_1.time_ <= var_310_19 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_21 = arg_307_1:FormatText(StoryNameCfg[8].name)

				arg_307_1.leftNameTxt_.text = var_310_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_22 = arg_307_1:GetWordFromCfg(416201073)
				local var_310_23 = arg_307_1:FormatText(var_310_22.content)

				arg_307_1.text_.text = var_310_23

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_24 = 15
				local var_310_25 = utf8.len(var_310_23)
				local var_310_26 = var_310_24 <= 0 and var_310_20 or var_310_20 * (var_310_25 / var_310_24)

				if var_310_26 > 0 and var_310_20 < var_310_26 then
					arg_307_1.talkMaxDuration = var_310_26

					if var_310_26 + var_310_19 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_26 + var_310_19
					end
				end

				arg_307_1.text_.text = var_310_23
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201073", "story_v_out_416201.awb") ~= 0 then
					local var_310_27 = manager.audio:GetVoiceLength("story_v_out_416201", "416201073", "story_v_out_416201.awb") / 1000

					if var_310_27 + var_310_19 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_27 + var_310_19
					end

					if var_310_22.prefab_name ~= "" and arg_307_1.actors_[var_310_22.prefab_name] ~= nil then
						local var_310_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_22.prefab_name].transform, "story_v_out_416201", "416201073", "story_v_out_416201.awb")

						arg_307_1:RecordAudio("416201073", var_310_28)
						arg_307_1:RecordAudio("416201073", var_310_28)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416201", "416201073", "story_v_out_416201.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416201", "416201073", "story_v_out_416201.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_29 = math.max(var_310_20, arg_307_1.talkMaxDuration)

			if var_310_19 <= arg_307_1.time_ and arg_307_1.time_ < var_310_19 + var_310_29 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_19) / var_310_29

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_19 + var_310_29 and arg_307_1.time_ < var_310_19 + var_310_29 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416201074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416201074
		arg_311_1.duration_ = 9.8

		local var_311_0 = {
			zh = 4.8,
			ja = 9.8
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
				arg_311_0:Play416201075(arg_311_1)
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

			local var_314_8 = arg_311_1.actors_["10122"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10122 == nil then
				arg_311_1.var_.actorSpriteComps10122 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps10122 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10122 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10122 = nil
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

					if var_314_19.name == "split_6" or not string.find(var_314_19.name, "split") then
						var_314_19.gameObject:SetActive(true)
					else
						var_314_19.gameObject:SetActive(false)
					end
				end
			end

			local var_314_20 = 0.001

			if var_314_17 <= arg_311_1.time_ and arg_311_1.time_ < var_314_17 + var_314_20 then
				local var_314_21 = (arg_311_1.time_ - var_314_17) / var_314_20
				local var_314_22 = Vector3.New(-390, -387.4, -316.5)

				var_314_16.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10127, var_314_22, var_314_21)
			end

			if arg_311_1.time_ >= var_314_17 + var_314_20 and arg_311_1.time_ < var_314_17 + var_314_20 + arg_314_0 then
				var_314_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_314_23 = arg_311_1.actors_["10122"].transform
			local var_314_24 = 0

			if var_314_24 < arg_311_1.time_ and arg_311_1.time_ <= var_314_24 + arg_314_0 then
				arg_311_1.var_.moveOldPos10122 = var_314_23.localPosition
				var_314_23.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10122", 4)

				local var_314_25 = var_314_23.childCount

				for iter_314_9 = 0, var_314_25 - 1 do
					local var_314_26 = var_314_23:GetChild(iter_314_9)

					if var_314_26.name == "split_5" or not string.find(var_314_26.name, "split") then
						var_314_26.gameObject:SetActive(true)
					else
						var_314_26.gameObject:SetActive(false)
					end
				end
			end

			local var_314_27 = 0.001

			if var_314_24 <= arg_311_1.time_ and arg_311_1.time_ < var_314_24 + var_314_27 then
				local var_314_28 = (arg_311_1.time_ - var_314_24) / var_314_27
				local var_314_29 = Vector3.New(390, -380, -100)

				var_314_23.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10122, var_314_29, var_314_28)
			end

			if arg_311_1.time_ >= var_314_24 + var_314_27 and arg_311_1.time_ < var_314_24 + var_314_27 + arg_314_0 then
				var_314_23.localPosition = Vector3.New(390, -380, -100)
			end

			local var_314_30 = 0
			local var_314_31 = 0.675

			if var_314_30 < arg_311_1.time_ and arg_311_1.time_ <= var_314_30 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_32 = arg_311_1:FormatText(StoryNameCfg[236].name)

				arg_311_1.leftNameTxt_.text = var_314_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_33 = arg_311_1:GetWordFromCfg(416201074)
				local var_314_34 = arg_311_1:FormatText(var_314_33.content)

				arg_311_1.text_.text = var_314_34

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_35 = 27
				local var_314_36 = utf8.len(var_314_34)
				local var_314_37 = var_314_35 <= 0 and var_314_31 or var_314_31 * (var_314_36 / var_314_35)

				if var_314_37 > 0 and var_314_31 < var_314_37 then
					arg_311_1.talkMaxDuration = var_314_37

					if var_314_37 + var_314_30 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_37 + var_314_30
					end
				end

				arg_311_1.text_.text = var_314_34
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201074", "story_v_out_416201.awb") ~= 0 then
					local var_314_38 = manager.audio:GetVoiceLength("story_v_out_416201", "416201074", "story_v_out_416201.awb") / 1000

					if var_314_38 + var_314_30 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_38 + var_314_30
					end

					if var_314_33.prefab_name ~= "" and arg_311_1.actors_[var_314_33.prefab_name] ~= nil then
						local var_314_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_33.prefab_name].transform, "story_v_out_416201", "416201074", "story_v_out_416201.awb")

						arg_311_1:RecordAudio("416201074", var_314_39)
						arg_311_1:RecordAudio("416201074", var_314_39)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416201", "416201074", "story_v_out_416201.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416201", "416201074", "story_v_out_416201.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_40 = math.max(var_314_31, arg_311_1.talkMaxDuration)

			if var_314_30 <= arg_311_1.time_ and arg_311_1.time_ < var_314_30 + var_314_40 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_30) / var_314_40

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_30 + var_314_40 and arg_311_1.time_ < var_314_30 + var_314_40 + arg_314_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play416201075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416201075
		arg_315_1.duration_ = 4.57

		local var_315_0 = {
			zh = 2.8,
			ja = 4.566
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
				arg_315_0:Play416201076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10122"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10122 == nil then
				arg_315_1.var_.actorSpriteComps10122 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps10122 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10122 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10122 = nil
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

			local var_318_16 = 0
			local var_318_17 = 0.325

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_18 = arg_315_1:FormatText(StoryNameCfg[8].name)

				arg_315_1.leftNameTxt_.text = var_318_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_19 = arg_315_1:GetWordFromCfg(416201075)
				local var_318_20 = arg_315_1:FormatText(var_318_19.content)

				arg_315_1.text_.text = var_318_20

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_21 = 13
				local var_318_22 = utf8.len(var_318_20)
				local var_318_23 = var_318_21 <= 0 and var_318_17 or var_318_17 * (var_318_22 / var_318_21)

				if var_318_23 > 0 and var_318_17 < var_318_23 then
					arg_315_1.talkMaxDuration = var_318_23

					if var_318_23 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_16
					end
				end

				arg_315_1.text_.text = var_318_20
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201075", "story_v_out_416201.awb") ~= 0 then
					local var_318_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201075", "story_v_out_416201.awb") / 1000

					if var_318_24 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_16
					end

					if var_318_19.prefab_name ~= "" and arg_315_1.actors_[var_318_19.prefab_name] ~= nil then
						local var_318_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_19.prefab_name].transform, "story_v_out_416201", "416201075", "story_v_out_416201.awb")

						arg_315_1:RecordAudio("416201075", var_318_25)
						arg_315_1:RecordAudio("416201075", var_318_25)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416201", "416201075", "story_v_out_416201.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416201", "416201075", "story_v_out_416201.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_26 = math.max(var_318_17, arg_315_1.talkMaxDuration)

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_26 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_16) / var_318_26

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_16 + var_318_26 and arg_315_1.time_ < var_318_16 + var_318_26 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play416201076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416201076
		arg_319_1.duration_ = 7.97

		local var_319_0 = {
			zh = 3.666,
			ja = 7.966
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
				arg_319_0:Play416201077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10127"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10127 == nil then
				arg_319_1.var_.actorSpriteComps10127 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10127 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10127 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10127 = nil
			end

			local var_322_8 = arg_319_1.actors_["10122"]
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10122 == nil then
				arg_319_1.var_.actorSpriteComps10122 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_10 = 0.2

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_10 and not isNil(var_322_8) then
				local var_322_11 = (arg_319_1.time_ - var_322_9) / var_322_10

				if arg_319_1.var_.actorSpriteComps10122 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								local var_322_12 = Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor2.r, var_322_11)
								local var_322_13 = Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor2.g, var_322_11)
								local var_322_14 = Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor2.b, var_322_11)

								iter_322_5.color = Color.New(var_322_12, var_322_13, var_322_14)
							else
								local var_322_15 = Mathf.Lerp(iter_322_5.color.r, 0.5, var_322_11)

								iter_322_5.color = Color.New(var_322_15, var_322_15, var_322_15)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_10 and arg_319_1.time_ < var_322_9 + var_322_10 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10122 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_322_7 then
						if arg_319_1.isInRecall_ then
							iter_322_7.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10122 = nil
			end

			local var_322_16 = 0
			local var_322_17 = 0.475

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_18 = arg_319_1:FormatText(StoryNameCfg[236].name)

				arg_319_1.leftNameTxt_.text = var_322_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_19 = arg_319_1:GetWordFromCfg(416201076)
				local var_322_20 = arg_319_1:FormatText(var_322_19.content)

				arg_319_1.text_.text = var_322_20

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_21 = 19
				local var_322_22 = utf8.len(var_322_20)
				local var_322_23 = var_322_21 <= 0 and var_322_17 or var_322_17 * (var_322_22 / var_322_21)

				if var_322_23 > 0 and var_322_17 < var_322_23 then
					arg_319_1.talkMaxDuration = var_322_23

					if var_322_23 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_16
					end
				end

				arg_319_1.text_.text = var_322_20
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201076", "story_v_out_416201.awb") ~= 0 then
					local var_322_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201076", "story_v_out_416201.awb") / 1000

					if var_322_24 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_16
					end

					if var_322_19.prefab_name ~= "" and arg_319_1.actors_[var_322_19.prefab_name] ~= nil then
						local var_322_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_19.prefab_name].transform, "story_v_out_416201", "416201076", "story_v_out_416201.awb")

						arg_319_1:RecordAudio("416201076", var_322_25)
						arg_319_1:RecordAudio("416201076", var_322_25)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_416201", "416201076", "story_v_out_416201.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_416201", "416201076", "story_v_out_416201.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_26 = math.max(var_322_17, arg_319_1.talkMaxDuration)

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_26 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_16) / var_322_26

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_16 + var_322_26 and arg_319_1.time_ < var_322_16 + var_322_26 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play416201077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416201077
		arg_323_1.duration_ = 4.63

		local var_323_0 = {
			zh = 3.3,
			ja = 4.633
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
				arg_323_0:Play416201078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10122"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10122 == nil then
				arg_323_1.var_.actorSpriteComps10122 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10122 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10122 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10122 = nil
			end

			local var_326_8 = arg_323_1.actors_["10127"]
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps10127 == nil then
				arg_323_1.var_.actorSpriteComps10127 = var_326_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_10 = 0.2

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_10 and not isNil(var_326_8) then
				local var_326_11 = (arg_323_1.time_ - var_326_9) / var_326_10

				if arg_323_1.var_.actorSpriteComps10127 then
					for iter_326_4, iter_326_5 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_323_1.time_ >= var_326_9 + var_326_10 and arg_323_1.time_ < var_326_9 + var_326_10 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps10127 then
				for iter_326_6, iter_326_7 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_326_7 then
						if arg_323_1.isInRecall_ then
							iter_326_7.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10127 = nil
			end

			local var_326_16 = arg_323_1.actors_["10122"].transform
			local var_326_17 = 0

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1.var_.moveOldPos10122 = var_326_16.localPosition
				var_326_16.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10122", 4)

				local var_326_18 = var_326_16.childCount

				for iter_326_8 = 0, var_326_18 - 1 do
					local var_326_19 = var_326_16:GetChild(iter_326_8)

					if var_326_19.name == "split_5" or not string.find(var_326_19.name, "split") then
						var_326_19.gameObject:SetActive(true)
					else
						var_326_19.gameObject:SetActive(false)
					end
				end
			end

			local var_326_20 = 0.001

			if var_326_17 <= arg_323_1.time_ and arg_323_1.time_ < var_326_17 + var_326_20 then
				local var_326_21 = (arg_323_1.time_ - var_326_17) / var_326_20
				local var_326_22 = Vector3.New(390, -380, -100)

				var_326_16.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10122, var_326_22, var_326_21)
			end

			if arg_323_1.time_ >= var_326_17 + var_326_20 and arg_323_1.time_ < var_326_17 + var_326_20 + arg_326_0 then
				var_326_16.localPosition = Vector3.New(390, -380, -100)
			end

			local var_326_23 = 0
			local var_326_24 = 0.45

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_25 = arg_323_1:FormatText(StoryNameCfg[8].name)

				arg_323_1.leftNameTxt_.text = var_326_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_26 = arg_323_1:GetWordFromCfg(416201077)
				local var_326_27 = arg_323_1:FormatText(var_326_26.content)

				arg_323_1.text_.text = var_326_27

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201077", "story_v_out_416201.awb") ~= 0 then
					local var_326_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201077", "story_v_out_416201.awb") / 1000

					if var_326_31 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_31 + var_326_23
					end

					if var_326_26.prefab_name ~= "" and arg_323_1.actors_[var_326_26.prefab_name] ~= nil then
						local var_326_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_26.prefab_name].transform, "story_v_out_416201", "416201077", "story_v_out_416201.awb")

						arg_323_1:RecordAudio("416201077", var_326_32)
						arg_323_1:RecordAudio("416201077", var_326_32)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416201", "416201077", "story_v_out_416201.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416201", "416201077", "story_v_out_416201.awb")
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
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play416201078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416201078
		arg_327_1.duration_ = 6.17

		local var_327_0 = {
			zh = 6.166,
			ja = 3.666
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
				arg_327_0:Play416201079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10122"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos10122 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10122", 7)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(0, -2000, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10122, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_7 = arg_327_1.actors_["10127"].transform
			local var_330_8 = 0

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.var_.moveOldPos10127 = var_330_7.localPosition
				var_330_7.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10127", 7)

				local var_330_9 = var_330_7.childCount

				for iter_330_1 = 0, var_330_9 - 1 do
					local var_330_10 = var_330_7:GetChild(iter_330_1)

					if var_330_10.name == "" or not string.find(var_330_10.name, "split") then
						var_330_10.gameObject:SetActive(true)
					else
						var_330_10.gameObject:SetActive(false)
					end
				end
			end

			local var_330_11 = 0.001

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_11 then
				local var_330_12 = (arg_327_1.time_ - var_330_8) / var_330_11
				local var_330_13 = Vector3.New(0, -2000, 0)

				var_330_7.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10127, var_330_13, var_330_12)
			end

			if arg_327_1.time_ >= var_330_8 + var_330_11 and arg_327_1.time_ < var_330_8 + var_330_11 + arg_330_0 then
				var_330_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_14 = 0
			local var_330_15 = 0.325

			if var_330_14 < arg_327_1.time_ and arg_327_1.time_ <= var_330_14 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_16 = arg_327_1:FormatText(StoryNameCfg[1093].name)

				arg_327_1.leftNameTxt_.text = var_330_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_17 = arg_327_1:GetWordFromCfg(416201078)
				local var_330_18 = arg_327_1:FormatText(var_330_17.content)

				arg_327_1.text_.text = var_330_18

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_19 = 13
				local var_330_20 = utf8.len(var_330_18)
				local var_330_21 = var_330_19 <= 0 and var_330_15 or var_330_15 * (var_330_20 / var_330_19)

				if var_330_21 > 0 and var_330_15 < var_330_21 then
					arg_327_1.talkMaxDuration = var_330_21

					if var_330_21 + var_330_14 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_21 + var_330_14
					end
				end

				arg_327_1.text_.text = var_330_18
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201078", "story_v_out_416201.awb") ~= 0 then
					local var_330_22 = manager.audio:GetVoiceLength("story_v_out_416201", "416201078", "story_v_out_416201.awb") / 1000

					if var_330_22 + var_330_14 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_14
					end

					if var_330_17.prefab_name ~= "" and arg_327_1.actors_[var_330_17.prefab_name] ~= nil then
						local var_330_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_17.prefab_name].transform, "story_v_out_416201", "416201078", "story_v_out_416201.awb")

						arg_327_1:RecordAudio("416201078", var_330_23)
						arg_327_1:RecordAudio("416201078", var_330_23)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_416201", "416201078", "story_v_out_416201.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_416201", "416201078", "story_v_out_416201.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_24 = math.max(var_330_15, arg_327_1.talkMaxDuration)

			if var_330_14 <= arg_327_1.time_ and arg_327_1.time_ < var_330_14 + var_330_24 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_14) / var_330_24

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_14 + var_330_24 and arg_327_1.time_ < var_330_14 + var_330_24 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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

		arg_327_1:InitPlayNodeList()
	end,
	Play416201079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 416201079
		arg_331_1.duration_ = 5.57

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play416201080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10109"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10109 == nil then
				arg_331_1.var_.actorSpriteComps10109 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps10109 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 0.5, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10109 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10109 = nil
			end

			local var_334_8 = arg_331_1.actors_["10127"].transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.moveOldPos10127 = var_334_8.localPosition
				var_334_8.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10127", 7)

				local var_334_10 = var_334_8.childCount

				for iter_334_4 = 0, var_334_10 - 1 do
					local var_334_11 = var_334_8:GetChild(iter_334_4)

					if var_334_11.name == "" or not string.find(var_334_11.name, "split") then
						var_334_11.gameObject:SetActive(true)
					else
						var_334_11.gameObject:SetActive(false)
					end
				end
			end

			local var_334_12 = 0.001

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_12 then
				local var_334_13 = (arg_331_1.time_ - var_334_9) / var_334_12
				local var_334_14 = Vector3.New(0, -2000, 0)

				var_334_8.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10127, var_334_14, var_334_13)
			end

			if arg_331_1.time_ >= var_334_9 + var_334_12 and arg_331_1.time_ < var_334_9 + var_334_12 + arg_334_0 then
				var_334_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_15 = arg_331_1.actors_["10122"].transform
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.var_.moveOldPos10122 = var_334_15.localPosition
				var_334_15.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10122", 7)

				local var_334_17 = var_334_15.childCount

				for iter_334_5 = 0, var_334_17 - 1 do
					local var_334_18 = var_334_15:GetChild(iter_334_5)

					if var_334_18.name == "" or not string.find(var_334_18.name, "split") then
						var_334_18.gameObject:SetActive(true)
					else
						var_334_18.gameObject:SetActive(false)
					end
				end
			end

			local var_334_19 = 0.001

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_19 then
				local var_334_20 = (arg_331_1.time_ - var_334_16) / var_334_19
				local var_334_21 = Vector3.New(0, -2000, 0)

				var_334_15.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10122, var_334_21, var_334_20)
			end

			if arg_331_1.time_ >= var_334_16 + var_334_19 and arg_331_1.time_ < var_334_16 + var_334_19 + arg_334_0 then
				var_334_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_22 = manager.ui.mainCamera.transform
			local var_334_23 = 0.2

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				local var_334_24 = arg_331_1.var_.effect778
				local var_334_25
				local var_334_26 = var_334_22

				if not var_334_24 then
					var_334_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_334_26)
					var_334_24.name = "778"
					arg_331_1.var_.effect778 = var_334_24
				else
					var_334_24.transform:SetParent(var_334_26)
				end

				var_334_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_334_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_334_27 = manager.ui.mainCamera.transform
			local var_334_28 = 1.83333333333333

			if var_334_28 < arg_331_1.time_ and arg_331_1.time_ <= var_334_28 + arg_334_0 then
				local var_334_29 = arg_331_1.var_.effect778

				if var_334_29 then
					Object.Destroy(var_334_29)

					arg_331_1.var_.effect778 = nil
				end
			end

			local var_334_30 = 0

			if var_334_30 < arg_331_1.time_ and arg_331_1.time_ <= var_334_30 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_31 = 0.333333333333333

			if var_334_30 <= arg_331_1.time_ and arg_331_1.time_ < var_334_30 + var_334_31 then
				local var_334_32 = (arg_331_1.time_ - var_334_30) / var_334_31
				local var_334_33 = Color.New(1, 1, 1)

				var_334_33.a = Mathf.Lerp(1, 0, var_334_32)
				arg_331_1.mask_.color = var_334_33
			end

			if arg_331_1.time_ >= var_334_30 + var_334_31 and arg_331_1.time_ < var_334_30 + var_334_31 + arg_334_0 then
				local var_334_34 = Color.New(1, 1, 1)
				local var_334_35 = 0

				arg_331_1.mask_.enabled = false
				var_334_34.a = var_334_35
				arg_331_1.mask_.color = var_334_34
			end

			local var_334_36 = 0.1
			local var_334_37 = 1

			if var_334_36 < arg_331_1.time_ and arg_331_1.time_ <= var_334_36 + arg_334_0 then
				local var_334_38 = "play"
				local var_334_39 = "effect"

				arg_331_1:AudioAction(var_334_38, var_334_39, "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_40 = 0.566666666666667
			local var_334_41 = 1.675

			if var_334_40 < arg_331_1.time_ and arg_331_1.time_ <= var_334_40 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_42 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_42:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_43 = arg_331_1:GetWordFromCfg(416201079)
				local var_334_44 = arg_331_1:FormatText(var_334_43.content)

				arg_331_1.text_.text = var_334_44

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_45 = 67
				local var_334_46 = utf8.len(var_334_44)
				local var_334_47 = var_334_45 <= 0 and var_334_41 or var_334_41 * (var_334_46 / var_334_45)

				if var_334_47 > 0 and var_334_41 < var_334_47 then
					arg_331_1.talkMaxDuration = var_334_47
					var_334_40 = var_334_40 + 0.3

					if var_334_47 + var_334_40 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_47 + var_334_40
					end
				end

				arg_331_1.text_.text = var_334_44
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_48 = var_334_40 + 0.3
			local var_334_49 = math.max(var_334_41, arg_331_1.talkMaxDuration)

			if var_334_48 <= arg_331_1.time_ and arg_331_1.time_ < var_334_48 + var_334_49 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_48) / var_334_49

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_48 + var_334_49 and arg_331_1.time_ < var_334_48 + var_334_49 + arg_334_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10122",
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
	Play416201080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416201080
		arg_337_1.duration_ = 7.73

		local var_337_0 = {
			zh = 5.9,
			ja = 7.733
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
				arg_337_0:Play416201081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10109"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10109 == nil then
				arg_337_1.var_.actorSpriteComps10109 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps10109 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_4 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, var_340_3)
								local var_340_5 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, var_340_3)
								local var_340_6 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, var_340_3)

								iter_340_1.color = Color.New(var_340_4, var_340_5, var_340_6)
							else
								local var_340_7 = Mathf.Lerp(iter_340_1.color.r, 1, var_340_3)

								iter_340_1.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10109 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10109 = nil
			end

			local var_340_8 = arg_337_1.actors_["10109"].transform
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1.var_.moveOldPos10109 = var_340_8.localPosition
				var_340_8.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10109", 3)

				local var_340_10 = var_340_8.childCount

				for iter_340_4 = 0, var_340_10 - 1 do
					local var_340_11 = var_340_8:GetChild(iter_340_4)

					if var_340_11.name == "" or not string.find(var_340_11.name, "split") then
						var_340_11.gameObject:SetActive(true)
					else
						var_340_11.gameObject:SetActive(false)
					end
				end
			end

			local var_340_12 = 0.001

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_12 then
				local var_340_13 = (arg_337_1.time_ - var_340_9) / var_340_12
				local var_340_14 = Vector3.New(0, -346.2, -395)

				var_340_8.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10109, var_340_14, var_340_13)
			end

			if arg_337_1.time_ >= var_340_9 + var_340_12 and arg_337_1.time_ < var_340_9 + var_340_12 + arg_340_0 then
				var_340_8.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_340_15 = 0
			local var_340_16 = 0.5

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_17 = arg_337_1:FormatText(StoryNameCfg[1093].name)

				arg_337_1.leftNameTxt_.text = var_340_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_18 = arg_337_1:GetWordFromCfg(416201080)
				local var_340_19 = arg_337_1:FormatText(var_340_18.content)

				arg_337_1.text_.text = var_340_19

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_20 = 20
				local var_340_21 = utf8.len(var_340_19)
				local var_340_22 = var_340_20 <= 0 and var_340_16 or var_340_16 * (var_340_21 / var_340_20)

				if var_340_22 > 0 and var_340_16 < var_340_22 then
					arg_337_1.talkMaxDuration = var_340_22

					if var_340_22 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_15
					end
				end

				arg_337_1.text_.text = var_340_19
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201080", "story_v_out_416201.awb") ~= 0 then
					local var_340_23 = manager.audio:GetVoiceLength("story_v_out_416201", "416201080", "story_v_out_416201.awb") / 1000

					if var_340_23 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_15
					end

					if var_340_18.prefab_name ~= "" and arg_337_1.actors_[var_340_18.prefab_name] ~= nil then
						local var_340_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_18.prefab_name].transform, "story_v_out_416201", "416201080", "story_v_out_416201.awb")

						arg_337_1:RecordAudio("416201080", var_340_24)
						arg_337_1:RecordAudio("416201080", var_340_24)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_416201", "416201080", "story_v_out_416201.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_416201", "416201080", "story_v_out_416201.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_25 = math.max(var_340_16, arg_337_1.talkMaxDuration)

			if var_340_15 <= arg_337_1.time_ and arg_337_1.time_ < var_340_15 + var_340_25 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_15) / var_340_25

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_15 + var_340_25 and arg_337_1.time_ < var_340_15 + var_340_25 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play416201081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416201081
		arg_341_1.duration_ = 8.13

		local var_341_0 = {
			zh = 4.433,
			ja = 8.133
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
				arg_341_0:Play416201082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10127"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps10127 == nil then
				arg_341_1.var_.actorSpriteComps10127 = var_344_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_2 = 0.2

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.actorSpriteComps10127 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.actorSpriteComps10127 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_344_3 then
						if arg_341_1.isInRecall_ then
							iter_344_3.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps10127 = nil
			end

			local var_344_8 = arg_341_1.actors_["10109"]
			local var_344_9 = 0

			if var_344_9 < arg_341_1.time_ and arg_341_1.time_ <= var_344_9 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps10109 == nil then
				arg_341_1.var_.actorSpriteComps10109 = var_344_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_10 = 0.2

			if var_344_9 <= arg_341_1.time_ and arg_341_1.time_ < var_344_9 + var_344_10 and not isNil(var_344_8) then
				local var_344_11 = (arg_341_1.time_ - var_344_9) / var_344_10

				if arg_341_1.var_.actorSpriteComps10109 then
					for iter_344_4, iter_344_5 in pairs(arg_341_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_344_5 then
							if arg_341_1.isInRecall_ then
								local var_344_12 = Mathf.Lerp(iter_344_5.color.r, arg_341_1.hightColor2.r, var_344_11)
								local var_344_13 = Mathf.Lerp(iter_344_5.color.g, arg_341_1.hightColor2.g, var_344_11)
								local var_344_14 = Mathf.Lerp(iter_344_5.color.b, arg_341_1.hightColor2.b, var_344_11)

								iter_344_5.color = Color.New(var_344_12, var_344_13, var_344_14)
							else
								local var_344_15 = Mathf.Lerp(iter_344_5.color.r, 0.5, var_344_11)

								iter_344_5.color = Color.New(var_344_15, var_344_15, var_344_15)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_9 + var_344_10 and arg_341_1.time_ < var_344_9 + var_344_10 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps10109 then
				for iter_344_6, iter_344_7 in pairs(arg_341_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_344_7 then
						if arg_341_1.isInRecall_ then
							iter_344_7.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps10109 = nil
			end

			local var_344_16 = arg_341_1.actors_["10109"].transform
			local var_344_17 = 0

			if var_344_17 < arg_341_1.time_ and arg_341_1.time_ <= var_344_17 + arg_344_0 then
				arg_341_1.var_.moveOldPos10109 = var_344_16.localPosition
				var_344_16.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10109", 7)

				local var_344_18 = var_344_16.childCount

				for iter_344_8 = 0, var_344_18 - 1 do
					local var_344_19 = var_344_16:GetChild(iter_344_8)

					if var_344_19.name == "" or not string.find(var_344_19.name, "split") then
						var_344_19.gameObject:SetActive(true)
					else
						var_344_19.gameObject:SetActive(false)
					end
				end
			end

			local var_344_20 = 0.001

			if var_344_17 <= arg_341_1.time_ and arg_341_1.time_ < var_344_17 + var_344_20 then
				local var_344_21 = (arg_341_1.time_ - var_344_17) / var_344_20
				local var_344_22 = Vector3.New(0, -2000, 0)

				var_344_16.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10109, var_344_22, var_344_21)
			end

			if arg_341_1.time_ >= var_344_17 + var_344_20 and arg_341_1.time_ < var_344_17 + var_344_20 + arg_344_0 then
				var_344_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_344_23 = arg_341_1.actors_["10127"].transform
			local var_344_24 = 0

			if var_344_24 < arg_341_1.time_ and arg_341_1.time_ <= var_344_24 + arg_344_0 then
				arg_341_1.var_.moveOldPos10127 = var_344_23.localPosition
				var_344_23.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10127", 2)

				local var_344_25 = var_344_23.childCount

				for iter_344_9 = 0, var_344_25 - 1 do
					local var_344_26 = var_344_23:GetChild(iter_344_9)

					if var_344_26.name == "split_6" or not string.find(var_344_26.name, "split") then
						var_344_26.gameObject:SetActive(true)
					else
						var_344_26.gameObject:SetActive(false)
					end
				end
			end

			local var_344_27 = 0.001

			if var_344_24 <= arg_341_1.time_ and arg_341_1.time_ < var_344_24 + var_344_27 then
				local var_344_28 = (arg_341_1.time_ - var_344_24) / var_344_27
				local var_344_29 = Vector3.New(-390, -387.4, -316.5)

				var_344_23.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10127, var_344_29, var_344_28)
			end

			if arg_341_1.time_ >= var_344_24 + var_344_27 and arg_341_1.time_ < var_344_24 + var_344_27 + arg_344_0 then
				var_344_23.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_344_30 = 0
			local var_344_31 = 0.575

			if var_344_30 < arg_341_1.time_ and arg_341_1.time_ <= var_344_30 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_32 = arg_341_1:FormatText(StoryNameCfg[236].name)

				arg_341_1.leftNameTxt_.text = var_344_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_33 = arg_341_1:GetWordFromCfg(416201081)
				local var_344_34 = arg_341_1:FormatText(var_344_33.content)

				arg_341_1.text_.text = var_344_34

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_35 = 23
				local var_344_36 = utf8.len(var_344_34)
				local var_344_37 = var_344_35 <= 0 and var_344_31 or var_344_31 * (var_344_36 / var_344_35)

				if var_344_37 > 0 and var_344_31 < var_344_37 then
					arg_341_1.talkMaxDuration = var_344_37

					if var_344_37 + var_344_30 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_37 + var_344_30
					end
				end

				arg_341_1.text_.text = var_344_34
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201081", "story_v_out_416201.awb") ~= 0 then
					local var_344_38 = manager.audio:GetVoiceLength("story_v_out_416201", "416201081", "story_v_out_416201.awb") / 1000

					if var_344_38 + var_344_30 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_38 + var_344_30
					end

					if var_344_33.prefab_name ~= "" and arg_341_1.actors_[var_344_33.prefab_name] ~= nil then
						local var_344_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_33.prefab_name].transform, "story_v_out_416201", "416201081", "story_v_out_416201.awb")

						arg_341_1:RecordAudio("416201081", var_344_39)
						arg_341_1:RecordAudio("416201081", var_344_39)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416201", "416201081", "story_v_out_416201.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416201", "416201081", "story_v_out_416201.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_40 = math.max(var_344_31, arg_341_1.talkMaxDuration)

			if var_344_30 <= arg_341_1.time_ and arg_341_1.time_ < var_344_30 + var_344_40 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_30) / var_344_40

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_30 + var_344_40 and arg_341_1.time_ < var_344_30 + var_344_40 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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

		arg_341_1:InitPlayNodeList()
	end,
	Play416201082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416201082
		arg_345_1.duration_ = 5

		local var_345_0 = {
			zh = 3.833,
			ja = 5
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play416201083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10122"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10122 == nil then
				arg_345_1.var_.actorSpriteComps10122 = var_348_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.actorSpriteComps10122 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								local var_348_4 = Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor1.r, var_348_3)
								local var_348_5 = Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor1.g, var_348_3)
								local var_348_6 = Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor1.b, var_348_3)

								iter_348_1.color = Color.New(var_348_4, var_348_5, var_348_6)
							else
								local var_348_7 = Mathf.Lerp(iter_348_1.color.r, 1, var_348_3)

								iter_348_1.color = Color.New(var_348_7, var_348_7, var_348_7)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10122 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_348_3 then
						if arg_345_1.isInRecall_ then
							iter_348_3.color = arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_348_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10122 = nil
			end

			local var_348_8 = arg_345_1.actors_["10127"]
			local var_348_9 = 0

			if var_348_9 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 and not isNil(var_348_8) and arg_345_1.var_.actorSpriteComps10127 == nil then
				arg_345_1.var_.actorSpriteComps10127 = var_348_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_10 = 0.2

			if var_348_9 <= arg_345_1.time_ and arg_345_1.time_ < var_348_9 + var_348_10 and not isNil(var_348_8) then
				local var_348_11 = (arg_345_1.time_ - var_348_9) / var_348_10

				if arg_345_1.var_.actorSpriteComps10127 then
					for iter_348_4, iter_348_5 in pairs(arg_345_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_348_5 then
							if arg_345_1.isInRecall_ then
								local var_348_12 = Mathf.Lerp(iter_348_5.color.r, arg_345_1.hightColor2.r, var_348_11)
								local var_348_13 = Mathf.Lerp(iter_348_5.color.g, arg_345_1.hightColor2.g, var_348_11)
								local var_348_14 = Mathf.Lerp(iter_348_5.color.b, arg_345_1.hightColor2.b, var_348_11)

								iter_348_5.color = Color.New(var_348_12, var_348_13, var_348_14)
							else
								local var_348_15 = Mathf.Lerp(iter_348_5.color.r, 0.5, var_348_11)

								iter_348_5.color = Color.New(var_348_15, var_348_15, var_348_15)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_9 + var_348_10 and arg_345_1.time_ < var_348_9 + var_348_10 + arg_348_0 and not isNil(var_348_8) and arg_345_1.var_.actorSpriteComps10127 then
				for iter_348_6, iter_348_7 in pairs(arg_345_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_348_7 then
						if arg_345_1.isInRecall_ then
							iter_348_7.color = arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_348_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10127 = nil
			end

			local var_348_16 = arg_345_1.actors_["10122"].transform
			local var_348_17 = 0

			if var_348_17 < arg_345_1.time_ and arg_345_1.time_ <= var_348_17 + arg_348_0 then
				arg_345_1.var_.moveOldPos10122 = var_348_16.localPosition
				var_348_16.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10122", 4)

				local var_348_18 = var_348_16.childCount

				for iter_348_8 = 0, var_348_18 - 1 do
					local var_348_19 = var_348_16:GetChild(iter_348_8)

					if var_348_19.name == "split_4" or not string.find(var_348_19.name, "split") then
						var_348_19.gameObject:SetActive(true)
					else
						var_348_19.gameObject:SetActive(false)
					end
				end
			end

			local var_348_20 = 0.001

			if var_348_17 <= arg_345_1.time_ and arg_345_1.time_ < var_348_17 + var_348_20 then
				local var_348_21 = (arg_345_1.time_ - var_348_17) / var_348_20
				local var_348_22 = Vector3.New(390, -380, -100)

				var_348_16.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10122, var_348_22, var_348_21)
			end

			if arg_345_1.time_ >= var_348_17 + var_348_20 and arg_345_1.time_ < var_348_17 + var_348_20 + arg_348_0 then
				var_348_16.localPosition = Vector3.New(390, -380, -100)
			end

			local var_348_23 = 0
			local var_348_24 = 0.4

			if var_348_23 < arg_345_1.time_ and arg_345_1.time_ <= var_348_23 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_25 = arg_345_1:FormatText(StoryNameCfg[8].name)

				arg_345_1.leftNameTxt_.text = var_348_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_26 = arg_345_1:GetWordFromCfg(416201082)
				local var_348_27 = arg_345_1:FormatText(var_348_26.content)

				arg_345_1.text_.text = var_348_27

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_28 = 16
				local var_348_29 = utf8.len(var_348_27)
				local var_348_30 = var_348_28 <= 0 and var_348_24 or var_348_24 * (var_348_29 / var_348_28)

				if var_348_30 > 0 and var_348_24 < var_348_30 then
					arg_345_1.talkMaxDuration = var_348_30

					if var_348_30 + var_348_23 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_30 + var_348_23
					end
				end

				arg_345_1.text_.text = var_348_27
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201082", "story_v_out_416201.awb") ~= 0 then
					local var_348_31 = manager.audio:GetVoiceLength("story_v_out_416201", "416201082", "story_v_out_416201.awb") / 1000

					if var_348_31 + var_348_23 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_31 + var_348_23
					end

					if var_348_26.prefab_name ~= "" and arg_345_1.actors_[var_348_26.prefab_name] ~= nil then
						local var_348_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_26.prefab_name].transform, "story_v_out_416201", "416201082", "story_v_out_416201.awb")

						arg_345_1:RecordAudio("416201082", var_348_32)
						arg_345_1:RecordAudio("416201082", var_348_32)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_416201", "416201082", "story_v_out_416201.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_416201", "416201082", "story_v_out_416201.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_33 = math.max(var_348_24, arg_345_1.talkMaxDuration)

			if var_348_23 <= arg_345_1.time_ and arg_345_1.time_ < var_348_23 + var_348_33 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_23) / var_348_33

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_23 + var_348_33 and arg_345_1.time_ < var_348_23 + var_348_33 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416201083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 416201083
		arg_349_1.duration_ = 8.1

		local var_349_0 = {
			zh = 4.6,
			ja = 8.1
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play416201084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10127"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10127 == nil then
				arg_349_1.var_.actorSpriteComps10127 = var_352_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_2 = 0.2

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.actorSpriteComps10127 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								local var_352_4 = Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor1.r, var_352_3)
								local var_352_5 = Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor1.g, var_352_3)
								local var_352_6 = Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor1.b, var_352_3)

								iter_352_1.color = Color.New(var_352_4, var_352_5, var_352_6)
							else
								local var_352_7 = Mathf.Lerp(iter_352_1.color.r, 1, var_352_3)

								iter_352_1.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10127 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_352_3 then
						if arg_349_1.isInRecall_ then
							iter_352_3.color = arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_352_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10127 = nil
			end

			local var_352_8 = arg_349_1.actors_["10122"]
			local var_352_9 = 0

			if var_352_9 < arg_349_1.time_ and arg_349_1.time_ <= var_352_9 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.actorSpriteComps10122 == nil then
				arg_349_1.var_.actorSpriteComps10122 = var_352_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_10 = 0.2

			if var_352_9 <= arg_349_1.time_ and arg_349_1.time_ < var_352_9 + var_352_10 and not isNil(var_352_8) then
				local var_352_11 = (arg_349_1.time_ - var_352_9) / var_352_10

				if arg_349_1.var_.actorSpriteComps10122 then
					for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_352_5 then
							if arg_349_1.isInRecall_ then
								local var_352_12 = Mathf.Lerp(iter_352_5.color.r, arg_349_1.hightColor2.r, var_352_11)
								local var_352_13 = Mathf.Lerp(iter_352_5.color.g, arg_349_1.hightColor2.g, var_352_11)
								local var_352_14 = Mathf.Lerp(iter_352_5.color.b, arg_349_1.hightColor2.b, var_352_11)

								iter_352_5.color = Color.New(var_352_12, var_352_13, var_352_14)
							else
								local var_352_15 = Mathf.Lerp(iter_352_5.color.r, 0.5, var_352_11)

								iter_352_5.color = Color.New(var_352_15, var_352_15, var_352_15)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_9 + var_352_10 and arg_349_1.time_ < var_352_9 + var_352_10 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.actorSpriteComps10122 then
				for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_352_7 then
						if arg_349_1.isInRecall_ then
							iter_352_7.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10122 = nil
			end

			local var_352_16 = 0
			local var_352_17 = 0.625

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_18 = arg_349_1:FormatText(StoryNameCfg[236].name)

				arg_349_1.leftNameTxt_.text = var_352_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_19 = arg_349_1:GetWordFromCfg(416201083)
				local var_352_20 = arg_349_1:FormatText(var_352_19.content)

				arg_349_1.text_.text = var_352_20

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_21 = 25
				local var_352_22 = utf8.len(var_352_20)
				local var_352_23 = var_352_21 <= 0 and var_352_17 or var_352_17 * (var_352_22 / var_352_21)

				if var_352_23 > 0 and var_352_17 < var_352_23 then
					arg_349_1.talkMaxDuration = var_352_23

					if var_352_23 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_23 + var_352_16
					end
				end

				arg_349_1.text_.text = var_352_20
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201083", "story_v_out_416201.awb") ~= 0 then
					local var_352_24 = manager.audio:GetVoiceLength("story_v_out_416201", "416201083", "story_v_out_416201.awb") / 1000

					if var_352_24 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_24 + var_352_16
					end

					if var_352_19.prefab_name ~= "" and arg_349_1.actors_[var_352_19.prefab_name] ~= nil then
						local var_352_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_19.prefab_name].transform, "story_v_out_416201", "416201083", "story_v_out_416201.awb")

						arg_349_1:RecordAudio("416201083", var_352_25)
						arg_349_1:RecordAudio("416201083", var_352_25)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_416201", "416201083", "story_v_out_416201.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_416201", "416201083", "story_v_out_416201.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_26 = math.max(var_352_17, arg_349_1.talkMaxDuration)

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_26 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_16) / var_352_26

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_16 + var_352_26 and arg_349_1.time_ < var_352_16 + var_352_26 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play416201084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 416201084
		arg_353_1.duration_ = 4.77

		local var_353_0 = {
			zh = 3.433,
			ja = 4.766
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10127"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos10127 = var_356_0.localPosition
				var_356_0.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10127", 2)

				local var_356_2 = var_356_0.childCount

				for iter_356_0 = 0, var_356_2 - 1 do
					local var_356_3 = var_356_0:GetChild(iter_356_0)

					if var_356_3.name == "" or not string.find(var_356_3.name, "split") then
						var_356_3.gameObject:SetActive(true)
					else
						var_356_3.gameObject:SetActive(false)
					end
				end
			end

			local var_356_4 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_4 then
				local var_356_5 = (arg_353_1.time_ - var_356_1) / var_356_4
				local var_356_6 = Vector3.New(-390, -387.4, -316.5)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10127, var_356_6, var_356_5)
			end

			if arg_353_1.time_ >= var_356_1 + var_356_4 and arg_353_1.time_ < var_356_1 + var_356_4 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_356_7 = 0
			local var_356_8 = 0.4

			if var_356_7 < arg_353_1.time_ and arg_353_1.time_ <= var_356_7 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_9 = arg_353_1:FormatText(StoryNameCfg[236].name)

				arg_353_1.leftNameTxt_.text = var_356_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(416201084)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_12 = 16
				local var_356_13 = utf8.len(var_356_11)
				local var_356_14 = var_356_12 <= 0 and var_356_8 or var_356_8 * (var_356_13 / var_356_12)

				if var_356_14 > 0 and var_356_8 < var_356_14 then
					arg_353_1.talkMaxDuration = var_356_14

					if var_356_14 + var_356_7 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_7
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416201", "416201084", "story_v_out_416201.awb") ~= 0 then
					local var_356_15 = manager.audio:GetVoiceLength("story_v_out_416201", "416201084", "story_v_out_416201.awb") / 1000

					if var_356_15 + var_356_7 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_15 + var_356_7
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_416201", "416201084", "story_v_out_416201.awb")

						arg_353_1:RecordAudio("416201084", var_356_16)
						arg_353_1:RecordAudio("416201084", var_356_16)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_416201", "416201084", "story_v_out_416201.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_416201", "416201084", "story_v_out_416201.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_17 = math.max(var_356_8, arg_353_1.talkMaxDuration)

			if var_356_7 <= arg_353_1.time_ and arg_353_1.time_ < var_356_7 + var_356_17 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_7) / var_356_17

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_7 + var_356_17 and arg_353_1.time_ < var_356_7 + var_356_17 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F09f",
		"TextureConfig/Background/I13i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_416201.awb"
	}
}
