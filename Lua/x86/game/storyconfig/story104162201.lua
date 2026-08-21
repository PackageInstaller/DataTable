return {
	Play416221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416221001
		arg_1_1.duration_ = 8.87

		local var_1_0 = {
			zh = 5.5,
			ja = 8.866
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
				arg_1_0:Play416221002(arg_1_1)
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

			local var_4_24 = "10127"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

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

			local var_4_28 = arg_1_1.actors_["10127"].transform
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10127 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10127", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -387.4, -316.5)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10127, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_4_35 = arg_1_1.actors_["10127"]
			local var_4_36 = 1.66666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_37 = var_4_35:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_37 then
					arg_1_1.var_.alphaOldValue10127 = var_4_37.alpha
					arg_1_1.var_.characterEffect10127 = var_4_37
				end

				arg_1_1.var_.alphaOldValue10127 = 0
			end

			local var_4_38 = 0.165343279329439

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_36) / var_4_38
				local var_4_40 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10127, 1, var_4_39)

				if arg_1_1.var_.characterEffect10127 then
					arg_1_1.var_.characterEffect10127.alpha = var_4_40
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_38 and arg_1_1.time_ < var_4_36 + var_4_38 + arg_4_0 and arg_1_1.var_.characterEffect10127 then
				arg_1_1.var_.characterEffect10127.alpha = 1
			end

			local var_4_41 = arg_1_1.actors_["10127"]
			local var_4_42 = 1.66666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.actorSpriteComps10127 == nil then
				arg_1_1.var_.actorSpriteComps10127 = var_4_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_43 = 0.2

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 and not isNil(var_4_41) then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43

				if arg_1_1.var_.actorSpriteComps10127 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_45 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_44)
								local var_4_46 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_44)
								local var_4_47 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_44)

								iter_4_6.color = Color.New(var_4_45, var_4_46, var_4_47)
							else
								local var_4_48 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_44)

								iter_4_6.color = Color.New(var_4_48, var_4_48, var_4_48)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.actorSpriteComps10127 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10127 = nil
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

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

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
			local var_4_62 = 0.575

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[236].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416221001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221001", "story_v_out_416221.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416221", "416221001", "story_v_out_416221.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416221", "416221001", "story_v_out_416221.awb")

						arg_1_1:RecordAudio("416221001", var_4_71)
						arg_1_1:RecordAudio("416221001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416221", "416221001", "story_v_out_416221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416221", "416221001", "story_v_out_416221.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416221002
		arg_9_1.duration_ = 4.93

		local var_9_0 = {
			zh = 4.933,
			ja = 4.6
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
				arg_9_0:Play416221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1086"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["1086"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1086 == nil then
				arg_9_1.var_.actorSpriteComps1086 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps1086 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								local var_12_8 = Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, var_12_7)
								local var_12_9 = Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, var_12_7)
								local var_12_10 = Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, var_12_7)

								iter_12_3.color = Color.New(var_12_8, var_12_9, var_12_10)
							else
								local var_12_11 = Mathf.Lerp(iter_12_3.color.r, 1, var_12_7)

								iter_12_3.color = Color.New(var_12_11, var_12_11, var_12_11)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1086 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1086 = nil
			end

			local var_12_12 = arg_9_1.actors_["10127"]
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.actorSpriteComps10127 == nil then
				arg_9_1.var_.actorSpriteComps10127 = var_12_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_14 = 0.2

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_14 and not isNil(var_12_12) then
				local var_12_15 = (arg_9_1.time_ - var_12_13) / var_12_14

				if arg_9_1.var_.actorSpriteComps10127 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								local var_12_16 = Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor2.r, var_12_15)
								local var_12_17 = Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor2.g, var_12_15)
								local var_12_18 = Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor2.b, var_12_15)

								iter_12_7.color = Color.New(var_12_16, var_12_17, var_12_18)
							else
								local var_12_19 = Mathf.Lerp(iter_12_7.color.r, 0.5, var_12_15)

								iter_12_7.color = Color.New(var_12_19, var_12_19, var_12_19)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_13 + var_12_14 and arg_9_1.time_ < var_12_13 + var_12_14 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.actorSpriteComps10127 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_12_9 then
						if arg_9_1.isInRecall_ then
							iter_12_9.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10127 = nil
			end

			local var_12_20 = arg_9_1.actors_["1086"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos1086 = var_12_20.localPosition
				var_12_20.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1086", 3)

				local var_12_22 = var_12_20.childCount

				for iter_12_10 = 0, var_12_22 - 1 do
					local var_12_23 = var_12_20:GetChild(iter_12_10)

					if var_12_23.name == "" or not string.find(var_12_23.name, "split") then
						var_12_23.gameObject:SetActive(true)
					else
						var_12_23.gameObject:SetActive(false)
					end
				end
			end

			local var_12_24 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_24 then
				local var_12_25 = (arg_9_1.time_ - var_12_21) / var_12_24
				local var_12_26 = Vector3.New(0, -404.2, -237.9)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1086, var_12_26, var_12_25)
			end

			if arg_9_1.time_ >= var_12_21 + var_12_24 and arg_9_1.time_ < var_12_21 + var_12_24 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_12_27 = arg_9_1.actors_["10127"].transform
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				arg_9_1.var_.moveOldPos10127 = var_12_27.localPosition
				var_12_27.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10127", 7)

				local var_12_29 = var_12_27.childCount

				for iter_12_11 = 0, var_12_29 - 1 do
					local var_12_30 = var_12_27:GetChild(iter_12_11)

					if var_12_30.name == "" or not string.find(var_12_30.name, "split") then
						var_12_30.gameObject:SetActive(true)
					else
						var_12_30.gameObject:SetActive(false)
					end
				end
			end

			local var_12_31 = 0.001

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_31 then
				local var_12_32 = (arg_9_1.time_ - var_12_28) / var_12_31
				local var_12_33 = Vector3.New(0, -2000, 0)

				var_12_27.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10127, var_12_33, var_12_32)
			end

			if arg_9_1.time_ >= var_12_28 + var_12_31 and arg_9_1.time_ < var_12_28 + var_12_31 + arg_12_0 then
				var_12_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_34 = 0
			local var_12_35 = 0.55

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[1080].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(416221002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 22
				local var_12_40 = utf8.len(var_12_38)
				local var_12_41 = var_12_39 <= 0 and var_12_35 or var_12_35 * (var_12_40 / var_12_39)

				if var_12_41 > 0 and var_12_35 < var_12_41 then
					arg_9_1.talkMaxDuration = var_12_41

					if var_12_41 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_34
					end
				end

				arg_9_1.text_.text = var_12_38
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221002", "story_v_out_416221.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_416221", "416221002", "story_v_out_416221.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_416221", "416221002", "story_v_out_416221.awb")

						arg_9_1:RecordAudio("416221002", var_12_43)
						arg_9_1:RecordAudio("416221002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416221", "416221002", "story_v_out_416221.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416221", "416221002", "story_v_out_416221.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_44 = math.max(var_12_35, arg_9_1.talkMaxDuration)

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_44 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_34) / var_12_44

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_34 + var_12_44 and arg_9_1.time_ < var_12_34 + var_12_44 + arg_12_0 then
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

		arg_9_1:InitPlayNodeList()
	end,
	Play416221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416221003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1086"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1086 == nil then
				arg_13_1.var_.actorSpriteComps1086 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1086 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1086 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1086 = nil
			end

			local var_16_8 = arg_13_1.actors_["1086"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1086 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1086", 7)

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
				local var_16_14 = Vector3.New(0, -2000, 0)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1086, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_15 = 0
			local var_16_16 = 1.5

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(416221003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 60
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
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
	Play416221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416221004
		arg_17_1.duration_ = 4.9

		local var_17_0 = {
			zh = 3.633,
			ja = 4.9
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
				arg_17_0:Play416221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1028"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["1028"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1028 == nil then
				arg_17_1.var_.actorSpriteComps1028 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps1028 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1028 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1028 = nil
			end

			local var_20_12 = arg_17_1.actors_["1028"].transform
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.var_.moveOldPos1028 = var_20_12.localPosition
				var_20_12.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1028", 4)

				local var_20_14 = var_20_12.childCount

				for iter_20_6 = 0, var_20_14 - 1 do
					local var_20_15 = var_20_12:GetChild(iter_20_6)

					if var_20_15.name == "" or not string.find(var_20_15.name, "split") then
						var_20_15.gameObject:SetActive(true)
					else
						var_20_15.gameObject:SetActive(false)
					end
				end
			end

			local var_20_16 = 0.001

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_13) / var_20_16
				local var_20_18 = Vector3.New(390, -402.7, -156.1)

				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1028, var_20_18, var_20_17)
			end

			if arg_17_1.time_ >= var_20_13 + var_20_16 and arg_17_1.time_ < var_20_13 + var_20_16 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_20_19 = 0
			local var_20_20 = 0.475

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_21 = arg_17_1:FormatText(StoryNameCfg[327].name)

				arg_17_1.leftNameTxt_.text = var_20_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_22 = arg_17_1:GetWordFromCfg(416221004)
				local var_20_23 = arg_17_1:FormatText(var_20_22.content)

				arg_17_1.text_.text = var_20_23

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_24 = 19
				local var_20_25 = utf8.len(var_20_23)
				local var_20_26 = var_20_24 <= 0 and var_20_20 or var_20_20 * (var_20_25 / var_20_24)

				if var_20_26 > 0 and var_20_20 < var_20_26 then
					arg_17_1.talkMaxDuration = var_20_26

					if var_20_26 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_26 + var_20_19
					end
				end

				arg_17_1.text_.text = var_20_23
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221004", "story_v_out_416221.awb") ~= 0 then
					local var_20_27 = manager.audio:GetVoiceLength("story_v_out_416221", "416221004", "story_v_out_416221.awb") / 1000

					if var_20_27 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_19
					end

					if var_20_22.prefab_name ~= "" and arg_17_1.actors_[var_20_22.prefab_name] ~= nil then
						local var_20_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_22.prefab_name].transform, "story_v_out_416221", "416221004", "story_v_out_416221.awb")

						arg_17_1:RecordAudio("416221004", var_20_28)
						arg_17_1:RecordAudio("416221004", var_20_28)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416221", "416221004", "story_v_out_416221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416221", "416221004", "story_v_out_416221.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_29 = math.max(var_20_20, arg_17_1.talkMaxDuration)

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_29 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_29

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_29 and arg_17_1.time_ < var_20_19 + var_20_29 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play416221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416221005
		arg_21_1.duration_ = 4.07

		local var_21_0 = {
			zh = 3.366,
			ja = 4.066
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
				arg_21_0:Play416221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10127"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10127 == nil then
				arg_21_1.var_.actorSpriteComps10127 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10127 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10127 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10127 = nil
			end

			local var_24_8 = arg_21_1.actors_["1028"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1028 == nil then
				arg_21_1.var_.actorSpriteComps1028 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1028 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1028 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1028 = nil
			end

			local var_24_16 = arg_21_1.actors_["10127"].transform
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.var_.moveOldPos10127 = var_24_16.localPosition
				var_24_16.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10127", 2)

				local var_24_18 = var_24_16.childCount

				for iter_24_8 = 0, var_24_18 - 1 do
					local var_24_19 = var_24_16:GetChild(iter_24_8)

					if var_24_19.name == "" or not string.find(var_24_19.name, "split") then
						var_24_19.gameObject:SetActive(true)
					else
						var_24_19.gameObject:SetActive(false)
					end
				end
			end

			local var_24_20 = 0.001

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_20 then
				local var_24_21 = (arg_21_1.time_ - var_24_17) / var_24_20
				local var_24_22 = Vector3.New(-390, -387.4, -316.5)

				var_24_16.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10127, var_24_22, var_24_21)
			end

			if arg_21_1.time_ >= var_24_17 + var_24_20 and arg_21_1.time_ < var_24_17 + var_24_20 + arg_24_0 then
				var_24_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_24_23 = 0
			local var_24_24 = 0.5

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[236].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(416221005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221005", "story_v_out_416221.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221005", "story_v_out_416221.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_416221", "416221005", "story_v_out_416221.awb")

						arg_21_1:RecordAudio("416221005", var_24_32)
						arg_21_1:RecordAudio("416221005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416221", "416221005", "story_v_out_416221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416221", "416221005", "story_v_out_416221.awb")
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
				actorName = "10127",
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
	Play416221006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416221006
		arg_25_1.duration_ = 7.27

		local var_25_0 = {
			zh = 3.566,
			ja = 7.266
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
				arg_25_0:Play416221007(arg_25_1)
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

			local var_28_8 = arg_25_1.actors_["10127"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10127 == nil then
				arg_25_1.var_.actorSpriteComps10127 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps10127 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10127 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10127 = nil
			end

			local var_28_16 = 0
			local var_28_17 = 0.5

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

				local var_28_19 = arg_25_1:GetWordFromCfg(416221006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221006", "story_v_out_416221.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221006", "story_v_out_416221.awb") / 1000

					if var_28_24 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_416221", "416221006", "story_v_out_416221.awb")

						arg_25_1:RecordAudio("416221006", var_28_25)
						arg_25_1:RecordAudio("416221006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416221", "416221006", "story_v_out_416221.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416221", "416221006", "story_v_out_416221.awb")
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
	Play416221007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416221007
		arg_29_1.duration_ = 5.3

		local var_29_0 = {
			zh = 3.433,
			ja = 5.3
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
				arg_29_0:Play416221008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10127"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10127 == nil then
				arg_29_1.var_.actorSpriteComps10127 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10127 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10127 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10127 = nil
			end

			local var_32_8 = arg_29_1.actors_["1028"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1028 == nil then
				arg_29_1.var_.actorSpriteComps1028 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps1028 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1028 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1028 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.475

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[236].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(416221007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221007", "story_v_out_416221.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221007", "story_v_out_416221.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_416221", "416221007", "story_v_out_416221.awb")

						arg_29_1:RecordAudio("416221007", var_32_25)
						arg_29_1:RecordAudio("416221007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416221", "416221007", "story_v_out_416221.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416221", "416221007", "story_v_out_416221.awb")
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
	Play416221008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416221008
		arg_33_1.duration_ = 7.6

		local var_33_0 = {
			zh = 7.6,
			ja = 6.733
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
				arg_33_0:Play416221009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1086"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1086 == nil then
				arg_33_1.var_.actorSpriteComps1086 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1086 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1086 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1086 = nil
			end

			local var_36_8 = arg_33_1.actors_["10127"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10127 == nil then
				arg_33_1.var_.actorSpriteComps10127 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.2

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps10127 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 0.5, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10127 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10127 = nil
			end

			local var_36_16 = arg_33_1.actors_["1028"].transform
			local var_36_17 = 0

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
				arg_33_1.var_.moveOldPos1028 = var_36_16.localPosition
				var_36_16.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1028", 7)

				local var_36_18 = var_36_16.childCount

				for iter_36_8 = 0, var_36_18 - 1 do
					local var_36_19 = var_36_16:GetChild(iter_36_8)

					if var_36_19.name == "" or not string.find(var_36_19.name, "split") then
						var_36_19.gameObject:SetActive(true)
					else
						var_36_19.gameObject:SetActive(false)
					end
				end
			end

			local var_36_20 = 0.001

			if var_36_17 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_20 then
				local var_36_21 = (arg_33_1.time_ - var_36_17) / var_36_20
				local var_36_22 = Vector3.New(0, -2000, 0)

				var_36_16.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1028, var_36_22, var_36_21)
			end

			if arg_33_1.time_ >= var_36_17 + var_36_20 and arg_33_1.time_ < var_36_17 + var_36_20 + arg_36_0 then
				var_36_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_23 = arg_33_1.actors_["10127"].transform
			local var_36_24 = 0

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 then
				arg_33_1.var_.moveOldPos10127 = var_36_23.localPosition
				var_36_23.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10127", 7)

				local var_36_25 = var_36_23.childCount

				for iter_36_9 = 0, var_36_25 - 1 do
					local var_36_26 = var_36_23:GetChild(iter_36_9)

					if var_36_26.name == "" or not string.find(var_36_26.name, "split") then
						var_36_26.gameObject:SetActive(true)
					else
						var_36_26.gameObject:SetActive(false)
					end
				end
			end

			local var_36_27 = 0.001

			if var_36_24 <= arg_33_1.time_ and arg_33_1.time_ < var_36_24 + var_36_27 then
				local var_36_28 = (arg_33_1.time_ - var_36_24) / var_36_27
				local var_36_29 = Vector3.New(0, -2000, 0)

				var_36_23.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10127, var_36_29, var_36_28)
			end

			if arg_33_1.time_ >= var_36_24 + var_36_27 and arg_33_1.time_ < var_36_24 + var_36_27 + arg_36_0 then
				var_36_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_30 = arg_33_1.actors_["1086"].transform
			local var_36_31 = 0

			if var_36_31 < arg_33_1.time_ and arg_33_1.time_ <= var_36_31 + arg_36_0 then
				arg_33_1.var_.moveOldPos1086 = var_36_30.localPosition
				var_36_30.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1086", 3)

				local var_36_32 = var_36_30.childCount

				for iter_36_10 = 0, var_36_32 - 1 do
					local var_36_33 = var_36_30:GetChild(iter_36_10)

					if var_36_33.name == "" or not string.find(var_36_33.name, "split") then
						var_36_33.gameObject:SetActive(true)
					else
						var_36_33.gameObject:SetActive(false)
					end
				end
			end

			local var_36_34 = 0.001

			if var_36_31 <= arg_33_1.time_ and arg_33_1.time_ < var_36_31 + var_36_34 then
				local var_36_35 = (arg_33_1.time_ - var_36_31) / var_36_34
				local var_36_36 = Vector3.New(0, -404.2, -237.9)

				var_36_30.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1086, var_36_36, var_36_35)
			end

			if arg_33_1.time_ >= var_36_31 + var_36_34 and arg_33_1.time_ < var_36_31 + var_36_34 + arg_36_0 then
				var_36_30.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_36_37 = 0
			local var_36_38 = 0.6

			if var_36_37 < arg_33_1.time_ and arg_33_1.time_ <= var_36_37 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_39 = arg_33_1:FormatText(StoryNameCfg[1080].name)

				arg_33_1.leftNameTxt_.text = var_36_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_40 = arg_33_1:GetWordFromCfg(416221008)
				local var_36_41 = arg_33_1:FormatText(var_36_40.content)

				arg_33_1.text_.text = var_36_41

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_42 = 24
				local var_36_43 = utf8.len(var_36_41)
				local var_36_44 = var_36_42 <= 0 and var_36_38 or var_36_38 * (var_36_43 / var_36_42)

				if var_36_44 > 0 and var_36_38 < var_36_44 then
					arg_33_1.talkMaxDuration = var_36_44

					if var_36_44 + var_36_37 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_44 + var_36_37
					end
				end

				arg_33_1.text_.text = var_36_41
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221008", "story_v_out_416221.awb") ~= 0 then
					local var_36_45 = manager.audio:GetVoiceLength("story_v_out_416221", "416221008", "story_v_out_416221.awb") / 1000

					if var_36_45 + var_36_37 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_45 + var_36_37
					end

					if var_36_40.prefab_name ~= "" and arg_33_1.actors_[var_36_40.prefab_name] ~= nil then
						local var_36_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_40.prefab_name].transform, "story_v_out_416221", "416221008", "story_v_out_416221.awb")

						arg_33_1:RecordAudio("416221008", var_36_46)
						arg_33_1:RecordAudio("416221008", var_36_46)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416221", "416221008", "story_v_out_416221.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416221", "416221008", "story_v_out_416221.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_47 = math.max(var_36_38, arg_33_1.talkMaxDuration)

			if var_36_37 <= arg_33_1.time_ and arg_33_1.time_ < var_36_37 + var_36_47 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_37) / var_36_47

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_37 + var_36_47 and arg_33_1.time_ < var_36_37 + var_36_47 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "1086",
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
	Play416221009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416221009
		arg_37_1.duration_ = 4.43

		local var_37_0 = {
			zh = 4.433,
			ja = 3.866
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
				arg_37_0:Play416221010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.475

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1080].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(416221009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221009", "story_v_out_416221.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221009", "story_v_out_416221.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_416221", "416221009", "story_v_out_416221.awb")

						arg_37_1:RecordAudio("416221009", var_40_9)
						arg_37_1:RecordAudio("416221009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416221", "416221009", "story_v_out_416221.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416221", "416221009", "story_v_out_416221.awb")
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
	Play416221010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416221010
		arg_41_1.duration_ = 4.87

		local var_41_0 = {
			zh = 3.666,
			ja = 4.866
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
				arg_41_0:Play416221011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "10122"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

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

			local var_44_4 = arg_41_1.actors_["10122"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps10122 == nil then
				arg_41_1.var_.actorSpriteComps10122 = var_44_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.actorSpriteComps10122 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps10122 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10122 = nil
			end

			local var_44_12 = arg_41_1.actors_["1086"]
			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps1086 == nil then
				arg_41_1.var_.actorSpriteComps1086 = var_44_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_14 = 0.2

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_14 and not isNil(var_44_12) then
				local var_44_15 = (arg_41_1.time_ - var_44_13) / var_44_14

				if arg_41_1.var_.actorSpriteComps1086 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_41_1.time_ >= var_44_13 + var_44_14 and arg_41_1.time_ < var_44_13 + var_44_14 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps1086 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1086 = nil
			end

			local var_44_20 = arg_41_1.actors_["1086"].transform
			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.var_.moveOldPos1086 = var_44_20.localPosition
				var_44_20.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1086", 7)

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

				var_44_20.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1086, var_44_26, var_44_25)
			end

			if arg_41_1.time_ >= var_44_21 + var_44_24 and arg_41_1.time_ < var_44_21 + var_44_24 + arg_44_0 then
				var_44_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_27 = arg_41_1.actors_["10122"].transform
			local var_44_28 = 0

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.var_.moveOldPos10122 = var_44_27.localPosition
				var_44_27.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10122", 4)

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
				local var_44_33 = Vector3.New(390, -380, -100)

				var_44_27.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10122, var_44_33, var_44_32)
			end

			if arg_41_1.time_ >= var_44_28 + var_44_31 and arg_41_1.time_ < var_44_28 + var_44_31 + arg_44_0 then
				var_44_27.localPosition = Vector3.New(390, -380, -100)
			end

			local var_44_34 = 0
			local var_44_35 = 0.375

			if var_44_34 < arg_41_1.time_ and arg_41_1.time_ <= var_44_34 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_36 = arg_41_1:FormatText(StoryNameCfg[8].name)

				arg_41_1.leftNameTxt_.text = var_44_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_37 = arg_41_1:GetWordFromCfg(416221010)
				local var_44_38 = arg_41_1:FormatText(var_44_37.content)

				arg_41_1.text_.text = var_44_38

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_39 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221010", "story_v_out_416221.awb") ~= 0 then
					local var_44_42 = manager.audio:GetVoiceLength("story_v_out_416221", "416221010", "story_v_out_416221.awb") / 1000

					if var_44_42 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_34
					end

					if var_44_37.prefab_name ~= "" and arg_41_1.actors_[var_44_37.prefab_name] ~= nil then
						local var_44_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_37.prefab_name].transform, "story_v_out_416221", "416221010", "story_v_out_416221.awb")

						arg_41_1:RecordAudio("416221010", var_44_43)
						arg_41_1:RecordAudio("416221010", var_44_43)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416221", "416221010", "story_v_out_416221.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416221", "416221010", "story_v_out_416221.awb")
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
				actorName = "10122",
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
	Play416221011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416221011
		arg_45_1.duration_ = 13.8

		local var_45_0 = {
			zh = 6.7,
			ja = 13.8
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
				arg_45_0:Play416221012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10127"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10127 == nil then
				arg_45_1.var_.actorSpriteComps10127 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10127 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10127 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10127 = nil
			end

			local var_48_8 = arg_45_1.actors_["10122"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10122 == nil then
				arg_45_1.var_.actorSpriteComps10122 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps10122 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10122 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10122 = nil
			end

			local var_48_16 = arg_45_1.actors_["10127"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos10127 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10127", 2)

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
				local var_48_22 = Vector3.New(-390, -387.4, -316.5)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10127, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_48_23 = 0
			local var_48_24 = 1.025

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[236].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(416221011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221011", "story_v_out_416221.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221011", "story_v_out_416221.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_416221", "416221011", "story_v_out_416221.awb")

						arg_45_1:RecordAudio("416221011", var_48_32)
						arg_45_1:RecordAudio("416221011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416221", "416221011", "story_v_out_416221.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416221", "416221011", "story_v_out_416221.awb")
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
				actorName = "10127",
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
	Play416221012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416221012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play416221013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10127"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10127 == nil then
				arg_49_1.var_.actorSpriteComps10127 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10127 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10127 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10127 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.875

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(416221012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 35
				local var_52_13 = utf8.len(var_52_11)
				local var_52_14 = var_52_12 <= 0 and var_52_9 or var_52_9 * (var_52_13 / var_52_12)

				if var_52_14 > 0 and var_52_9 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_15 and arg_49_1.time_ < var_52_8 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play416221013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416221013
		arg_53_1.duration_ = 8.73

		local var_53_0 = {
			zh = 8.733,
			ja = 6.2
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
				arg_53_0:Play416221014(arg_53_1)
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

			local var_56_8 = arg_53_1.actors_["1086"].transform
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.var_.moveOldPos1086 = var_56_8.localPosition
				var_56_8.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1086", 4)

				local var_56_10 = var_56_8.childCount

				for iter_56_4 = 0, var_56_10 - 1 do
					local var_56_11 = var_56_8:GetChild(iter_56_4)

					if var_56_11.name == "split_1" or not string.find(var_56_11.name, "split") then
						var_56_11.gameObject:SetActive(true)
					else
						var_56_11.gameObject:SetActive(false)
					end
				end
			end

			local var_56_12 = 0.001

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_9) / var_56_12
				local var_56_14 = Vector3.New(390, -404.2, -237.9)

				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1086, var_56_14, var_56_13)
			end

			if arg_53_1.time_ >= var_56_9 + var_56_12 and arg_53_1.time_ < var_56_9 + var_56_12 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_56_15 = arg_53_1.actors_["10122"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos10122 = var_56_15.localPosition
				var_56_15.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10122", 7)

				local var_56_17 = var_56_15.childCount

				for iter_56_5 = 0, var_56_17 - 1 do
					local var_56_18 = var_56_15:GetChild(iter_56_5)

					if var_56_18.name == "" or not string.find(var_56_18.name, "split") then
						var_56_18.gameObject:SetActive(true)
					else
						var_56_18.gameObject:SetActive(false)
					end
				end
			end

			local var_56_19 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_19 then
				local var_56_20 = (arg_53_1.time_ - var_56_16) / var_56_19
				local var_56_21 = Vector3.New(0, -2000, 0)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10122, var_56_21, var_56_20)
			end

			if arg_53_1.time_ >= var_56_16 + var_56_19 and arg_53_1.time_ < var_56_16 + var_56_19 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_22 = 0
			local var_56_23 = 0.575

			if var_56_22 < arg_53_1.time_ and arg_53_1.time_ <= var_56_22 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_24 = arg_53_1:FormatText(StoryNameCfg[1080].name)

				arg_53_1.leftNameTxt_.text = var_56_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_25 = arg_53_1:GetWordFromCfg(416221013)
				local var_56_26 = arg_53_1:FormatText(var_56_25.content)

				arg_53_1.text_.text = var_56_26

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_27 = 23
				local var_56_28 = utf8.len(var_56_26)
				local var_56_29 = var_56_27 <= 0 and var_56_23 or var_56_23 * (var_56_28 / var_56_27)

				if var_56_29 > 0 and var_56_23 < var_56_29 then
					arg_53_1.talkMaxDuration = var_56_29

					if var_56_29 + var_56_22 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_29 + var_56_22
					end
				end

				arg_53_1.text_.text = var_56_26
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221013", "story_v_out_416221.awb") ~= 0 then
					local var_56_30 = manager.audio:GetVoiceLength("story_v_out_416221", "416221013", "story_v_out_416221.awb") / 1000

					if var_56_30 + var_56_22 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_22
					end

					if var_56_25.prefab_name ~= "" and arg_53_1.actors_[var_56_25.prefab_name] ~= nil then
						local var_56_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_25.prefab_name].transform, "story_v_out_416221", "416221013", "story_v_out_416221.awb")

						arg_53_1:RecordAudio("416221013", var_56_31)
						arg_53_1:RecordAudio("416221013", var_56_31)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416221", "416221013", "story_v_out_416221.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416221", "416221013", "story_v_out_416221.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_32 = math.max(var_56_23, arg_53_1.talkMaxDuration)

			if var_56_22 <= arg_53_1.time_ and arg_53_1.time_ < var_56_22 + var_56_32 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_22) / var_56_32

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_22 + var_56_32 and arg_53_1.time_ < var_56_22 + var_56_32 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "10122",
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
	Play416221014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416221014
		arg_57_1.duration_ = 5.1

		local var_57_0 = {
			zh = 2.433,
			ja = 5.1
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
				arg_57_0:Play416221015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1080].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(416221014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221014", "story_v_out_416221.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221014", "story_v_out_416221.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_416221", "416221014", "story_v_out_416221.awb")

						arg_57_1:RecordAudio("416221014", var_60_9)
						arg_57_1:RecordAudio("416221014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416221", "416221014", "story_v_out_416221.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416221", "416221014", "story_v_out_416221.awb")
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
	Play416221015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416221015
		arg_61_1.duration_ = 9.53

		local var_61_0 = {
			zh = 4.366,
			ja = 9.533
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
				arg_61_0:Play416221016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10127"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10127 == nil then
				arg_61_1.var_.actorSpriteComps10127 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10127 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10127 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10127 = nil
			end

			local var_64_8 = arg_61_1.actors_["1086"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1086 == nil then
				arg_61_1.var_.actorSpriteComps1086 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1086 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1086 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1086 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.55

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[236].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(416221015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 22
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221015", "story_v_out_416221.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221015", "story_v_out_416221.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_416221", "416221015", "story_v_out_416221.awb")

						arg_61_1:RecordAudio("416221015", var_64_25)
						arg_61_1:RecordAudio("416221015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416221", "416221015", "story_v_out_416221.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416221", "416221015", "story_v_out_416221.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416221016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416221016
		arg_65_1.duration_ = 9.7

		local var_65_0 = {
			zh = 7.066,
			ja = 9.7
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
				arg_65_0:Play416221017(arg_65_1)
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

			local var_68_8 = arg_65_1.actors_["10127"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10127 == nil then
				arg_65_1.var_.actorSpriteComps10127 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10127 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10127 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10127 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.65

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

				local var_68_19 = arg_65_1:GetWordFromCfg(416221016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221016", "story_v_out_416221.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221016", "story_v_out_416221.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_416221", "416221016", "story_v_out_416221.awb")

						arg_65_1:RecordAudio("416221016", var_68_25)
						arg_65_1:RecordAudio("416221016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416221", "416221016", "story_v_out_416221.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416221", "416221016", "story_v_out_416221.awb")
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
	Play416221017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416221017
		arg_69_1.duration_ = 7.4

		local var_69_0 = {
			zh = 5.533,
			ja = 7.4
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
				arg_69_0:Play416221018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10127"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10127 == nil then
				arg_69_1.var_.actorSpriteComps10127 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10127 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10127 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10127 = nil
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
			local var_72_17 = 0.825

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[236].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(416221017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221017", "story_v_out_416221.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221017", "story_v_out_416221.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_416221", "416221017", "story_v_out_416221.awb")

						arg_69_1:RecordAudio("416221017", var_72_25)
						arg_69_1:RecordAudio("416221017", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416221", "416221017", "story_v_out_416221.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416221", "416221017", "story_v_out_416221.awb")
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
	Play416221018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416221018
		arg_73_1.duration_ = 5.3

		local var_73_0 = {
			zh = 2.9,
			ja = 5.3
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
				arg_73_0:Play416221019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1028"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1028 == nil then
				arg_73_1.var_.actorSpriteComps1028 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1028 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1028 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1028 = nil
			end

			local var_76_8 = arg_73_1.actors_["10127"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10127 == nil then
				arg_73_1.var_.actorSpriteComps10127 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps10127 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10127 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10127 = nil
			end

			local var_76_16 = arg_73_1.actors_["1086"].transform
			local var_76_17 = 0

			if var_76_17 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 then
				arg_73_1.var_.moveOldPos1086 = var_76_16.localPosition
				var_76_16.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1086", 7)

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
				local var_76_22 = Vector3.New(0, -2000, 0)

				var_76_16.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1086, var_76_22, var_76_21)
			end

			if arg_73_1.time_ >= var_76_17 + var_76_20 and arg_73_1.time_ < var_76_17 + var_76_20 + arg_76_0 then
				var_76_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_23 = arg_73_1.actors_["1028"].transform
			local var_76_24 = 0

			if var_76_24 < arg_73_1.time_ and arg_73_1.time_ <= var_76_24 + arg_76_0 then
				arg_73_1.var_.moveOldPos1028 = var_76_23.localPosition
				var_76_23.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1028", 4)

				local var_76_25 = var_76_23.childCount

				for iter_76_9 = 0, var_76_25 - 1 do
					local var_76_26 = var_76_23:GetChild(iter_76_9)

					if var_76_26.name == "" or not string.find(var_76_26.name, "split") then
						var_76_26.gameObject:SetActive(true)
					else
						var_76_26.gameObject:SetActive(false)
					end
				end
			end

			local var_76_27 = 0.001

			if var_76_24 <= arg_73_1.time_ and arg_73_1.time_ < var_76_24 + var_76_27 then
				local var_76_28 = (arg_73_1.time_ - var_76_24) / var_76_27
				local var_76_29 = Vector3.New(390, -402.7, -156.1)

				var_76_23.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1028, var_76_29, var_76_28)
			end

			if arg_73_1.time_ >= var_76_24 + var_76_27 and arg_73_1.time_ < var_76_24 + var_76_27 + arg_76_0 then
				var_76_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_76_30 = 0
			local var_76_31 = 0.325

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_32 = arg_73_1:FormatText(StoryNameCfg[327].name)

				arg_73_1.leftNameTxt_.text = var_76_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_33 = arg_73_1:GetWordFromCfg(416221018)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 13
				local var_76_36 = utf8.len(var_76_34)
				local var_76_37 = var_76_35 <= 0 and var_76_31 or var_76_31 * (var_76_36 / var_76_35)

				if var_76_37 > 0 and var_76_31 < var_76_37 then
					arg_73_1.talkMaxDuration = var_76_37

					if var_76_37 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_37 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_34
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221018", "story_v_out_416221.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221018", "story_v_out_416221.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_416221", "416221018", "story_v_out_416221.awb")

						arg_73_1:RecordAudio("416221018", var_76_39)
						arg_73_1:RecordAudio("416221018", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416221", "416221018", "story_v_out_416221.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416221", "416221018", "story_v_out_416221.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_40 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_40 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_40

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_40 and arg_73_1.time_ < var_76_30 + var_76_40 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play416221019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416221019
		arg_77_1.duration_ = 7.47

		local var_77_0 = {
			zh = 4.433,
			ja = 7.466
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
				arg_77_0:Play416221020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10127"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10127 == nil then
				arg_77_1.var_.actorSpriteComps10127 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10127 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10127 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10127 = nil
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

			local var_80_16 = arg_77_1.actors_["10127"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos10127 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10127", 2)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(-390, -387.4, -316.5)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10127, var_80_22, var_80_21)
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_80_23 = 0
			local var_80_24 = 0.625

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[236].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(416221019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221019", "story_v_out_416221.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221019", "story_v_out_416221.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_416221", "416221019", "story_v_out_416221.awb")

						arg_77_1:RecordAudio("416221019", var_80_32)
						arg_77_1:RecordAudio("416221019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416221", "416221019", "story_v_out_416221.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416221", "416221019", "story_v_out_416221.awb")
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
				actorName = "10127",
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
	Play416221020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416221020
		arg_81_1.duration_ = 12.93

		local var_81_0 = {
			zh = 4.7,
			ja = 12.933
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
				arg_81_0:Play416221021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.65

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[236].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(416221020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 26
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221020", "story_v_out_416221.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221020", "story_v_out_416221.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_416221", "416221020", "story_v_out_416221.awb")

						arg_81_1:RecordAudio("416221020", var_84_9)
						arg_81_1:RecordAudio("416221020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416221", "416221020", "story_v_out_416221.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416221", "416221020", "story_v_out_416221.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play416221021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416221021
		arg_85_1.duration_ = 5.77

		local var_85_0 = {
			zh = 5.766,
			ja = 4.266
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
				arg_85_0:Play416221022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1028"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1028 == nil then
				arg_85_1.var_.actorSpriteComps1028 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1028 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1028 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1028 = nil
			end

			local var_88_8 = arg_85_1.actors_["10127"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10127 == nil then
				arg_85_1.var_.actorSpriteComps10127 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10127 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10127 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10127 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.625

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[327].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(416221021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221021", "story_v_out_416221.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221021", "story_v_out_416221.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_416221", "416221021", "story_v_out_416221.awb")

						arg_85_1:RecordAudio("416221021", var_88_25)
						arg_85_1:RecordAudio("416221021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416221", "416221021", "story_v_out_416221.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416221", "416221021", "story_v_out_416221.awb")
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
	Play416221022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416221022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play416221023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1028"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1028 == nil then
				arg_89_1.var_.actorSpriteComps1028 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps1028 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor2.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor2.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor2.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 0.5, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1028 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1028 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 1.15

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(416221022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 46
				local var_92_13 = utf8.len(var_92_11)
				local var_92_14 = var_92_12 <= 0 and var_92_9 or var_92_9 * (var_92_13 / var_92_12)

				if var_92_14 > 0 and var_92_9 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_15 and arg_89_1.time_ < var_92_8 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416221023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416221023
		arg_93_1.duration_ = 7.4

		local var_93_0 = {
			zh = 3.766,
			ja = 7.4
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
				arg_93_0:Play416221024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10127"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10127 == nil then
				arg_93_1.var_.actorSpriteComps10127 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10127 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10127 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10127 = nil
			end

			local var_96_8 = arg_93_1.actors_["10127"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos10127 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10127", 2)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "split_6" or not string.find(var_96_11.name, "split") then
						var_96_11.gameObject:SetActive(true)
					else
						var_96_11.gameObject:SetActive(false)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(-390, -387.4, -316.5)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10127, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_96_15 = 0
			local var_96_16 = 0.5

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[236].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(416221023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221023", "story_v_out_416221.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221023", "story_v_out_416221.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_416221", "416221023", "story_v_out_416221.awb")

						arg_93_1:RecordAudio("416221023", var_96_24)
						arg_93_1:RecordAudio("416221023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416221", "416221023", "story_v_out_416221.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416221", "416221023", "story_v_out_416221.awb")
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
				actorName = "10127",
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
	Play416221024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416221024
		arg_97_1.duration_ = 3.2

		local var_97_0 = {
			zh = 2.366,
			ja = 3.2
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
				arg_97_0:Play416221025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1086"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1086 == nil then
				arg_97_1.var_.actorSpriteComps1086 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1086 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 1, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1086 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1086 = nil
			end

			local var_100_8 = arg_97_1.actors_["10127"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10127 == nil then
				arg_97_1.var_.actorSpriteComps10127 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10127 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 0.5, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10127 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10127 = nil
			end

			local var_100_16 = arg_97_1.actors_["1086"].transform
			local var_100_17 = 0

			if var_100_17 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.var_.moveOldPos1086 = var_100_16.localPosition
				var_100_16.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1086", 4)

				local var_100_18 = var_100_16.childCount

				for iter_100_8 = 0, var_100_18 - 1 do
					local var_100_19 = var_100_16:GetChild(iter_100_8)

					if var_100_19.name == "" or not string.find(var_100_19.name, "split") then
						var_100_19.gameObject:SetActive(true)
					else
						var_100_19.gameObject:SetActive(false)
					end
				end
			end

			local var_100_20 = 0.001

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_20 then
				local var_100_21 = (arg_97_1.time_ - var_100_17) / var_100_20
				local var_100_22 = Vector3.New(390, -404.2, -237.9)

				var_100_16.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1086, var_100_22, var_100_21)
			end

			if arg_97_1.time_ >= var_100_17 + var_100_20 and arg_97_1.time_ < var_100_17 + var_100_20 + arg_100_0 then
				var_100_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_100_23 = arg_97_1.actors_["1028"].transform
			local var_100_24 = 0

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.var_.moveOldPos1028 = var_100_23.localPosition
				var_100_23.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1028", 7)

				local var_100_25 = var_100_23.childCount

				for iter_100_9 = 0, var_100_25 - 1 do
					local var_100_26 = var_100_23:GetChild(iter_100_9)

					if var_100_26.name == "" or not string.find(var_100_26.name, "split") then
						var_100_26.gameObject:SetActive(true)
					else
						var_100_26.gameObject:SetActive(false)
					end
				end
			end

			local var_100_27 = 0.001

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_27 then
				local var_100_28 = (arg_97_1.time_ - var_100_24) / var_100_27
				local var_100_29 = Vector3.New(0, -2000, 0)

				var_100_23.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1028, var_100_29, var_100_28)
			end

			if arg_97_1.time_ >= var_100_24 + var_100_27 and arg_97_1.time_ < var_100_24 + var_100_27 + arg_100_0 then
				var_100_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_30 = 0
			local var_100_31 = 0.275

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[1080].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(416221024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 11
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221024", "story_v_out_416221.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221024", "story_v_out_416221.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_416221", "416221024", "story_v_out_416221.awb")

						arg_97_1:RecordAudio("416221024", var_100_39)
						arg_97_1:RecordAudio("416221024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416221", "416221024", "story_v_out_416221.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416221", "416221024", "story_v_out_416221.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play416221025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416221025
		arg_101_1.duration_ = 11.57

		local var_101_0 = {
			zh = 6.1,
			ja = 11.566
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
				arg_101_0:Play416221026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10127"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10127 == nil then
				arg_101_1.var_.actorSpriteComps10127 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10127 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10127 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10127 = nil
			end

			local var_104_8 = arg_101_1.actors_["1086"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1086 == nil then
				arg_101_1.var_.actorSpriteComps1086 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps1086 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								local var_104_12 = Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, var_104_11)
								local var_104_13 = Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, var_104_11)
								local var_104_14 = Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, var_104_11)

								iter_104_5.color = Color.New(var_104_12, var_104_13, var_104_14)
							else
								local var_104_15 = Mathf.Lerp(iter_104_5.color.r, 0.5, var_104_11)

								iter_104_5.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps1086 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1086 = nil
			end

			local var_104_16 = 0
			local var_104_17 = 0.8

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_18 = arg_101_1:FormatText(StoryNameCfg[236].name)

				arg_101_1.leftNameTxt_.text = var_104_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_19 = arg_101_1:GetWordFromCfg(416221025)
				local var_104_20 = arg_101_1:FormatText(var_104_19.content)

				arg_101_1.text_.text = var_104_20

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_21 = 32
				local var_104_22 = utf8.len(var_104_20)
				local var_104_23 = var_104_21 <= 0 and var_104_17 or var_104_17 * (var_104_22 / var_104_21)

				if var_104_23 > 0 and var_104_17 < var_104_23 then
					arg_101_1.talkMaxDuration = var_104_23

					if var_104_23 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_16
					end
				end

				arg_101_1.text_.text = var_104_20
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221025", "story_v_out_416221.awb") ~= 0 then
					local var_104_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221025", "story_v_out_416221.awb") / 1000

					if var_104_24 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_24 + var_104_16
					end

					if var_104_19.prefab_name ~= "" and arg_101_1.actors_[var_104_19.prefab_name] ~= nil then
						local var_104_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_19.prefab_name].transform, "story_v_out_416221", "416221025", "story_v_out_416221.awb")

						arg_101_1:RecordAudio("416221025", var_104_25)
						arg_101_1:RecordAudio("416221025", var_104_25)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416221", "416221025", "story_v_out_416221.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416221", "416221025", "story_v_out_416221.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_26 = math.max(var_104_17, arg_101_1.talkMaxDuration)

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_26 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_16) / var_104_26

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_16 + var_104_26 and arg_101_1.time_ < var_104_16 + var_104_26 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416221026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416221026
		arg_105_1.duration_ = 10.03

		local var_105_0 = {
			zh = 6.7,
			ja = 10.033
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
				arg_105_0:Play416221027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.85

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[236].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(416221026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221026", "story_v_out_416221.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221026", "story_v_out_416221.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_416221", "416221026", "story_v_out_416221.awb")

						arg_105_1:RecordAudio("416221026", var_108_9)
						arg_105_1:RecordAudio("416221026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416221", "416221026", "story_v_out_416221.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416221", "416221026", "story_v_out_416221.awb")
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
	Play416221027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416221027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play416221028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10127"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10127 == nil then
				arg_109_1.var_.actorSpriteComps10127 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps10127 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10127 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10127 = nil
			end

			local var_112_8 = arg_109_1.actors_["1086"].transform
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 then
				arg_109_1.var_.moveOldPos1086 = var_112_8.localPosition
				var_112_8.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1086", 7)

				local var_112_10 = var_112_8.childCount

				for iter_112_4 = 0, var_112_10 - 1 do
					local var_112_11 = var_112_8:GetChild(iter_112_4)

					if var_112_11.name == "" or not string.find(var_112_11.name, "split") then
						var_112_11.gameObject:SetActive(true)
					else
						var_112_11.gameObject:SetActive(false)
					end
				end
			end

			local var_112_12 = 0.001

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_12 then
				local var_112_13 = (arg_109_1.time_ - var_112_9) / var_112_12
				local var_112_14 = Vector3.New(0, -2000, 0)

				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1086, var_112_14, var_112_13)
			end

			if arg_109_1.time_ >= var_112_9 + var_112_12 and arg_109_1.time_ < var_112_9 + var_112_12 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_15 = arg_109_1.actors_["10127"].transform
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.var_.moveOldPos10127 = var_112_15.localPosition
				var_112_15.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10127", 7)

				local var_112_17 = var_112_15.childCount

				for iter_112_5 = 0, var_112_17 - 1 do
					local var_112_18 = var_112_15:GetChild(iter_112_5)

					if var_112_18.name == "" or not string.find(var_112_18.name, "split") then
						var_112_18.gameObject:SetActive(true)
					else
						var_112_18.gameObject:SetActive(false)
					end
				end
			end

			local var_112_19 = 0.001

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_19 then
				local var_112_20 = (arg_109_1.time_ - var_112_16) / var_112_19
				local var_112_21 = Vector3.New(0, -2000, 0)

				var_112_15.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10127, var_112_21, var_112_20)
			end

			if arg_109_1.time_ >= var_112_16 + var_112_19 and arg_109_1.time_ < var_112_16 + var_112_19 + arg_112_0 then
				var_112_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_22 = 0
			local var_112_23 = 1

			if var_112_22 < arg_109_1.time_ and arg_109_1.time_ <= var_112_22 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(416221027)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 40
				local var_112_27 = utf8.len(var_112_25)
				local var_112_28 = var_112_26 <= 0 and var_112_23 or var_112_23 * (var_112_27 / var_112_26)

				if var_112_28 > 0 and var_112_23 < var_112_28 then
					arg_109_1.talkMaxDuration = var_112_28

					if var_112_28 + var_112_22 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_22
					end
				end

				arg_109_1.text_.text = var_112_25
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_29 = math.max(var_112_23, arg_109_1.talkMaxDuration)

			if var_112_22 <= arg_109_1.time_ and arg_109_1.time_ < var_112_22 + var_112_29 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_22) / var_112_29

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_22 + var_112_29 and arg_109_1.time_ < var_112_22 + var_112_29 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "10127",
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
	Play416221028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416221028
		arg_113_1.duration_ = 7

		local var_113_0 = {
			zh = 5.833,
			ja = 7
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
				arg_113_0:Play416221029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1086"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1086 == nil then
				arg_113_1.var_.actorSpriteComps1086 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1086 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1086 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1086 = nil
			end

			local var_116_8 = arg_113_1.actors_["1086"].transform
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.var_.moveOldPos1086 = var_116_8.localPosition
				var_116_8.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1086", 4)

				local var_116_10 = var_116_8.childCount

				for iter_116_4 = 0, var_116_10 - 1 do
					local var_116_11 = var_116_8:GetChild(iter_116_4)

					if var_116_11.name == "" or not string.find(var_116_11.name, "split") then
						var_116_11.gameObject:SetActive(true)
					else
						var_116_11.gameObject:SetActive(false)
					end
				end
			end

			local var_116_12 = 0.001

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_12 then
				local var_116_13 = (arg_113_1.time_ - var_116_9) / var_116_12
				local var_116_14 = Vector3.New(390, -404.2, -237.9)

				var_116_8.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1086, var_116_14, var_116_13)
			end

			if arg_113_1.time_ >= var_116_9 + var_116_12 and arg_113_1.time_ < var_116_9 + var_116_12 + arg_116_0 then
				var_116_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_116_15 = 0
			local var_116_16 = 0.725

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[1080].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(416221028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221028", "story_v_out_416221.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221028", "story_v_out_416221.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_416221", "416221028", "story_v_out_416221.awb")

						arg_113_1:RecordAudio("416221028", var_116_24)
						arg_113_1:RecordAudio("416221028", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416221", "416221028", "story_v_out_416221.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416221", "416221028", "story_v_out_416221.awb")
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
				actorName = "1086",
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
	Play416221029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416221029
		arg_117_1.duration_ = 7.17

		local var_117_0 = {
			zh = 7.166,
			ja = 4.466
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
				arg_117_0:Play416221030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10122"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10122 == nil then
				arg_117_1.var_.actorSpriteComps10122 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10122 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10122 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10122 = nil
			end

			local var_120_8 = arg_117_1.actors_["1086"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1086 == nil then
				arg_117_1.var_.actorSpriteComps1086 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 0.2

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps1086 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1086 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1086 = nil
			end

			local var_120_16 = arg_117_1.actors_["10122"].transform
			local var_120_17 = 0

			if var_120_17 < arg_117_1.time_ and arg_117_1.time_ <= var_120_17 + arg_120_0 then
				arg_117_1.var_.moveOldPos10122 = var_120_16.localPosition
				var_120_16.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10122", 2)

				local var_120_18 = var_120_16.childCount

				for iter_120_8 = 0, var_120_18 - 1 do
					local var_120_19 = var_120_16:GetChild(iter_120_8)

					if var_120_19.name == "split_1" or not string.find(var_120_19.name, "split") then
						var_120_19.gameObject:SetActive(true)
					else
						var_120_19.gameObject:SetActive(false)
					end
				end
			end

			local var_120_20 = 0.001

			if var_120_17 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_20 then
				local var_120_21 = (arg_117_1.time_ - var_120_17) / var_120_20
				local var_120_22 = Vector3.New(-390, -380, -100)

				var_120_16.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10122, var_120_22, var_120_21)
			end

			if arg_117_1.time_ >= var_120_17 + var_120_20 and arg_117_1.time_ < var_120_17 + var_120_20 + arg_120_0 then
				var_120_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_120_23 = 0
			local var_120_24 = 0.7

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

				local var_120_26 = arg_117_1:GetWordFromCfg(416221029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221029", "story_v_out_416221.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221029", "story_v_out_416221.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_416221", "416221029", "story_v_out_416221.awb")

						arg_117_1:RecordAudio("416221029", var_120_32)
						arg_117_1:RecordAudio("416221029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416221", "416221029", "story_v_out_416221.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416221", "416221029", "story_v_out_416221.awb")
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
				actorName = "10122",
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
	Play416221030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416221030
		arg_121_1.duration_ = 3.1

		local var_121_0 = {
			zh = 3.1,
			ja = 2.9
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
				arg_121_0:Play416221031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1086"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1086 == nil then
				arg_121_1.var_.actorSpriteComps1086 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps1086 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1086 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1086 = nil
			end

			local var_124_8 = arg_121_1.actors_["10122"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10122 == nil then
				arg_121_1.var_.actorSpriteComps10122 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_10 = 0.2

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 and not isNil(var_124_8) then
				local var_124_11 = (arg_121_1.time_ - var_124_9) / var_124_10

				if arg_121_1.var_.actorSpriteComps10122 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10122 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_124_7 then
						if arg_121_1.isInRecall_ then
							iter_124_7.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10122 = nil
			end

			local var_124_16 = 0
			local var_124_17 = 0.35

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_18 = arg_121_1:FormatText(StoryNameCfg[1080].name)

				arg_121_1.leftNameTxt_.text = var_124_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_19 = arg_121_1:GetWordFromCfg(416221030)
				local var_124_20 = arg_121_1:FormatText(var_124_19.content)

				arg_121_1.text_.text = var_124_20

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221030", "story_v_out_416221.awb") ~= 0 then
					local var_124_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221030", "story_v_out_416221.awb") / 1000

					if var_124_24 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_24 + var_124_16
					end

					if var_124_19.prefab_name ~= "" and arg_121_1.actors_[var_124_19.prefab_name] ~= nil then
						local var_124_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_19.prefab_name].transform, "story_v_out_416221", "416221030", "story_v_out_416221.awb")

						arg_121_1:RecordAudio("416221030", var_124_25)
						arg_121_1:RecordAudio("416221030", var_124_25)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416221", "416221030", "story_v_out_416221.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416221", "416221030", "story_v_out_416221.awb")
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
	Play416221031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416221031
		arg_125_1.duration_ = 8.63

		local var_125_0 = {
			zh = 5.066,
			ja = 8.633
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
				arg_125_0:Play416221032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10127"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10127 == nil then
				arg_125_1.var_.actorSpriteComps10127 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10127 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 1, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10127 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10127 = nil
			end

			local var_128_8 = arg_125_1.actors_["1086"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1086 == nil then
				arg_125_1.var_.actorSpriteComps1086 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps1086 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 0.5, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1086 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1086 = nil
			end

			local var_128_16 = arg_125_1.actors_["10122"].transform
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.var_.moveOldPos10122 = var_128_16.localPosition
				var_128_16.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10122", 7)

				local var_128_18 = var_128_16.childCount

				for iter_128_8 = 0, var_128_18 - 1 do
					local var_128_19 = var_128_16:GetChild(iter_128_8)

					if var_128_19.name == "" or not string.find(var_128_19.name, "split") then
						var_128_19.gameObject:SetActive(true)
					else
						var_128_19.gameObject:SetActive(false)
					end
				end
			end

			local var_128_20 = 0.001

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_17) / var_128_20
				local var_128_22 = Vector3.New(0, -2000, 0)

				var_128_16.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10122, var_128_22, var_128_21)
			end

			if arg_125_1.time_ >= var_128_17 + var_128_20 and arg_125_1.time_ < var_128_17 + var_128_20 + arg_128_0 then
				var_128_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_23 = arg_125_1.actors_["10127"].transform
			local var_128_24 = 0

			if var_128_24 < arg_125_1.time_ and arg_125_1.time_ <= var_128_24 + arg_128_0 then
				arg_125_1.var_.moveOldPos10127 = var_128_23.localPosition
				var_128_23.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10127", 2)

				local var_128_25 = var_128_23.childCount

				for iter_128_9 = 0, var_128_25 - 1 do
					local var_128_26 = var_128_23:GetChild(iter_128_9)

					if var_128_26.name == "" or not string.find(var_128_26.name, "split") then
						var_128_26.gameObject:SetActive(true)
					else
						var_128_26.gameObject:SetActive(false)
					end
				end
			end

			local var_128_27 = 0.001

			if var_128_24 <= arg_125_1.time_ and arg_125_1.time_ < var_128_24 + var_128_27 then
				local var_128_28 = (arg_125_1.time_ - var_128_24) / var_128_27
				local var_128_29 = Vector3.New(-390, -387.4, -316.5)

				var_128_23.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10127, var_128_29, var_128_28)
			end

			if arg_125_1.time_ >= var_128_24 + var_128_27 and arg_125_1.time_ < var_128_24 + var_128_27 + arg_128_0 then
				var_128_23.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_128_30 = 0
			local var_128_31 = 0.675

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[236].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(416221031)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 27
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221031", "story_v_out_416221.awb") ~= 0 then
					local var_128_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221031", "story_v_out_416221.awb") / 1000

					if var_128_38 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_30
					end

					if var_128_33.prefab_name ~= "" and arg_125_1.actors_[var_128_33.prefab_name] ~= nil then
						local var_128_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_33.prefab_name].transform, "story_v_out_416221", "416221031", "story_v_out_416221.awb")

						arg_125_1:RecordAudio("416221031", var_128_39)
						arg_125_1:RecordAudio("416221031", var_128_39)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416221", "416221031", "story_v_out_416221.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416221", "416221031", "story_v_out_416221.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_40 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_40 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_40

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_40 and arg_125_1.time_ < var_128_30 + var_128_40 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play416221032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416221032
		arg_129_1.duration_ = 5.87

		local var_129_0 = {
			zh = 2.8,
			ja = 5.866
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
				arg_129_0:Play416221033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1028"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1028 == nil then
				arg_129_1.var_.actorSpriteComps1028 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps1028 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1028 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1028 = nil
			end

			local var_132_8 = arg_129_1.actors_["10127"]
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10127 == nil then
				arg_129_1.var_.actorSpriteComps10127 = var_132_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_10 = 0.2

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_10 and not isNil(var_132_8) then
				local var_132_11 = (arg_129_1.time_ - var_132_9) / var_132_10

				if arg_129_1.var_.actorSpriteComps10127 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								local var_132_12 = Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, var_132_11)
								local var_132_13 = Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, var_132_11)
								local var_132_14 = Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, var_132_11)

								iter_132_5.color = Color.New(var_132_12, var_132_13, var_132_14)
							else
								local var_132_15 = Mathf.Lerp(iter_132_5.color.r, 0.5, var_132_11)

								iter_132_5.color = Color.New(var_132_15, var_132_15, var_132_15)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_9 + var_132_10 and arg_129_1.time_ < var_132_9 + var_132_10 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10127 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_132_7 then
						if arg_129_1.isInRecall_ then
							iter_132_7.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10127 = nil
			end

			local var_132_16 = arg_129_1.actors_["1086"].transform
			local var_132_17 = 0

			if var_132_17 < arg_129_1.time_ and arg_129_1.time_ <= var_132_17 + arg_132_0 then
				arg_129_1.var_.moveOldPos1086 = var_132_16.localPosition
				var_132_16.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1086", 7)

				local var_132_18 = var_132_16.childCount

				for iter_132_8 = 0, var_132_18 - 1 do
					local var_132_19 = var_132_16:GetChild(iter_132_8)

					if var_132_19.name == "" or not string.find(var_132_19.name, "split") then
						var_132_19.gameObject:SetActive(true)
					else
						var_132_19.gameObject:SetActive(false)
					end
				end
			end

			local var_132_20 = 0.001

			if var_132_17 <= arg_129_1.time_ and arg_129_1.time_ < var_132_17 + var_132_20 then
				local var_132_21 = (arg_129_1.time_ - var_132_17) / var_132_20
				local var_132_22 = Vector3.New(0, -2000, 0)

				var_132_16.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1086, var_132_22, var_132_21)
			end

			if arg_129_1.time_ >= var_132_17 + var_132_20 and arg_129_1.time_ < var_132_17 + var_132_20 + arg_132_0 then
				var_132_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_23 = arg_129_1.actors_["1028"].transform
			local var_132_24 = 0

			if var_132_24 < arg_129_1.time_ and arg_129_1.time_ <= var_132_24 + arg_132_0 then
				arg_129_1.var_.moveOldPos1028 = var_132_23.localPosition
				var_132_23.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1028", 4)

				local var_132_25 = var_132_23.childCount

				for iter_132_9 = 0, var_132_25 - 1 do
					local var_132_26 = var_132_23:GetChild(iter_132_9)

					if var_132_26.name == "" or not string.find(var_132_26.name, "split") then
						var_132_26.gameObject:SetActive(true)
					else
						var_132_26.gameObject:SetActive(false)
					end
				end
			end

			local var_132_27 = 0.001

			if var_132_24 <= arg_129_1.time_ and arg_129_1.time_ < var_132_24 + var_132_27 then
				local var_132_28 = (arg_129_1.time_ - var_132_24) / var_132_27
				local var_132_29 = Vector3.New(390, -402.7, -156.1)

				var_132_23.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1028, var_132_29, var_132_28)
			end

			if arg_129_1.time_ >= var_132_24 + var_132_27 and arg_129_1.time_ < var_132_24 + var_132_27 + arg_132_0 then
				var_132_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_132_30 = 0
			local var_132_31 = 0.3

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_32 = arg_129_1:FormatText(StoryNameCfg[327].name)

				arg_129_1.leftNameTxt_.text = var_132_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_33 = arg_129_1:GetWordFromCfg(416221032)
				local var_132_34 = arg_129_1:FormatText(var_132_33.content)

				arg_129_1.text_.text = var_132_34

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_35 = 12
				local var_132_36 = utf8.len(var_132_34)
				local var_132_37 = var_132_35 <= 0 and var_132_31 or var_132_31 * (var_132_36 / var_132_35)

				if var_132_37 > 0 and var_132_31 < var_132_37 then
					arg_129_1.talkMaxDuration = var_132_37

					if var_132_37 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_37 + var_132_30
					end
				end

				arg_129_1.text_.text = var_132_34
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221032", "story_v_out_416221.awb") ~= 0 then
					local var_132_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221032", "story_v_out_416221.awb") / 1000

					if var_132_38 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_38 + var_132_30
					end

					if var_132_33.prefab_name ~= "" and arg_129_1.actors_[var_132_33.prefab_name] ~= nil then
						local var_132_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_33.prefab_name].transform, "story_v_out_416221", "416221032", "story_v_out_416221.awb")

						arg_129_1:RecordAudio("416221032", var_132_39)
						arg_129_1:RecordAudio("416221032", var_132_39)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416221", "416221032", "story_v_out_416221.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416221", "416221032", "story_v_out_416221.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_40 = math.max(var_132_31, arg_129_1.talkMaxDuration)

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_40 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_30) / var_132_40

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_30 + var_132_40 and arg_129_1.time_ < var_132_30 + var_132_40 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play416221033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416221033
		arg_133_1.duration_ = 8.27

		local var_133_0 = {
			zh = 3.8,
			ja = 8.266
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
				arg_133_0:Play416221034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10127"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10127 == nil then
				arg_133_1.var_.actorSpriteComps10127 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10127 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10127 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10127 = nil
			end

			local var_136_8 = arg_133_1.actors_["1028"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps1028 == nil then
				arg_133_1.var_.actorSpriteComps1028 = var_136_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_10 = 0.2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.actorSpriteComps1028 then
					for iter_136_4, iter_136_5 in pairs(arg_133_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps1028 then
				for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_136_7 then
						if arg_133_1.isInRecall_ then
							iter_136_7.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1028 = nil
			end

			local var_136_16 = 0
			local var_136_17 = 0.525

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_18 = arg_133_1:FormatText(StoryNameCfg[236].name)

				arg_133_1.leftNameTxt_.text = var_136_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_19 = arg_133_1:GetWordFromCfg(416221033)
				local var_136_20 = arg_133_1:FormatText(var_136_19.content)

				arg_133_1.text_.text = var_136_20

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_21 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221033", "story_v_out_416221.awb") ~= 0 then
					local var_136_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221033", "story_v_out_416221.awb") / 1000

					if var_136_24 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_24 + var_136_16
					end

					if var_136_19.prefab_name ~= "" and arg_133_1.actors_[var_136_19.prefab_name] ~= nil then
						local var_136_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_19.prefab_name].transform, "story_v_out_416221", "416221033", "story_v_out_416221.awb")

						arg_133_1:RecordAudio("416221033", var_136_25)
						arg_133_1:RecordAudio("416221033", var_136_25)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416221", "416221033", "story_v_out_416221.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416221", "416221033", "story_v_out_416221.awb")
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
	Play416221034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416221034
		arg_137_1.duration_ = 3.4

		local var_137_0 = {
			zh = 3.4,
			ja = 2.733
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
				arg_137_0:Play416221035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1028"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1028 == nil then
				arg_137_1.var_.actorSpriteComps1028 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1028 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1028 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1028 = nil
			end

			local var_140_8 = arg_137_1.actors_["10127"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10127 == nil then
				arg_137_1.var_.actorSpriteComps10127 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps10127 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10127 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10127 = nil
			end

			local var_140_16 = 0
			local var_140_17 = 0.3

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_18 = arg_137_1:FormatText(StoryNameCfg[327].name)

				arg_137_1.leftNameTxt_.text = var_140_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_19 = arg_137_1:GetWordFromCfg(416221034)
				local var_140_20 = arg_137_1:FormatText(var_140_19.content)

				arg_137_1.text_.text = var_140_20

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_21 = 12
				local var_140_22 = utf8.len(var_140_20)
				local var_140_23 = var_140_21 <= 0 and var_140_17 or var_140_17 * (var_140_22 / var_140_21)

				if var_140_23 > 0 and var_140_17 < var_140_23 then
					arg_137_1.talkMaxDuration = var_140_23

					if var_140_23 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_16
					end
				end

				arg_137_1.text_.text = var_140_20
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221034", "story_v_out_416221.awb") ~= 0 then
					local var_140_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221034", "story_v_out_416221.awb") / 1000

					if var_140_24 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_16
					end

					if var_140_19.prefab_name ~= "" and arg_137_1.actors_[var_140_19.prefab_name] ~= nil then
						local var_140_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_19.prefab_name].transform, "story_v_out_416221", "416221034", "story_v_out_416221.awb")

						arg_137_1:RecordAudio("416221034", var_140_25)
						arg_137_1:RecordAudio("416221034", var_140_25)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416221", "416221034", "story_v_out_416221.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416221", "416221034", "story_v_out_416221.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_26 = math.max(var_140_17, arg_137_1.talkMaxDuration)

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_26 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_16) / var_140_26

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_16 + var_140_26 and arg_137_1.time_ < var_140_16 + var_140_26 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play416221035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416221035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416221036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1028"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1028 == nil then
				arg_141_1.var_.actorSpriteComps1028 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps1028 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1028 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1028 = nil
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

			local var_144_15 = arg_141_1.actors_["10127"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos10127 = var_144_15.localPosition
				var_144_15.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10127", 7)

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

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10127, var_144_21, var_144_20)
			end

			if arg_141_1.time_ >= var_144_16 + var_144_19 and arg_141_1.time_ < var_144_16 + var_144_19 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_22 = 0
			local var_144_23 = 0.95

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

				local var_144_24 = arg_141_1:GetWordFromCfg(416221035)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 38
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
				actorName = "10127",
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
	Play416221036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416221036
		arg_145_1.duration_ = 6.87

		local var_145_0 = {
			zh = 5.066,
			ja = 6.866
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
				arg_145_0:Play416221037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1086"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1086 == nil then
				arg_145_1.var_.actorSpriteComps1086 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1086 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1086 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1086 = nil
			end

			local var_148_8 = arg_145_1.actors_["1086"].transform
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos1086 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1086", 3)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "split_6" or not string.find(var_148_11.name, "split") then
						var_148_11.gameObject:SetActive(true)
					else
						var_148_11.gameObject:SetActive(false)
					end
				end
			end

			local var_148_12 = 0.001

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(0, -404.2, -237.9)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1086, var_148_14, var_148_13)
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_148_15 = 0
			local var_148_16 = 0.725

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[1080].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(416221036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221036", "story_v_out_416221.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221036", "story_v_out_416221.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_416221", "416221036", "story_v_out_416221.awb")

						arg_145_1:RecordAudio("416221036", var_148_24)
						arg_145_1:RecordAudio("416221036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416221", "416221036", "story_v_out_416221.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416221", "416221036", "story_v_out_416221.awb")
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
				actorName = "1086",
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
	Play416221037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416221037
		arg_149_1.duration_ = 7.27

		local var_149_0 = {
			zh = 4.4,
			ja = 7.266
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
				arg_149_0:Play416221038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.575

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[1080].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(416221037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221037", "story_v_out_416221.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221037", "story_v_out_416221.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_416221", "416221037", "story_v_out_416221.awb")

						arg_149_1:RecordAudio("416221037", var_152_9)
						arg_149_1:RecordAudio("416221037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416221", "416221037", "story_v_out_416221.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416221", "416221037", "story_v_out_416221.awb")
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
	Play416221038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416221038
		arg_153_1.duration_ = 15.33

		local var_153_0 = {
			zh = 7.133,
			ja = 15.333
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
				arg_153_0:Play416221039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10127"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10127 == nil then
				arg_153_1.var_.actorSpriteComps10127 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10127 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10127 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10127 = nil
			end

			local var_156_8 = arg_153_1.actors_["1086"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1086 == nil then
				arg_153_1.var_.actorSpriteComps1086 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.2

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps1086 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 0.5, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1086 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1086 = nil
			end

			local var_156_16 = arg_153_1.actors_["10127"].transform
			local var_156_17 = 0

			if var_156_17 < arg_153_1.time_ and arg_153_1.time_ <= var_156_17 + arg_156_0 then
				arg_153_1.var_.moveOldPos10127 = var_156_16.localPosition
				var_156_16.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10127", 2)

				local var_156_18 = var_156_16.childCount

				for iter_156_8 = 0, var_156_18 - 1 do
					local var_156_19 = var_156_16:GetChild(iter_156_8)

					if var_156_19.name == "split_6" or not string.find(var_156_19.name, "split") then
						var_156_19.gameObject:SetActive(true)
					else
						var_156_19.gameObject:SetActive(false)
					end
				end
			end

			local var_156_20 = 0.001

			if var_156_17 <= arg_153_1.time_ and arg_153_1.time_ < var_156_17 + var_156_20 then
				local var_156_21 = (arg_153_1.time_ - var_156_17) / var_156_20
				local var_156_22 = Vector3.New(-390, -387.4, -316.5)

				var_156_16.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10127, var_156_22, var_156_21)
			end

			if arg_153_1.time_ >= var_156_17 + var_156_20 and arg_153_1.time_ < var_156_17 + var_156_20 + arg_156_0 then
				var_156_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_156_23 = arg_153_1.actors_["1086"].transform
			local var_156_24 = 0

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.var_.moveOldPos1086 = var_156_23.localPosition
				var_156_23.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1086", 4)

				local var_156_25 = var_156_23.childCount

				for iter_156_9 = 0, var_156_25 - 1 do
					local var_156_26 = var_156_23:GetChild(iter_156_9)

					if var_156_26.name == "split_6" or not string.find(var_156_26.name, "split") then
						var_156_26.gameObject:SetActive(true)
					else
						var_156_26.gameObject:SetActive(false)
					end
				end
			end

			local var_156_27 = 0.001

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_27 then
				local var_156_28 = (arg_153_1.time_ - var_156_24) / var_156_27
				local var_156_29 = Vector3.New(390, -404.2, -237.9)

				var_156_23.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1086, var_156_29, var_156_28)
			end

			if arg_153_1.time_ >= var_156_24 + var_156_27 and arg_153_1.time_ < var_156_24 + var_156_27 + arg_156_0 then
				var_156_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_156_30 = 0
			local var_156_31 = 1

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_32 = arg_153_1:FormatText(StoryNameCfg[236].name)

				arg_153_1.leftNameTxt_.text = var_156_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_33 = arg_153_1:GetWordFromCfg(416221038)
				local var_156_34 = arg_153_1:FormatText(var_156_33.content)

				arg_153_1.text_.text = var_156_34

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_35 = 40
				local var_156_36 = utf8.len(var_156_34)
				local var_156_37 = var_156_35 <= 0 and var_156_31 or var_156_31 * (var_156_36 / var_156_35)

				if var_156_37 > 0 and var_156_31 < var_156_37 then
					arg_153_1.talkMaxDuration = var_156_37

					if var_156_37 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_37 + var_156_30
					end
				end

				arg_153_1.text_.text = var_156_34
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221038", "story_v_out_416221.awb") ~= 0 then
					local var_156_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221038", "story_v_out_416221.awb") / 1000

					if var_156_38 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_38 + var_156_30
					end

					if var_156_33.prefab_name ~= "" and arg_153_1.actors_[var_156_33.prefab_name] ~= nil then
						local var_156_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_33.prefab_name].transform, "story_v_out_416221", "416221038", "story_v_out_416221.awb")

						arg_153_1:RecordAudio("416221038", var_156_39)
						arg_153_1:RecordAudio("416221038", var_156_39)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416221", "416221038", "story_v_out_416221.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416221", "416221038", "story_v_out_416221.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_40 = math.max(var_156_31, arg_153_1.talkMaxDuration)

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_40 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_30) / var_156_40

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_30 + var_156_40 and arg_153_1.time_ < var_156_30 + var_156_40 + arg_156_0 then
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

		arg_153_1:InitPlayNodeList()
	end,
	Play416221039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416221039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416221040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10127"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10127 == nil then
				arg_157_1.var_.actorSpriteComps10127 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10127 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10127 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10127 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.725

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(416221039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_12 = 29
				local var_160_13 = utf8.len(var_160_11)
				local var_160_14 = var_160_12 <= 0 and var_160_9 or var_160_9 * (var_160_13 / var_160_12)

				if var_160_14 > 0 and var_160_9 < var_160_14 then
					arg_157_1.talkMaxDuration = var_160_14

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_15 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_15 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_15

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_15 and arg_157_1.time_ < var_160_8 + var_160_15 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416221040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416221040
		arg_161_1.duration_ = 7.3

		local var_161_0 = {
			zh = 3.6,
			ja = 7.3
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
				arg_161_0:Play416221041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10122"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10122 == nil then
				arg_161_1.var_.actorSpriteComps10122 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10122 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10122 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10122 = nil
			end

			local var_164_8 = arg_161_1.actors_["10122"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos10122 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10122", 4)

				local var_164_10 = var_164_8.childCount

				for iter_164_4 = 0, var_164_10 - 1 do
					local var_164_11 = var_164_8:GetChild(iter_164_4)

					if var_164_11.name == "split_5" or not string.find(var_164_11.name, "split") then
						var_164_11.gameObject:SetActive(true)
					else
						var_164_11.gameObject:SetActive(false)
					end
				end
			end

			local var_164_12 = 0.001

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_9) / var_164_12
				local var_164_14 = Vector3.New(390, -380, -100)

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10122, var_164_14, var_164_13)
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(390, -380, -100)
			end

			local var_164_15 = arg_161_1.actors_["1086"].transform
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.var_.moveOldPos1086 = var_164_15.localPosition
				var_164_15.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1086", 7)

				local var_164_17 = var_164_15.childCount

				for iter_164_5 = 0, var_164_17 - 1 do
					local var_164_18 = var_164_15:GetChild(iter_164_5)

					if var_164_18.name == "" or not string.find(var_164_18.name, "split") then
						var_164_18.gameObject:SetActive(true)
					else
						var_164_18.gameObject:SetActive(false)
					end
				end
			end

			local var_164_19 = 0.001

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_19 then
				local var_164_20 = (arg_161_1.time_ - var_164_16) / var_164_19
				local var_164_21 = Vector3.New(0, -2000, 0)

				var_164_15.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1086, var_164_21, var_164_20)
			end

			if arg_161_1.time_ >= var_164_16 + var_164_19 and arg_161_1.time_ < var_164_16 + var_164_19 + arg_164_0 then
				var_164_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_22 = 0
			local var_164_23 = 0.45

			if var_164_22 < arg_161_1.time_ and arg_161_1.time_ <= var_164_22 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_24 = arg_161_1:FormatText(StoryNameCfg[8].name)

				arg_161_1.leftNameTxt_.text = var_164_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_25 = arg_161_1:GetWordFromCfg(416221040)
				local var_164_26 = arg_161_1:FormatText(var_164_25.content)

				arg_161_1.text_.text = var_164_26

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_27 = 18
				local var_164_28 = utf8.len(var_164_26)
				local var_164_29 = var_164_27 <= 0 and var_164_23 or var_164_23 * (var_164_28 / var_164_27)

				if var_164_29 > 0 and var_164_23 < var_164_29 then
					arg_161_1.talkMaxDuration = var_164_29

					if var_164_29 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_29 + var_164_22
					end
				end

				arg_161_1.text_.text = var_164_26
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221040", "story_v_out_416221.awb") ~= 0 then
					local var_164_30 = manager.audio:GetVoiceLength("story_v_out_416221", "416221040", "story_v_out_416221.awb") / 1000

					if var_164_30 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_30 + var_164_22
					end

					if var_164_25.prefab_name ~= "" and arg_161_1.actors_[var_164_25.prefab_name] ~= nil then
						local var_164_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_25.prefab_name].transform, "story_v_out_416221", "416221040", "story_v_out_416221.awb")

						arg_161_1:RecordAudio("416221040", var_164_31)
						arg_161_1:RecordAudio("416221040", var_164_31)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416221", "416221040", "story_v_out_416221.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416221", "416221040", "story_v_out_416221.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_32 = math.max(var_164_23, arg_161_1.talkMaxDuration)

			if var_164_22 <= arg_161_1.time_ and arg_161_1.time_ < var_164_22 + var_164_32 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_22) / var_164_32

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_22 + var_164_32 and arg_161_1.time_ < var_164_22 + var_164_32 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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
				actorName = "1086",
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
	Play416221041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416221041
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			zh = 4.3,
			ja = 3.733
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
				arg_165_0:Play416221042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.525

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[8].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(416221041)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221041", "story_v_out_416221.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221041", "story_v_out_416221.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_416221", "416221041", "story_v_out_416221.awb")

						arg_165_1:RecordAudio("416221041", var_168_9)
						arg_165_1:RecordAudio("416221041", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416221", "416221041", "story_v_out_416221.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416221", "416221041", "story_v_out_416221.awb")
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
	Play416221042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416221042
		arg_169_1.duration_ = 8.43

		local var_169_0 = {
			zh = 3.766,
			ja = 8.433
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
				arg_169_0:Play416221043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1028"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1028 == nil then
				arg_169_1.var_.actorSpriteComps1028 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

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

			local var_172_8 = arg_169_1.actors_["10122"]
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10122 == nil then
				arg_169_1.var_.actorSpriteComps10122 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_10 = 0.2

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 and not isNil(var_172_8) then
				local var_172_11 = (arg_169_1.time_ - var_172_9) / var_172_10

				if arg_169_1.var_.actorSpriteComps10122 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10122 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_172_7 then
						if arg_169_1.isInRecall_ then
							iter_172_7.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10122 = nil
			end

			local var_172_16 = arg_169_1.actors_["1028"].transform
			local var_172_17 = 0

			if var_172_17 < arg_169_1.time_ and arg_169_1.time_ <= var_172_17 + arg_172_0 then
				arg_169_1.var_.moveOldPos1028 = var_172_16.localPosition
				var_172_16.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1028", 4)

				local var_172_18 = var_172_16.childCount

				for iter_172_8 = 0, var_172_18 - 1 do
					local var_172_19 = var_172_16:GetChild(iter_172_8)

					if var_172_19.name == "split_2" or not string.find(var_172_19.name, "split") then
						var_172_19.gameObject:SetActive(true)
					else
						var_172_19.gameObject:SetActive(false)
					end
				end
			end

			local var_172_20 = 0.001

			if var_172_17 <= arg_169_1.time_ and arg_169_1.time_ < var_172_17 + var_172_20 then
				local var_172_21 = (arg_169_1.time_ - var_172_17) / var_172_20
				local var_172_22 = Vector3.New(390, -402.7, -156.1)

				var_172_16.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1028, var_172_22, var_172_21)
			end

			if arg_169_1.time_ >= var_172_17 + var_172_20 and arg_169_1.time_ < var_172_17 + var_172_20 + arg_172_0 then
				var_172_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_172_23 = arg_169_1.actors_["10122"].transform
			local var_172_24 = 0

			if var_172_24 < arg_169_1.time_ and arg_169_1.time_ <= var_172_24 + arg_172_0 then
				arg_169_1.var_.moveOldPos10122 = var_172_23.localPosition
				var_172_23.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10122", 7)

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
				local var_172_29 = Vector3.New(0, -2000, 0)

				var_172_23.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10122, var_172_29, var_172_28)
			end

			if arg_169_1.time_ >= var_172_24 + var_172_27 and arg_169_1.time_ < var_172_24 + var_172_27 + arg_172_0 then
				var_172_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_30 = 0
			local var_172_31 = 0.45

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_32 = arg_169_1:FormatText(StoryNameCfg[327].name)

				arg_169_1.leftNameTxt_.text = var_172_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_33 = arg_169_1:GetWordFromCfg(416221042)
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221042", "story_v_out_416221.awb") ~= 0 then
					local var_172_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221042", "story_v_out_416221.awb") / 1000

					if var_172_38 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_38 + var_172_30
					end

					if var_172_33.prefab_name ~= "" and arg_169_1.actors_[var_172_33.prefab_name] ~= nil then
						local var_172_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_33.prefab_name].transform, "story_v_out_416221", "416221042", "story_v_out_416221.awb")

						arg_169_1:RecordAudio("416221042", var_172_39)
						arg_169_1:RecordAudio("416221042", var_172_39)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416221", "416221042", "story_v_out_416221.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416221", "416221042", "story_v_out_416221.awb")
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
				actorName = "10122",
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
	Play416221043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416221043
		arg_173_1.duration_ = 6.17

		local var_173_0 = {
			zh = 4.633,
			ja = 6.166
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
				arg_173_0:Play416221044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10127"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10127 == nil then
				arg_173_1.var_.actorSpriteComps10127 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10127 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10127 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10127 = nil
			end

			local var_176_8 = arg_173_1.actors_["1028"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps1028 == nil then
				arg_173_1.var_.actorSpriteComps1028 = var_176_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_10 = 0.2

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

			local var_176_16 = arg_173_1.actors_["10127"].transform
			local var_176_17 = 0

			if var_176_17 < arg_173_1.time_ and arg_173_1.time_ <= var_176_17 + arg_176_0 then
				arg_173_1.var_.moveOldPos10127 = var_176_16.localPosition
				var_176_16.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10127", 2)

				local var_176_18 = var_176_16.childCount

				for iter_176_8 = 0, var_176_18 - 1 do
					local var_176_19 = var_176_16:GetChild(iter_176_8)

					if var_176_19.name == "" or not string.find(var_176_19.name, "split") then
						var_176_19.gameObject:SetActive(true)
					else
						var_176_19.gameObject:SetActive(false)
					end
				end
			end

			local var_176_20 = 0.001

			if var_176_17 <= arg_173_1.time_ and arg_173_1.time_ < var_176_17 + var_176_20 then
				local var_176_21 = (arg_173_1.time_ - var_176_17) / var_176_20
				local var_176_22 = Vector3.New(-390, -387.4, -316.5)

				var_176_16.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10127, var_176_22, var_176_21)
			end

			if arg_173_1.time_ >= var_176_17 + var_176_20 and arg_173_1.time_ < var_176_17 + var_176_20 + arg_176_0 then
				var_176_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_176_23 = 0
			local var_176_24 = 0.625

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_25 = arg_173_1:FormatText(StoryNameCfg[236].name)

				arg_173_1.leftNameTxt_.text = var_176_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(416221043)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 25
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_24 or var_176_24 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_24 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221043", "story_v_out_416221.awb") ~= 0 then
					local var_176_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221043", "story_v_out_416221.awb") / 1000

					if var_176_31 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_31 + var_176_23
					end

					if var_176_26.prefab_name ~= "" and arg_173_1.actors_[var_176_26.prefab_name] ~= nil then
						local var_176_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_26.prefab_name].transform, "story_v_out_416221", "416221043", "story_v_out_416221.awb")

						arg_173_1:RecordAudio("416221043", var_176_32)
						arg_173_1:RecordAudio("416221043", var_176_32)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416221", "416221043", "story_v_out_416221.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416221", "416221043", "story_v_out_416221.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_33 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_33 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_23) / var_176_33

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_23 + var_176_33 and arg_173_1.time_ < var_176_23 + var_176_33 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play416221044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416221044
		arg_177_1.duration_ = 8.6

		local var_177_0 = {
			zh = 4.8,
			ja = 8.6
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
				arg_177_0:Play416221045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.675

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[236].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(416221044)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 27
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221044", "story_v_out_416221.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221044", "story_v_out_416221.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_416221", "416221044", "story_v_out_416221.awb")

						arg_177_1:RecordAudio("416221044", var_180_9)
						arg_177_1:RecordAudio("416221044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416221", "416221044", "story_v_out_416221.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416221", "416221044", "story_v_out_416221.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416221045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416221045
		arg_181_1.duration_ = 5.37

		local var_181_0 = {
			zh = 3.633,
			ja = 5.366
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
				arg_181_0:Play416221046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1028"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1028 == nil then
				arg_181_1.var_.actorSpriteComps1028 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps1028 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1028 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1028 = nil
			end

			local var_184_8 = arg_181_1.actors_["10127"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10127 == nil then
				arg_181_1.var_.actorSpriteComps10127 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps10127 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10127 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10127 = nil
			end

			local var_184_16 = 0
			local var_184_17 = 0.475

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_18 = arg_181_1:FormatText(StoryNameCfg[327].name)

				arg_181_1.leftNameTxt_.text = var_184_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:GetWordFromCfg(416221045)
				local var_184_20 = arg_181_1:FormatText(var_184_19.content)

				arg_181_1.text_.text = var_184_20

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221045", "story_v_out_416221.awb") ~= 0 then
					local var_184_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221045", "story_v_out_416221.awb") / 1000

					if var_184_24 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_16
					end

					if var_184_19.prefab_name ~= "" and arg_181_1.actors_[var_184_19.prefab_name] ~= nil then
						local var_184_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_19.prefab_name].transform, "story_v_out_416221", "416221045", "story_v_out_416221.awb")

						arg_181_1:RecordAudio("416221045", var_184_25)
						arg_181_1:RecordAudio("416221045", var_184_25)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416221", "416221045", "story_v_out_416221.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416221", "416221045", "story_v_out_416221.awb")
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
	Play416221046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416221046
		arg_185_1.duration_ = 3.9

		local var_185_0 = {
			zh = 1.866,
			ja = 3.9
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
				arg_185_0:Play416221047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10127"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10127 == nil then
				arg_185_1.var_.actorSpriteComps10127 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10127 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10127 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10127 = nil
			end

			local var_188_8 = arg_185_1.actors_["1028"]
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps1028 == nil then
				arg_185_1.var_.actorSpriteComps1028 = var_188_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_10 = 0.2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 and not isNil(var_188_8) then
				local var_188_11 = (arg_185_1.time_ - var_188_9) / var_188_10

				if arg_185_1.var_.actorSpriteComps1028 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								local var_188_12 = Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor2.r, var_188_11)
								local var_188_13 = Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor2.g, var_188_11)
								local var_188_14 = Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor2.b, var_188_11)

								iter_188_5.color = Color.New(var_188_12, var_188_13, var_188_14)
							else
								local var_188_15 = Mathf.Lerp(iter_188_5.color.r, 0.5, var_188_11)

								iter_188_5.color = Color.New(var_188_15, var_188_15, var_188_15)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps1028 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_188_7 then
						if arg_185_1.isInRecall_ then
							iter_188_7.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1028 = nil
			end

			local var_188_16 = 0
			local var_188_17 = 0.3

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_18 = arg_185_1:FormatText(StoryNameCfg[236].name)

				arg_185_1.leftNameTxt_.text = var_188_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:GetWordFromCfg(416221046)
				local var_188_20 = arg_185_1:FormatText(var_188_19.content)

				arg_185_1.text_.text = var_188_20

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_21 = 12
				local var_188_22 = utf8.len(var_188_20)
				local var_188_23 = var_188_21 <= 0 and var_188_17 or var_188_17 * (var_188_22 / var_188_21)

				if var_188_23 > 0 and var_188_17 < var_188_23 then
					arg_185_1.talkMaxDuration = var_188_23

					if var_188_23 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_20
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221046", "story_v_out_416221.awb") ~= 0 then
					local var_188_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221046", "story_v_out_416221.awb") / 1000

					if var_188_24 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_24 + var_188_16
					end

					if var_188_19.prefab_name ~= "" and arg_185_1.actors_[var_188_19.prefab_name] ~= nil then
						local var_188_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_19.prefab_name].transform, "story_v_out_416221", "416221046", "story_v_out_416221.awb")

						arg_185_1:RecordAudio("416221046", var_188_25)
						arg_185_1:RecordAudio("416221046", var_188_25)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416221", "416221046", "story_v_out_416221.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416221", "416221046", "story_v_out_416221.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_26 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_26 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_16) / var_188_26

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_16 + var_188_26 and arg_185_1.time_ < var_188_16 + var_188_26 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play416221047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416221047
		arg_189_1.duration_ = 15.9

		local var_189_0 = {
			zh = 5.8,
			ja = 15.9
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
				arg_189_0:Play416221048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.775

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[236].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(416221047)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 31
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221047", "story_v_out_416221.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221047", "story_v_out_416221.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_416221", "416221047", "story_v_out_416221.awb")

						arg_189_1:RecordAudio("416221047", var_192_9)
						arg_189_1:RecordAudio("416221047", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416221", "416221047", "story_v_out_416221.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416221", "416221047", "story_v_out_416221.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416221048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416221048
		arg_193_1.duration_ = 4.57

		local var_193_0 = {
			zh = 3.033,
			ja = 4.566
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
				arg_193_0:Play416221049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.375

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[236].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(416221048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 15
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221048", "story_v_out_416221.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221048", "story_v_out_416221.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_416221", "416221048", "story_v_out_416221.awb")

						arg_193_1:RecordAudio("416221048", var_196_9)
						arg_193_1:RecordAudio("416221048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416221", "416221048", "story_v_out_416221.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416221", "416221048", "story_v_out_416221.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416221049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416221049
		arg_197_1.duration_ = 7.43

		local var_197_0 = {
			zh = 5.7,
			ja = 7.433
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
				arg_197_0:Play416221050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1028"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1028 == nil then
				arg_197_1.var_.actorSpriteComps1028 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps1028 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 1, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1028 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1028 = nil
			end

			local var_200_8 = arg_197_1.actors_["10127"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10127 == nil then
				arg_197_1.var_.actorSpriteComps10127 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps10127 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 0.5, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10127 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10127 = nil
			end

			local var_200_16 = arg_197_1.actors_["1028"].transform
			local var_200_17 = 0

			if var_200_17 < arg_197_1.time_ and arg_197_1.time_ <= var_200_17 + arg_200_0 then
				arg_197_1.var_.moveOldPos1028 = var_200_16.localPosition
				var_200_16.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1028", 4)

				local var_200_18 = var_200_16.childCount

				for iter_200_8 = 0, var_200_18 - 1 do
					local var_200_19 = var_200_16:GetChild(iter_200_8)

					if var_200_19.name == "split_4" or not string.find(var_200_19.name, "split") then
						var_200_19.gameObject:SetActive(true)
					else
						var_200_19.gameObject:SetActive(false)
					end
				end
			end

			local var_200_20 = 0.001

			if var_200_17 <= arg_197_1.time_ and arg_197_1.time_ < var_200_17 + var_200_20 then
				local var_200_21 = (arg_197_1.time_ - var_200_17) / var_200_20
				local var_200_22 = Vector3.New(390, -402.7, -156.1)

				var_200_16.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1028, var_200_22, var_200_21)
			end

			if arg_197_1.time_ >= var_200_17 + var_200_20 and arg_197_1.time_ < var_200_17 + var_200_20 + arg_200_0 then
				var_200_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_200_23 = 0
			local var_200_24 = 0.45

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[327].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(416221049)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 18
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221049", "story_v_out_416221.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221049", "story_v_out_416221.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_416221", "416221049", "story_v_out_416221.awb")

						arg_197_1:RecordAudio("416221049", var_200_32)
						arg_197_1:RecordAudio("416221049", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416221", "416221049", "story_v_out_416221.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416221", "416221049", "story_v_out_416221.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play416221050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416221050
		arg_201_1.duration_ = 2.83

		local var_201_0 = {
			zh = 1.766,
			ja = 2.833
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
				arg_201_0:Play416221051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1086"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1086 == nil then
				arg_201_1.var_.actorSpriteComps1086 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1086 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1086 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1086 = nil
			end

			local var_204_8 = arg_201_1.actors_["1028"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps1028 == nil then
				arg_201_1.var_.actorSpriteComps1028 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 0.2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps1028 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								local var_204_12 = Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, var_204_11)
								local var_204_13 = Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, var_204_11)
								local var_204_14 = Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, var_204_11)

								iter_204_5.color = Color.New(var_204_12, var_204_13, var_204_14)
							else
								local var_204_15 = Mathf.Lerp(iter_204_5.color.r, 0.5, var_204_11)

								iter_204_5.color = Color.New(var_204_15, var_204_15, var_204_15)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps1028 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1028 = nil
			end

			local var_204_16 = arg_201_1.actors_["1086"].transform
			local var_204_17 = 0

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				arg_201_1.var_.moveOldPos1086 = var_204_16.localPosition
				var_204_16.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1086", 2)

				local var_204_18 = var_204_16.childCount

				for iter_204_8 = 0, var_204_18 - 1 do
					local var_204_19 = var_204_16:GetChild(iter_204_8)

					if var_204_19.name == "" or not string.find(var_204_19.name, "split") then
						var_204_19.gameObject:SetActive(true)
					else
						var_204_19.gameObject:SetActive(false)
					end
				end
			end

			local var_204_20 = 0.001

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_20 then
				local var_204_21 = (arg_201_1.time_ - var_204_17) / var_204_20
				local var_204_22 = Vector3.New(-390, -404.2, -237.9)

				var_204_16.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1086, var_204_22, var_204_21)
			end

			if arg_201_1.time_ >= var_204_17 + var_204_20 and arg_201_1.time_ < var_204_17 + var_204_20 + arg_204_0 then
				var_204_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_204_23 = arg_201_1.actors_["10127"].transform
			local var_204_24 = 0

			if var_204_24 < arg_201_1.time_ and arg_201_1.time_ <= var_204_24 + arg_204_0 then
				arg_201_1.var_.moveOldPos10127 = var_204_23.localPosition
				var_204_23.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10127", 7)

				local var_204_25 = var_204_23.childCount

				for iter_204_9 = 0, var_204_25 - 1 do
					local var_204_26 = var_204_23:GetChild(iter_204_9)

					if var_204_26.name == "" or not string.find(var_204_26.name, "split") then
						var_204_26.gameObject:SetActive(true)
					else
						var_204_26.gameObject:SetActive(false)
					end
				end
			end

			local var_204_27 = 0.001

			if var_204_24 <= arg_201_1.time_ and arg_201_1.time_ < var_204_24 + var_204_27 then
				local var_204_28 = (arg_201_1.time_ - var_204_24) / var_204_27
				local var_204_29 = Vector3.New(0, -2000, 0)

				var_204_23.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10127, var_204_29, var_204_28)
			end

			if arg_201_1.time_ >= var_204_24 + var_204_27 and arg_201_1.time_ < var_204_24 + var_204_27 + arg_204_0 then
				var_204_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_204_30 = 0
			local var_204_31 = 0.2

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[1080].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(416221050)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 8
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221050", "story_v_out_416221.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221050", "story_v_out_416221.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_416221", "416221050", "story_v_out_416221.awb")

						arg_201_1:RecordAudio("416221050", var_204_39)
						arg_201_1:RecordAudio("416221050", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416221", "416221050", "story_v_out_416221.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416221", "416221050", "story_v_out_416221.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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
				actorName = "10127",
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
	Play416221051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416221051
		arg_205_1.duration_ = 3.73

		local var_205_0 = {
			zh = 3.233,
			ja = 3.733
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
				arg_205_0:Play416221052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1028"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1028 == nil then
				arg_205_1.var_.actorSpriteComps1028 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1028 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1028 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1028 = nil
			end

			local var_208_8 = arg_205_1.actors_["1086"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1086 == nil then
				arg_205_1.var_.actorSpriteComps1086 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 0.2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps1086 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1086 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1086 = nil
			end

			local var_208_16 = arg_205_1.actors_["1028"].transform
			local var_208_17 = 0

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.var_.moveOldPos1028 = var_208_16.localPosition
				var_208_16.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1028", 4)

				local var_208_18 = var_208_16.childCount

				for iter_208_8 = 0, var_208_18 - 1 do
					local var_208_19 = var_208_16:GetChild(iter_208_8)

					if var_208_19.name == "split_7" or not string.find(var_208_19.name, "split") then
						var_208_19.gameObject:SetActive(true)
					else
						var_208_19.gameObject:SetActive(false)
					end
				end
			end

			local var_208_20 = 0.001

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_20 then
				local var_208_21 = (arg_205_1.time_ - var_208_17) / var_208_20
				local var_208_22 = Vector3.New(390, -402.7, -156.1)

				var_208_16.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1028, var_208_22, var_208_21)
			end

			if arg_205_1.time_ >= var_208_17 + var_208_20 and arg_205_1.time_ < var_208_17 + var_208_20 + arg_208_0 then
				var_208_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_208_23 = 0
			local var_208_24 = 0.375

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[327].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(416221051)
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221051", "story_v_out_416221.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221051", "story_v_out_416221.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_416221", "416221051", "story_v_out_416221.awb")

						arg_205_1:RecordAudio("416221051", var_208_32)
						arg_205_1:RecordAudio("416221051", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416221", "416221051", "story_v_out_416221.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416221", "416221051", "story_v_out_416221.awb")
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
	Play416221052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416221052
		arg_209_1.duration_ = 8.57

		local var_209_0 = {
			zh = 5.933,
			ja = 8.566
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
				arg_209_0:Play416221053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1086"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1086 == nil then
				arg_209_1.var_.actorSpriteComps1086 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1086 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1086 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1086 = nil
			end

			local var_212_8 = arg_209_1.actors_["1028"]
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1028 == nil then
				arg_209_1.var_.actorSpriteComps1028 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_10 = 0.2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 and not isNil(var_212_8) then
				local var_212_11 = (arg_209_1.time_ - var_212_9) / var_212_10

				if arg_209_1.var_.actorSpriteComps1028 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1028 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1028 = nil
			end

			local var_212_16 = 0
			local var_212_17 = 0.75

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_18 = arg_209_1:FormatText(StoryNameCfg[1080].name)

				arg_209_1.leftNameTxt_.text = var_212_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_19 = arg_209_1:GetWordFromCfg(416221052)
				local var_212_20 = arg_209_1:FormatText(var_212_19.content)

				arg_209_1.text_.text = var_212_20

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_21 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221052", "story_v_out_416221.awb") ~= 0 then
					local var_212_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221052", "story_v_out_416221.awb") / 1000

					if var_212_24 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_16
					end

					if var_212_19.prefab_name ~= "" and arg_209_1.actors_[var_212_19.prefab_name] ~= nil then
						local var_212_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_19.prefab_name].transform, "story_v_out_416221", "416221052", "story_v_out_416221.awb")

						arg_209_1:RecordAudio("416221052", var_212_25)
						arg_209_1:RecordAudio("416221052", var_212_25)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_416221", "416221052", "story_v_out_416221.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_416221", "416221052", "story_v_out_416221.awb")
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
	Play416221053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416221053
		arg_213_1.duration_ = 7.43

		local var_213_0 = {
			zh = 7.166,
			ja = 7.433
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
				arg_213_0:Play416221054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1028"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1028 == nil then
				arg_213_1.var_.actorSpriteComps1028 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps1028 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 1, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1028 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1028 = nil
			end

			local var_216_8 = arg_213_1.actors_["1086"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps1086 == nil then
				arg_213_1.var_.actorSpriteComps1086 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 0.2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps1086 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_12 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, var_216_11)
								local var_216_13 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, var_216_11)
								local var_216_14 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, var_216_11)

								iter_216_5.color = Color.New(var_216_12, var_216_13, var_216_14)
							else
								local var_216_15 = Mathf.Lerp(iter_216_5.color.r, 0.5, var_216_11)

								iter_216_5.color = Color.New(var_216_15, var_216_15, var_216_15)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps1086 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1086 = nil
			end

			local var_216_16 = arg_213_1.actors_["1028"].transform
			local var_216_17 = 0

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.var_.moveOldPos1028 = var_216_16.localPosition
				var_216_16.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1028", 4)

				local var_216_18 = var_216_16.childCount

				for iter_216_8 = 0, var_216_18 - 1 do
					local var_216_19 = var_216_16:GetChild(iter_216_8)

					if var_216_19.name == "" or not string.find(var_216_19.name, "split") then
						var_216_19.gameObject:SetActive(true)
					else
						var_216_19.gameObject:SetActive(false)
					end
				end
			end

			local var_216_20 = 0.001

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_20 then
				local var_216_21 = (arg_213_1.time_ - var_216_17) / var_216_20
				local var_216_22 = Vector3.New(390, -402.7, -156.1)

				var_216_16.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1028, var_216_22, var_216_21)
			end

			if arg_213_1.time_ >= var_216_17 + var_216_20 and arg_213_1.time_ < var_216_17 + var_216_20 + arg_216_0 then
				var_216_16.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_216_23 = 0
			local var_216_24 = 0.375

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_25 = arg_213_1:FormatText(StoryNameCfg[327].name)

				arg_213_1.leftNameTxt_.text = var_216_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(416221053)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 15
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_24 or var_216_24 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_24 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_23
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221053", "story_v_out_416221.awb") ~= 0 then
					local var_216_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221053", "story_v_out_416221.awb") / 1000

					if var_216_31 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_31 + var_216_23
					end

					if var_216_26.prefab_name ~= "" and arg_213_1.actors_[var_216_26.prefab_name] ~= nil then
						local var_216_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_26.prefab_name].transform, "story_v_out_416221", "416221053", "story_v_out_416221.awb")

						arg_213_1:RecordAudio("416221053", var_216_32)
						arg_213_1:RecordAudio("416221053", var_216_32)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416221", "416221053", "story_v_out_416221.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416221", "416221053", "story_v_out_416221.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_33 = math.max(var_216_24, arg_213_1.talkMaxDuration)

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_33 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_23) / var_216_33

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_23 + var_216_33 and arg_213_1.time_ < var_216_23 + var_216_33 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play416221054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416221054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play416221055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1028"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1028 == nil then
				arg_217_1.var_.actorSpriteComps1028 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps1028 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 0.5, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1028 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1028 = nil
			end

			local var_220_8 = arg_217_1.actors_["1028"].transform
			local var_220_9 = 0

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 then
				arg_217_1.var_.moveOldPos1028 = var_220_8.localPosition
				var_220_8.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1028", 7)

				local var_220_10 = var_220_8.childCount

				for iter_220_4 = 0, var_220_10 - 1 do
					local var_220_11 = var_220_8:GetChild(iter_220_4)

					if var_220_11.name == "" or not string.find(var_220_11.name, "split") then
						var_220_11.gameObject:SetActive(true)
					else
						var_220_11.gameObject:SetActive(false)
					end
				end
			end

			local var_220_12 = 0.001

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_12 then
				local var_220_13 = (arg_217_1.time_ - var_220_9) / var_220_12
				local var_220_14 = Vector3.New(0, -2000, 0)

				var_220_8.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1028, var_220_14, var_220_13)
			end

			if arg_217_1.time_ >= var_220_9 + var_220_12 and arg_217_1.time_ < var_220_9 + var_220_12 + arg_220_0 then
				var_220_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_15 = arg_217_1.actors_["1086"].transform
			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.var_.moveOldPos1086 = var_220_15.localPosition
				var_220_15.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1086", 7)

				local var_220_17 = var_220_15.childCount

				for iter_220_5 = 0, var_220_17 - 1 do
					local var_220_18 = var_220_15:GetChild(iter_220_5)

					if var_220_18.name == "" or not string.find(var_220_18.name, "split") then
						var_220_18.gameObject:SetActive(true)
					else
						var_220_18.gameObject:SetActive(false)
					end
				end
			end

			local var_220_19 = 0.001

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_19 then
				local var_220_20 = (arg_217_1.time_ - var_220_16) / var_220_19
				local var_220_21 = Vector3.New(0, -2000, 0)

				var_220_15.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1086, var_220_21, var_220_20)
			end

			if arg_217_1.time_ >= var_220_16 + var_220_19 and arg_217_1.time_ < var_220_16 + var_220_19 + arg_220_0 then
				var_220_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_22 = 0
			local var_220_23 = 1.475

			if var_220_22 < arg_217_1.time_ and arg_217_1.time_ <= var_220_22 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_24 = arg_217_1:GetWordFromCfg(416221054)
				local var_220_25 = arg_217_1:FormatText(var_220_24.content)

				arg_217_1.text_.text = var_220_25

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_26 = 59
				local var_220_27 = utf8.len(var_220_25)
				local var_220_28 = var_220_26 <= 0 and var_220_23 or var_220_23 * (var_220_27 / var_220_26)

				if var_220_28 > 0 and var_220_23 < var_220_28 then
					arg_217_1.talkMaxDuration = var_220_28

					if var_220_28 + var_220_22 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_28 + var_220_22
					end
				end

				arg_217_1.text_.text = var_220_25
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_29 = math.max(var_220_23, arg_217_1.talkMaxDuration)

			if var_220_22 <= arg_217_1.time_ and arg_217_1.time_ < var_220_22 + var_220_29 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_22) / var_220_29

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_22 + var_220_29 and arg_217_1.time_ < var_220_22 + var_220_29 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play416221055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 416221055
		arg_221_1.duration_ = 7.77

		local var_221_0 = {
			zh = 7.766,
			ja = 4.7
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play416221056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1086"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1086 == nil then
				arg_221_1.var_.actorSpriteComps1086 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1086 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 1, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1086 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1086 = nil
			end

			local var_224_8 = arg_221_1.actors_["1086"].transform
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.var_.moveOldPos1086 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1086", 3)

				local var_224_10 = var_224_8.childCount

				for iter_224_4 = 0, var_224_10 - 1 do
					local var_224_11 = var_224_8:GetChild(iter_224_4)

					if var_224_11.name == "split_2" or not string.find(var_224_11.name, "split") then
						var_224_11.gameObject:SetActive(true)
					else
						var_224_11.gameObject:SetActive(false)
					end
				end
			end

			local var_224_12 = 0.001

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_9) / var_224_12
				local var_224_14 = Vector3.New(0, -404.2, -237.9)

				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1086, var_224_14, var_224_13)
			end

			if arg_221_1.time_ >= var_224_9 + var_224_12 and arg_221_1.time_ < var_224_9 + var_224_12 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_224_15 = 0
			local var_224_16 = 0.55

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[1080].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(416221055)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 22
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221055", "story_v_out_416221.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221055", "story_v_out_416221.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_416221", "416221055", "story_v_out_416221.awb")

						arg_221_1:RecordAudio("416221055", var_224_24)
						arg_221_1:RecordAudio("416221055", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_416221", "416221055", "story_v_out_416221.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_416221", "416221055", "story_v_out_416221.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play416221056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 416221056
		arg_225_1.duration_ = 6.4

		local var_225_0 = {
			zh = 5.19933333333333,
			ja = 6.39933333333333
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
				arg_225_0:Play416221057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.46666666666667

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_1 = manager.ui.mainCamera.transform.localPosition
				local var_228_2 = Vector3.New(0, 0, 10) + Vector3.New(var_228_1.x, var_228_1.y, 0)
				local var_228_3 = arg_225_1.bgs_.F09f

				var_228_3.transform.localPosition = var_228_2
				var_228_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_4 = var_228_3:GetComponent("SpriteRenderer")

				if var_228_4 and var_228_4.sprite then
					local var_228_5 = (var_228_3.transform.localPosition - var_228_1).z
					local var_228_6 = manager.ui.mainCameraCom_
					local var_228_7 = 2 * var_228_5 * Mathf.Tan(var_228_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_228_8 = var_228_7 * var_228_6.aspect
					local var_228_9 = var_228_4.sprite.bounds.size.x
					local var_228_10 = var_228_4.sprite.bounds.size.y
					local var_228_11 = var_228_8 / var_228_9
					local var_228_12 = var_228_7 / var_228_10
					local var_228_13 = var_228_12 < var_228_11 and var_228_11 or var_228_12

					var_228_3.transform.localScale = Vector3.New(var_228_13, var_228_13, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "F09f" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_14 = 1.46666666666667

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			local var_228_15 = 0.3

			if arg_225_1.time_ >= var_228_14 + var_228_15 and arg_225_1.time_ < var_228_14 + var_228_15 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end

			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_17 = 1.46666666666667

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17
				local var_228_19 = Color.New(0, 0, 0)

				var_228_19.a = Mathf.Lerp(0, 1, var_228_18)
				arg_225_1.mask_.color = var_228_19
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				local var_228_20 = Color.New(0, 0, 0)

				var_228_20.a = 1
				arg_225_1.mask_.color = var_228_20
			end

			local var_228_21 = 1.46666666666667

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_22 = 2

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_22 then
				local var_228_23 = (arg_225_1.time_ - var_228_21) / var_228_22
				local var_228_24 = Color.New(0, 0, 0)

				var_228_24.a = Mathf.Lerp(1, 0, var_228_23)
				arg_225_1.mask_.color = var_228_24
			end

			if arg_225_1.time_ >= var_228_21 + var_228_22 and arg_225_1.time_ < var_228_21 + var_228_22 + arg_228_0 then
				local var_228_25 = Color.New(0, 0, 0)
				local var_228_26 = 0

				arg_225_1.mask_.enabled = false
				var_228_25.a = var_228_26
				arg_225_1.mask_.color = var_228_25
			end

			local var_228_27 = arg_225_1.actors_["1086"].transform
			local var_228_28 = 1.46666666666667

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1.var_.moveOldPos1086 = var_228_27.localPosition
				var_228_27.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1086", 7)

				local var_228_29 = var_228_27.childCount

				for iter_228_2 = 0, var_228_29 - 1 do
					local var_228_30 = var_228_27:GetChild(iter_228_2)

					if var_228_30.name == "" or not string.find(var_228_30.name, "split") then
						var_228_30.gameObject:SetActive(true)
					else
						var_228_30.gameObject:SetActive(false)
					end
				end
			end

			local var_228_31 = 0.001

			if var_228_28 <= arg_225_1.time_ and arg_225_1.time_ < var_228_28 + var_228_31 then
				local var_228_32 = (arg_225_1.time_ - var_228_28) / var_228_31
				local var_228_33 = Vector3.New(0, -2000, 0)

				var_228_27.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1086, var_228_33, var_228_32)
			end

			if arg_225_1.time_ >= var_228_28 + var_228_31 and arg_225_1.time_ < var_228_28 + var_228_31 + arg_228_0 then
				var_228_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_228_34 = arg_225_1.actors_["1086"].transform
			local var_228_35 = 3.2

			if var_228_35 < arg_225_1.time_ and arg_225_1.time_ <= var_228_35 + arg_228_0 then
				arg_225_1.var_.moveOldPos1086 = var_228_34.localPosition
				var_228_34.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1086", 4)

				local var_228_36 = var_228_34.childCount

				for iter_228_3 = 0, var_228_36 - 1 do
					local var_228_37 = var_228_34:GetChild(iter_228_3)

					if var_228_37.name == "" or not string.find(var_228_37.name, "split") then
						var_228_37.gameObject:SetActive(true)
					else
						var_228_37.gameObject:SetActive(false)
					end
				end
			end

			local var_228_38 = 0.001

			if var_228_35 <= arg_225_1.time_ and arg_225_1.time_ < var_228_35 + var_228_38 then
				local var_228_39 = (arg_225_1.time_ - var_228_35) / var_228_38
				local var_228_40 = Vector3.New(390, -404.2, -237.9)

				var_228_34.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1086, var_228_40, var_228_39)
			end

			if arg_225_1.time_ >= var_228_35 + var_228_38 and arg_225_1.time_ < var_228_35 + var_228_38 + arg_228_0 then
				var_228_34.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_228_41 = arg_225_1.actors_["1086"]
			local var_228_42 = 3.2

			if var_228_42 < arg_225_1.time_ and arg_225_1.time_ <= var_228_42 + arg_228_0 then
				local var_228_43 = var_228_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_43 then
					arg_225_1.var_.alphaOldValue1086 = var_228_43.alpha
					arg_225_1.var_.characterEffect1086 = var_228_43
				end

				arg_225_1.var_.alphaOldValue1086 = 0
			end

			local var_228_44 = 0.166666666666667

			if var_228_42 <= arg_225_1.time_ and arg_225_1.time_ < var_228_42 + var_228_44 then
				local var_228_45 = (arg_225_1.time_ - var_228_42) / var_228_44
				local var_228_46 = Mathf.Lerp(arg_225_1.var_.alphaOldValue1086, 1, var_228_45)

				if arg_225_1.var_.characterEffect1086 then
					arg_225_1.var_.characterEffect1086.alpha = var_228_46
				end
			end

			if arg_225_1.time_ >= var_228_42 + var_228_44 and arg_225_1.time_ < var_228_42 + var_228_44 + arg_228_0 and arg_225_1.var_.characterEffect1086 then
				arg_225_1.var_.characterEffect1086.alpha = 1
			end

			local var_228_47 = arg_225_1.actors_["1086"]
			local var_228_48 = 3.21666666666667

			if var_228_48 < arg_225_1.time_ and arg_225_1.time_ <= var_228_48 + arg_228_0 and not isNil(var_228_47) and arg_225_1.var_.actorSpriteComps1086 == nil then
				arg_225_1.var_.actorSpriteComps1086 = var_228_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_49 = 0.2

			if var_228_48 <= arg_225_1.time_ and arg_225_1.time_ < var_228_48 + var_228_49 and not isNil(var_228_47) then
				local var_228_50 = (arg_225_1.time_ - var_228_48) / var_228_49

				if arg_225_1.var_.actorSpriteComps1086 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								local var_228_51 = Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor1.r, var_228_50)
								local var_228_52 = Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor1.g, var_228_50)
								local var_228_53 = Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor1.b, var_228_50)

								iter_228_5.color = Color.New(var_228_51, var_228_52, var_228_53)
							else
								local var_228_54 = Mathf.Lerp(iter_228_5.color.r, 1, var_228_50)

								iter_228_5.color = Color.New(var_228_54, var_228_54, var_228_54)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_48 + var_228_49 and arg_225_1.time_ < var_228_48 + var_228_49 + arg_228_0 and not isNil(var_228_47) and arg_225_1.var_.actorSpriteComps1086 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1086 = nil
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_55 = 3.43333333333333
			local var_228_56 = 0.2

			if var_228_55 < arg_225_1.time_ and arg_225_1.time_ <= var_228_55 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_57 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_57:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_58 = arg_225_1:FormatText(StoryNameCfg[1080].name)

				arg_225_1.leftNameTxt_.text = var_228_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_59 = arg_225_1:GetWordFromCfg(416221056)
				local var_228_60 = arg_225_1:FormatText(var_228_59.content)

				arg_225_1.text_.text = var_228_60

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_61 = 8
				local var_228_62 = utf8.len(var_228_60)
				local var_228_63 = var_228_61 <= 0 and var_228_56 or var_228_56 * (var_228_62 / var_228_61)

				if var_228_63 > 0 and var_228_56 < var_228_63 then
					arg_225_1.talkMaxDuration = var_228_63
					var_228_55 = var_228_55 + 0.3

					if var_228_63 + var_228_55 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_63 + var_228_55
					end
				end

				arg_225_1.text_.text = var_228_60
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221056", "story_v_out_416221.awb") ~= 0 then
					local var_228_64 = manager.audio:GetVoiceLength("story_v_out_416221", "416221056", "story_v_out_416221.awb") / 1000

					if var_228_64 + var_228_55 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_64 + var_228_55
					end

					if var_228_59.prefab_name ~= "" and arg_225_1.actors_[var_228_59.prefab_name] ~= nil then
						local var_228_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_59.prefab_name].transform, "story_v_out_416221", "416221056", "story_v_out_416221.awb")

						arg_225_1:RecordAudio("416221056", var_228_65)
						arg_225_1:RecordAudio("416221056", var_228_65)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_416221", "416221056", "story_v_out_416221.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_416221", "416221056", "story_v_out_416221.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_66 = var_228_55 + 0.3
			local var_228_67 = math.max(var_228_56, arg_225_1.talkMaxDuration)

			if var_228_66 <= arg_225_1.time_ and arg_225_1.time_ < var_228_66 + var_228_67 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_66) / var_228_67

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_66 + var_228_67 and arg_225_1.time_ < var_228_66 + var_228_67 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play416221057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416221057
		arg_231_1.duration_ = 7.5

		local var_231_0 = {
			zh = 4.5,
			ja = 7.5
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
				arg_231_0:Play416221058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1028"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1028 == nil then
				arg_231_1.var_.actorSpriteComps1028 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1028 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1028 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1028 = nil
			end

			local var_234_8 = arg_231_1.actors_["1086"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1086 == nil then
				arg_231_1.var_.actorSpriteComps1086 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1086 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1086 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1086 = nil
			end

			local var_234_16 = arg_231_1.actors_["1028"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos1028 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1028", 2)

				local var_234_18 = var_234_16.childCount

				for iter_234_8 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_8)

					if var_234_19.name == "" or not string.find(var_234_19.name, "split") then
						var_234_19.gameObject:SetActive(true)
					else
						var_234_19.gameObject:SetActive(false)
					end
				end
			end

			local var_234_20 = 0.001

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-390, -402.7, -156.1)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1028, var_234_22, var_234_21)
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_234_23 = 0
			local var_234_24 = 0.6

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[327].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(416221057)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221057", "story_v_out_416221.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221057", "story_v_out_416221.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_416221", "416221057", "story_v_out_416221.awb")

						arg_231_1:RecordAudio("416221057", var_234_32)
						arg_231_1:RecordAudio("416221057", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416221", "416221057", "story_v_out_416221.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416221", "416221057", "story_v_out_416221.awb")
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play416221058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416221058
		arg_235_1.duration_ = 4.33

		local var_235_0 = {
			zh = 4.333,
			ja = 2.633
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
				arg_235_0:Play416221059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1086"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1086 == nil then
				arg_235_1.var_.actorSpriteComps1086 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1086 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1086 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1086 = nil
			end

			local var_238_8 = arg_235_1.actors_["1028"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1028 == nil then
				arg_235_1.var_.actorSpriteComps1028 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps1028 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1028 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1028 = nil
			end

			local var_238_16 = 0
			local var_238_17 = 0.375

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_18 = arg_235_1:FormatText(StoryNameCfg[1080].name)

				arg_235_1.leftNameTxt_.text = var_238_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_19 = arg_235_1:GetWordFromCfg(416221058)
				local var_238_20 = arg_235_1:FormatText(var_238_19.content)

				arg_235_1.text_.text = var_238_20

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_21 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221058", "story_v_out_416221.awb") ~= 0 then
					local var_238_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221058", "story_v_out_416221.awb") / 1000

					if var_238_24 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_16
					end

					if var_238_19.prefab_name ~= "" and arg_235_1.actors_[var_238_19.prefab_name] ~= nil then
						local var_238_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_19.prefab_name].transform, "story_v_out_416221", "416221058", "story_v_out_416221.awb")

						arg_235_1:RecordAudio("416221058", var_238_25)
						arg_235_1:RecordAudio("416221058", var_238_25)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416221", "416221058", "story_v_out_416221.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416221", "416221058", "story_v_out_416221.awb")
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
	Play416221059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416221059
		arg_239_1.duration_ = 7.87

		local var_239_0 = {
			zh = 7.866,
			ja = 7.533
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
				arg_239_0:Play416221060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1028"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1028 == nil then
				arg_239_1.var_.actorSpriteComps1028 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps1028 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 1, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1028 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1028 = nil
			end

			local var_242_8 = arg_239_1.actors_["1086"]
			local var_242_9 = 0

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 and not isNil(var_242_8) and arg_239_1.var_.actorSpriteComps1086 == nil then
				arg_239_1.var_.actorSpriteComps1086 = var_242_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_10 = 0.2

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_10 and not isNil(var_242_8) then
				local var_242_11 = (arg_239_1.time_ - var_242_9) / var_242_10

				if arg_239_1.var_.actorSpriteComps1086 then
					for iter_242_4, iter_242_5 in pairs(arg_239_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_242_5 then
							if arg_239_1.isInRecall_ then
								local var_242_12 = Mathf.Lerp(iter_242_5.color.r, arg_239_1.hightColor2.r, var_242_11)
								local var_242_13 = Mathf.Lerp(iter_242_5.color.g, arg_239_1.hightColor2.g, var_242_11)
								local var_242_14 = Mathf.Lerp(iter_242_5.color.b, arg_239_1.hightColor2.b, var_242_11)

								iter_242_5.color = Color.New(var_242_12, var_242_13, var_242_14)
							else
								local var_242_15 = Mathf.Lerp(iter_242_5.color.r, 0.5, var_242_11)

								iter_242_5.color = Color.New(var_242_15, var_242_15, var_242_15)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_9 + var_242_10 and arg_239_1.time_ < var_242_9 + var_242_10 + arg_242_0 and not isNil(var_242_8) and arg_239_1.var_.actorSpriteComps1086 then
				for iter_242_6, iter_242_7 in pairs(arg_239_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_242_7 then
						if arg_239_1.isInRecall_ then
							iter_242_7.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1086 = nil
			end

			local var_242_16 = 0
			local var_242_17 = 0.7

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_18 = arg_239_1:FormatText(StoryNameCfg[327].name)

				arg_239_1.leftNameTxt_.text = var_242_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_19 = arg_239_1:GetWordFromCfg(416221059)
				local var_242_20 = arg_239_1:FormatText(var_242_19.content)

				arg_239_1.text_.text = var_242_20

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_21 = 28
				local var_242_22 = utf8.len(var_242_20)
				local var_242_23 = var_242_21 <= 0 and var_242_17 or var_242_17 * (var_242_22 / var_242_21)

				if var_242_23 > 0 and var_242_17 < var_242_23 then
					arg_239_1.talkMaxDuration = var_242_23

					if var_242_23 + var_242_16 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_16
					end
				end

				arg_239_1.text_.text = var_242_20
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221059", "story_v_out_416221.awb") ~= 0 then
					local var_242_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221059", "story_v_out_416221.awb") / 1000

					if var_242_24 + var_242_16 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_24 + var_242_16
					end

					if var_242_19.prefab_name ~= "" and arg_239_1.actors_[var_242_19.prefab_name] ~= nil then
						local var_242_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_19.prefab_name].transform, "story_v_out_416221", "416221059", "story_v_out_416221.awb")

						arg_239_1:RecordAudio("416221059", var_242_25)
						arg_239_1:RecordAudio("416221059", var_242_25)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416221", "416221059", "story_v_out_416221.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416221", "416221059", "story_v_out_416221.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_26 = math.max(var_242_17, arg_239_1.talkMaxDuration)

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_26 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_16) / var_242_26

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_16 + var_242_26 and arg_239_1.time_ < var_242_16 + var_242_26 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416221060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416221060
		arg_243_1.duration_ = 6.13

		local var_243_0 = {
			zh = 3.9,
			ja = 6.133
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
				arg_243_0:Play416221061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1086"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1086 == nil then
				arg_243_1.var_.actorSpriteComps1086 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

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

			local var_246_10 = 0.2

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

			local var_246_16 = 0
			local var_246_17 = 0.375

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_18 = arg_243_1:FormatText(StoryNameCfg[1080].name)

				arg_243_1.leftNameTxt_.text = var_246_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_19 = arg_243_1:GetWordFromCfg(416221060)
				local var_246_20 = arg_243_1:FormatText(var_246_19.content)

				arg_243_1.text_.text = var_246_20

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_21 = 15
				local var_246_22 = utf8.len(var_246_20)
				local var_246_23 = var_246_21 <= 0 and var_246_17 or var_246_17 * (var_246_22 / var_246_21)

				if var_246_23 > 0 and var_246_17 < var_246_23 then
					arg_243_1.talkMaxDuration = var_246_23

					if var_246_23 + var_246_16 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_16
					end
				end

				arg_243_1.text_.text = var_246_20
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221060", "story_v_out_416221.awb") ~= 0 then
					local var_246_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221060", "story_v_out_416221.awb") / 1000

					if var_246_24 + var_246_16 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_24 + var_246_16
					end

					if var_246_19.prefab_name ~= "" and arg_243_1.actors_[var_246_19.prefab_name] ~= nil then
						local var_246_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_19.prefab_name].transform, "story_v_out_416221", "416221060", "story_v_out_416221.awb")

						arg_243_1:RecordAudio("416221060", var_246_25)
						arg_243_1:RecordAudio("416221060", var_246_25)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416221", "416221060", "story_v_out_416221.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416221", "416221060", "story_v_out_416221.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_26 = math.max(var_246_17, arg_243_1.talkMaxDuration)

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_26 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_16) / var_246_26

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_16 + var_246_26 and arg_243_1.time_ < var_246_16 + var_246_26 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416221061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416221061
		arg_247_1.duration_ = 8.9

		local var_247_0 = {
			zh = 5.6,
			ja = 8.9
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
				arg_247_0:Play416221062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1028"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1028 == nil then
				arg_247_1.var_.actorSpriteComps1028 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps1028 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 1, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1028 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1028 = nil
			end

			local var_250_8 = arg_247_1.actors_["1086"]
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps1086 == nil then
				arg_247_1.var_.actorSpriteComps1086 = var_250_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_10 = 0.2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 and not isNil(var_250_8) then
				local var_250_11 = (arg_247_1.time_ - var_250_9) / var_250_10

				if arg_247_1.var_.actorSpriteComps1086 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								local var_250_12 = Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, var_250_11)
								local var_250_13 = Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, var_250_11)
								local var_250_14 = Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, var_250_11)

								iter_250_5.color = Color.New(var_250_12, var_250_13, var_250_14)
							else
								local var_250_15 = Mathf.Lerp(iter_250_5.color.r, 0.5, var_250_11)

								iter_250_5.color = Color.New(var_250_15, var_250_15, var_250_15)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps1086 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1086 = nil
			end

			local var_250_16 = 0
			local var_250_17 = 0.45

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_18 = arg_247_1:FormatText(StoryNameCfg[327].name)

				arg_247_1.leftNameTxt_.text = var_250_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_19 = arg_247_1:GetWordFromCfg(416221061)
				local var_250_20 = arg_247_1:FormatText(var_250_19.content)

				arg_247_1.text_.text = var_250_20

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_21 = 18
				local var_250_22 = utf8.len(var_250_20)
				local var_250_23 = var_250_21 <= 0 and var_250_17 or var_250_17 * (var_250_22 / var_250_21)

				if var_250_23 > 0 and var_250_17 < var_250_23 then
					arg_247_1.talkMaxDuration = var_250_23

					if var_250_23 + var_250_16 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_16
					end
				end

				arg_247_1.text_.text = var_250_20
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221061", "story_v_out_416221.awb") ~= 0 then
					local var_250_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221061", "story_v_out_416221.awb") / 1000

					if var_250_24 + var_250_16 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_24 + var_250_16
					end

					if var_250_19.prefab_name ~= "" and arg_247_1.actors_[var_250_19.prefab_name] ~= nil then
						local var_250_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_19.prefab_name].transform, "story_v_out_416221", "416221061", "story_v_out_416221.awb")

						arg_247_1:RecordAudio("416221061", var_250_25)
						arg_247_1:RecordAudio("416221061", var_250_25)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416221", "416221061", "story_v_out_416221.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416221", "416221061", "story_v_out_416221.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_26 = math.max(var_250_17, arg_247_1.talkMaxDuration)

			if var_250_16 <= arg_247_1.time_ and arg_247_1.time_ < var_250_16 + var_250_26 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_16) / var_250_26

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_16 + var_250_26 and arg_247_1.time_ < var_250_16 + var_250_26 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play416221062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416221062
		arg_251_1.duration_ = 6.2

		local var_251_0 = {
			zh = 6.2,
			ja = 6.166
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
				arg_251_0:Play416221063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1086"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps1086 == nil then
				arg_251_1.var_.actorSpriteComps1086 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps1086 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps1086 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1086 = nil
			end

			local var_254_8 = arg_251_1.actors_["1028"]
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1028 == nil then
				arg_251_1.var_.actorSpriteComps1028 = var_254_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_10 = 0.2

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_10 and not isNil(var_254_8) then
				local var_254_11 = (arg_251_1.time_ - var_254_9) / var_254_10

				if arg_251_1.var_.actorSpriteComps1028 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								local var_254_12 = Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor2.r, var_254_11)
								local var_254_13 = Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor2.g, var_254_11)
								local var_254_14 = Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor2.b, var_254_11)

								iter_254_5.color = Color.New(var_254_12, var_254_13, var_254_14)
							else
								local var_254_15 = Mathf.Lerp(iter_254_5.color.r, 0.5, var_254_11)

								iter_254_5.color = Color.New(var_254_15, var_254_15, var_254_15)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_10 and arg_251_1.time_ < var_254_9 + var_254_10 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1028 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_254_7 then
						if arg_251_1.isInRecall_ then
							iter_254_7.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1028 = nil
			end

			local var_254_16 = arg_251_1.actors_["1086"].transform
			local var_254_17 = 0

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.var_.moveOldPos1086 = var_254_16.localPosition
				var_254_16.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1086", 4)

				local var_254_18 = var_254_16.childCount

				for iter_254_8 = 0, var_254_18 - 1 do
					local var_254_19 = var_254_16:GetChild(iter_254_8)

					if var_254_19.name == "split_2" or not string.find(var_254_19.name, "split") then
						var_254_19.gameObject:SetActive(true)
					else
						var_254_19.gameObject:SetActive(false)
					end
				end
			end

			local var_254_20 = 0.001

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_20 then
				local var_254_21 = (arg_251_1.time_ - var_254_17) / var_254_20
				local var_254_22 = Vector3.New(390, -404.2, -237.9)

				var_254_16.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1086, var_254_22, var_254_21)
			end

			if arg_251_1.time_ >= var_254_17 + var_254_20 and arg_251_1.time_ < var_254_17 + var_254_20 + arg_254_0 then
				var_254_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_254_23 = 0
			local var_254_24 = 0.6

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[1080].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_26 = arg_251_1:GetWordFromCfg(416221062)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 24
				local var_254_29 = utf8.len(var_254_27)
				local var_254_30 = var_254_28 <= 0 and var_254_24 or var_254_24 * (var_254_29 / var_254_28)

				if var_254_30 > 0 and var_254_24 < var_254_30 then
					arg_251_1.talkMaxDuration = var_254_30

					if var_254_30 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_23
					end
				end

				arg_251_1.text_.text = var_254_27
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221062", "story_v_out_416221.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221062", "story_v_out_416221.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_416221", "416221062", "story_v_out_416221.awb")

						arg_251_1:RecordAudio("416221062", var_254_32)
						arg_251_1:RecordAudio("416221062", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416221", "416221062", "story_v_out_416221.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416221", "416221062", "story_v_out_416221.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_33 = math.max(var_254_24, arg_251_1.talkMaxDuration)

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_33 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_23) / var_254_33

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_23 + var_254_33 and arg_251_1.time_ < var_254_23 + var_254_33 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play416221063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416221063
		arg_255_1.duration_ = 6.4

		local var_255_0 = {
			zh = 6.4,
			ja = 5.266
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
				arg_255_0:Play416221064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1028"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1028 == nil then
				arg_255_1.var_.actorSpriteComps1028 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps1028 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1028 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1028 = nil
			end

			local var_258_8 = arg_255_1.actors_["1086"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1086 == nil then
				arg_255_1.var_.actorSpriteComps1086 = var_258_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_10 = 0.2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.actorSpriteComps1086 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1086 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1086 = nil
			end

			local var_258_16 = 0
			local var_258_17 = 0.625

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_18 = arg_255_1:FormatText(StoryNameCfg[327].name)

				arg_255_1.leftNameTxt_.text = var_258_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_19 = arg_255_1:GetWordFromCfg(416221063)
				local var_258_20 = arg_255_1:FormatText(var_258_19.content)

				arg_255_1.text_.text = var_258_20

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_21 = 25
				local var_258_22 = utf8.len(var_258_20)
				local var_258_23 = var_258_21 <= 0 and var_258_17 or var_258_17 * (var_258_22 / var_258_21)

				if var_258_23 > 0 and var_258_17 < var_258_23 then
					arg_255_1.talkMaxDuration = var_258_23

					if var_258_23 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_23 + var_258_16
					end
				end

				arg_255_1.text_.text = var_258_20
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221063", "story_v_out_416221.awb") ~= 0 then
					local var_258_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221063", "story_v_out_416221.awb") / 1000

					if var_258_24 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_16
					end

					if var_258_19.prefab_name ~= "" and arg_255_1.actors_[var_258_19.prefab_name] ~= nil then
						local var_258_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_19.prefab_name].transform, "story_v_out_416221", "416221063", "story_v_out_416221.awb")

						arg_255_1:RecordAudio("416221063", var_258_25)
						arg_255_1:RecordAudio("416221063", var_258_25)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416221", "416221063", "story_v_out_416221.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416221", "416221063", "story_v_out_416221.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_26 = math.max(var_258_17, arg_255_1.talkMaxDuration)

			if var_258_16 <= arg_255_1.time_ and arg_255_1.time_ < var_258_16 + var_258_26 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_16) / var_258_26

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_16 + var_258_26 and arg_255_1.time_ < var_258_16 + var_258_26 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play416221064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416221064
		arg_259_1.duration_ = 8.27

		local var_259_0 = {
			zh = 4.966,
			ja = 8.266
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
				arg_259_0:Play416221065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1086"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1086 == nil then
				arg_259_1.var_.actorSpriteComps1086 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1086 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1086 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1086 = nil
			end

			local var_262_8 = arg_259_1.actors_["1028"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1028 == nil then
				arg_259_1.var_.actorSpriteComps1028 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps1028 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1028 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1028 = nil
			end

			local var_262_16 = arg_259_1.actors_["1086"].transform
			local var_262_17 = 0

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 then
				arg_259_1.var_.moveOldPos1086 = var_262_16.localPosition
				var_262_16.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1086", 4)

				local var_262_18 = var_262_16.childCount

				for iter_262_8 = 0, var_262_18 - 1 do
					local var_262_19 = var_262_16:GetChild(iter_262_8)

					if var_262_19.name == "" or not string.find(var_262_19.name, "split") then
						var_262_19.gameObject:SetActive(true)
					else
						var_262_19.gameObject:SetActive(false)
					end
				end
			end

			local var_262_20 = 0.001

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_20 then
				local var_262_21 = (arg_259_1.time_ - var_262_17) / var_262_20
				local var_262_22 = Vector3.New(390, -404.2, -237.9)

				var_262_16.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1086, var_262_22, var_262_21)
			end

			if arg_259_1.time_ >= var_262_17 + var_262_20 and arg_259_1.time_ < var_262_17 + var_262_20 + arg_262_0 then
				var_262_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_262_23 = 0
			local var_262_24 = 0.5

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_25 = arg_259_1:FormatText(StoryNameCfg[1080].name)

				arg_259_1.leftNameTxt_.text = var_262_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_26 = arg_259_1:GetWordFromCfg(416221064)
				local var_262_27 = arg_259_1:FormatText(var_262_26.content)

				arg_259_1.text_.text = var_262_27

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_28 = 20
				local var_262_29 = utf8.len(var_262_27)
				local var_262_30 = var_262_28 <= 0 and var_262_24 or var_262_24 * (var_262_29 / var_262_28)

				if var_262_30 > 0 and var_262_24 < var_262_30 then
					arg_259_1.talkMaxDuration = var_262_30

					if var_262_30 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_30 + var_262_23
					end
				end

				arg_259_1.text_.text = var_262_27
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221064", "story_v_out_416221.awb") ~= 0 then
					local var_262_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221064", "story_v_out_416221.awb") / 1000

					if var_262_31 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_31 + var_262_23
					end

					if var_262_26.prefab_name ~= "" and arg_259_1.actors_[var_262_26.prefab_name] ~= nil then
						local var_262_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_26.prefab_name].transform, "story_v_out_416221", "416221064", "story_v_out_416221.awb")

						arg_259_1:RecordAudio("416221064", var_262_32)
						arg_259_1:RecordAudio("416221064", var_262_32)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416221", "416221064", "story_v_out_416221.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416221", "416221064", "story_v_out_416221.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_33 = math.max(var_262_24, arg_259_1.talkMaxDuration)

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_33 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_23) / var_262_33

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_23 + var_262_33 and arg_259_1.time_ < var_262_23 + var_262_33 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play416221065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416221065
		arg_263_1.duration_ = 9

		local var_263_0 = {
			zh = 7.466,
			ja = 9
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
				arg_263_0:Play416221066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.925

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[1080].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(416221065)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 37
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221065", "story_v_out_416221.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221065", "story_v_out_416221.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_416221", "416221065", "story_v_out_416221.awb")

						arg_263_1:RecordAudio("416221065", var_266_9)
						arg_263_1:RecordAudio("416221065", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416221", "416221065", "story_v_out_416221.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416221", "416221065", "story_v_out_416221.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_10 and arg_263_1.time_ < var_266_0 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play416221066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416221066
		arg_267_1.duration_ = 5.63

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416221067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.65

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[1080].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(416221066)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 26
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221066", "story_v_out_416221.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221066", "story_v_out_416221.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_416221", "416221066", "story_v_out_416221.awb")

						arg_267_1:RecordAudio("416221066", var_270_9)
						arg_267_1:RecordAudio("416221066", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_416221", "416221066", "story_v_out_416221.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_416221", "416221066", "story_v_out_416221.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416221067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416221067
		arg_271_1.duration_ = 7.5

		local var_271_0 = {
			zh = 3.766,
			ja = 7.5
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
				arg_271_0:Play416221068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1028"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1028 == nil then
				arg_271_1.var_.actorSpriteComps1028 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1028 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1028 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1028 = nil
			end

			local var_274_8 = arg_271_1.actors_["1086"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1086 == nil then
				arg_271_1.var_.actorSpriteComps1086 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps1086 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								local var_274_12 = Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor2.r, var_274_11)
								local var_274_13 = Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor2.g, var_274_11)
								local var_274_14 = Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor2.b, var_274_11)

								iter_274_5.color = Color.New(var_274_12, var_274_13, var_274_14)
							else
								local var_274_15 = Mathf.Lerp(iter_274_5.color.r, 0.5, var_274_11)

								iter_274_5.color = Color.New(var_274_15, var_274_15, var_274_15)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1086 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1086 = nil
			end

			local var_274_16 = 0
			local var_274_17 = 0.425

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_18 = arg_271_1:FormatText(StoryNameCfg[327].name)

				arg_271_1.leftNameTxt_.text = var_274_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(416221067)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 17
				local var_274_22 = utf8.len(var_274_20)
				local var_274_23 = var_274_21 <= 0 and var_274_17 or var_274_17 * (var_274_22 / var_274_21)

				if var_274_23 > 0 and var_274_17 < var_274_23 then
					arg_271_1.talkMaxDuration = var_274_23

					if var_274_23 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_16
					end
				end

				arg_271_1.text_.text = var_274_20
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221067", "story_v_out_416221.awb") ~= 0 then
					local var_274_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221067", "story_v_out_416221.awb") / 1000

					if var_274_24 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_16
					end

					if var_274_19.prefab_name ~= "" and arg_271_1.actors_[var_274_19.prefab_name] ~= nil then
						local var_274_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_19.prefab_name].transform, "story_v_out_416221", "416221067", "story_v_out_416221.awb")

						arg_271_1:RecordAudio("416221067", var_274_25)
						arg_271_1:RecordAudio("416221067", var_274_25)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416221", "416221067", "story_v_out_416221.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416221", "416221067", "story_v_out_416221.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_26 = math.max(var_274_17, arg_271_1.talkMaxDuration)

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_26 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_16) / var_274_26

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_16 + var_274_26 and arg_271_1.time_ < var_274_16 + var_274_26 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play416221068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416221068
		arg_275_1.duration_ = 5.8

		local var_275_0 = {
			zh = 2.966,
			ja = 5.8
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
				arg_275_0:Play416221069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1086"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1086 == nil then
				arg_275_1.var_.actorSpriteComps1086 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1086 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1086 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1086 = nil
			end

			local var_278_8 = arg_275_1.actors_["1028"]
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1028 == nil then
				arg_275_1.var_.actorSpriteComps1028 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_10 = 0.2

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 and not isNil(var_278_8) then
				local var_278_11 = (arg_275_1.time_ - var_278_9) / var_278_10

				if arg_275_1.var_.actorSpriteComps1028 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1028 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_278_7 then
						if arg_275_1.isInRecall_ then
							iter_278_7.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1028 = nil
			end

			local var_278_16 = 0
			local var_278_17 = 0.325

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_18 = arg_275_1:FormatText(StoryNameCfg[1080].name)

				arg_275_1.leftNameTxt_.text = var_278_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_19 = arg_275_1:GetWordFromCfg(416221068)
				local var_278_20 = arg_275_1:FormatText(var_278_19.content)

				arg_275_1.text_.text = var_278_20

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_21 = 13
				local var_278_22 = utf8.len(var_278_20)
				local var_278_23 = var_278_21 <= 0 and var_278_17 or var_278_17 * (var_278_22 / var_278_21)

				if var_278_23 > 0 and var_278_17 < var_278_23 then
					arg_275_1.talkMaxDuration = var_278_23

					if var_278_23 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_20
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221068", "story_v_out_416221.awb") ~= 0 then
					local var_278_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221068", "story_v_out_416221.awb") / 1000

					if var_278_24 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_24 + var_278_16
					end

					if var_278_19.prefab_name ~= "" and arg_275_1.actors_[var_278_19.prefab_name] ~= nil then
						local var_278_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_19.prefab_name].transform, "story_v_out_416221", "416221068", "story_v_out_416221.awb")

						arg_275_1:RecordAudio("416221068", var_278_25)
						arg_275_1:RecordAudio("416221068", var_278_25)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416221", "416221068", "story_v_out_416221.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416221", "416221068", "story_v_out_416221.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_26 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_26 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_16) / var_278_26

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_16 + var_278_26 and arg_275_1.time_ < var_278_16 + var_278_26 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play416221069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416221069
		arg_279_1.duration_ = 8.73

		local var_279_0 = {
			zh = 4.566,
			ja = 8.733
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
				arg_279_0:Play416221070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1028"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1028 == nil then
				arg_279_1.var_.actorSpriteComps1028 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps1028 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1028 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1028 = nil
			end

			local var_282_8 = arg_279_1.actors_["1086"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1086 == nil then
				arg_279_1.var_.actorSpriteComps1086 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 0.2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps1086 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								local var_282_12 = Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, var_282_11)
								local var_282_13 = Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, var_282_11)
								local var_282_14 = Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, var_282_11)

								iter_282_5.color = Color.New(var_282_12, var_282_13, var_282_14)
							else
								local var_282_15 = Mathf.Lerp(iter_282_5.color.r, 0.5, var_282_11)

								iter_282_5.color = Color.New(var_282_15, var_282_15, var_282_15)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1086 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1086 = nil
			end

			local var_282_16 = 0
			local var_282_17 = 0.5

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_18 = arg_279_1:FormatText(StoryNameCfg[327].name)

				arg_279_1.leftNameTxt_.text = var_282_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_19 = arg_279_1:GetWordFromCfg(416221069)
				local var_282_20 = arg_279_1:FormatText(var_282_19.content)

				arg_279_1.text_.text = var_282_20

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_21 = 20
				local var_282_22 = utf8.len(var_282_20)
				local var_282_23 = var_282_21 <= 0 and var_282_17 or var_282_17 * (var_282_22 / var_282_21)

				if var_282_23 > 0 and var_282_17 < var_282_23 then
					arg_279_1.talkMaxDuration = var_282_23

					if var_282_23 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_16
					end
				end

				arg_279_1.text_.text = var_282_20
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221069", "story_v_out_416221.awb") ~= 0 then
					local var_282_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221069", "story_v_out_416221.awb") / 1000

					if var_282_24 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_16
					end

					if var_282_19.prefab_name ~= "" and arg_279_1.actors_[var_282_19.prefab_name] ~= nil then
						local var_282_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_19.prefab_name].transform, "story_v_out_416221", "416221069", "story_v_out_416221.awb")

						arg_279_1:RecordAudio("416221069", var_282_25)
						arg_279_1:RecordAudio("416221069", var_282_25)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416221", "416221069", "story_v_out_416221.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416221", "416221069", "story_v_out_416221.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_26 = math.max(var_282_17, arg_279_1.talkMaxDuration)

			if var_282_16 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_26 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_16) / var_282_26

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_16 + var_282_26 and arg_279_1.time_ < var_282_16 + var_282_26 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play416221070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416221070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play416221071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1028"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1028 == nil then
				arg_283_1.var_.actorSpriteComps1028 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps1028 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1028 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1028 = nil
			end

			local var_286_8 = arg_283_1.actors_["1028"].transform
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.var_.moveOldPos1028 = var_286_8.localPosition
				var_286_8.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1028", 7)

				local var_286_10 = var_286_8.childCount

				for iter_286_4 = 0, var_286_10 - 1 do
					local var_286_11 = var_286_8:GetChild(iter_286_4)

					if var_286_11.name == "" or not string.find(var_286_11.name, "split") then
						var_286_11.gameObject:SetActive(true)
					else
						var_286_11.gameObject:SetActive(false)
					end
				end
			end

			local var_286_12 = 0.001

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_12 then
				local var_286_13 = (arg_283_1.time_ - var_286_9) / var_286_12
				local var_286_14 = Vector3.New(0, -2000, 0)

				var_286_8.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1028, var_286_14, var_286_13)
			end

			if arg_283_1.time_ >= var_286_9 + var_286_12 and arg_283_1.time_ < var_286_9 + var_286_12 + arg_286_0 then
				var_286_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_15 = arg_283_1.actors_["1086"].transform
			local var_286_16 = 0

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.var_.moveOldPos1086 = var_286_15.localPosition
				var_286_15.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1086", 7)

				local var_286_17 = var_286_15.childCount

				for iter_286_5 = 0, var_286_17 - 1 do
					local var_286_18 = var_286_15:GetChild(iter_286_5)

					if var_286_18.name == "" or not string.find(var_286_18.name, "split") then
						var_286_18.gameObject:SetActive(true)
					else
						var_286_18.gameObject:SetActive(false)
					end
				end
			end

			local var_286_19 = 0.001

			if var_286_16 <= arg_283_1.time_ and arg_283_1.time_ < var_286_16 + var_286_19 then
				local var_286_20 = (arg_283_1.time_ - var_286_16) / var_286_19
				local var_286_21 = Vector3.New(0, -2000, 0)

				var_286_15.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1086, var_286_21, var_286_20)
			end

			if arg_283_1.time_ >= var_286_16 + var_286_19 and arg_283_1.time_ < var_286_16 + var_286_19 + arg_286_0 then
				var_286_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_22 = 0.2
			local var_286_23 = 1

			if var_286_22 < arg_283_1.time_ and arg_283_1.time_ <= var_286_22 + arg_286_0 then
				local var_286_24 = "play"
				local var_286_25 = "effect"

				arg_283_1:AudioAction(var_286_24, var_286_25, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_286_26 = 0
			local var_286_27 = 1.55

			if var_286_26 < arg_283_1.time_ and arg_283_1.time_ <= var_286_26 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_28 = arg_283_1:GetWordFromCfg(416221070)
				local var_286_29 = arg_283_1:FormatText(var_286_28.content)

				arg_283_1.text_.text = var_286_29

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_30 = 62
				local var_286_31 = utf8.len(var_286_29)
				local var_286_32 = var_286_30 <= 0 and var_286_27 or var_286_27 * (var_286_31 / var_286_30)

				if var_286_32 > 0 and var_286_27 < var_286_32 then
					arg_283_1.talkMaxDuration = var_286_32

					if var_286_32 + var_286_26 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_32 + var_286_26
					end
				end

				arg_283_1.text_.text = var_286_29
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_33 = math.max(var_286_27, arg_283_1.talkMaxDuration)

			if var_286_26 <= arg_283_1.time_ and arg_283_1.time_ < var_286_26 + var_286_33 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_26) / var_286_33

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_26 + var_286_33 and arg_283_1.time_ < var_286_26 + var_286_33 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play416221071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416221071
		arg_287_1.duration_ = 5.67

		local var_287_0 = {
			zh = 4.566,
			ja = 5.666
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
				arg_287_0:Play416221072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1028"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1028 == nil then
				arg_287_1.var_.actorSpriteComps1028 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1028 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1028 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1028 = nil
			end

			local var_290_8 = arg_287_1.actors_["1028"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos1028 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1028", 2)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(-390, -402.7, -156.1)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1028, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_290_15 = 0
			local var_290_16 = 0.625

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[327].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(416221071)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221071", "story_v_out_416221.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221071", "story_v_out_416221.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_416221", "416221071", "story_v_out_416221.awb")

						arg_287_1:RecordAudio("416221071", var_290_24)
						arg_287_1:RecordAudio("416221071", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416221", "416221071", "story_v_out_416221.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416221", "416221071", "story_v_out_416221.awb")
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
				actorName = "1028",
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
	Play416221072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416221072
		arg_291_1.duration_ = 5.6

		local var_291_0 = {
			zh = 5.6,
			ja = 4.233
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
				arg_291_0:Play416221073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1086"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1086 == nil then
				arg_291_1.var_.actorSpriteComps1086 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1086 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 1, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1086 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1086 = nil
			end

			local var_294_8 = arg_291_1.actors_["1028"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps1028 == nil then
				arg_291_1.var_.actorSpriteComps1028 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 0.2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps1028 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_294_5 then
							if arg_291_1.isInRecall_ then
								local var_294_12 = Mathf.Lerp(iter_294_5.color.r, arg_291_1.hightColor2.r, var_294_11)
								local var_294_13 = Mathf.Lerp(iter_294_5.color.g, arg_291_1.hightColor2.g, var_294_11)
								local var_294_14 = Mathf.Lerp(iter_294_5.color.b, arg_291_1.hightColor2.b, var_294_11)

								iter_294_5.color = Color.New(var_294_12, var_294_13, var_294_14)
							else
								local var_294_15 = Mathf.Lerp(iter_294_5.color.r, 0.5, var_294_11)

								iter_294_5.color = Color.New(var_294_15, var_294_15, var_294_15)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps1028 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1028 = nil
			end

			local var_294_16 = arg_291_1.actors_["1086"].transform
			local var_294_17 = 0

			if var_294_17 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.var_.moveOldPos1086 = var_294_16.localPosition
				var_294_16.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1086", 4)

				local var_294_18 = var_294_16.childCount

				for iter_294_8 = 0, var_294_18 - 1 do
					local var_294_19 = var_294_16:GetChild(iter_294_8)

					if var_294_19.name == "" or not string.find(var_294_19.name, "split") then
						var_294_19.gameObject:SetActive(true)
					else
						var_294_19.gameObject:SetActive(false)
					end
				end
			end

			local var_294_20 = 0.001

			if var_294_17 <= arg_291_1.time_ and arg_291_1.time_ < var_294_17 + var_294_20 then
				local var_294_21 = (arg_291_1.time_ - var_294_17) / var_294_20
				local var_294_22 = Vector3.New(390, -404.2, -237.9)

				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1086, var_294_22, var_294_21)
			end

			if arg_291_1.time_ >= var_294_17 + var_294_20 and arg_291_1.time_ < var_294_17 + var_294_20 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_294_23 = 0
			local var_294_24 = 0.525

			if var_294_23 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_25 = arg_291_1:FormatText(StoryNameCfg[1080].name)

				arg_291_1.leftNameTxt_.text = var_294_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_26 = arg_291_1:GetWordFromCfg(416221072)
				local var_294_27 = arg_291_1:FormatText(var_294_26.content)

				arg_291_1.text_.text = var_294_27

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_28 = 21
				local var_294_29 = utf8.len(var_294_27)
				local var_294_30 = var_294_28 <= 0 and var_294_24 or var_294_24 * (var_294_29 / var_294_28)

				if var_294_30 > 0 and var_294_24 < var_294_30 then
					arg_291_1.talkMaxDuration = var_294_30

					if var_294_30 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_30 + var_294_23
					end
				end

				arg_291_1.text_.text = var_294_27
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221072", "story_v_out_416221.awb") ~= 0 then
					local var_294_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221072", "story_v_out_416221.awb") / 1000

					if var_294_31 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_31 + var_294_23
					end

					if var_294_26.prefab_name ~= "" and arg_291_1.actors_[var_294_26.prefab_name] ~= nil then
						local var_294_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_26.prefab_name].transform, "story_v_out_416221", "416221072", "story_v_out_416221.awb")

						arg_291_1:RecordAudio("416221072", var_294_32)
						arg_291_1:RecordAudio("416221072", var_294_32)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416221", "416221072", "story_v_out_416221.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416221", "416221072", "story_v_out_416221.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_33 = math.max(var_294_24, arg_291_1.talkMaxDuration)

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_33 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_23) / var_294_33

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_23 + var_294_33 and arg_291_1.time_ < var_294_23 + var_294_33 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play416221073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416221073
		arg_295_1.duration_ = 2.87

		local var_295_0 = {
			zh = 2.866,
			ja = 2.8
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
				arg_295_0:Play416221074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1028"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1028 == nil then
				arg_295_1.var_.actorSpriteComps1028 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps1028 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1028 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1028 = nil
			end

			local var_298_8 = arg_295_1.actors_["1086"]
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps1086 == nil then
				arg_295_1.var_.actorSpriteComps1086 = var_298_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_10 = 0.2

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_10 and not isNil(var_298_8) then
				local var_298_11 = (arg_295_1.time_ - var_298_9) / var_298_10

				if arg_295_1.var_.actorSpriteComps1086 then
					for iter_298_4, iter_298_5 in pairs(arg_295_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_298_5 then
							if arg_295_1.isInRecall_ then
								local var_298_12 = Mathf.Lerp(iter_298_5.color.r, arg_295_1.hightColor2.r, var_298_11)
								local var_298_13 = Mathf.Lerp(iter_298_5.color.g, arg_295_1.hightColor2.g, var_298_11)
								local var_298_14 = Mathf.Lerp(iter_298_5.color.b, arg_295_1.hightColor2.b, var_298_11)

								iter_298_5.color = Color.New(var_298_12, var_298_13, var_298_14)
							else
								local var_298_15 = Mathf.Lerp(iter_298_5.color.r, 0.5, var_298_11)

								iter_298_5.color = Color.New(var_298_15, var_298_15, var_298_15)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_9 + var_298_10 and arg_295_1.time_ < var_298_9 + var_298_10 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps1086 then
				for iter_298_6, iter_298_7 in pairs(arg_295_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_298_7 then
						if arg_295_1.isInRecall_ then
							iter_298_7.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1086 = nil
			end

			local var_298_16 = arg_295_1.actors_["1028"].transform
			local var_298_17 = 0

			if var_298_17 < arg_295_1.time_ and arg_295_1.time_ <= var_298_17 + arg_298_0 then
				arg_295_1.var_.moveOldPos1028 = var_298_16.localPosition
				var_298_16.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("1028", 2)

				local var_298_18 = var_298_16.childCount

				for iter_298_8 = 0, var_298_18 - 1 do
					local var_298_19 = var_298_16:GetChild(iter_298_8)

					if var_298_19.name == "split_6" or not string.find(var_298_19.name, "split") then
						var_298_19.gameObject:SetActive(true)
					else
						var_298_19.gameObject:SetActive(false)
					end
				end
			end

			local var_298_20 = 0.001

			if var_298_17 <= arg_295_1.time_ and arg_295_1.time_ < var_298_17 + var_298_20 then
				local var_298_21 = (arg_295_1.time_ - var_298_17) / var_298_20
				local var_298_22 = Vector3.New(-390, -402.7, -156.1)

				var_298_16.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1028, var_298_22, var_298_21)
			end

			if arg_295_1.time_ >= var_298_17 + var_298_20 and arg_295_1.time_ < var_298_17 + var_298_20 + arg_298_0 then
				var_298_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_298_23 = 0
			local var_298_24 = 0.2

			if var_298_23 < arg_295_1.time_ and arg_295_1.time_ <= var_298_23 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_25 = arg_295_1:FormatText(StoryNameCfg[327].name)

				arg_295_1.leftNameTxt_.text = var_298_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_26 = arg_295_1:GetWordFromCfg(416221073)
				local var_298_27 = arg_295_1:FormatText(var_298_26.content)

				arg_295_1.text_.text = var_298_27

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_28 = 8
				local var_298_29 = utf8.len(var_298_27)
				local var_298_30 = var_298_28 <= 0 and var_298_24 or var_298_24 * (var_298_29 / var_298_28)

				if var_298_30 > 0 and var_298_24 < var_298_30 then
					arg_295_1.talkMaxDuration = var_298_30

					if var_298_30 + var_298_23 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_30 + var_298_23
					end
				end

				arg_295_1.text_.text = var_298_27
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221073", "story_v_out_416221.awb") ~= 0 then
					local var_298_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221073", "story_v_out_416221.awb") / 1000

					if var_298_31 + var_298_23 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_31 + var_298_23
					end

					if var_298_26.prefab_name ~= "" and arg_295_1.actors_[var_298_26.prefab_name] ~= nil then
						local var_298_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_26.prefab_name].transform, "story_v_out_416221", "416221073", "story_v_out_416221.awb")

						arg_295_1:RecordAudio("416221073", var_298_32)
						arg_295_1:RecordAudio("416221073", var_298_32)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416221", "416221073", "story_v_out_416221.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416221", "416221073", "story_v_out_416221.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_33 = math.max(var_298_24, arg_295_1.talkMaxDuration)

			if var_298_23 <= arg_295_1.time_ and arg_295_1.time_ < var_298_23 + var_298_33 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_23) / var_298_33

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_23 + var_298_33 and arg_295_1.time_ < var_298_23 + var_298_33 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play416221074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416221074
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play416221075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1028"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1028 == nil then
				arg_299_1.var_.actorSpriteComps1028 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps1028 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor2.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor2.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor2.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 0.5, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1028 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1028 = nil
			end

			local var_302_8 = arg_299_1.actors_["1028"].transform
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 then
				arg_299_1.var_.moveOldPos1028 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1028", 7)

				local var_302_10 = var_302_8.childCount

				for iter_302_4 = 0, var_302_10 - 1 do
					local var_302_11 = var_302_8:GetChild(iter_302_4)

					if var_302_11.name == "" or not string.find(var_302_11.name, "split") then
						var_302_11.gameObject:SetActive(true)
					else
						var_302_11.gameObject:SetActive(false)
					end
				end
			end

			local var_302_12 = 0.001

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_12 then
				local var_302_13 = (arg_299_1.time_ - var_302_9) / var_302_12
				local var_302_14 = Vector3.New(0, -2000, 0)

				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1028, var_302_14, var_302_13)
			end

			if arg_299_1.time_ >= var_302_9 + var_302_12 and arg_299_1.time_ < var_302_9 + var_302_12 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_302_15 = arg_299_1.actors_["1086"].transform
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1.var_.moveOldPos1086 = var_302_15.localPosition
				var_302_15.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1086", 7)

				local var_302_17 = var_302_15.childCount

				for iter_302_5 = 0, var_302_17 - 1 do
					local var_302_18 = var_302_15:GetChild(iter_302_5)

					if var_302_18.name == "" or not string.find(var_302_18.name, "split") then
						var_302_18.gameObject:SetActive(true)
					else
						var_302_18.gameObject:SetActive(false)
					end
				end
			end

			local var_302_19 = 0.001

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_19 then
				local var_302_20 = (arg_299_1.time_ - var_302_16) / var_302_19
				local var_302_21 = Vector3.New(0, -2000, 0)

				var_302_15.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1086, var_302_21, var_302_20)
			end

			if arg_299_1.time_ >= var_302_16 + var_302_19 and arg_299_1.time_ < var_302_16 + var_302_19 + arg_302_0 then
				var_302_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_302_22 = 0.034
			local var_302_23 = 1

			if var_302_22 < arg_299_1.time_ and arg_299_1.time_ <= var_302_22 + arg_302_0 then
				local var_302_24 = "play"
				local var_302_25 = "effect"

				arg_299_1:AudioAction(var_302_24, var_302_25, "se_story_138", "se_story_138_elecskill01", "")
			end

			local var_302_26 = 0
			local var_302_27 = 1.15

			if var_302_26 < arg_299_1.time_ and arg_299_1.time_ <= var_302_26 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_28 = arg_299_1:GetWordFromCfg(416221074)
				local var_302_29 = arg_299_1:FormatText(var_302_28.content)

				arg_299_1.text_.text = var_302_29

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_30 = 46
				local var_302_31 = utf8.len(var_302_29)
				local var_302_32 = var_302_30 <= 0 and var_302_27 or var_302_27 * (var_302_31 / var_302_30)

				if var_302_32 > 0 and var_302_27 < var_302_32 then
					arg_299_1.talkMaxDuration = var_302_32

					if var_302_32 + var_302_26 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_32 + var_302_26
					end
				end

				arg_299_1.text_.text = var_302_29
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_33 = math.max(var_302_27, arg_299_1.talkMaxDuration)

			if var_302_26 <= arg_299_1.time_ and arg_299_1.time_ < var_302_26 + var_302_33 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_26) / var_302_33

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_26 + var_302_33 and arg_299_1.time_ < var_302_26 + var_302_33 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play416221075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416221075
		arg_303_1.duration_ = 5

		local var_303_0 = {
			zh = 4.8,
			ja = 5
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
				arg_303_0:Play416221076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1028"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1028 == nil then
				arg_303_1.var_.actorSpriteComps1028 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1028 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 1, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1028 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1028 = nil
			end

			local var_306_8 = arg_303_1.actors_["1028"].transform
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.var_.moveOldPos1028 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1028", 3)

				local var_306_10 = var_306_8.childCount

				for iter_306_4 = 0, var_306_10 - 1 do
					local var_306_11 = var_306_8:GetChild(iter_306_4)

					if var_306_11.name == "" or not string.find(var_306_11.name, "split") then
						var_306_11.gameObject:SetActive(true)
					else
						var_306_11.gameObject:SetActive(false)
					end
				end
			end

			local var_306_12 = 0.001

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_9) / var_306_12
				local var_306_14 = Vector3.New(0, -402.7, -156.1)

				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1028, var_306_14, var_306_13)
			end

			if arg_303_1.time_ >= var_306_9 + var_306_12 and arg_303_1.time_ < var_306_9 + var_306_12 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_306_15 = 0
			local var_306_16 = 0.475

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[327].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(416221075)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 19
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221075", "story_v_out_416221.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221075", "story_v_out_416221.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_out_416221", "416221075", "story_v_out_416221.awb")

						arg_303_1:RecordAudio("416221075", var_306_24)
						arg_303_1:RecordAudio("416221075", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416221", "416221075", "story_v_out_416221.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416221", "416221075", "story_v_out_416221.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play416221076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416221076
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play416221077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1028"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1028 == nil then
				arg_307_1.var_.actorSpriteComps1028 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps1028 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1028 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1028 = nil
			end

			local var_310_8 = 0
			local var_310_9 = 1.15

			if var_310_8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(416221076)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_12 = 46
				local var_310_13 = utf8.len(var_310_11)
				local var_310_14 = var_310_12 <= 0 and var_310_9 or var_310_9 * (var_310_13 / var_310_12)

				if var_310_14 > 0 and var_310_9 < var_310_14 then
					arg_307_1.talkMaxDuration = var_310_14

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_15 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_15 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_15

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_15 and arg_307_1.time_ < var_310_8 + var_310_15 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play416221077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416221077
		arg_311_1.duration_ = 3.7

		local var_311_0 = {
			zh = 3.7,
			ja = 3.566
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
				arg_311_0:Play416221078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1028"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1028 == nil then
				arg_311_1.var_.actorSpriteComps1028 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1028 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1028 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1028 = nil
			end

			local var_314_8 = arg_311_1.actors_["1028"].transform
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.var_.moveOldPos1028 = var_314_8.localPosition
				var_314_8.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1028", 3)

				local var_314_10 = var_314_8.childCount

				for iter_314_4 = 0, var_314_10 - 1 do
					local var_314_11 = var_314_8:GetChild(iter_314_4)

					if var_314_11.name == "" or not string.find(var_314_11.name, "split") then
						var_314_11.gameObject:SetActive(true)
					else
						var_314_11.gameObject:SetActive(false)
					end
				end
			end

			local var_314_12 = 0.001

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_9) / var_314_12
				local var_314_14 = Vector3.New(0, -402.7, -156.1)

				var_314_8.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1028, var_314_14, var_314_13)
			end

			if arg_311_1.time_ >= var_314_9 + var_314_12 and arg_311_1.time_ < var_314_9 + var_314_12 + arg_314_0 then
				var_314_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_314_15 = 0
			local var_314_16 = 0.375

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[327].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(416221077)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 15
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_16 or var_314_16 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_16 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_15
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221077", "story_v_out_416221.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221077", "story_v_out_416221.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_416221", "416221077", "story_v_out_416221.awb")

						arg_311_1:RecordAudio("416221077", var_314_24)
						arg_311_1:RecordAudio("416221077", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416221", "416221077", "story_v_out_416221.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416221", "416221077", "story_v_out_416221.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = math.max(var_314_16, arg_311_1.talkMaxDuration)

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_25 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_15) / var_314_25

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_15 + var_314_25 and arg_311_1.time_ < var_314_15 + var_314_25 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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

		arg_311_1:InitPlayNodeList()
	end,
	Play416221078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416221078
		arg_315_1.duration_ = 6

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play416221079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1028"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1028 == nil then
				arg_315_1.var_.actorSpriteComps1028 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1028 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor2.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor2.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor2.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 0.5, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1028 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1028 = nil
			end

			local var_318_8 = arg_315_1.actors_["1028"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos1028 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1028", 7)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(0, -2000, 0)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1028, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_15 = arg_315_1.actors_["1086"].transform
			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.var_.moveOldPos1086 = var_318_15.localPosition
				var_318_15.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1086", 7)

				local var_318_17 = var_318_15.childCount

				for iter_318_5 = 0, var_318_17 - 1 do
					local var_318_18 = var_318_15:GetChild(iter_318_5)

					if var_318_18.name == "" or not string.find(var_318_18.name, "split") then
						var_318_18.gameObject:SetActive(true)
					else
						var_318_18.gameObject:SetActive(false)
					end
				end
			end

			local var_318_19 = 0.001

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_19 then
				local var_318_20 = (arg_315_1.time_ - var_318_16) / var_318_19
				local var_318_21 = Vector3.New(0, -2000, 0)

				var_318_15.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1086, var_318_21, var_318_20)
			end

			if arg_315_1.time_ >= var_318_16 + var_318_19 and arg_315_1.time_ < var_318_16 + var_318_19 + arg_318_0 then
				var_318_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_22 = 0

			if var_318_22 < arg_315_1.time_ and arg_315_1.time_ <= var_318_22 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_23 = 0.333333333333333

			if var_318_22 <= arg_315_1.time_ and arg_315_1.time_ < var_318_22 + var_318_23 then
				local var_318_24 = (arg_315_1.time_ - var_318_22) / var_318_23
				local var_318_25 = Color.New(1, 1, 1)

				var_318_25.a = Mathf.Lerp(1, 0, var_318_24)
				arg_315_1.mask_.color = var_318_25
			end

			if arg_315_1.time_ >= var_318_22 + var_318_23 and arg_315_1.time_ < var_318_22 + var_318_23 + arg_318_0 then
				local var_318_26 = Color.New(1, 1, 1)
				local var_318_27 = 0

				arg_315_1.mask_.enabled = false
				var_318_26.a = var_318_27
				arg_315_1.mask_.color = var_318_26
			end

			local var_318_28 = 0.333333333333333

			if var_318_28 < arg_315_1.time_ and arg_315_1.time_ <= var_318_28 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_29 = 0.5

			if var_318_28 <= arg_315_1.time_ and arg_315_1.time_ < var_318_28 + var_318_29 then
				local var_318_30 = (arg_315_1.time_ - var_318_28) / var_318_29
				local var_318_31 = Color.New(1, 1, 1)

				var_318_31.a = Mathf.Lerp(1, 0, var_318_30)
				arg_315_1.mask_.color = var_318_31
			end

			if arg_315_1.time_ >= var_318_28 + var_318_29 and arg_315_1.time_ < var_318_28 + var_318_29 + arg_318_0 then
				local var_318_32 = Color.New(1, 1, 1)
				local var_318_33 = 0

				arg_315_1.mask_.enabled = false
				var_318_32.a = var_318_33
				arg_315_1.mask_.color = var_318_32
			end

			local var_318_34 = manager.ui.mainCamera.transform
			local var_318_35 = 0.034

			if var_318_35 < arg_315_1.time_ and arg_315_1.time_ <= var_318_35 + arg_318_0 then
				local var_318_36 = arg_315_1.var_.effect244
				local var_318_37
				local var_318_38 = var_318_34

				if not var_318_36 then
					var_318_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_318_38)
					var_318_36.name = "244"
					arg_315_1.var_.effect244 = var_318_36
				else
					var_318_36.transform:SetParent(var_318_38)
				end

				var_318_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_318_36.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_318_39 = manager.ui.mainCameraCom_
				local var_318_40 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_318_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_318_41 = var_318_36.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_318_42 = 15
				local var_318_43 = 2 * var_318_42 * Mathf.Tan(var_318_39.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_318_39.aspect
				local var_318_44 = 1
				local var_318_45 = 1.7777777777777777

				if var_318_45 < var_318_39.aspect then
					var_318_44 = var_318_43 / (2 * var_318_42 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_318_45)
				end

				for iter_318_6, iter_318_7 in ipairs(var_318_41) do
					local var_318_46 = iter_318_7.transform.localScale

					iter_318_7.transform.localScale = Vector3.New(var_318_46.x / var_318_40 * var_318_44, var_318_46.y / var_318_40, var_318_46.z)
				end
			end

			local var_318_47 = manager.ui.mainCamera.transform
			local var_318_48 = 0.534

			if var_318_48 < arg_315_1.time_ and arg_315_1.time_ <= var_318_48 + arg_318_0 then
				local var_318_49 = arg_315_1.var_.effect245
				local var_318_50
				local var_318_51 = var_318_47

				if not var_318_49 then
					var_318_49 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_318_51)
					var_318_49.name = "245"
					arg_315_1.var_.effect245 = var_318_49
				else
					var_318_49.transform:SetParent(var_318_51)
				end

				var_318_49.transform.localPosition = Vector3.New(0, 0, 0)
				var_318_49.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_318_52 = manager.ui.mainCameraCom_
				local var_318_53 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_318_52.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_318_54 = var_318_49.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_318_55 = 15
				local var_318_56 = 2 * var_318_55 * Mathf.Tan(var_318_52.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_318_52.aspect
				local var_318_57 = 1
				local var_318_58 = 1.7777777777777777

				if var_318_58 < var_318_52.aspect then
					var_318_57 = var_318_56 / (2 * var_318_55 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_318_58)
				end

				for iter_318_8, iter_318_9 in ipairs(var_318_54) do
					local var_318_59 = iter_318_9.transform.localScale

					iter_318_9.transform.localScale = Vector3.New(var_318_59.x / var_318_53 * var_318_57, var_318_59.y / var_318_53, var_318_59.z)
				end
			end

			local var_318_60 = manager.ui.mainCamera.transform
			local var_318_61 = 1.034

			if var_318_61 < arg_315_1.time_ and arg_315_1.time_ <= var_318_61 + arg_318_0 then
				local var_318_62 = arg_315_1.var_.effect244

				if var_318_62 then
					Object.Destroy(var_318_62)

					arg_315_1.var_.effect244 = nil
				end
			end

			local var_318_63 = manager.ui.mainCamera.transform
			local var_318_64 = 1.434

			if var_318_64 < arg_315_1.time_ and arg_315_1.time_ <= var_318_64 + arg_318_0 then
				local var_318_65 = arg_315_1.var_.effect245

				if var_318_65 then
					Object.Destroy(var_318_65)

					arg_315_1.var_.effect245 = nil
				end
			end

			local var_318_66 = 0

			if var_318_66 < arg_315_1.time_ and arg_315_1.time_ <= var_318_66 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			local var_318_67 = 1.7

			if arg_315_1.time_ >= var_318_66 + var_318_67 and arg_315_1.time_ < var_318_66 + var_318_67 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			local var_318_68 = 0.1
			local var_318_69 = 1

			if var_318_68 < arg_315_1.time_ and arg_315_1.time_ <= var_318_68 + arg_318_0 then
				local var_318_70 = "play"
				local var_318_71 = "effect"

				arg_315_1:AudioAction(var_318_70, var_318_71, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_72 = 1
			local var_318_73 = 1.55

			if var_318_72 < arg_315_1.time_ and arg_315_1.time_ <= var_318_72 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_74 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_74:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_75 = arg_315_1:GetWordFromCfg(416221078)
				local var_318_76 = arg_315_1:FormatText(var_318_75.content)

				arg_315_1.text_.text = var_318_76

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_77 = 62
				local var_318_78 = utf8.len(var_318_76)
				local var_318_79 = var_318_77 <= 0 and var_318_73 or var_318_73 * (var_318_78 / var_318_77)

				if var_318_79 > 0 and var_318_73 < var_318_79 then
					arg_315_1.talkMaxDuration = var_318_79
					var_318_72 = var_318_72 + 0.3

					if var_318_79 + var_318_72 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_79 + var_318_72
					end
				end

				arg_315_1.text_.text = var_318_76
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_80 = var_318_72 + 0.3
			local var_318_81 = math.max(var_318_73, arg_315_1.talkMaxDuration)

			if var_318_80 <= arg_315_1.time_ and arg_315_1.time_ < var_318_80 + var_318_81 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_80) / var_318_81

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_80 + var_318_81 and arg_315_1.time_ < var_318_80 + var_318_81 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play416221079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 416221079
		arg_321_1.duration_ = 7.53

		local var_321_0 = {
			zh = 7.533,
			ja = 5.133
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play416221080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = "10109"

			if arg_321_1.actors_[var_324_0] == nil then
				local var_324_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_324_1) then
					local var_324_2 = Object.Instantiate(var_324_1, arg_321_1.canvasGo_.transform)

					var_324_2.transform:SetSiblingIndex(1)

					var_324_2.name = var_324_0
					var_324_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_321_1.actors_[var_324_0] = var_324_2

					local var_324_3 = var_324_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_321_1.isInRecall_ then
						for iter_324_0, iter_324_1 in ipairs(var_324_3) do
							iter_324_1.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_324_4 = arg_321_1.actors_["10109"]
			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.actorSpriteComps10109 == nil then
				arg_321_1.var_.actorSpriteComps10109 = var_324_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_6 = 0.2

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 and not isNil(var_324_4) then
				local var_324_7 = (arg_321_1.time_ - var_324_5) / var_324_6

				if arg_321_1.var_.actorSpriteComps10109 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								local var_324_8 = Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor1.r, var_324_7)
								local var_324_9 = Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor1.g, var_324_7)
								local var_324_10 = Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor1.b, var_324_7)

								iter_324_3.color = Color.New(var_324_8, var_324_9, var_324_10)
							else
								local var_324_11 = Mathf.Lerp(iter_324_3.color.r, 1, var_324_7)

								iter_324_3.color = Color.New(var_324_11, var_324_11, var_324_11)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.actorSpriteComps10109 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_324_5 then
						if arg_321_1.isInRecall_ then
							iter_324_5.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10109 = nil
			end

			local var_324_12 = arg_321_1.actors_["10109"].transform
			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1.var_.moveOldPos10109 = var_324_12.localPosition
				var_324_12.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10109", 3)

				local var_324_14 = var_324_12.childCount

				for iter_324_6 = 0, var_324_14 - 1 do
					local var_324_15 = var_324_12:GetChild(iter_324_6)

					if var_324_15.name == "" or not string.find(var_324_15.name, "split") then
						var_324_15.gameObject:SetActive(true)
					else
						var_324_15.gameObject:SetActive(false)
					end
				end
			end

			local var_324_16 = 0.001

			if var_324_13 <= arg_321_1.time_ and arg_321_1.time_ < var_324_13 + var_324_16 then
				local var_324_17 = (arg_321_1.time_ - var_324_13) / var_324_16
				local var_324_18 = Vector3.New(0, -346.2, -395)

				var_324_12.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10109, var_324_18, var_324_17)
			end

			if arg_321_1.time_ >= var_324_13 + var_324_16 and arg_321_1.time_ < var_324_13 + var_324_16 + arg_324_0 then
				var_324_12.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_324_19 = 0
			local var_324_20 = 0.375

			if var_324_19 < arg_321_1.time_ and arg_321_1.time_ <= var_324_19 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_21 = arg_321_1:FormatText(StoryNameCfg[1093].name)

				arg_321_1.leftNameTxt_.text = var_324_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_22 = arg_321_1:GetWordFromCfg(416221079)
				local var_324_23 = arg_321_1:FormatText(var_324_22.content)

				arg_321_1.text_.text = var_324_23

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_24 = 15
				local var_324_25 = utf8.len(var_324_23)
				local var_324_26 = var_324_24 <= 0 and var_324_20 or var_324_20 * (var_324_25 / var_324_24)

				if var_324_26 > 0 and var_324_20 < var_324_26 then
					arg_321_1.talkMaxDuration = var_324_26

					if var_324_26 + var_324_19 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_26 + var_324_19
					end
				end

				arg_321_1.text_.text = var_324_23
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221079", "story_v_out_416221.awb") ~= 0 then
					local var_324_27 = manager.audio:GetVoiceLength("story_v_out_416221", "416221079", "story_v_out_416221.awb") / 1000

					if var_324_27 + var_324_19 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_27 + var_324_19
					end

					if var_324_22.prefab_name ~= "" and arg_321_1.actors_[var_324_22.prefab_name] ~= nil then
						local var_324_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_22.prefab_name].transform, "story_v_out_416221", "416221079", "story_v_out_416221.awb")

						arg_321_1:RecordAudio("416221079", var_324_28)
						arg_321_1:RecordAudio("416221079", var_324_28)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_416221", "416221079", "story_v_out_416221.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_416221", "416221079", "story_v_out_416221.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_29 = math.max(var_324_20, arg_321_1.talkMaxDuration)

			if var_324_19 <= arg_321_1.time_ and arg_321_1.time_ < var_324_19 + var_324_29 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_19) / var_324_29

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_19 + var_324_29 and arg_321_1.time_ < var_324_19 + var_324_29 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play416221080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 416221080
		arg_325_1.duration_ = 9.2

		local var_325_0 = {
			zh = 5.033,
			ja = 9.2
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
				arg_325_0:Play416221081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1028"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1028 == nil then
				arg_325_1.var_.actorSpriteComps1028 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps1028 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								local var_328_4 = Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, var_328_3)
								local var_328_5 = Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, var_328_3)
								local var_328_6 = Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, var_328_3)

								iter_328_1.color = Color.New(var_328_4, var_328_5, var_328_6)
							else
								local var_328_7 = Mathf.Lerp(iter_328_1.color.r, 1, var_328_3)

								iter_328_1.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1028 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps1028 = nil
			end

			local var_328_8 = arg_325_1.actors_["10109"]
			local var_328_9 = 0

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps10109 == nil then
				arg_325_1.var_.actorSpriteComps10109 = var_328_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_10 = 0.2

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_10 and not isNil(var_328_8) then
				local var_328_11 = (arg_325_1.time_ - var_328_9) / var_328_10

				if arg_325_1.var_.actorSpriteComps10109 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_328_5 then
							if arg_325_1.isInRecall_ then
								local var_328_12 = Mathf.Lerp(iter_328_5.color.r, arg_325_1.hightColor2.r, var_328_11)
								local var_328_13 = Mathf.Lerp(iter_328_5.color.g, arg_325_1.hightColor2.g, var_328_11)
								local var_328_14 = Mathf.Lerp(iter_328_5.color.b, arg_325_1.hightColor2.b, var_328_11)

								iter_328_5.color = Color.New(var_328_12, var_328_13, var_328_14)
							else
								local var_328_15 = Mathf.Lerp(iter_328_5.color.r, 0.5, var_328_11)

								iter_328_5.color = Color.New(var_328_15, var_328_15, var_328_15)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_9 + var_328_10 and arg_325_1.time_ < var_328_9 + var_328_10 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps10109 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_328_7 then
						if arg_325_1.isInRecall_ then
							iter_328_7.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10109 = nil
			end

			local var_328_16 = arg_325_1.actors_["10109"].transform
			local var_328_17 = 0

			if var_328_17 < arg_325_1.time_ and arg_325_1.time_ <= var_328_17 + arg_328_0 then
				arg_325_1.var_.moveOldPos10109 = var_328_16.localPosition
				var_328_16.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10109", 7)

				local var_328_18 = var_328_16.childCount

				for iter_328_8 = 0, var_328_18 - 1 do
					local var_328_19 = var_328_16:GetChild(iter_328_8)

					if var_328_19.name == "" or not string.find(var_328_19.name, "split") then
						var_328_19.gameObject:SetActive(true)
					else
						var_328_19.gameObject:SetActive(false)
					end
				end
			end

			local var_328_20 = 0.001

			if var_328_17 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_20 then
				local var_328_21 = (arg_325_1.time_ - var_328_17) / var_328_20
				local var_328_22 = Vector3.New(0, -2000, 0)

				var_328_16.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10109, var_328_22, var_328_21)
			end

			if arg_325_1.time_ >= var_328_17 + var_328_20 and arg_325_1.time_ < var_328_17 + var_328_20 + arg_328_0 then
				var_328_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_23 = arg_325_1.actors_["1028"].transform
			local var_328_24 = 0

			if var_328_24 < arg_325_1.time_ and arg_325_1.time_ <= var_328_24 + arg_328_0 then
				arg_325_1.var_.moveOldPos1028 = var_328_23.localPosition
				var_328_23.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1028", 3)

				local var_328_25 = var_328_23.childCount

				for iter_328_9 = 0, var_328_25 - 1 do
					local var_328_26 = var_328_23:GetChild(iter_328_9)

					if var_328_26.name == "" or not string.find(var_328_26.name, "split") then
						var_328_26.gameObject:SetActive(true)
					else
						var_328_26.gameObject:SetActive(false)
					end
				end
			end

			local var_328_27 = 0.001

			if var_328_24 <= arg_325_1.time_ and arg_325_1.time_ < var_328_24 + var_328_27 then
				local var_328_28 = (arg_325_1.time_ - var_328_24) / var_328_27
				local var_328_29 = Vector3.New(0, -402.7, -156.1)

				var_328_23.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1028, var_328_29, var_328_28)
			end

			if arg_325_1.time_ >= var_328_24 + var_328_27 and arg_325_1.time_ < var_328_24 + var_328_27 + arg_328_0 then
				var_328_23.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_328_30 = 0
			local var_328_31 = 0.5

			if var_328_30 < arg_325_1.time_ and arg_325_1.time_ <= var_328_30 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_32 = arg_325_1:FormatText(StoryNameCfg[327].name)

				arg_325_1.leftNameTxt_.text = var_328_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_33 = arg_325_1:GetWordFromCfg(416221080)
				local var_328_34 = arg_325_1:FormatText(var_328_33.content)

				arg_325_1.text_.text = var_328_34

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_35 = 20
				local var_328_36 = utf8.len(var_328_34)
				local var_328_37 = var_328_35 <= 0 and var_328_31 or var_328_31 * (var_328_36 / var_328_35)

				if var_328_37 > 0 and var_328_31 < var_328_37 then
					arg_325_1.talkMaxDuration = var_328_37

					if var_328_37 + var_328_30 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_37 + var_328_30
					end
				end

				arg_325_1.text_.text = var_328_34
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221080", "story_v_out_416221.awb") ~= 0 then
					local var_328_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221080", "story_v_out_416221.awb") / 1000

					if var_328_38 + var_328_30 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_38 + var_328_30
					end

					if var_328_33.prefab_name ~= "" and arg_325_1.actors_[var_328_33.prefab_name] ~= nil then
						local var_328_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_33.prefab_name].transform, "story_v_out_416221", "416221080", "story_v_out_416221.awb")

						arg_325_1:RecordAudio("416221080", var_328_39)
						arg_325_1:RecordAudio("416221080", var_328_39)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_416221", "416221080", "story_v_out_416221.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_416221", "416221080", "story_v_out_416221.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_40 = math.max(var_328_31, arg_325_1.talkMaxDuration)

			if var_328_30 <= arg_325_1.time_ and arg_325_1.time_ < var_328_30 + var_328_40 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_30) / var_328_40

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_30 + var_328_40 and arg_325_1.time_ < var_328_30 + var_328_40 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play416221081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 416221081
		arg_329_1.duration_ = 6.93

		local var_329_0 = {
			zh = 6.933,
			ja = 4.833
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
				arg_329_0:Play416221082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10109"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10109 == nil then
				arg_329_1.var_.actorSpriteComps10109 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps10109 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10109 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10109 = nil
			end

			local var_332_8 = arg_329_1.actors_["1028"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps1028 == nil then
				arg_329_1.var_.actorSpriteComps1028 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps1028 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_332_5 then
							if arg_329_1.isInRecall_ then
								local var_332_12 = Mathf.Lerp(iter_332_5.color.r, arg_329_1.hightColor2.r, var_332_11)
								local var_332_13 = Mathf.Lerp(iter_332_5.color.g, arg_329_1.hightColor2.g, var_332_11)
								local var_332_14 = Mathf.Lerp(iter_332_5.color.b, arg_329_1.hightColor2.b, var_332_11)

								iter_332_5.color = Color.New(var_332_12, var_332_13, var_332_14)
							else
								local var_332_15 = Mathf.Lerp(iter_332_5.color.r, 0.5, var_332_11)

								iter_332_5.color = Color.New(var_332_15, var_332_15, var_332_15)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps1028 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1028 = nil
			end

			local var_332_16 = arg_329_1.actors_["10109"].transform
			local var_332_17 = 0

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.var_.moveOldPos10109 = var_332_16.localPosition
				var_332_16.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("10109", 3)

				local var_332_18 = var_332_16.childCount

				for iter_332_8 = 0, var_332_18 - 1 do
					local var_332_19 = var_332_16:GetChild(iter_332_8)

					if var_332_19.name == "" or not string.find(var_332_19.name, "split") then
						var_332_19.gameObject:SetActive(true)
					else
						var_332_19.gameObject:SetActive(false)
					end
				end
			end

			local var_332_20 = 0.001

			if var_332_17 <= arg_329_1.time_ and arg_329_1.time_ < var_332_17 + var_332_20 then
				local var_332_21 = (arg_329_1.time_ - var_332_17) / var_332_20
				local var_332_22 = Vector3.New(0, -346.2, -395)

				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10109, var_332_22, var_332_21)
			end

			if arg_329_1.time_ >= var_332_17 + var_332_20 and arg_329_1.time_ < var_332_17 + var_332_20 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_332_23 = arg_329_1.actors_["1028"].transform
			local var_332_24 = 0

			if var_332_24 < arg_329_1.time_ and arg_329_1.time_ <= var_332_24 + arg_332_0 then
				arg_329_1.var_.moveOldPos1028 = var_332_23.localPosition
				var_332_23.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1028", 7)

				local var_332_25 = var_332_23.childCount

				for iter_332_9 = 0, var_332_25 - 1 do
					local var_332_26 = var_332_23:GetChild(iter_332_9)

					if var_332_26.name == "" or not string.find(var_332_26.name, "split") then
						var_332_26.gameObject:SetActive(true)
					else
						var_332_26.gameObject:SetActive(false)
					end
				end
			end

			local var_332_27 = 0.001

			if var_332_24 <= arg_329_1.time_ and arg_329_1.time_ < var_332_24 + var_332_27 then
				local var_332_28 = (arg_329_1.time_ - var_332_24) / var_332_27
				local var_332_29 = Vector3.New(0, -2000, 0)

				var_332_23.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1028, var_332_29, var_332_28)
			end

			if arg_329_1.time_ >= var_332_24 + var_332_27 and arg_329_1.time_ < var_332_24 + var_332_27 + arg_332_0 then
				var_332_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_332_30 = 0
			local var_332_31 = 0.275

			if var_332_30 < arg_329_1.time_ and arg_329_1.time_ <= var_332_30 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_32 = arg_329_1:FormatText(StoryNameCfg[1093].name)

				arg_329_1.leftNameTxt_.text = var_332_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_33 = arg_329_1:GetWordFromCfg(416221081)
				local var_332_34 = arg_329_1:FormatText(var_332_33.content)

				arg_329_1.text_.text = var_332_34

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_35 = 11
				local var_332_36 = utf8.len(var_332_34)
				local var_332_37 = var_332_35 <= 0 and var_332_31 or var_332_31 * (var_332_36 / var_332_35)

				if var_332_37 > 0 and var_332_31 < var_332_37 then
					arg_329_1.talkMaxDuration = var_332_37

					if var_332_37 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_37 + var_332_30
					end
				end

				arg_329_1.text_.text = var_332_34
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221081", "story_v_out_416221.awb") ~= 0 then
					local var_332_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221081", "story_v_out_416221.awb") / 1000

					if var_332_38 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_38 + var_332_30
					end

					if var_332_33.prefab_name ~= "" and arg_329_1.actors_[var_332_33.prefab_name] ~= nil then
						local var_332_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_33.prefab_name].transform, "story_v_out_416221", "416221081", "story_v_out_416221.awb")

						arg_329_1:RecordAudio("416221081", var_332_39)
						arg_329_1:RecordAudio("416221081", var_332_39)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_416221", "416221081", "story_v_out_416221.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_416221", "416221081", "story_v_out_416221.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_40 = math.max(var_332_31, arg_329_1.talkMaxDuration)

			if var_332_30 <= arg_329_1.time_ and arg_329_1.time_ < var_332_30 + var_332_40 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_30) / var_332_40

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_30 + var_332_40 and arg_329_1.time_ < var_332_30 + var_332_40 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416221082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416221082
		arg_333_1.duration_ = 12.57

		local var_333_0 = {
			zh = 7,
			ja = 12.566
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
				arg_333_0:Play416221083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1028"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1028 == nil then
				arg_333_1.var_.actorSpriteComps1028 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1028 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 1, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1028 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1028 = nil
			end

			local var_336_8 = arg_333_1.actors_["10109"]
			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10109 == nil then
				arg_333_1.var_.actorSpriteComps10109 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_10 = 0.2

			if var_336_9 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 and not isNil(var_336_8) then
				local var_336_11 = (arg_333_1.time_ - var_336_9) / var_336_10

				if arg_333_1.var_.actorSpriteComps10109 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								local var_336_12 = Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor2.r, var_336_11)
								local var_336_13 = Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor2.g, var_336_11)
								local var_336_14 = Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor2.b, var_336_11)

								iter_336_5.color = Color.New(var_336_12, var_336_13, var_336_14)
							else
								local var_336_15 = Mathf.Lerp(iter_336_5.color.r, 0.5, var_336_11)

								iter_336_5.color = Color.New(var_336_15, var_336_15, var_336_15)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10109 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_336_7 then
						if arg_333_1.isInRecall_ then
							iter_336_7.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10109 = nil
			end

			local var_336_16 = 0
			local var_336_17 = 0.7

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_18 = arg_333_1:FormatText(StoryNameCfg[327].name)

				arg_333_1.leftNameTxt_.text = var_336_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_19 = arg_333_1:GetWordFromCfg(416221082)
				local var_336_20 = arg_333_1:FormatText(var_336_19.content)

				arg_333_1.text_.text = var_336_20

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_21 = 28
				local var_336_22 = utf8.len(var_336_20)
				local var_336_23 = var_336_21 <= 0 and var_336_17 or var_336_17 * (var_336_22 / var_336_21)

				if var_336_23 > 0 and var_336_17 < var_336_23 then
					arg_333_1.talkMaxDuration = var_336_23

					if var_336_23 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_16
					end
				end

				arg_333_1.text_.text = var_336_20
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221082", "story_v_out_416221.awb") ~= 0 then
					local var_336_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221082", "story_v_out_416221.awb") / 1000

					if var_336_24 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_24 + var_336_16
					end

					if var_336_19.prefab_name ~= "" and arg_333_1.actors_[var_336_19.prefab_name] ~= nil then
						local var_336_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_19.prefab_name].transform, "story_v_out_416221", "416221082", "story_v_out_416221.awb")

						arg_333_1:RecordAudio("416221082", var_336_25)
						arg_333_1:RecordAudio("416221082", var_336_25)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_416221", "416221082", "story_v_out_416221.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_416221", "416221082", "story_v_out_416221.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_26 = math.max(var_336_17, arg_333_1.talkMaxDuration)

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_26 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_16) / var_336_26

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_16 + var_336_26 and arg_333_1.time_ < var_336_16 + var_336_26 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416221083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416221083
		arg_337_1.duration_ = 3.5

		local var_337_0 = {
			zh = 2.333,
			ja = 3.5
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
				arg_337_0:Play416221084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1086"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1086 == nil then
				arg_337_1.var_.actorSpriteComps1086 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps1086 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps1086 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1086 = nil
			end

			local var_340_8 = arg_337_1.actors_["1028"]
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1028 == nil then
				arg_337_1.var_.actorSpriteComps1028 = var_340_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_10 = 0.2

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_10 and not isNil(var_340_8) then
				local var_340_11 = (arg_337_1.time_ - var_340_9) / var_340_10

				if arg_337_1.var_.actorSpriteComps1028 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								local var_340_12 = Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor2.r, var_340_11)
								local var_340_13 = Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor2.g, var_340_11)
								local var_340_14 = Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor2.b, var_340_11)

								iter_340_5.color = Color.New(var_340_12, var_340_13, var_340_14)
							else
								local var_340_15 = Mathf.Lerp(iter_340_5.color.r, 0.5, var_340_11)

								iter_340_5.color = Color.New(var_340_15, var_340_15, var_340_15)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_9 + var_340_10 and arg_337_1.time_ < var_340_9 + var_340_10 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1028 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_340_7 then
						if arg_337_1.isInRecall_ then
							iter_340_7.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1028 = nil
			end

			local var_340_16 = 0
			local var_340_17 = 0.275

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_18 = arg_337_1:FormatText(StoryNameCfg[1080].name)

				arg_337_1.leftNameTxt_.text = var_340_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_5")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_19 = arg_337_1:GetWordFromCfg(416221083)
				local var_340_20 = arg_337_1:FormatText(var_340_19.content)

				arg_337_1.text_.text = var_340_20

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_21 = 11
				local var_340_22 = utf8.len(var_340_20)
				local var_340_23 = var_340_21 <= 0 and var_340_17 or var_340_17 * (var_340_22 / var_340_21)

				if var_340_23 > 0 and var_340_17 < var_340_23 then
					arg_337_1.talkMaxDuration = var_340_23

					if var_340_23 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_16
					end
				end

				arg_337_1.text_.text = var_340_20
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221083", "story_v_out_416221.awb") ~= 0 then
					local var_340_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221083", "story_v_out_416221.awb") / 1000

					if var_340_24 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_24 + var_340_16
					end

					if var_340_19.prefab_name ~= "" and arg_337_1.actors_[var_340_19.prefab_name] ~= nil then
						local var_340_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_19.prefab_name].transform, "story_v_out_416221", "416221083", "story_v_out_416221.awb")

						arg_337_1:RecordAudio("416221083", var_340_25)
						arg_337_1:RecordAudio("416221083", var_340_25)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_416221", "416221083", "story_v_out_416221.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_416221", "416221083", "story_v_out_416221.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_26 = math.max(var_340_17, arg_337_1.talkMaxDuration)

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_26 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_16) / var_340_26

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_16 + var_340_26 and arg_337_1.time_ < var_340_16 + var_340_26 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416221084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416221084
		arg_341_1.duration_ = 4.43

		local var_341_0 = {
			zh = 3.766,
			ja = 4.433
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
				arg_341_0:Play416221085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.375

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[327].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:GetWordFromCfg(416221084)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 15
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221084", "story_v_out_416221.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221084", "story_v_out_416221.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_416221", "416221084", "story_v_out_416221.awb")

						arg_341_1:RecordAudio("416221084", var_344_9)
						arg_341_1:RecordAudio("416221084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416221", "416221084", "story_v_out_416221.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416221", "416221084", "story_v_out_416221.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play416221085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416221085
		arg_345_1.duration_ = 20.43

		local var_345_0 = {
			zh = 9.033,
			ja = 20.433
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
				arg_345_0:Play416221086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10109"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10109 == nil then
				arg_345_1.var_.actorSpriteComps10109 = var_348_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.actorSpriteComps10109 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.actorSpriteComps10109 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_348_3 then
						if arg_345_1.isInRecall_ then
							iter_348_3.color = arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_348_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10109 = nil
			end

			local var_348_8 = arg_345_1.actors_["10109"].transform
			local var_348_9 = 0

			if var_348_9 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 then
				arg_345_1.var_.moveOldPos10109 = var_348_8.localPosition
				var_348_8.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10109", 3)

				local var_348_10 = var_348_8.childCount

				for iter_348_4 = 0, var_348_10 - 1 do
					local var_348_11 = var_348_8:GetChild(iter_348_4)

					if var_348_11.name == "" or not string.find(var_348_11.name, "split") then
						var_348_11.gameObject:SetActive(true)
					else
						var_348_11.gameObject:SetActive(false)
					end
				end
			end

			local var_348_12 = 0.001

			if var_348_9 <= arg_345_1.time_ and arg_345_1.time_ < var_348_9 + var_348_12 then
				local var_348_13 = (arg_345_1.time_ - var_348_9) / var_348_12
				local var_348_14 = Vector3.New(0, -346.2, -395)

				var_348_8.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10109, var_348_14, var_348_13)
			end

			if arg_345_1.time_ >= var_348_9 + var_348_12 and arg_345_1.time_ < var_348_9 + var_348_12 + arg_348_0 then
				var_348_8.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_348_15 = 0
			local var_348_16 = 0.7

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[1093].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(416221085)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 28
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221085", "story_v_out_416221.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221085", "story_v_out_416221.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_out_416221", "416221085", "story_v_out_416221.awb")

						arg_345_1:RecordAudio("416221085", var_348_24)
						arg_345_1:RecordAudio("416221085", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_416221", "416221085", "story_v_out_416221.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_416221", "416221085", "story_v_out_416221.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play416221086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 416221086
		arg_349_1.duration_ = 9

		local var_349_0 = {
			zh = 6.266,
			ja = 9
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
				arg_349_0:Play416221087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.6

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[1093].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:GetWordFromCfg(416221086)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 24
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221086", "story_v_out_416221.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_416221", "416221086", "story_v_out_416221.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_416221", "416221086", "story_v_out_416221.awb")

						arg_349_1:RecordAudio("416221086", var_352_9)
						arg_349_1:RecordAudio("416221086", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_416221", "416221086", "story_v_out_416221.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_416221", "416221086", "story_v_out_416221.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_10 and arg_349_1.time_ < var_352_0 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play416221087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 416221087
		arg_353_1.duration_ = 3.77

		local var_353_0 = {
			zh = 3.566,
			ja = 3.766
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
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play416221088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1086"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1086 == nil then
				arg_353_1.var_.actorSpriteComps1086 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps1086 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 1, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1086 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1086 = nil
			end

			local var_356_8 = arg_353_1.actors_["10109"]
			local var_356_9 = 0

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps10109 == nil then
				arg_353_1.var_.actorSpriteComps10109 = var_356_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_10 = 0.2

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_10 and not isNil(var_356_8) then
				local var_356_11 = (arg_353_1.time_ - var_356_9) / var_356_10

				if arg_353_1.var_.actorSpriteComps10109 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								local var_356_12 = Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, var_356_11)
								local var_356_13 = Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, var_356_11)
								local var_356_14 = Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, var_356_11)

								iter_356_5.color = Color.New(var_356_12, var_356_13, var_356_14)
							else
								local var_356_15 = Mathf.Lerp(iter_356_5.color.r, 0.5, var_356_11)

								iter_356_5.color = Color.New(var_356_15, var_356_15, var_356_15)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_9 + var_356_10 and arg_353_1.time_ < var_356_9 + var_356_10 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps10109 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_356_7 then
						if arg_353_1.isInRecall_ then
							iter_356_7.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10109 = nil
			end

			local var_356_16 = arg_353_1.actors_["1086"].transform
			local var_356_17 = 0

			if var_356_17 < arg_353_1.time_ and arg_353_1.time_ <= var_356_17 + arg_356_0 then
				arg_353_1.var_.moveOldPos1086 = var_356_16.localPosition
				var_356_16.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1086", 2)

				local var_356_18 = var_356_16.childCount

				for iter_356_8 = 0, var_356_18 - 1 do
					local var_356_19 = var_356_16:GetChild(iter_356_8)

					if var_356_19.name == "" or not string.find(var_356_19.name, "split") then
						var_356_19.gameObject:SetActive(true)
					else
						var_356_19.gameObject:SetActive(false)
					end
				end
			end

			local var_356_20 = 0.001

			if var_356_17 <= arg_353_1.time_ and arg_353_1.time_ < var_356_17 + var_356_20 then
				local var_356_21 = (arg_353_1.time_ - var_356_17) / var_356_20
				local var_356_22 = Vector3.New(-390, -404.2, -237.9)

				var_356_16.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1086, var_356_22, var_356_21)
			end

			if arg_353_1.time_ >= var_356_17 + var_356_20 and arg_353_1.time_ < var_356_17 + var_356_20 + arg_356_0 then
				var_356_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_356_23 = arg_353_1.actors_["10109"].transform
			local var_356_24 = 0

			if var_356_24 < arg_353_1.time_ and arg_353_1.time_ <= var_356_24 + arg_356_0 then
				arg_353_1.var_.moveOldPos10109 = var_356_23.localPosition
				var_356_23.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10109", 4)

				local var_356_25 = var_356_23.childCount

				for iter_356_9 = 0, var_356_25 - 1 do
					local var_356_26 = var_356_23:GetChild(iter_356_9)

					if var_356_26.name == "" or not string.find(var_356_26.name, "split") then
						var_356_26.gameObject:SetActive(true)
					else
						var_356_26.gameObject:SetActive(false)
					end
				end
			end

			local var_356_27 = 0.001

			if var_356_24 <= arg_353_1.time_ and arg_353_1.time_ < var_356_24 + var_356_27 then
				local var_356_28 = (arg_353_1.time_ - var_356_24) / var_356_27
				local var_356_29 = Vector3.New(390, -346.2, -395)

				var_356_23.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10109, var_356_29, var_356_28)
			end

			if arg_353_1.time_ >= var_356_24 + var_356_27 and arg_353_1.time_ < var_356_24 + var_356_27 + arg_356_0 then
				var_356_23.localPosition = Vector3.New(390, -346.2, -395)
			end

			local var_356_30 = 0
			local var_356_31 = 0.325

			if var_356_30 < arg_353_1.time_ and arg_353_1.time_ <= var_356_30 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_32 = arg_353_1:FormatText(StoryNameCfg[1080].name)

				arg_353_1.leftNameTxt_.text = var_356_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_33 = arg_353_1:GetWordFromCfg(416221087)
				local var_356_34 = arg_353_1:FormatText(var_356_33.content)

				arg_353_1.text_.text = var_356_34

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_35 = 13
				local var_356_36 = utf8.len(var_356_34)
				local var_356_37 = var_356_35 <= 0 and var_356_31 or var_356_31 * (var_356_36 / var_356_35)

				if var_356_37 > 0 and var_356_31 < var_356_37 then
					arg_353_1.talkMaxDuration = var_356_37

					if var_356_37 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_37 + var_356_30
					end
				end

				arg_353_1.text_.text = var_356_34
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221087", "story_v_out_416221.awb") ~= 0 then
					local var_356_38 = manager.audio:GetVoiceLength("story_v_out_416221", "416221087", "story_v_out_416221.awb") / 1000

					if var_356_38 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_38 + var_356_30
					end

					if var_356_33.prefab_name ~= "" and arg_353_1.actors_[var_356_33.prefab_name] ~= nil then
						local var_356_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_33.prefab_name].transform, "story_v_out_416221", "416221087", "story_v_out_416221.awb")

						arg_353_1:RecordAudio("416221087", var_356_39)
						arg_353_1:RecordAudio("416221087", var_356_39)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_416221", "416221087", "story_v_out_416221.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_416221", "416221087", "story_v_out_416221.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_40 = math.max(var_356_31, arg_353_1.talkMaxDuration)

			if var_356_30 <= arg_353_1.time_ and arg_353_1.time_ < var_356_30 + var_356_40 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_30) / var_356_40

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_30 + var_356_40 and arg_353_1.time_ < var_356_30 + var_356_40 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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
				actorName = "10109",
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
	Play416221088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 416221088
		arg_357_1.duration_ = 15.13

		local var_357_0 = {
			zh = 9.633,
			ja = 15.133
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play416221089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10109"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10109 == nil then
				arg_357_1.var_.actorSpriteComps10109 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps10109 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10109 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10109 = nil
			end

			local var_360_8 = arg_357_1.actors_["1086"]
			local var_360_9 = 0

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1086 == nil then
				arg_357_1.var_.actorSpriteComps1086 = var_360_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_10 = 0.2

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_10 and not isNil(var_360_8) then
				local var_360_11 = (arg_357_1.time_ - var_360_9) / var_360_10

				if arg_357_1.var_.actorSpriteComps1086 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								local var_360_12 = Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, var_360_11)
								local var_360_13 = Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, var_360_11)
								local var_360_14 = Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, var_360_11)

								iter_360_5.color = Color.New(var_360_12, var_360_13, var_360_14)
							else
								local var_360_15 = Mathf.Lerp(iter_360_5.color.r, 0.5, var_360_11)

								iter_360_5.color = Color.New(var_360_15, var_360_15, var_360_15)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_9 + var_360_10 and arg_357_1.time_ < var_360_9 + var_360_10 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1086 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_360_7 then
						if arg_357_1.isInRecall_ then
							iter_360_7.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1086 = nil
			end

			local var_360_16 = 0
			local var_360_17 = 0.7

			if var_360_16 < arg_357_1.time_ and arg_357_1.time_ <= var_360_16 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_18 = arg_357_1:FormatText(StoryNameCfg[1093].name)

				arg_357_1.leftNameTxt_.text = var_360_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_19 = arg_357_1:GetWordFromCfg(416221088)
				local var_360_20 = arg_357_1:FormatText(var_360_19.content)

				arg_357_1.text_.text = var_360_20

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_21 = 28
				local var_360_22 = utf8.len(var_360_20)
				local var_360_23 = var_360_21 <= 0 and var_360_17 or var_360_17 * (var_360_22 / var_360_21)

				if var_360_23 > 0 and var_360_17 < var_360_23 then
					arg_357_1.talkMaxDuration = var_360_23

					if var_360_23 + var_360_16 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_16
					end
				end

				arg_357_1.text_.text = var_360_20
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221088", "story_v_out_416221.awb") ~= 0 then
					local var_360_24 = manager.audio:GetVoiceLength("story_v_out_416221", "416221088", "story_v_out_416221.awb") / 1000

					if var_360_24 + var_360_16 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_24 + var_360_16
					end

					if var_360_19.prefab_name ~= "" and arg_357_1.actors_[var_360_19.prefab_name] ~= nil then
						local var_360_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_19.prefab_name].transform, "story_v_out_416221", "416221088", "story_v_out_416221.awb")

						arg_357_1:RecordAudio("416221088", var_360_25)
						arg_357_1:RecordAudio("416221088", var_360_25)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_416221", "416221088", "story_v_out_416221.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_416221", "416221088", "story_v_out_416221.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_26 = math.max(var_360_17, arg_357_1.talkMaxDuration)

			if var_360_16 <= arg_357_1.time_ and arg_357_1.time_ < var_360_16 + var_360_26 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_16) / var_360_26

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_16 + var_360_26 and arg_357_1.time_ < var_360_16 + var_360_26 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play416221089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 416221089
		arg_361_1.duration_ = 5.63

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play416221090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10109"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps10109 == nil then
				arg_361_1.var_.actorSpriteComps10109 = var_364_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_2 = 0.2

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.actorSpriteComps10109 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								local var_364_4 = Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor2.r, var_364_3)
								local var_364_5 = Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor2.g, var_364_3)
								local var_364_6 = Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor2.b, var_364_3)

								iter_364_1.color = Color.New(var_364_4, var_364_5, var_364_6)
							else
								local var_364_7 = Mathf.Lerp(iter_364_1.color.r, 0.5, var_364_3)

								iter_364_1.color = Color.New(var_364_7, var_364_7, var_364_7)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps10109 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_364_3 then
						if arg_361_1.isInRecall_ then
							iter_364_3.color = arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_364_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps10109 = nil
			end

			local var_364_8 = arg_361_1.actors_["1086"].transform
			local var_364_9 = 0

			if var_364_9 < arg_361_1.time_ and arg_361_1.time_ <= var_364_9 + arg_364_0 then
				arg_361_1.var_.moveOldPos1086 = var_364_8.localPosition
				var_364_8.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1086", 7)

				local var_364_10 = var_364_8.childCount

				for iter_364_4 = 0, var_364_10 - 1 do
					local var_364_11 = var_364_8:GetChild(iter_364_4)

					if var_364_11.name == "" or not string.find(var_364_11.name, "split") then
						var_364_11.gameObject:SetActive(true)
					else
						var_364_11.gameObject:SetActive(false)
					end
				end
			end

			local var_364_12 = 0.001

			if var_364_9 <= arg_361_1.time_ and arg_361_1.time_ < var_364_9 + var_364_12 then
				local var_364_13 = (arg_361_1.time_ - var_364_9) / var_364_12
				local var_364_14 = Vector3.New(0, -2000, 0)

				var_364_8.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1086, var_364_14, var_364_13)
			end

			if arg_361_1.time_ >= var_364_9 + var_364_12 and arg_361_1.time_ < var_364_9 + var_364_12 + arg_364_0 then
				var_364_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_15 = arg_361_1.actors_["10109"].transform
			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.var_.moveOldPos10109 = var_364_15.localPosition
				var_364_15.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10109", 7)

				local var_364_17 = var_364_15.childCount

				for iter_364_5 = 0, var_364_17 - 1 do
					local var_364_18 = var_364_15:GetChild(iter_364_5)

					if var_364_18.name == "" or not string.find(var_364_18.name, "split") then
						var_364_18.gameObject:SetActive(true)
					else
						var_364_18.gameObject:SetActive(false)
					end
				end
			end

			local var_364_19 = 0.001

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_19 then
				local var_364_20 = (arg_361_1.time_ - var_364_16) / var_364_19
				local var_364_21 = Vector3.New(0, -2000, 0)

				var_364_15.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10109, var_364_21, var_364_20)
			end

			if arg_361_1.time_ >= var_364_16 + var_364_19 and arg_361_1.time_ < var_364_16 + var_364_19 + arg_364_0 then
				var_364_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_22 = 0

			if var_364_22 < arg_361_1.time_ and arg_361_1.time_ <= var_364_22 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			local var_364_23 = 0.733333333333333

			if arg_361_1.time_ >= var_364_22 + var_364_23 and arg_361_1.time_ < var_364_22 + var_364_23 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_24 = manager.ui.mainCamera.transform
			local var_364_25 = 0

			if var_364_25 < arg_361_1.time_ and arg_361_1.time_ <= var_364_25 + arg_364_0 then
				local var_364_26 = arg_361_1.var_.effect998
				local var_364_27
				local var_364_28 = var_364_24

				if not var_364_26 then
					var_364_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_364_28)
					var_364_26.name = "998"
					arg_361_1.var_.effect998 = var_364_26
				else
					var_364_26.transform:SetParent(var_364_28)
				end

				var_364_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_364_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_364_29 = manager.ui.mainCamera.transform
			local var_364_30 = 1.25

			if var_364_30 < arg_361_1.time_ and arg_361_1.time_ <= var_364_30 + arg_364_0 then
				local var_364_31 = arg_361_1.var_.effect998

				if var_364_31 then
					Object.Destroy(var_364_31)

					arg_361_1.var_.effect998 = nil
				end
			end

			local var_364_32 = 0.05
			local var_364_33 = 1

			if var_364_32 < arg_361_1.time_ and arg_361_1.time_ <= var_364_32 + arg_364_0 then
				local var_364_34 = "play"
				local var_364_35 = "effect"

				arg_361_1:AudioAction(var_364_34, var_364_35, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_36 = 0.633333333333333
			local var_364_37 = 1.35

			if var_364_36 < arg_361_1.time_ and arg_361_1.time_ <= var_364_36 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_38 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_38:setOnUpdate(LuaHelper.FloatAction(function(arg_365_0)
					arg_361_1.dialogCg_.alpha = arg_365_0
				end))
				var_364_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_39 = arg_361_1:GetWordFromCfg(416221089)
				local var_364_40 = arg_361_1:FormatText(var_364_39.content)

				arg_361_1.text_.text = var_364_40

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_41 = 54
				local var_364_42 = utf8.len(var_364_40)
				local var_364_43 = var_364_41 <= 0 and var_364_37 or var_364_37 * (var_364_42 / var_364_41)

				if var_364_43 > 0 and var_364_37 < var_364_43 then
					arg_361_1.talkMaxDuration = var_364_43
					var_364_36 = var_364_36 + 0.3

					if var_364_43 + var_364_36 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_43 + var_364_36
					end
				end

				arg_361_1.text_.text = var_364_40
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_44 = var_364_36 + 0.3
			local var_364_45 = math.max(var_364_37, arg_361_1.talkMaxDuration)

			if var_364_44 <= arg_361_1.time_ and arg_361_1.time_ < var_364_44 + var_364_45 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_44) / var_364_45

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_44 + var_364_45 and arg_361_1.time_ < var_364_44 + var_364_45 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play416221090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 416221090
		arg_367_1.duration_ = 3.7

		local var_367_0 = {
			zh = 2.633,
			ja = 3.7
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
				arg_367_0:Play416221091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1028"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps1028 == nil then
				arg_367_1.var_.actorSpriteComps1028 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps1028 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps1028 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps1028 = nil
			end

			local var_370_8 = arg_367_1.actors_["1028"].transform
			local var_370_9 = 0

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 then
				arg_367_1.var_.moveOldPos1028 = var_370_8.localPosition
				var_370_8.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("1028", 2)

				local var_370_10 = var_370_8.childCount

				for iter_370_4 = 0, var_370_10 - 1 do
					local var_370_11 = var_370_8:GetChild(iter_370_4)

					if var_370_11.name == "split_2" or not string.find(var_370_11.name, "split") then
						var_370_11.gameObject:SetActive(true)
					else
						var_370_11.gameObject:SetActive(false)
					end
				end
			end

			local var_370_12 = 0.001

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_12 then
				local var_370_13 = (arg_367_1.time_ - var_370_9) / var_370_12
				local var_370_14 = Vector3.New(-390, -402.7, -156.1)

				var_370_8.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1028, var_370_14, var_370_13)
			end

			if arg_367_1.time_ >= var_370_9 + var_370_12 and arg_367_1.time_ < var_370_9 + var_370_12 + arg_370_0 then
				var_370_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_370_15 = 0
			local var_370_16 = 0.225

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[327].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(416221090)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 9
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221090", "story_v_out_416221.awb") ~= 0 then
					local var_370_23 = manager.audio:GetVoiceLength("story_v_out_416221", "416221090", "story_v_out_416221.awb") / 1000

					if var_370_23 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_15
					end

					if var_370_18.prefab_name ~= "" and arg_367_1.actors_[var_370_18.prefab_name] ~= nil then
						local var_370_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_18.prefab_name].transform, "story_v_out_416221", "416221090", "story_v_out_416221.awb")

						arg_367_1:RecordAudio("416221090", var_370_24)
						arg_367_1:RecordAudio("416221090", var_370_24)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_416221", "416221090", "story_v_out_416221.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_416221", "416221090", "story_v_out_416221.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_25 and arg_367_1.time_ < var_370_15 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play416221091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 416221091
		arg_371_1.duration_ = 3.8

		local var_371_0 = {
			zh = 2.933,
			ja = 3.8
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
				arg_371_0:Play416221092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1086"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1086 == nil then
				arg_371_1.var_.actorSpriteComps1086 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps1086 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor1.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor1.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor1.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 1, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1086 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps1086 = nil
			end

			local var_374_8 = arg_371_1.actors_["1028"]
			local var_374_9 = 0

			if var_374_9 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps1028 == nil then
				arg_371_1.var_.actorSpriteComps1028 = var_374_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_10 = 0.2

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_10 and not isNil(var_374_8) then
				local var_374_11 = (arg_371_1.time_ - var_374_9) / var_374_10

				if arg_371_1.var_.actorSpriteComps1028 then
					for iter_374_4, iter_374_5 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_374_5 then
							if arg_371_1.isInRecall_ then
								local var_374_12 = Mathf.Lerp(iter_374_5.color.r, arg_371_1.hightColor2.r, var_374_11)
								local var_374_13 = Mathf.Lerp(iter_374_5.color.g, arg_371_1.hightColor2.g, var_374_11)
								local var_374_14 = Mathf.Lerp(iter_374_5.color.b, arg_371_1.hightColor2.b, var_374_11)

								iter_374_5.color = Color.New(var_374_12, var_374_13, var_374_14)
							else
								local var_374_15 = Mathf.Lerp(iter_374_5.color.r, 0.5, var_374_11)

								iter_374_5.color = Color.New(var_374_15, var_374_15, var_374_15)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_9 + var_374_10 and arg_371_1.time_ < var_374_9 + var_374_10 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps1028 then
				for iter_374_6, iter_374_7 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_374_7 then
						if arg_371_1.isInRecall_ then
							iter_374_7.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps1028 = nil
			end

			local var_374_16 = arg_371_1.actors_["1086"].transform
			local var_374_17 = 0

			if var_374_17 < arg_371_1.time_ and arg_371_1.time_ <= var_374_17 + arg_374_0 then
				arg_371_1.var_.moveOldPos1086 = var_374_16.localPosition
				var_374_16.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("1086", 4)

				local var_374_18 = var_374_16.childCount

				for iter_374_8 = 0, var_374_18 - 1 do
					local var_374_19 = var_374_16:GetChild(iter_374_8)

					if var_374_19.name == "" or not string.find(var_374_19.name, "split") then
						var_374_19.gameObject:SetActive(true)
					else
						var_374_19.gameObject:SetActive(false)
					end
				end
			end

			local var_374_20 = 0.001

			if var_374_17 <= arg_371_1.time_ and arg_371_1.time_ < var_374_17 + var_374_20 then
				local var_374_21 = (arg_371_1.time_ - var_374_17) / var_374_20
				local var_374_22 = Vector3.New(390, -404.2, -237.9)

				var_374_16.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1086, var_374_22, var_374_21)
			end

			if arg_371_1.time_ >= var_374_17 + var_374_20 and arg_371_1.time_ < var_374_17 + var_374_20 + arg_374_0 then
				var_374_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_374_23 = 0
			local var_374_24 = 0.325

			if var_374_23 < arg_371_1.time_ and arg_371_1.time_ <= var_374_23 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_25 = arg_371_1:FormatText(StoryNameCfg[1080].name)

				arg_371_1.leftNameTxt_.text = var_374_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_26 = arg_371_1:GetWordFromCfg(416221091)
				local var_374_27 = arg_371_1:FormatText(var_374_26.content)

				arg_371_1.text_.text = var_374_27

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_28 = 13
				local var_374_29 = utf8.len(var_374_27)
				local var_374_30 = var_374_28 <= 0 and var_374_24 or var_374_24 * (var_374_29 / var_374_28)

				if var_374_30 > 0 and var_374_24 < var_374_30 then
					arg_371_1.talkMaxDuration = var_374_30

					if var_374_30 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_30 + var_374_23
					end
				end

				arg_371_1.text_.text = var_374_27
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416221", "416221091", "story_v_out_416221.awb") ~= 0 then
					local var_374_31 = manager.audio:GetVoiceLength("story_v_out_416221", "416221091", "story_v_out_416221.awb") / 1000

					if var_374_31 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_31 + var_374_23
					end

					if var_374_26.prefab_name ~= "" and arg_371_1.actors_[var_374_26.prefab_name] ~= nil then
						local var_374_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_26.prefab_name].transform, "story_v_out_416221", "416221091", "story_v_out_416221.awb")

						arg_371_1:RecordAudio("416221091", var_374_32)
						arg_371_1:RecordAudio("416221091", var_374_32)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_416221", "416221091", "story_v_out_416221.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_416221", "416221091", "story_v_out_416221.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_33 = math.max(var_374_24, arg_371_1.talkMaxDuration)

			if var_374_23 <= arg_371_1.time_ and arg_371_1.time_ < var_374_23 + var_374_33 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_23) / var_374_33

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_23 + var_374_33 and arg_371_1.time_ < var_374_23 + var_374_33 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play416221092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 416221092
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
			arg_375_1.auto_ = false
		end

		function arg_375_1.playNext_(arg_377_0)
			arg_375_1.onStoryFinished_()
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1086"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1086 == nil then
				arg_375_1.var_.actorSpriteComps1086 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps1086 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor2.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor2.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor2.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 0.5, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1086 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_378_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps1086 = nil
			end

			local var_378_8 = arg_375_1.actors_["1086"].transform
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.var_.moveOldPos1086 = var_378_8.localPosition
				var_378_8.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1086", 7)

				local var_378_10 = var_378_8.childCount

				for iter_378_4 = 0, var_378_10 - 1 do
					local var_378_11 = var_378_8:GetChild(iter_378_4)

					if var_378_11.name == "" or not string.find(var_378_11.name, "split") then
						var_378_11.gameObject:SetActive(true)
					else
						var_378_11.gameObject:SetActive(false)
					end
				end
			end

			local var_378_12 = 0.001

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_12 then
				local var_378_13 = (arg_375_1.time_ - var_378_9) / var_378_12
				local var_378_14 = Vector3.New(0, -2000, 0)

				var_378_8.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1086, var_378_14, var_378_13)
			end

			if arg_375_1.time_ >= var_378_9 + var_378_12 and arg_375_1.time_ < var_378_9 + var_378_12 + arg_378_0 then
				var_378_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_15 = arg_375_1.actors_["1028"].transform
			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 then
				arg_375_1.var_.moveOldPos1028 = var_378_15.localPosition
				var_378_15.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1028", 7)

				local var_378_17 = var_378_15.childCount

				for iter_378_5 = 0, var_378_17 - 1 do
					local var_378_18 = var_378_15:GetChild(iter_378_5)

					if var_378_18.name == "" or not string.find(var_378_18.name, "split") then
						var_378_18.gameObject:SetActive(true)
					else
						var_378_18.gameObject:SetActive(false)
					end
				end
			end

			local var_378_19 = 0.001

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_19 then
				local var_378_20 = (arg_375_1.time_ - var_378_16) / var_378_19
				local var_378_21 = Vector3.New(0, -2000, 0)

				var_378_15.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1028, var_378_21, var_378_20)
			end

			if arg_375_1.time_ >= var_378_16 + var_378_19 and arg_375_1.time_ < var_378_16 + var_378_19 + arg_378_0 then
				var_378_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_22 = 0
			local var_378_23 = 1.3

			if var_378_22 < arg_375_1.time_ and arg_375_1.time_ <= var_378_22 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_24 = arg_375_1:GetWordFromCfg(416221092)
				local var_378_25 = arg_375_1:FormatText(var_378_24.content)

				arg_375_1.text_.text = var_378_25

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_26 = 52
				local var_378_27 = utf8.len(var_378_25)
				local var_378_28 = var_378_26 <= 0 and var_378_23 or var_378_23 * (var_378_27 / var_378_26)

				if var_378_28 > 0 and var_378_23 < var_378_28 then
					arg_375_1.talkMaxDuration = var_378_28

					if var_378_28 + var_378_22 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_28 + var_378_22
					end
				end

				arg_375_1.text_.text = var_378_25
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_29 = math.max(var_378_23, arg_375_1.talkMaxDuration)

			if var_378_22 <= arg_375_1.time_ and arg_375_1.time_ < var_378_22 + var_378_29 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_22) / var_378_29

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_22 + var_378_29 and arg_375_1.time_ < var_378_22 + var_378_29 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F09f"
	},
	voices = {
		"story_v_out_416221.awb"
	}
}
