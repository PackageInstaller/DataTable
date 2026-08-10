return {
	Play416232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416232001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416232002(arg_1_1)
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

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.466666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.8
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 1.8
			local var_4_41 = 1.4

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(416232001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 56
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416232002
		arg_9_1.duration_ = 4.6

		local var_9_0 = {
			zh = 3.266,
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
				arg_9_0:Play416232003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10127"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

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

			local var_12_4 = arg_9_1.actors_["10127"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10127 == nil then
				arg_9_1.var_.actorSpriteComps10127 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps10127 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10127 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10127 = nil
			end

			local var_12_12 = arg_9_1.actors_["10127"].transform
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.var_.moveOldPos10127 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10127", 2)

				local var_12_14 = var_12_12.childCount

				for iter_12_6 = 0, var_12_14 - 1 do
					local var_12_15 = var_12_12:GetChild(iter_12_6)

					if var_12_15.name == "" or not string.find(var_12_15.name, "split") then
						var_12_15.gameObject:SetActive(true)
					else
						var_12_15.gameObject:SetActive(false)
					end
				end
			end

			local var_12_16 = 0.001

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_13) / var_12_16
				local var_12_18 = Vector3.New(-390, -387.4, -316.5)

				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10127, var_12_18, var_12_17)
			end

			if arg_9_1.time_ >= var_12_13 + var_12_16 and arg_9_1.time_ < var_12_13 + var_12_16 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_12_19 = 0
			local var_12_20 = 0.475

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[236].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(416232002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 19
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232002", "story_v_out_416232.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_416232", "416232002", "story_v_out_416232.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_416232", "416232002", "story_v_out_416232.awb")

						arg_9_1:RecordAudio("416232002", var_12_28)
						arg_9_1:RecordAudio("416232002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416232", "416232002", "story_v_out_416232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416232", "416232002", "story_v_out_416232.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_29 and arg_9_1.time_ < var_12_19 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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
	Play416232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416232003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 2.9,
			ja = 3.433
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
				arg_13_0:Play416232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10122"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

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

			local var_16_4 = arg_13_1.actors_["10122"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10122 == nil then
				arg_13_1.var_.actorSpriteComps10122 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps10122 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10122 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10122 = nil
			end

			local var_16_12 = arg_13_1.actors_["10127"]
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps10127 == nil then
				arg_13_1.var_.actorSpriteComps10127 = var_16_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_14 = 0.2

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_14 and not isNil(var_16_12) then
				local var_16_15 = (arg_13_1.time_ - var_16_13) / var_16_14

				if arg_13_1.var_.actorSpriteComps10127 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								local var_16_16 = Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor2.r, var_16_15)
								local var_16_17 = Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor2.g, var_16_15)
								local var_16_18 = Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor2.b, var_16_15)

								iter_16_7.color = Color.New(var_16_16, var_16_17, var_16_18)
							else
								local var_16_19 = Mathf.Lerp(iter_16_7.color.r, 0.5, var_16_15)

								iter_16_7.color = Color.New(var_16_19, var_16_19, var_16_19)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_13 + var_16_14 and arg_13_1.time_ < var_16_13 + var_16_14 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps10127 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_16_9 then
						if arg_13_1.isInRecall_ then
							iter_16_9.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10127 = nil
			end

			local var_16_20 = arg_13_1.actors_["10122"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos10122 = var_16_20.localPosition
				var_16_20.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10122", 4)

				local var_16_22 = var_16_20.childCount

				for iter_16_10 = 0, var_16_22 - 1 do
					local var_16_23 = var_16_20:GetChild(iter_16_10)

					if var_16_23.name == "" or not string.find(var_16_23.name, "split") then
						var_16_23.gameObject:SetActive(true)
					else
						var_16_23.gameObject:SetActive(false)
					end
				end
			end

			local var_16_24 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_24 then
				local var_16_25 = (arg_13_1.time_ - var_16_21) / var_16_24
				local var_16_26 = Vector3.New(390, -380, -100)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10122, var_16_26, var_16_25)
			end

			if arg_13_1.time_ >= var_16_21 + var_16_24 and arg_13_1.time_ < var_16_21 + var_16_24 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(390, -380, -100)
			end

			local var_16_27 = 0
			local var_16_28 = 0.35

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_29 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_30 = arg_13_1:GetWordFromCfg(416232003)
				local var_16_31 = arg_13_1:FormatText(var_16_30.content)

				arg_13_1.text_.text = var_16_31

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_32 = 14
				local var_16_33 = utf8.len(var_16_31)
				local var_16_34 = var_16_32 <= 0 and var_16_28 or var_16_28 * (var_16_33 / var_16_32)

				if var_16_34 > 0 and var_16_28 < var_16_34 then
					arg_13_1.talkMaxDuration = var_16_34

					if var_16_34 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_27
					end
				end

				arg_13_1.text_.text = var_16_31
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232003", "story_v_out_416232.awb") ~= 0 then
					local var_16_35 = manager.audio:GetVoiceLength("story_v_out_416232", "416232003", "story_v_out_416232.awb") / 1000

					if var_16_35 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_35 + var_16_27
					end

					if var_16_30.prefab_name ~= "" and arg_13_1.actors_[var_16_30.prefab_name] ~= nil then
						local var_16_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_30.prefab_name].transform, "story_v_out_416232", "416232003", "story_v_out_416232.awb")

						arg_13_1:RecordAudio("416232003", var_16_36)
						arg_13_1:RecordAudio("416232003", var_16_36)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416232", "416232003", "story_v_out_416232.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416232", "416232003", "story_v_out_416232.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_37 = math.max(var_16_28, arg_13_1.talkMaxDuration)

			if var_16_27 <= arg_13_1.time_ and arg_13_1.time_ < var_16_27 + var_16_37 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_27) / var_16_37

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_27 + var_16_37 and arg_13_1.time_ < var_16_27 + var_16_37 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play416232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416232004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10122"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10122 == nil then
				arg_17_1.var_.actorSpriteComps10122 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10122 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10122 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10122 = nil
			end

			local var_20_8 = arg_17_1.actors_["10122"].transform
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.var_.moveOldPos10122 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10122", 7)

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

				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10122, var_20_14, var_20_13)
			end

			if arg_17_1.time_ >= var_20_9 + var_20_12 and arg_17_1.time_ < var_20_9 + var_20_12 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_15 = arg_17_1.actors_["10127"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos10127 = var_20_15.localPosition
				var_20_15.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10127", 7)

				local var_20_17 = var_20_15.childCount

				for iter_20_5 = 0, var_20_17 - 1 do
					local var_20_18 = var_20_15:GetChild(iter_20_5)

					if var_20_18.name == "" or not string.find(var_20_18.name, "split") then
						var_20_18.gameObject:SetActive(true)
					else
						var_20_18.gameObject:SetActive(false)
					end
				end
			end

			local var_20_19 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_16) / var_20_19
				local var_20_21 = Vector3.New(0, -2000, 0)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10127, var_20_21, var_20_20)
			end

			if arg_17_1.time_ >= var_20_16 + var_20_19 and arg_17_1.time_ < var_20_16 + var_20_19 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_22 = 0
			local var_20_23 = 1.525

			if var_20_22 < arg_17_1.time_ and arg_17_1.time_ <= var_20_22 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(416232004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 61
				local var_20_27 = utf8.len(var_20_25)
				local var_20_28 = var_20_26 <= 0 and var_20_23 or var_20_23 * (var_20_27 / var_20_26)

				if var_20_28 > 0 and var_20_23 < var_20_28 then
					arg_17_1.talkMaxDuration = var_20_28

					if var_20_28 + var_20_22 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_22
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_29 = math.max(var_20_23, arg_17_1.talkMaxDuration)

			if var_20_22 <= arg_17_1.time_ and arg_17_1.time_ < var_20_22 + var_20_29 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_22) / var_20_29

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_22 + var_20_29 and arg_17_1.time_ < var_20_22 + var_20_29 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play416232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416232005
		arg_21_1.duration_ = 5.4

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = manager.ui.mainCamera.transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_0.localPosition
			end

			local var_24_2 = 0.4

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / 0.066
				local var_24_4, var_24_5 = math.modf(var_24_3)

				var_24_0.localPosition = Vector3.New(var_24_5 * 0.13, var_24_5 * 0.13, var_24_5 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			local var_24_7 = 0.7

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_8 = 0
			local var_24_9 = 1

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				local var_24_10 = "play"
				local var_24_11 = "effect"

				arg_21_1:AudioAction(var_24_10, var_24_11, "se_story_15", "se_story_15_gun02", "")
			end

			local var_24_12 = 1.9
			local var_24_13 = 1

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				local var_24_14 = "play"
				local var_24_15 = "effect"

				arg_21_1:AudioAction(var_24_14, var_24_15, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_16 = 0.4
			local var_24_17 = 1.15

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_18 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_18:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(416232005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 46
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23
					var_24_16 = var_24_16 + 0.3

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_24 = var_24_16 + 0.3
			local var_24_25 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_24) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416232006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 416232006
		arg_27_1.duration_ = 12.7

		local var_27_0 = {
			zh = 12.7,
			ja = 10.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play416232007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.625

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[1093].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(416232006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 25
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232006", "story_v_out_416232.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232006", "story_v_out_416232.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_416232", "416232006", "story_v_out_416232.awb")

						arg_27_1:RecordAudio("416232006", var_30_9)
						arg_27_1:RecordAudio("416232006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_416232", "416232006", "story_v_out_416232.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_416232", "416232006", "story_v_out_416232.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play416232007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416232007
		arg_31_1.duration_ = 2.73

		local var_31_0 = {
			zh = 2.733,
			ja = 2.133
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play416232008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.325

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[8].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:GetWordFromCfg(416232007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 13
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232007", "story_v_out_416232.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232007", "story_v_out_416232.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_416232", "416232007", "story_v_out_416232.awb")

						arg_31_1:RecordAudio("416232007", var_34_9)
						arg_31_1:RecordAudio("416232007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416232", "416232007", "story_v_out_416232.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416232", "416232007", "story_v_out_416232.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play416232008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416232008
		arg_35_1.duration_ = 5.83

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416232009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "10109"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(var_38_1, arg_35_1.canvasGo_.transform)

					var_38_2.transform:SetSiblingIndex(1)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_35_1.isInRecall_ then
						for iter_38_0, iter_38_1 in ipairs(var_38_3) do
							iter_38_1.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_38_4 = arg_35_1.actors_["10109"].transform
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.var_.moveOldPos10109 = var_38_4.localPosition
				var_38_4.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10109", 7)

				local var_38_6 = var_38_4.childCount

				for iter_38_2 = 0, var_38_6 - 1 do
					local var_38_7 = var_38_4:GetChild(iter_38_2)

					if var_38_7.name == "" or not string.find(var_38_7.name, "split") then
						var_38_7.gameObject:SetActive(true)
					else
						var_38_7.gameObject:SetActive(false)
					end
				end
			end

			local var_38_8 = 0.001

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_8 then
				local var_38_9 = (arg_35_1.time_ - var_38_5) / var_38_8
				local var_38_10 = Vector3.New(0, -2000, 0)

				var_38_4.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10109, var_38_10, var_38_9)
			end

			if arg_35_1.time_ >= var_38_5 + var_38_8 and arg_35_1.time_ < var_38_5 + var_38_8 + arg_38_0 then
				var_38_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_38_11 = 0

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_12 = 0.366666666666667

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_12 then
				local var_38_13 = (arg_35_1.time_ - var_38_11) / var_38_12
				local var_38_14 = Color.New(1, 1, 1)

				var_38_14.a = Mathf.Lerp(0, 1, var_38_13)
				arg_35_1.mask_.color = var_38_14
			end

			if arg_35_1.time_ >= var_38_11 + var_38_12 and arg_35_1.time_ < var_38_11 + var_38_12 + arg_38_0 then
				local var_38_15 = Color.New(1, 1, 1)

				var_38_15.a = 1
				arg_35_1.mask_.color = var_38_15
			end

			local var_38_16 = 0.2

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_17 = 0.466666666666667

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_17 then
				local var_38_18 = (arg_35_1.time_ - var_38_16) / var_38_17
				local var_38_19 = Color.New(1, 1, 1)

				var_38_19.a = Mathf.Lerp(1, 0, var_38_18)
				arg_35_1.mask_.color = var_38_19
			end

			if arg_35_1.time_ >= var_38_16 + var_38_17 and arg_35_1.time_ < var_38_16 + var_38_17 + arg_38_0 then
				local var_38_20 = Color.New(1, 1, 1)
				local var_38_21 = 0

				arg_35_1.mask_.enabled = false
				var_38_20.a = var_38_21
				arg_35_1.mask_.color = var_38_20
			end

			local var_38_22 = 0.933333333333333
			local var_38_23 = 1

			if var_38_22 < arg_35_1.time_ and arg_35_1.time_ <= var_38_22 + arg_38_0 then
				local var_38_24 = "play"
				local var_38_25 = "effect"

				arg_35_1:AudioAction(var_38_24, var_38_25, "se_story_9", "se_story_9_shoot", "")
			end

			local var_38_26 = 1.556
			local var_38_27 = 1

			if var_38_26 < arg_35_1.time_ and arg_35_1.time_ <= var_38_26 + arg_38_0 then
				local var_38_28 = "play"
				local var_38_29 = "effect"

				arg_35_1:AudioAction(var_38_28, var_38_29, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_38_30 = 0.8
			local var_38_31 = 1

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				local var_38_32 = "play"
				local var_38_33 = "effect"

				arg_35_1:AudioAction(var_38_32, var_38_33, "se_story_122_03", "se_story_122_03_laser", "")
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_34 = 0.833333333333333
			local var_38_35 = 1.275

			if var_38_34 < arg_35_1.time_ and arg_35_1.time_ <= var_38_34 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_36 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_36:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_37 = arg_35_1:GetWordFromCfg(416232008)
				local var_38_38 = arg_35_1:FormatText(var_38_37.content)

				arg_35_1.text_.text = var_38_38

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_39 = 51
				local var_38_40 = utf8.len(var_38_38)
				local var_38_41 = var_38_39 <= 0 and var_38_35 or var_38_35 * (var_38_40 / var_38_39)

				if var_38_41 > 0 and var_38_35 < var_38_41 then
					arg_35_1.talkMaxDuration = var_38_41
					var_38_34 = var_38_34 + 0.3

					if var_38_41 + var_38_34 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_41 + var_38_34
					end
				end

				arg_35_1.text_.text = var_38_38
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_42 = var_38_34 + 0.3
			local var_38_43 = math.max(var_38_35, arg_35_1.talkMaxDuration)

			if var_38_42 <= arg_35_1.time_ and arg_35_1.time_ < var_38_42 + var_38_43 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_42) / var_38_43

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_42 + var_38_43 and arg_35_1.time_ < var_38_42 + var_38_43 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play416232009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416232009
		arg_41_1.duration_ = 5.47

		local var_41_0 = {
			zh = 5.466,
			ja = 4.366
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
				arg_41_0:Play416232010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.525

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1093].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(416232009)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232009", "story_v_out_416232.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232009", "story_v_out_416232.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_416232", "416232009", "story_v_out_416232.awb")

						arg_41_1:RecordAudio("416232009", var_44_9)
						arg_41_1:RecordAudio("416232009", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416232", "416232009", "story_v_out_416232.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416232", "416232009", "story_v_out_416232.awb")
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
	Play416232010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416232010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416232011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.925

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(416232010)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 37
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416232011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416232011
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			zh = 3.233,
			ja = 5.9
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
				arg_49_0:Play416232012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.375

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[236].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(416232011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232011", "story_v_out_416232.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232011", "story_v_out_416232.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_416232", "416232011", "story_v_out_416232.awb")

						arg_49_1:RecordAudio("416232011", var_52_9)
						arg_49_1:RecordAudio("416232011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416232", "416232011", "story_v_out_416232.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416232", "416232011", "story_v_out_416232.awb")
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
	Play416232012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416232012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play416232013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.325

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(416232012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 53
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416232013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416232013
		arg_57_1.duration_ = 5.63

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play416232014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = manager.ui.mainCamera.transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				local var_60_2 = arg_57_1.var_.effect144
				local var_60_3
				local var_60_4 = var_60_0

				if not var_60_2 then
					var_60_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_60_4)
					var_60_2.name = "144"
					arg_57_1.var_.effect144 = var_60_2
				else
					var_60_2.transform:SetParent(var_60_4)
				end

				var_60_2.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_60_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_60_5 = manager.ui.mainCameraCom_
				local var_60_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_60_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_60_7 = var_60_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_60_8 = 15
				local var_60_9 = 2 * var_60_8 * Mathf.Tan(var_60_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_60_5.aspect
				local var_60_10 = 1
				local var_60_11 = 1.7777777777777777

				if var_60_11 < var_60_5.aspect then
					var_60_10 = var_60_9 / (2 * var_60_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_60_11)
				end

				for iter_60_0, iter_60_1 in ipairs(var_60_7) do
					local var_60_12 = iter_60_1.transform.localScale

					iter_60_1.transform.localScale = Vector3.New(var_60_12.x / var_60_6 * var_60_10, var_60_12.y / var_60_6, var_60_12.z)
				end
			end

			local var_60_13 = manager.ui.mainCamera.transform
			local var_60_14 = 0.833333333333333

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				local var_60_15 = arg_57_1.var_.effect144

				if var_60_15 then
					Object.Destroy(var_60_15)

					arg_57_1.var_.effect144 = nil
				end
			end

			local var_60_16 = manager.ui.mainCamera.transform
			local var_60_17 = 0.166666666666667

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				local var_60_18 = arg_57_1.var_.effect778
				local var_60_19
				local var_60_20 = var_60_16

				if not var_60_18 then
					var_60_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_60_20)
					var_60_18.name = "778"
					arg_57_1.var_.effect778 = var_60_18
				else
					var_60_18.transform:SetParent(var_60_20)
				end

				var_60_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_60_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_60_21 = manager.ui.mainCameraCom_
				local var_60_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_60_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_60_23 = var_60_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_60_24 = 15
				local var_60_25 = 2 * var_60_24 * Mathf.Tan(var_60_21.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_60_21.aspect
				local var_60_26 = 1
				local var_60_27 = 1.7777777777777777

				if var_60_27 < var_60_21.aspect then
					var_60_26 = var_60_25 / (2 * var_60_24 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_60_27)
				end

				for iter_60_2, iter_60_3 in ipairs(var_60_23) do
					local var_60_28 = iter_60_3.transform.localScale

					iter_60_3.transform.localScale = Vector3.New(var_60_28.x / var_60_22 * var_60_26, var_60_28.y / var_60_22, var_60_28.z)
				end
			end

			local var_60_29 = manager.ui.mainCamera.transform
			local var_60_30 = 0.5

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				local var_60_31 = arg_57_1.var_.effect778

				if var_60_31 then
					Object.Destroy(var_60_31)

					arg_57_1.var_.effect778 = nil
				end
			end

			local var_60_32 = 0

			if var_60_32 < arg_57_1.time_ and arg_57_1.time_ <= var_60_32 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_33 = 1.16666666666667

			if arg_57_1.time_ >= var_60_32 + var_60_33 and arg_57_1.time_ < var_60_32 + var_60_33 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_34 = 0
			local var_60_35 = 1

			if var_60_34 < arg_57_1.time_ and arg_57_1.time_ <= var_60_34 + arg_60_0 then
				local var_60_36 = "play"
				local var_60_37 = "effect"

				arg_57_1:AudioAction(var_60_36, var_60_37, "se_story_127", "se_story_127_dart", "")
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_38 = 0.633333333332
			local var_60_39 = 1.05

			if var_60_38 < arg_57_1.time_ and arg_57_1.time_ <= var_60_38 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_40 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_40:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_41 = arg_57_1:GetWordFromCfg(416232013)
				local var_60_42 = arg_57_1:FormatText(var_60_41.content)

				arg_57_1.text_.text = var_60_42

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_43 = 42
				local var_60_44 = utf8.len(var_60_42)
				local var_60_45 = var_60_43 <= 0 and var_60_39 or var_60_39 * (var_60_44 / var_60_43)

				if var_60_45 > 0 and var_60_39 < var_60_45 then
					arg_57_1.talkMaxDuration = var_60_45
					var_60_38 = var_60_38 + 0.3

					if var_60_45 + var_60_38 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_45 + var_60_38
					end
				end

				arg_57_1.text_.text = var_60_42
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_46 = var_60_38 + 0.3
			local var_60_47 = math.max(var_60_39, arg_57_1.talkMaxDuration)

			if var_60_46 <= arg_57_1.time_ and arg_57_1.time_ < var_60_46 + var_60_47 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_46) / var_60_47

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_46 + var_60_47 and arg_57_1.time_ < var_60_46 + var_60_47 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416232014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416232014
		arg_63_1.duration_ = 9.73

		local var_63_0 = {
			zh = 9.5,
			ja = 9.733
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
				arg_63_0:Play416232015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.75

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[236].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(416232014)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232014", "story_v_out_416232.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232014", "story_v_out_416232.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_416232", "416232014", "story_v_out_416232.awb")

						arg_63_1:RecordAudio("416232014", var_66_9)
						arg_63_1:RecordAudio("416232014", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416232", "416232014", "story_v_out_416232.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416232", "416232014", "story_v_out_416232.awb")
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
	Play416232015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416232015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416232016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.825

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(416232015)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 33
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416232016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416232016
		arg_71_1.duration_ = 7.6

		local var_71_0 = {
			zh = 5.9,
			ja = 7.6
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
				arg_71_0:Play416232017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0
			local var_74_1 = 0.625

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				local var_74_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_2 then
					var_74_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_2.radialBlurScale = 0
					var_74_2.radialBlurGradient = 1
					var_74_2.radialBlurIntensity = 1

					if var_74_0 then
						var_74_2.radialBlurTarget = var_74_0.transform
					end
				end
			end

			local var_74_3 = 1.04166666666667

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_3 then
				local var_74_4 = (arg_71_1.time_ - var_74_1) / var_74_3
				local var_74_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_5 then
					var_74_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_5.radialBlurScale = Mathf.Lerp(0, 0, var_74_4)
					var_74_5.radialBlurGradient = Mathf.Lerp(1, 1, var_74_4)
					var_74_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_74_4)
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_3 and arg_71_1.time_ < var_74_1 + var_74_3 + arg_74_0 then
				local var_74_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_6 then
					var_74_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_6.radialBlurScale = 0
					var_74_6.radialBlurGradient = 1
					var_74_6.radialBlurIntensity = 1
				end
			end

			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_8 = 1.66666666666667

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_9 = 0
			local var_74_10 = 1

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				local var_74_11 = "play"
				local var_74_12 = "effect"

				arg_71_1:AudioAction(var_74_11, var_74_12, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_74_13 = 0
			local var_74_14 = 0.625

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_15 = arg_71_1:FormatText(StoryNameCfg[236].name)

				arg_71_1.leftNameTxt_.text = var_74_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_16 = arg_71_1:GetWordFromCfg(416232016)
				local var_74_17 = arg_71_1:FormatText(var_74_16.content)

				arg_71_1.text_.text = var_74_17

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_18 = 25
				local var_74_19 = utf8.len(var_74_17)
				local var_74_20 = var_74_18 <= 0 and var_74_14 or var_74_14 * (var_74_19 / var_74_18)

				if var_74_20 > 0 and var_74_14 < var_74_20 then
					arg_71_1.talkMaxDuration = var_74_20

					if var_74_20 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_13
					end
				end

				arg_71_1.text_.text = var_74_17
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232016", "story_v_out_416232.awb") ~= 0 then
					local var_74_21 = manager.audio:GetVoiceLength("story_v_out_416232", "416232016", "story_v_out_416232.awb") / 1000

					if var_74_21 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_13
					end

					if var_74_16.prefab_name ~= "" and arg_71_1.actors_[var_74_16.prefab_name] ~= nil then
						local var_74_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_16.prefab_name].transform, "story_v_out_416232", "416232016", "story_v_out_416232.awb")

						arg_71_1:RecordAudio("416232016", var_74_22)
						arg_71_1:RecordAudio("416232016", var_74_22)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416232", "416232016", "story_v_out_416232.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416232", "416232016", "story_v_out_416232.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_23 = math.max(var_74_14, arg_71_1.talkMaxDuration)

			if var_74_13 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_23 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_13) / var_74_23

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_13 + var_74_23 and arg_71_1.time_ < var_74_13 + var_74_23 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play416232017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416232017
		arg_75_1.duration_ = 12.07

		local var_75_0 = {
			zh = 6.866,
			ja = 12.066
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
				arg_75_0:Play416232018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "STblack"

			if arg_75_1.bgs_[var_78_0] == nil then
				local var_78_1 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_78_0)
				var_78_1.name = var_78_0
				var_78_1.transform.parent = arg_75_1.stage_.transform
				var_78_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_[var_78_0] = var_78_1
			end

			local var_78_2 = 1.2

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				local var_78_3 = manager.ui.mainCamera.transform.localPosition
				local var_78_4 = Vector3.New(0, 0, 10) + Vector3.New(var_78_3.x, var_78_3.y, 0)
				local var_78_5 = arg_75_1.bgs_.STblack

				var_78_5.transform.localPosition = var_78_4
				var_78_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_6 = var_78_5:GetComponent("SpriteRenderer")

				if var_78_6 and var_78_6.sprite then
					local var_78_7 = (var_78_5.transform.localPosition - var_78_3).z
					local var_78_8 = manager.ui.mainCameraCom_
					local var_78_9 = 2 * var_78_7 * Mathf.Tan(var_78_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_10 = var_78_9 * var_78_8.aspect
					local var_78_11 = var_78_6.sprite.bounds.size.x
					local var_78_12 = var_78_6.sprite.bounds.size.y
					local var_78_13 = var_78_10 / var_78_11
					local var_78_14 = var_78_9 / var_78_12
					local var_78_15 = var_78_14 < var_78_13 and var_78_13 or var_78_14

					var_78_5.transform.localScale = Vector3.New(var_78_15, var_78_15, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "STblack" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_16 = 1.2

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_17 = 0.3

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_18 = 0

			if var_78_18 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_19 = 1.2

			if var_78_18 <= arg_75_1.time_ and arg_75_1.time_ < var_78_18 + var_78_19 then
				local var_78_20 = (arg_75_1.time_ - var_78_18) / var_78_19
				local var_78_21 = Color.New(0, 0, 0)

				var_78_21.a = Mathf.Lerp(0, 1, var_78_20)
				arg_75_1.mask_.color = var_78_21
			end

			if arg_75_1.time_ >= var_78_18 + var_78_19 and arg_75_1.time_ < var_78_18 + var_78_19 + arg_78_0 then
				local var_78_22 = Color.New(0, 0, 0)

				var_78_22.a = 1
				arg_75_1.mask_.color = var_78_22
			end

			local var_78_23 = 1.2

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_24 = 1.36666666666667

			if var_78_23 <= arg_75_1.time_ and arg_75_1.time_ < var_78_23 + var_78_24 then
				local var_78_25 = (arg_75_1.time_ - var_78_23) / var_78_24
				local var_78_26 = Color.New(0, 0, 0)

				var_78_26.a = Mathf.Lerp(1, 0, var_78_25)
				arg_75_1.mask_.color = var_78_26
			end

			if arg_75_1.time_ >= var_78_23 + var_78_24 and arg_75_1.time_ < var_78_23 + var_78_24 + arg_78_0 then
				local var_78_27 = Color.New(0, 0, 0)
				local var_78_28 = 0

				arg_75_1.mask_.enabled = false
				var_78_27.a = var_78_28
				arg_75_1.mask_.color = var_78_27
			end

			local var_78_29
			local var_78_30 = 1.2

			if var_78_30 < arg_75_1.time_ and arg_75_1.time_ <= var_78_30 + arg_78_0 then
				local var_78_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_31 then
					var_78_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_31.radialBlurScale = 0
					var_78_31.radialBlurGradient = 1
					var_78_31.radialBlurIntensity = 1

					if var_78_29 then
						var_78_31.radialBlurTarget = var_78_29.transform
					end
				end
			end

			local var_78_32 = 1.04166666666667

			if var_78_30 <= arg_75_1.time_ and arg_75_1.time_ < var_78_30 + var_78_32 then
				local var_78_33 = (arg_75_1.time_ - var_78_30) / var_78_32
				local var_78_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_34 then
					var_78_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_34.radialBlurScale = Mathf.Lerp(0, 0, var_78_33)
					var_78_34.radialBlurGradient = Mathf.Lerp(1, 1, var_78_33)
					var_78_34.radialBlurIntensity = Mathf.Lerp(1, 1, var_78_33)
				end
			end

			if arg_75_1.time_ >= var_78_30 + var_78_32 and arg_75_1.time_ < var_78_30 + var_78_32 + arg_78_0 then
				local var_78_35 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_35 then
					var_78_35.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_35.radialBlurScale = 0
					var_78_35.radialBlurGradient = 1
					var_78_35.radialBlurIntensity = 1
				end
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_36 = 2.1
			local var_78_37 = 0.3

			if var_78_36 < arg_75_1.time_ and arg_75_1.time_ <= var_78_36 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_38 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_38:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_39 = arg_75_1:FormatText(StoryNameCfg[1093].name)

				arg_75_1.leftNameTxt_.text = var_78_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_40 = arg_75_1:GetWordFromCfg(416232017)
				local var_78_41 = arg_75_1:FormatText(var_78_40.content)

				arg_75_1.text_.text = var_78_41

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_42 = 12
				local var_78_43 = utf8.len(var_78_41)
				local var_78_44 = var_78_42 <= 0 and var_78_37 or var_78_37 * (var_78_43 / var_78_42)

				if var_78_44 > 0 and var_78_37 < var_78_44 then
					arg_75_1.talkMaxDuration = var_78_44
					var_78_36 = var_78_36 + 0.3

					if var_78_44 + var_78_36 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_44 + var_78_36
					end
				end

				arg_75_1.text_.text = var_78_41
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232017", "story_v_out_416232.awb") ~= 0 then
					local var_78_45 = manager.audio:GetVoiceLength("story_v_out_416232", "416232017", "story_v_out_416232.awb") / 1000

					if var_78_45 + var_78_36 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_45 + var_78_36
					end

					if var_78_40.prefab_name ~= "" and arg_75_1.actors_[var_78_40.prefab_name] ~= nil then
						local var_78_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_40.prefab_name].transform, "story_v_out_416232", "416232017", "story_v_out_416232.awb")

						arg_75_1:RecordAudio("416232017", var_78_46)
						arg_75_1:RecordAudio("416232017", var_78_46)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416232", "416232017", "story_v_out_416232.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416232", "416232017", "story_v_out_416232.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_47 = var_78_36 + 0.3
			local var_78_48 = math.max(var_78_37, arg_75_1.talkMaxDuration)

			if var_78_47 <= arg_75_1.time_ and arg_75_1.time_ < var_78_47 + var_78_48 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_47) / var_78_48

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_47 + var_78_48 and arg_75_1.time_ < var_78_47 + var_78_48 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416232018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416232018
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play416232019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.775

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(416232018)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 71
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play416232019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416232019
		arg_85_1.duration_ = 6.7

		local var_85_0 = {
			zh = 6.7,
			ja = 6.633
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
				arg_85_0:Play416232020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "stop"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_88_4 = 0
			local var_88_5 = 0.6

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_6 = arg_85_1:FormatText(StoryNameCfg[1093].name)

				arg_85_1.leftNameTxt_.text = var_88_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_7 = arg_85_1:GetWordFromCfg(416232019)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 24
				local var_88_10 = utf8.len(var_88_8)
				local var_88_11 = var_88_9 <= 0 and var_88_5 or var_88_5 * (var_88_10 / var_88_9)

				if var_88_11 > 0 and var_88_5 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232019", "story_v_out_416232.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_416232", "416232019", "story_v_out_416232.awb") / 1000

					if var_88_12 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_4
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416232", "416232019", "story_v_out_416232.awb")

						arg_85_1:RecordAudio("416232019", var_88_13)
						arg_85_1:RecordAudio("416232019", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416232", "416232019", "story_v_out_416232.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416232", "416232019", "story_v_out_416232.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_14 and arg_85_1.time_ < var_88_4 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play416232020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416232020
		arg_89_1.duration_ = 9.27

		local var_89_0 = {
			zh = 4.533,
			ja = 9.266
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
				arg_89_0:Play416232021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.425

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[1093].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(416232020)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232020", "story_v_out_416232.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232020", "story_v_out_416232.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_416232", "416232020", "story_v_out_416232.awb")

						arg_89_1:RecordAudio("416232020", var_92_9)
						arg_89_1:RecordAudio("416232020", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416232", "416232020", "story_v_out_416232.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416232", "416232020", "story_v_out_416232.awb")
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
	Play416232021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416232021
		arg_93_1.duration_ = 9.9

		local var_93_0 = {
			zh = 9.9,
			ja = 6.166
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
				arg_93_0:Play416232022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.65

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1093].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(416232021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 26
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232021", "story_v_out_416232.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232021", "story_v_out_416232.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_416232", "416232021", "story_v_out_416232.awb")

						arg_93_1:RecordAudio("416232021", var_96_9)
						arg_93_1:RecordAudio("416232021", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416232", "416232021", "story_v_out_416232.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416232", "416232021", "story_v_out_416232.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416232022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416232022
		arg_97_1.duration_ = 5.8

		local var_97_0 = {
			zh = 5.666,
			ja = 5.8
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
				arg_97_0:Play416232023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.4

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[1093].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(416232022)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232022", "story_v_out_416232.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232022", "story_v_out_416232.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_416232", "416232022", "story_v_out_416232.awb")

						arg_97_1:RecordAudio("416232022", var_100_9)
						arg_97_1:RecordAudio("416232022", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416232", "416232022", "story_v_out_416232.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416232", "416232022", "story_v_out_416232.awb")
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
	Play416232023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416232023
		arg_101_1.duration_ = 10.5

		local var_101_0 = {
			zh = 7.766,
			ja = 10.5
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
				arg_101_0:Play416232024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.866666666666667

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_1 = manager.ui.mainCamera.transform.localPosition
				local var_104_2 = Vector3.New(0, 0, 10) + Vector3.New(var_104_1.x, var_104_1.y, 0)
				local var_104_3 = arg_101_1.bgs_.F09f

				var_104_3.transform.localPosition = var_104_2
				var_104_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_4 = var_104_3:GetComponent("SpriteRenderer")

				if var_104_4 and var_104_4.sprite then
					local var_104_5 = (var_104_3.transform.localPosition - var_104_1).z
					local var_104_6 = manager.ui.mainCameraCom_
					local var_104_7 = 2 * var_104_5 * Mathf.Tan(var_104_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_8 = var_104_7 * var_104_6.aspect
					local var_104_9 = var_104_4.sprite.bounds.size.x
					local var_104_10 = var_104_4.sprite.bounds.size.y
					local var_104_11 = var_104_8 / var_104_9
					local var_104_12 = var_104_7 / var_104_10
					local var_104_13 = var_104_12 < var_104_11 and var_104_11 or var_104_12

					var_104_3.transform.localScale = Vector3.New(var_104_13, var_104_13, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "F09f" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_14 = 0.866666666666667

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_15 = 0.3

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_17 = 0.866666666666667

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Color.New(0, 0, 0)

				var_104_19.a = Mathf.Lerp(0, 1, var_104_18)
				arg_101_1.mask_.color = var_104_19
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				local var_104_20 = Color.New(0, 0, 0)

				var_104_20.a = 1
				arg_101_1.mask_.color = var_104_20
			end

			local var_104_21 = 0.866666666666667

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_22 = 1.76666666666667

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_21) / var_104_22
				local var_104_24 = Color.New(0, 0, 0)

				var_104_24.a = Mathf.Lerp(1, 0, var_104_23)
				arg_101_1.mask_.color = var_104_24
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				local var_104_25 = Color.New(0, 0, 0)
				local var_104_26 = 0

				arg_101_1.mask_.enabled = false
				var_104_25.a = var_104_26
				arg_101_1.mask_.color = var_104_25
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_27 = 2.3
			local var_104_28 = 0.45

			if var_104_27 < arg_101_1.time_ and arg_101_1.time_ <= var_104_27 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_29 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_29:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_30 = arg_101_1:FormatText(StoryNameCfg[236].name)

				arg_101_1.leftNameTxt_.text = var_104_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_31 = arg_101_1:GetWordFromCfg(416232023)
				local var_104_32 = arg_101_1:FormatText(var_104_31.content)

				arg_101_1.text_.text = var_104_32

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_33 = 18
				local var_104_34 = utf8.len(var_104_32)
				local var_104_35 = var_104_33 <= 0 and var_104_28 or var_104_28 * (var_104_34 / var_104_33)

				if var_104_35 > 0 and var_104_28 < var_104_35 then
					arg_101_1.talkMaxDuration = var_104_35
					var_104_27 = var_104_27 + 0.3

					if var_104_35 + var_104_27 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_35 + var_104_27
					end
				end

				arg_101_1.text_.text = var_104_32
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232023", "story_v_out_416232.awb") ~= 0 then
					local var_104_36 = manager.audio:GetVoiceLength("story_v_out_416232", "416232023", "story_v_out_416232.awb") / 1000

					if var_104_36 + var_104_27 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_36 + var_104_27
					end

					if var_104_31.prefab_name ~= "" and arg_101_1.actors_[var_104_31.prefab_name] ~= nil then
						local var_104_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_31.prefab_name].transform, "story_v_out_416232", "416232023", "story_v_out_416232.awb")

						arg_101_1:RecordAudio("416232023", var_104_37)
						arg_101_1:RecordAudio("416232023", var_104_37)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416232", "416232023", "story_v_out_416232.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416232", "416232023", "story_v_out_416232.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_38 = var_104_27 + 0.3
			local var_104_39 = math.max(var_104_28, arg_101_1.talkMaxDuration)

			if var_104_38 <= arg_101_1.time_ and arg_101_1.time_ < var_104_38 + var_104_39 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_38) / var_104_39

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_38 + var_104_39 and arg_101_1.time_ < var_104_38 + var_104_39 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416232024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416232024
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416232025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10127"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10127 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10127", 7)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(0, -2000, 0)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10127, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_110_7 = 0
			local var_110_8 = 1.3

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_9 = arg_107_1:GetWordFromCfg(416232024)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 52
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_8 or var_110_8 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_8 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_14 and arg_107_1.time_ < var_110_7 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play416232025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416232025
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play416232026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.475

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(416232025)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 60
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416232026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416232026
		arg_115_1.duration_ = 7.63

		local var_115_0 = {
			zh = 6.7,
			ja = 7.633
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
				arg_115_0:Play416232027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10127"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10127 == nil then
				arg_115_1.var_.actorSpriteComps10127 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps10127 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10127 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10127 = nil
			end

			local var_118_8 = arg_115_1.actors_["10127"].transform
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.var_.moveOldPos10127 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10127", 3)

				local var_118_10 = var_118_8.childCount

				for iter_118_4 = 0, var_118_10 - 1 do
					local var_118_11 = var_118_8:GetChild(iter_118_4)

					if var_118_11.name == "split_1" or not string.find(var_118_11.name, "split") then
						var_118_11.gameObject:SetActive(true)
					else
						var_118_11.gameObject:SetActive(false)
					end
				end
			end

			local var_118_12 = 0.001

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_12 then
				local var_118_13 = (arg_115_1.time_ - var_118_9) / var_118_12
				local var_118_14 = Vector3.New(0, -387.4, -316.5)

				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10127, var_118_14, var_118_13)
			end

			if arg_115_1.time_ >= var_118_9 + var_118_12 and arg_115_1.time_ < var_118_9 + var_118_12 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_118_15 = 0
			local var_118_16 = 0.65

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[236].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(416232026)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 26
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232026", "story_v_out_416232.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232026", "story_v_out_416232.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_416232", "416232026", "story_v_out_416232.awb")

						arg_115_1:RecordAudio("416232026", var_118_24)
						arg_115_1:RecordAudio("416232026", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416232", "416232026", "story_v_out_416232.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416232", "416232026", "story_v_out_416232.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play416232027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416232027
		arg_119_1.duration_ = 9

		local var_119_0 = {
			zh = 5.733,
			ja = 9
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
				arg_119_0:Play416232028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.475

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[236].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(416232027)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 19
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232027", "story_v_out_416232.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232027", "story_v_out_416232.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_416232", "416232027", "story_v_out_416232.awb")

						arg_119_1:RecordAudio("416232027", var_122_9)
						arg_119_1:RecordAudio("416232027", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416232", "416232027", "story_v_out_416232.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416232", "416232027", "story_v_out_416232.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416232028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416232028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416232029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10127"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10127 == nil then
				arg_123_1.var_.actorSpriteComps10127 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10127 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10127 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10127 = nil
			end

			local var_126_8 = arg_123_1.actors_["10127"].transform
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.var_.moveOldPos10127 = var_126_8.localPosition
				var_126_8.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10127", 7)

				local var_126_10 = var_126_8.childCount

				for iter_126_4 = 0, var_126_10 - 1 do
					local var_126_11 = var_126_8:GetChild(iter_126_4)

					if var_126_11.name == "" or not string.find(var_126_11.name, "split") then
						var_126_11.gameObject:SetActive(true)
					else
						var_126_11.gameObject:SetActive(false)
					end
				end
			end

			local var_126_12 = 0.001

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_9) / var_126_12
				local var_126_14 = Vector3.New(0, -2000, 0)

				var_126_8.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10127, var_126_14, var_126_13)
			end

			if arg_123_1.time_ >= var_126_9 + var_126_12 and arg_123_1.time_ < var_126_9 + var_126_12 + arg_126_0 then
				var_126_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_15 = 0
			local var_126_16 = 1.625

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_17 = arg_123_1:GetWordFromCfg(416232028)
				local var_126_18 = arg_123_1:FormatText(var_126_17.content)

				arg_123_1.text_.text = var_126_18

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_19 = 65
				local var_126_20 = utf8.len(var_126_18)
				local var_126_21 = var_126_19 <= 0 and var_126_16 or var_126_16 * (var_126_20 / var_126_19)

				if var_126_21 > 0 and var_126_16 < var_126_21 then
					arg_123_1.talkMaxDuration = var_126_21

					if var_126_21 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_21 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_18
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_22 and arg_123_1.time_ < var_126_15 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play416232029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416232029
		arg_127_1.duration_ = 3.67

		local var_127_0 = {
			zh = 3.233,
			ja = 3.666
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
				arg_127_0:Play416232030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.225

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[236].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(416232029)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 9
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232029", "story_v_out_416232.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232029", "story_v_out_416232.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_416232", "416232029", "story_v_out_416232.awb")

						arg_127_1:RecordAudio("416232029", var_130_9)
						arg_127_1:RecordAudio("416232029", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416232", "416232029", "story_v_out_416232.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416232", "416232029", "story_v_out_416232.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416232030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416232030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play416232031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(416232030)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 40
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play416232031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416232031
		arg_135_1.duration_ = 10

		local var_135_0 = {
			zh = 6.233,
			ja = 10
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
				arg_135_0:Play416232032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.425

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1093].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(416232031)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 17
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232031", "story_v_out_416232.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232031", "story_v_out_416232.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_416232", "416232031", "story_v_out_416232.awb")

						arg_135_1:RecordAudio("416232031", var_138_9)
						arg_135_1:RecordAudio("416232031", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416232", "416232031", "story_v_out_416232.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416232", "416232031", "story_v_out_416232.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play416232032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416232032
		arg_139_1.duration_ = 5.9

		local var_139_0 = {
			zh = 2.3,
			ja = 5.9
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
				arg_139_0:Play416232033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.25

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[236].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(416232032)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 10
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232032", "story_v_out_416232.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232032", "story_v_out_416232.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_416232", "416232032", "story_v_out_416232.awb")

						arg_139_1:RecordAudio("416232032", var_142_9)
						arg_139_1:RecordAudio("416232032", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416232", "416232032", "story_v_out_416232.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416232", "416232032", "story_v_out_416232.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play416232033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416232033
		arg_143_1.duration_ = 6.9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play416232034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = manager.ui.mainCamera.transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				local var_146_2 = arg_143_1.var_.effect799
				local var_146_3
				local var_146_4 = var_146_0

				if not var_146_2 then
					var_146_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_146_4)
					var_146_2.name = "799"
					arg_143_1.var_.effect799 = var_146_2
				else
					var_146_2.transform:SetParent(var_146_4)
				end

				var_146_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_146_5 = manager.ui.mainCameraCom_
				local var_146_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_146_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_146_7 = var_146_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_146_8 = 15
				local var_146_9 = 2 * var_146_8 * Mathf.Tan(var_146_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_146_5.aspect
				local var_146_10 = 1
				local var_146_11 = 1.7777777777777777

				if var_146_11 < var_146_5.aspect then
					var_146_10 = var_146_9 / (2 * var_146_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_146_11)
				end

				for iter_146_0, iter_146_1 in ipairs(var_146_7) do
					local var_146_12 = iter_146_1.transform.localScale

					iter_146_1.transform.localScale = Vector3.New(var_146_12.x / var_146_6 * var_146_10, var_146_12.y / var_146_6, var_146_12.z)
				end
			end

			local var_146_13 = manager.ui.mainCamera.transform
			local var_146_14 = 2.09166666666667

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				local var_146_15 = arg_143_1.var_.effect799

				if var_146_15 then
					Object.Destroy(var_146_15)

					arg_143_1.var_.effect799 = nil
				end
			end

			local var_146_16 = 0.5

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_17 = 0.633333333333333

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17
				local var_146_19 = Color.New(0, 0, 0)

				var_146_19.a = Mathf.Lerp(0, 1, var_146_18)
				arg_143_1.mask_.color = var_146_19
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				local var_146_20 = Color.New(0, 0, 0)

				var_146_20.a = 1
				arg_143_1.mask_.color = var_146_20
			end

			local var_146_21 = 1.13333333333333

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_22 = 1.5

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_22 then
				local var_146_23 = (arg_143_1.time_ - var_146_21) / var_146_22
				local var_146_24 = Color.New(0, 0, 0)

				var_146_24.a = Mathf.Lerp(1, 0, var_146_23)
				arg_143_1.mask_.color = var_146_24
			end

			if arg_143_1.time_ >= var_146_21 + var_146_22 and arg_143_1.time_ < var_146_21 + var_146_22 + arg_146_0 then
				local var_146_25 = Color.New(0, 0, 0)
				local var_146_26 = 0

				arg_143_1.mask_.enabled = false
				var_146_25.a = var_146_26
				arg_143_1.mask_.color = var_146_25
			end

			local var_146_27 = 1.13333333333333

			if var_146_27 < arg_143_1.time_ and arg_143_1.time_ <= var_146_27 + arg_146_0 then
				local var_146_28 = manager.ui.mainCamera.transform.localPosition
				local var_146_29 = Vector3.New(0, 0, 10) + Vector3.New(var_146_28.x, var_146_28.y, 0)
				local var_146_30 = arg_143_1.bgs_.STblack

				var_146_30.transform.localPosition = var_146_29
				var_146_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_31 = var_146_30:GetComponent("SpriteRenderer")

				if var_146_31 and var_146_31.sprite then
					local var_146_32 = (var_146_30.transform.localPosition - var_146_28).z
					local var_146_33 = manager.ui.mainCameraCom_
					local var_146_34 = 2 * var_146_32 * Mathf.Tan(var_146_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_146_35 = var_146_34 * var_146_33.aspect
					local var_146_36 = var_146_31.sprite.bounds.size.x
					local var_146_37 = var_146_31.sprite.bounds.size.y
					local var_146_38 = var_146_35 / var_146_36
					local var_146_39 = var_146_34 / var_146_37
					local var_146_40 = var_146_39 < var_146_38 and var_146_38 or var_146_39

					var_146_30.transform.localScale = Vector3.New(var_146_40, var_146_40, 0)
				end

				for iter_146_2, iter_146_3 in pairs(arg_143_1.bgs_) do
					if iter_146_2 ~= "STblack" then
						iter_146_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_41 = 1.85833333333333
			local var_146_42 = 1

			if var_146_41 < arg_143_1.time_ and arg_143_1.time_ <= var_146_41 + arg_146_0 then
				local var_146_43 = "play"
				local var_146_44 = "effect"

				arg_143_1:AudioAction(var_146_43, var_146_44, "se_story_139", "se_story_139_lasergun", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_45 = 1.9
			local var_146_46 = 1.325

			if var_146_45 < arg_143_1.time_ and arg_143_1.time_ <= var_146_45 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_47 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_47:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_48 = arg_143_1:GetWordFromCfg(416232033)
				local var_146_49 = arg_143_1:FormatText(var_146_48.content)

				arg_143_1.text_.text = var_146_49

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_50 = 53
				local var_146_51 = utf8.len(var_146_49)
				local var_146_52 = var_146_50 <= 0 and var_146_46 or var_146_46 * (var_146_51 / var_146_50)

				if var_146_52 > 0 and var_146_46 < var_146_52 then
					arg_143_1.talkMaxDuration = var_146_52
					var_146_45 = var_146_45 + 0.3

					if var_146_52 + var_146_45 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_52 + var_146_45
					end
				end

				arg_143_1.text_.text = var_146_49
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_53 = var_146_45 + 0.3
			local var_146_54 = math.max(var_146_46, arg_143_1.talkMaxDuration)

			if var_146_53 <= arg_143_1.time_ and arg_143_1.time_ < var_146_53 + var_146_54 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_53) / var_146_54

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_53 + var_146_54 and arg_143_1.time_ < var_146_53 + var_146_54 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play416232034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416232034
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416232035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.325

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(416232034)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 53
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416232035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416232035
		arg_153_1.duration_ = 5.73

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416232036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "STwhite"

			if arg_153_1.bgs_[var_156_0] == nil then
				local var_156_1 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_156_0)
				var_156_1.name = var_156_0
				var_156_1.transform.parent = arg_153_1.stage_.transform
				var_156_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_[var_156_0] = var_156_1
			end

			local var_156_2 = 1.26666666666667

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				local var_156_3 = manager.ui.mainCamera.transform.localPosition
				local var_156_4 = Vector3.New(0, 0, 10) + Vector3.New(var_156_3.x, var_156_3.y, 0)
				local var_156_5 = arg_153_1.bgs_.STwhite

				var_156_5.transform.localPosition = var_156_4
				var_156_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_6 = var_156_5:GetComponent("SpriteRenderer")

				if var_156_6 and var_156_6.sprite then
					local var_156_7 = (var_156_5.transform.localPosition - var_156_3).z
					local var_156_8 = manager.ui.mainCameraCom_
					local var_156_9 = 2 * var_156_7 * Mathf.Tan(var_156_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_156_10 = var_156_9 * var_156_8.aspect
					local var_156_11 = var_156_6.sprite.bounds.size.x
					local var_156_12 = var_156_6.sprite.bounds.size.y
					local var_156_13 = var_156_10 / var_156_11
					local var_156_14 = var_156_9 / var_156_12
					local var_156_15 = var_156_14 < var_156_13 and var_156_13 or var_156_14

					var_156_5.transform.localScale = Vector3.New(var_156_15, var_156_15, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "STwhite" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_16 = 1.26666666666667

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_17 = 0.3

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_18 = 0

			if var_156_18 < arg_153_1.time_ and arg_153_1.time_ <= var_156_18 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_19 = 1.3

			if var_156_18 <= arg_153_1.time_ and arg_153_1.time_ < var_156_18 + var_156_19 then
				local var_156_20 = (arg_153_1.time_ - var_156_18) / var_156_19
				local var_156_21 = Color.New(0, 0, 0)

				var_156_21.a = Mathf.Lerp(0, 1, var_156_20)
				arg_153_1.mask_.color = var_156_21
			end

			if arg_153_1.time_ >= var_156_18 + var_156_19 and arg_153_1.time_ < var_156_18 + var_156_19 + arg_156_0 then
				local var_156_22 = Color.New(0, 0, 0)

				var_156_22.a = 1
				arg_153_1.mask_.color = var_156_22
			end

			local var_156_23 = 1.3

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_24 = 2

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_24 then
				local var_156_25 = (arg_153_1.time_ - var_156_23) / var_156_24
				local var_156_26 = Color.New(0, 0, 0)

				var_156_26.a = Mathf.Lerp(1, 0, var_156_25)
				arg_153_1.mask_.color = var_156_26
			end

			if arg_153_1.time_ >= var_156_23 + var_156_24 and arg_153_1.time_ < var_156_23 + var_156_24 + arg_156_0 then
				local var_156_27 = Color.New(0, 0, 0)
				local var_156_28 = 0

				arg_153_1.mask_.enabled = false
				var_156_27.a = var_156_28
				arg_153_1.mask_.color = var_156_27
			end

			local var_156_29 = arg_153_1.actors_["10127"]
			local var_156_30 = 1.26666666666667

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 and not isNil(var_156_29) and arg_153_1.var_.actorSpriteComps10127 == nil then
				arg_153_1.var_.actorSpriteComps10127 = var_156_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_31 = 0.2

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_31 and not isNil(var_156_29) then
				local var_156_32 = (arg_153_1.time_ - var_156_30) / var_156_31

				if arg_153_1.var_.actorSpriteComps10127 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								local var_156_33 = Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, var_156_32)
								local var_156_34 = Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, var_156_32)
								local var_156_35 = Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, var_156_32)

								iter_156_3.color = Color.New(var_156_33, var_156_34, var_156_35)
							else
								local var_156_36 = Mathf.Lerp(iter_156_3.color.r, 1, var_156_32)

								iter_156_3.color = Color.New(var_156_36, var_156_36, var_156_36)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_30 + var_156_31 and arg_153_1.time_ < var_156_30 + var_156_31 + arg_156_0 and not isNil(var_156_29) and arg_153_1.var_.actorSpriteComps10127 then
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

			local var_156_37 = 1.26666666666667

			if var_156_37 < arg_153_1.time_ and arg_153_1.time_ <= var_156_37 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(true)
				arg_153_1.dialog_:SetActive(false)

				arg_153_1.fswtw_.percent = 0

				local var_156_38 = arg_153_1:GetWordFromCfg(416232035)
				local var_156_39 = arg_153_1:FormatText(var_156_38.content)

				arg_153_1.fswt_.text = var_156_39

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.fswt_)

				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_153_1.fswtw_:SetDirty()

				arg_153_1.typewritterCharCountI18N = 0

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_40 = 2.03333333333333

			if var_156_40 < arg_153_1.time_ and arg_153_1.time_ <= var_156_40 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_41 = 10
			local var_156_42 = 0.666666666666667
			local var_156_43 = arg_153_1:GetWordFromCfg(416232035)
			local var_156_44 = arg_153_1:FormatText(var_156_43.content)
			local var_156_45, var_156_46 = arg_153_1:GetPercentByPara(var_156_44, 1)

			if var_156_40 < arg_153_1.time_ and arg_153_1.time_ <= var_156_40 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_47 = var_156_41 <= 0 and var_156_42 or var_156_42 * ((var_156_46 - arg_153_1.typewritterCharCountI18N) / var_156_41)

				if var_156_47 > 0 and var_156_42 < var_156_47 then
					arg_153_1.talkMaxDuration = var_156_47

					if var_156_47 + var_156_40 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_47 + var_156_40
					end
				end
			end

			local var_156_48 = 0.666666666666667
			local var_156_49 = math.max(var_156_48, arg_153_1.talkMaxDuration)

			if var_156_40 <= arg_153_1.time_ and arg_153_1.time_ < var_156_40 + var_156_49 then
				local var_156_50 = (arg_153_1.time_ - var_156_40) / var_156_49

				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_45, var_156_50)
				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_40 + var_156_49 and arg_153_1.time_ < var_156_40 + var_156_49 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_45

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_46
			end

			local var_156_51 = 2.3

			if var_156_51 < arg_153_1.time_ and arg_153_1.time_ <= var_156_51 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_52 = 0
			local var_156_53 = 0
			local var_156_54 = arg_153_1:GetWordFromCfg(416232035)
			local var_156_55 = arg_153_1:FormatText(var_156_54.content)
			local var_156_56, var_156_57 = arg_153_1:GetPercentByPara(var_156_55, 1)

			if var_156_51 < arg_153_1.time_ and arg_153_1.time_ <= var_156_51 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_58 = var_156_52 <= 0 and var_156_53 or var_156_53 * ((var_156_57 - arg_153_1.typewritterCharCountI18N) / var_156_52)

				if var_156_58 > 0 and var_156_53 < var_156_58 then
					arg_153_1.talkMaxDuration = var_156_58

					if var_156_58 + var_156_51 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_58 + var_156_51
					end
				end
			end

			local var_156_59 = 0
			local var_156_60 = math.max(var_156_59, arg_153_1.talkMaxDuration)

			if var_156_51 <= arg_153_1.time_ and arg_153_1.time_ < var_156_51 + var_156_60 then
				local var_156_61 = (arg_153_1.time_ - var_156_51) / var_156_60

				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_56, var_156_61)
				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_51 + var_156_60 and arg_153_1.time_ < var_156_51 + var_156_60 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_56

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_57
			end

			local var_156_62 = 1.28333333333333

			if var_156_62 < arg_153_1.time_ and arg_153_1.time_ <= var_156_62 + arg_156_0 then
				local var_156_63 = arg_153_1.fswbg_.transform:Find("textbox/adapt/content") or arg_153_1.fswbg_.transform:Find("textbox/content")
				local var_156_64 = arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_156_65 = var_156_63:GetComponent("Text")
				local var_156_66 = var_156_63:GetComponent("RectTransform")

				var_156_65.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_156_66.offsetMin = Vector2.New(0, 0)
				var_156_66.offsetMax = Vector2.New(0, -53.2)
			end

			local var_156_67 = 1.86666666666667
			local var_156_68 = 3.866
			local var_156_69 = manager.audio:GetVoiceLength("story_v_out_416232", "416232035", "") / 1000

			if var_156_69 > 0 and var_156_68 < var_156_69 and var_156_69 + var_156_67 > arg_153_1.duration_ then
				local var_156_70 = var_156_69

				arg_153_1.duration_ = var_156_69 + var_156_67
			end

			if var_156_67 < arg_153_1.time_ and arg_153_1.time_ <= var_156_67 + arg_156_0 then
				local var_156_71 = "play"
				local var_156_72 = "voice"

				arg_153_1:AudioAction(var_156_71, var_156_72, "story_v_out_416232", "416232035", "")
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416232036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416232036
		arg_157_1.duration_ = 8.39

		local var_157_0 = {
			zh = 7.25766666666667,
			ja = 8.39166666666667
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
				arg_157_0:Play416232037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.66666666666667

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				local var_160_1 = manager.ui.mainCamera.transform.localPosition
				local var_160_2 = Vector3.New(0, 0, 10) + Vector3.New(var_160_1.x, var_160_1.y, 0)
				local var_160_3 = arg_157_1.bgs_.F09f

				var_160_3.transform.localPosition = var_160_2
				var_160_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_4 = var_160_3:GetComponent("SpriteRenderer")

				if var_160_4 and var_160_4.sprite then
					local var_160_5 = (var_160_3.transform.localPosition - var_160_1).z
					local var_160_6 = manager.ui.mainCameraCom_
					local var_160_7 = 2 * var_160_5 * Mathf.Tan(var_160_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_160_8 = var_160_7 * var_160_6.aspect
					local var_160_9 = var_160_4.sprite.bounds.size.x
					local var_160_10 = var_160_4.sprite.bounds.size.y
					local var_160_11 = var_160_8 / var_160_9
					local var_160_12 = var_160_7 / var_160_10
					local var_160_13 = var_160_12 < var_160_11 and var_160_11 or var_160_12

					var_160_3.transform.localScale = Vector3.New(var_160_13, var_160_13, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "F09f" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_14 = 1.66666666666667

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_15 = 0.3

			if arg_157_1.time_ >= var_160_14 + var_160_15 and arg_157_1.time_ < var_160_14 + var_160_15 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_17 = 1.66666666666667

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

			local var_160_21 = 1.66666666666667

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

			local var_160_27 = "1028"

			if arg_157_1.actors_[var_160_27] == nil then
				local var_160_28 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_160_28) then
					local var_160_29 = Object.Instantiate(var_160_28, arg_157_1.canvasGo_.transform)

					var_160_29.transform:SetSiblingIndex(1)

					var_160_29.name = var_160_27
					var_160_29.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_[var_160_27] = var_160_29

					local var_160_30 = var_160_29:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_157_1.isInRecall_ then
						for iter_160_2, iter_160_3 in ipairs(var_160_30) do
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_31 = arg_157_1.actors_["1028"]
			local var_160_32 = 3.09166666666667

			if var_160_32 < arg_157_1.time_ and arg_157_1.time_ <= var_160_32 + arg_160_0 and not isNil(var_160_31) and arg_157_1.var_.actorSpriteComps1028 == nil then
				arg_157_1.var_.actorSpriteComps1028 = var_160_31:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_33 = 0.2

			if var_160_32 <= arg_157_1.time_ and arg_157_1.time_ < var_160_32 + var_160_33 and not isNil(var_160_31) then
				local var_160_34 = (arg_157_1.time_ - var_160_32) / var_160_33

				if arg_157_1.var_.actorSpriteComps1028 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								local var_160_35 = Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor1.r, var_160_34)
								local var_160_36 = Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor1.g, var_160_34)
								local var_160_37 = Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor1.b, var_160_34)

								iter_160_5.color = Color.New(var_160_35, var_160_36, var_160_37)
							else
								local var_160_38 = Mathf.Lerp(iter_160_5.color.r, 1, var_160_34)

								iter_160_5.color = Color.New(var_160_38, var_160_38, var_160_38)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_32 + var_160_33 and arg_157_1.time_ < var_160_32 + var_160_33 + arg_160_0 and not isNil(var_160_31) and arg_157_1.var_.actorSpriteComps1028 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_160_7 then
						if arg_157_1.isInRecall_ then
							iter_160_7.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1028 = nil
			end

			local var_160_39 = arg_157_1.actors_["10127"]
			local var_160_40 = 3.09166666666667

			if var_160_40 < arg_157_1.time_ and arg_157_1.time_ <= var_160_40 + arg_160_0 and not isNil(var_160_39) and arg_157_1.var_.actorSpriteComps10127 == nil then
				arg_157_1.var_.actorSpriteComps10127 = var_160_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_41 = 0.2

			if var_160_40 <= arg_157_1.time_ and arg_157_1.time_ < var_160_40 + var_160_41 and not isNil(var_160_39) then
				local var_160_42 = (arg_157_1.time_ - var_160_40) / var_160_41

				if arg_157_1.var_.actorSpriteComps10127 then
					for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_160_9 then
							if arg_157_1.isInRecall_ then
								local var_160_43 = Mathf.Lerp(iter_160_9.color.r, arg_157_1.hightColor2.r, var_160_42)
								local var_160_44 = Mathf.Lerp(iter_160_9.color.g, arg_157_1.hightColor2.g, var_160_42)
								local var_160_45 = Mathf.Lerp(iter_160_9.color.b, arg_157_1.hightColor2.b, var_160_42)

								iter_160_9.color = Color.New(var_160_43, var_160_44, var_160_45)
							else
								local var_160_46 = Mathf.Lerp(iter_160_9.color.r, 0.5, var_160_42)

								iter_160_9.color = Color.New(var_160_46, var_160_46, var_160_46)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_40 + var_160_41 and arg_157_1.time_ < var_160_40 + var_160_41 + arg_160_0 and not isNil(var_160_39) and arg_157_1.var_.actorSpriteComps10127 then
				for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_160_11 then
						if arg_157_1.isInRecall_ then
							iter_160_11.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10127 = nil
			end

			local var_160_47 = arg_157_1.actors_["1028"].transform
			local var_160_48 = 3.09166666666667

			if var_160_48 < arg_157_1.time_ and arg_157_1.time_ <= var_160_48 + arg_160_0 then
				arg_157_1.var_.moveOldPos1028 = var_160_47.localPosition
				var_160_47.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1028", 2)

				local var_160_49 = var_160_47.childCount

				for iter_160_12 = 0, var_160_49 - 1 do
					local var_160_50 = var_160_47:GetChild(iter_160_12)

					if var_160_50.name == "" or not string.find(var_160_50.name, "split") then
						var_160_50.gameObject:SetActive(true)
					else
						var_160_50.gameObject:SetActive(false)
					end
				end
			end

			local var_160_51 = 0.001

			if var_160_48 <= arg_157_1.time_ and arg_157_1.time_ < var_160_48 + var_160_51 then
				local var_160_52 = (arg_157_1.time_ - var_160_48) / var_160_51
				local var_160_53 = Vector3.New(-390, -402.7, -156.1)

				var_160_47.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1028, var_160_53, var_160_52)
			end

			if arg_157_1.time_ >= var_160_48 + var_160_51 and arg_157_1.time_ < var_160_48 + var_160_51 + arg_160_0 then
				var_160_47.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_160_54 = 1.66666666666667

			if var_160_54 < arg_157_1.time_ and arg_157_1.time_ <= var_160_54 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(false)
				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_55 = 1.68333333333333

			if var_160_55 < arg_157_1.time_ and arg_157_1.time_ <= var_160_55 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(false)
				arg_157_1.dialog_:SetActive(false)
				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_56 = 2.7

			if var_160_56 < arg_157_1.time_ and arg_157_1.time_ <= var_160_56 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_57 = 0
			local var_160_58 = 0
			local var_160_59 = arg_157_1:GetWordFromCfg(416232035)
			local var_160_60 = arg_157_1:FormatText(var_160_59.content)
			local var_160_61, var_160_62 = arg_157_1:GetPercentByPara(var_160_60, 1)

			if var_160_56 < arg_157_1.time_ and arg_157_1.time_ <= var_160_56 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_63 = var_160_57 <= 0 and var_160_58 or var_160_58 * ((var_160_62 - arg_157_1.typewritterCharCountI18N) / var_160_57)

				if var_160_63 > 0 and var_160_58 < var_160_63 then
					arg_157_1.talkMaxDuration = var_160_63

					if var_160_63 + var_160_56 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_63 + var_160_56
					end
				end
			end

			local var_160_64 = 0
			local var_160_65 = math.max(var_160_64, arg_157_1.talkMaxDuration)

			if var_160_56 <= arg_157_1.time_ and arg_157_1.time_ < var_160_56 + var_160_65 then
				local var_160_66 = (arg_157_1.time_ - var_160_56) / var_160_65

				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_61, var_160_66)
				arg_157_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_56 + var_160_65 and arg_157_1.time_ < var_160_56 + var_160_65 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_61

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_62
			end

			local var_160_67 = arg_157_1.actors_["1028"]
			local var_160_68 = 3.05833333333333

			if var_160_68 < arg_157_1.time_ and arg_157_1.time_ <= var_160_68 + arg_160_0 then
				local var_160_69 = var_160_67:GetComponentInChildren(typeof(CanvasGroup))

				if var_160_69 then
					arg_157_1.var_.alphaOldValue1028 = var_160_69.alpha
					arg_157_1.var_.characterEffect1028 = var_160_69
				end

				arg_157_1.var_.alphaOldValue1028 = 0
			end

			local var_160_70 = 0.233333333333333

			if var_160_68 <= arg_157_1.time_ and arg_157_1.time_ < var_160_68 + var_160_70 then
				local var_160_71 = (arg_157_1.time_ - var_160_68) / var_160_70
				local var_160_72 = Mathf.Lerp(arg_157_1.var_.alphaOldValue1028, 1, var_160_71)

				if arg_157_1.var_.characterEffect1028 then
					arg_157_1.var_.characterEffect1028.alpha = var_160_72
				end
			end

			if arg_157_1.time_ >= var_160_68 + var_160_70 and arg_157_1.time_ < var_160_68 + var_160_70 + arg_160_0 and arg_157_1.var_.characterEffect1028 then
				arg_157_1.var_.characterEffect1028.alpha = 1
			end

			local var_160_73 = 1.66666666666667

			arg_157_1.isInRecall_ = true

			if var_160_73 < arg_157_1.time_ and arg_157_1.time_ <= var_160_73 + arg_160_0 then
				arg_157_1.screenFilterGo_:SetActive(true)

				arg_157_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_157_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_157_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_160_13, iter_160_14 in pairs(arg_157_1.actors_) do
					local var_160_74 = iter_160_14:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_160_15, iter_160_16 in ipairs(var_160_74) do
						if iter_160_16.color.r > 0.51 then
							iter_160_16.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_160_16.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_160_75 = 0.0166666666666667

			if var_160_73 <= arg_157_1.time_ and arg_157_1.time_ < var_160_73 + var_160_75 then
				local var_160_76 = (arg_157_1.time_ - var_160_73) / var_160_75

				arg_157_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_160_76)
			end

			if arg_157_1.time_ >= var_160_73 + var_160_75 and arg_157_1.time_ < var_160_73 + var_160_75 + arg_160_0 then
				arg_157_1.screenFilterEffect_.weight = 1
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_77 = 3.49166666666667
			local var_160_78 = 0.375

			if var_160_77 < arg_157_1.time_ and arg_157_1.time_ <= var_160_77 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_79 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_79:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_80 = arg_157_1:FormatText(StoryNameCfg[327].name)

				arg_157_1.leftNameTxt_.text = var_160_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_81 = arg_157_1:GetWordFromCfg(416232036)
				local var_160_82 = arg_157_1:FormatText(var_160_81.content)

				arg_157_1.text_.text = var_160_82

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_83 = 15
				local var_160_84 = utf8.len(var_160_82)
				local var_160_85 = var_160_83 <= 0 and var_160_78 or var_160_78 * (var_160_84 / var_160_83)

				if var_160_85 > 0 and var_160_78 < var_160_85 then
					arg_157_1.talkMaxDuration = var_160_85
					var_160_77 = var_160_77 + 0.3

					if var_160_85 + var_160_77 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_85 + var_160_77
					end
				end

				arg_157_1.text_.text = var_160_82
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232036", "story_v_out_416232.awb") ~= 0 then
					local var_160_86 = manager.audio:GetVoiceLength("story_v_out_416232", "416232036", "story_v_out_416232.awb") / 1000

					if var_160_86 + var_160_77 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_86 + var_160_77
					end

					if var_160_81.prefab_name ~= "" and arg_157_1.actors_[var_160_81.prefab_name] ~= nil then
						local var_160_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_81.prefab_name].transform, "story_v_out_416232", "416232036", "story_v_out_416232.awb")

						arg_157_1:RecordAudio("416232036", var_160_87)
						arg_157_1:RecordAudio("416232036", var_160_87)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416232", "416232036", "story_v_out_416232.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416232", "416232036", "story_v_out_416232.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_88 = var_160_77 + 0.3
			local var_160_89 = math.max(var_160_78, arg_157_1.talkMaxDuration)

			if var_160_88 <= arg_157_1.time_ and arg_157_1.time_ < var_160_88 + var_160_89 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_88) / var_160_89

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_88 + var_160_89 and arg_157_1.time_ < var_160_88 + var_160_89 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.09166666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play416232037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416232037
		arg_163_1.duration_ = 7.33

		local var_163_0 = {
			zh = 4.666,
			ja = 7.333
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
				arg_163_0:Play416232038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "1086"

			if arg_163_1.actors_[var_166_0] == nil then
				local var_166_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_166_1) then
					local var_166_2 = Object.Instantiate(var_166_1, arg_163_1.canvasGo_.transform)

					var_166_2.transform:SetSiblingIndex(1)

					var_166_2.name = var_166_0
					var_166_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_163_1.actors_[var_166_0] = var_166_2

					local var_166_3 = var_166_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_163_1.isInRecall_ then
						for iter_166_0, iter_166_1 in ipairs(var_166_3) do
							iter_166_1.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_166_4 = arg_163_1.actors_["1086"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps1086 == nil then
				arg_163_1.var_.actorSpriteComps1086 = var_166_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 0.2

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.actorSpriteComps1086 then
					for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_166_3 then
							if arg_163_1.isInRecall_ then
								local var_166_8 = Mathf.Lerp(iter_166_3.color.r, arg_163_1.hightColor1.r, var_166_7)
								local var_166_9 = Mathf.Lerp(iter_166_3.color.g, arg_163_1.hightColor1.g, var_166_7)
								local var_166_10 = Mathf.Lerp(iter_166_3.color.b, arg_163_1.hightColor1.b, var_166_7)

								iter_166_3.color = Color.New(var_166_8, var_166_9, var_166_10)
							else
								local var_166_11 = Mathf.Lerp(iter_166_3.color.r, 1, var_166_7)

								iter_166_3.color = Color.New(var_166_11, var_166_11, var_166_11)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps1086 then
				for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_166_5 then
						if arg_163_1.isInRecall_ then
							iter_166_5.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1086 = nil
			end

			local var_166_12 = arg_163_1.actors_["1028"]
			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 and not isNil(var_166_12) and arg_163_1.var_.actorSpriteComps1028 == nil then
				arg_163_1.var_.actorSpriteComps1028 = var_166_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_14 = 0.2

			if var_166_13 <= arg_163_1.time_ and arg_163_1.time_ < var_166_13 + var_166_14 and not isNil(var_166_12) then
				local var_166_15 = (arg_163_1.time_ - var_166_13) / var_166_14

				if arg_163_1.var_.actorSpriteComps1028 then
					for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_166_7 then
							if arg_163_1.isInRecall_ then
								local var_166_16 = Mathf.Lerp(iter_166_7.color.r, arg_163_1.hightColor2.r, var_166_15)
								local var_166_17 = Mathf.Lerp(iter_166_7.color.g, arg_163_1.hightColor2.g, var_166_15)
								local var_166_18 = Mathf.Lerp(iter_166_7.color.b, arg_163_1.hightColor2.b, var_166_15)

								iter_166_7.color = Color.New(var_166_16, var_166_17, var_166_18)
							else
								local var_166_19 = Mathf.Lerp(iter_166_7.color.r, 0.5, var_166_15)

								iter_166_7.color = Color.New(var_166_19, var_166_19, var_166_19)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_13 + var_166_14 and arg_163_1.time_ < var_166_13 + var_166_14 + arg_166_0 and not isNil(var_166_12) and arg_163_1.var_.actorSpriteComps1028 then
				for iter_166_8, iter_166_9 in pairs(arg_163_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_166_9 then
						if arg_163_1.isInRecall_ then
							iter_166_9.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1028 = nil
			end

			local var_166_20 = arg_163_1.actors_["1086"].transform
			local var_166_21 = 0

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.var_.moveOldPos1086 = var_166_20.localPosition
				var_166_20.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1086", 4)

				local var_166_22 = var_166_20.childCount

				for iter_166_10 = 0, var_166_22 - 1 do
					local var_166_23 = var_166_20:GetChild(iter_166_10)

					if var_166_23.name == "" or not string.find(var_166_23.name, "split") then
						var_166_23.gameObject:SetActive(true)
					else
						var_166_23.gameObject:SetActive(false)
					end
				end
			end

			local var_166_24 = 0.001

			if var_166_21 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_24 then
				local var_166_25 = (arg_163_1.time_ - var_166_21) / var_166_24
				local var_166_26 = Vector3.New(390, -404.2, -237.9)

				var_166_20.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1086, var_166_26, var_166_25)
			end

			if arg_163_1.time_ >= var_166_21 + var_166_24 and arg_163_1.time_ < var_166_21 + var_166_24 + arg_166_0 then
				var_166_20.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_166_27 = 0
			local var_166_28 = 0.575

			if var_166_27 < arg_163_1.time_ and arg_163_1.time_ <= var_166_27 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_29 = arg_163_1:FormatText(StoryNameCfg[1080].name)

				arg_163_1.leftNameTxt_.text = var_166_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_30 = arg_163_1:GetWordFromCfg(416232037)
				local var_166_31 = arg_163_1:FormatText(var_166_30.content)

				arg_163_1.text_.text = var_166_31

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_32 = 23
				local var_166_33 = utf8.len(var_166_31)
				local var_166_34 = var_166_32 <= 0 and var_166_28 or var_166_28 * (var_166_33 / var_166_32)

				if var_166_34 > 0 and var_166_28 < var_166_34 then
					arg_163_1.talkMaxDuration = var_166_34

					if var_166_34 + var_166_27 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_34 + var_166_27
					end
				end

				arg_163_1.text_.text = var_166_31
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232037", "story_v_out_416232.awb") ~= 0 then
					local var_166_35 = manager.audio:GetVoiceLength("story_v_out_416232", "416232037", "story_v_out_416232.awb") / 1000

					if var_166_35 + var_166_27 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_35 + var_166_27
					end

					if var_166_30.prefab_name ~= "" and arg_163_1.actors_[var_166_30.prefab_name] ~= nil then
						local var_166_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_30.prefab_name].transform, "story_v_out_416232", "416232037", "story_v_out_416232.awb")

						arg_163_1:RecordAudio("416232037", var_166_36)
						arg_163_1:RecordAudio("416232037", var_166_36)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416232", "416232037", "story_v_out_416232.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416232", "416232037", "story_v_out_416232.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_37 = math.max(var_166_28, arg_163_1.talkMaxDuration)

			if var_166_27 <= arg_163_1.time_ and arg_163_1.time_ < var_166_27 + var_166_37 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_27) / var_166_37

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_27 + var_166_37 and arg_163_1.time_ < var_166_27 + var_166_37 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play416232038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416232038
		arg_167_1.duration_ = 9.73

		local var_167_0 = {
			zh = 4.233,
			ja = 9.733
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
				arg_167_0:Play416232039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.55

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[1080].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(416232038)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232038", "story_v_out_416232.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232038", "story_v_out_416232.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_416232", "416232038", "story_v_out_416232.awb")

						arg_167_1:RecordAudio("416232038", var_170_9)
						arg_167_1:RecordAudio("416232038", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416232", "416232038", "story_v_out_416232.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416232", "416232038", "story_v_out_416232.awb")
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
	Play416232039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416232039
		arg_171_1.duration_ = 10.2

		local var_171_0 = {
			zh = 7.133,
			ja = 10.2
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
				arg_171_0:Play416232040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.825

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1080].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(416232039)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 33
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232039", "story_v_out_416232.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232039", "story_v_out_416232.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_416232", "416232039", "story_v_out_416232.awb")

						arg_171_1:RecordAudio("416232039", var_174_9)
						arg_171_1:RecordAudio("416232039", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416232", "416232039", "story_v_out_416232.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416232", "416232039", "story_v_out_416232.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play416232040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416232040
		arg_175_1.duration_ = 8.63

		local var_175_0 = {
			zh = 7.366,
			ja = 8.633
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
				arg_175_0:Play416232041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1086"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1086 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1086", 4)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "split_6" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(390, -404.2, -237.9)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1086, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_178_7 = 0
			local var_178_8 = 0.875

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_9 = arg_175_1:FormatText(StoryNameCfg[1080].name)

				arg_175_1.leftNameTxt_.text = var_178_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(416232040)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_12 = 35
				local var_178_13 = utf8.len(var_178_11)
				local var_178_14 = var_178_12 <= 0 and var_178_8 or var_178_8 * (var_178_13 / var_178_12)

				if var_178_14 > 0 and var_178_8 < var_178_14 then
					arg_175_1.talkMaxDuration = var_178_14

					if var_178_14 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_7
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232040", "story_v_out_416232.awb") ~= 0 then
					local var_178_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232040", "story_v_out_416232.awb") / 1000

					if var_178_15 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_7
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_416232", "416232040", "story_v_out_416232.awb")

						arg_175_1:RecordAudio("416232040", var_178_16)
						arg_175_1:RecordAudio("416232040", var_178_16)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416232", "416232040", "story_v_out_416232.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416232", "416232040", "story_v_out_416232.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_17 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_17 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_7) / var_178_17

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_7 + var_178_17 and arg_175_1.time_ < var_178_7 + var_178_17 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play416232041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416232041
		arg_179_1.duration_ = 7.5

		local var_179_0 = {
			zh = 6.3,
			ja = 7.5
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
				arg_179_0:Play416232042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10127"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10127 == nil then
				arg_179_1.var_.actorSpriteComps10127 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps10127 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 1, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10127 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10127 = nil
			end

			local var_182_8 = arg_179_1.actors_["1086"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1086 == nil then
				arg_179_1.var_.actorSpriteComps1086 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.2

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps1086 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_12 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, var_182_11)
								local var_182_13 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, var_182_11)
								local var_182_14 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, var_182_11)

								iter_182_5.color = Color.New(var_182_12, var_182_13, var_182_14)
							else
								local var_182_15 = Mathf.Lerp(iter_182_5.color.r, 0.5, var_182_11)

								iter_182_5.color = Color.New(var_182_15, var_182_15, var_182_15)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1086 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1086 = nil
			end

			local var_182_16 = arg_179_1.actors_["1028"].transform
			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.var_.moveOldPos1028 = var_182_16.localPosition
				var_182_16.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1028", 7)

				local var_182_18 = var_182_16.childCount

				for iter_182_8 = 0, var_182_18 - 1 do
					local var_182_19 = var_182_16:GetChild(iter_182_8)

					if var_182_19.name == "" or not string.find(var_182_19.name, "split") then
						var_182_19.gameObject:SetActive(true)
					else
						var_182_19.gameObject:SetActive(false)
					end
				end
			end

			local var_182_20 = 0.001

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_20 then
				local var_182_21 = (arg_179_1.time_ - var_182_17) / var_182_20
				local var_182_22 = Vector3.New(0, -2000, 0)

				var_182_16.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1028, var_182_22, var_182_21)
			end

			if arg_179_1.time_ >= var_182_17 + var_182_20 and arg_179_1.time_ < var_182_17 + var_182_20 + arg_182_0 then
				var_182_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_182_23 = arg_179_1.actors_["10127"].transform
			local var_182_24 = 0

			if var_182_24 < arg_179_1.time_ and arg_179_1.time_ <= var_182_24 + arg_182_0 then
				arg_179_1.var_.moveOldPos10127 = var_182_23.localPosition
				var_182_23.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10127", 2)

				local var_182_25 = var_182_23.childCount

				for iter_182_9 = 0, var_182_25 - 1 do
					local var_182_26 = var_182_23:GetChild(iter_182_9)

					if var_182_26.name == "" or not string.find(var_182_26.name, "split") then
						var_182_26.gameObject:SetActive(true)
					else
						var_182_26.gameObject:SetActive(false)
					end
				end
			end

			local var_182_27 = 0.001

			if var_182_24 <= arg_179_1.time_ and arg_179_1.time_ < var_182_24 + var_182_27 then
				local var_182_28 = (arg_179_1.time_ - var_182_24) / var_182_27
				local var_182_29 = Vector3.New(-390, -387.4, -316.5)

				var_182_23.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10127, var_182_29, var_182_28)
			end

			if arg_179_1.time_ >= var_182_24 + var_182_27 and arg_179_1.time_ < var_182_24 + var_182_27 + arg_182_0 then
				var_182_23.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_182_30 = 0
			local var_182_31 = 0.825

			if var_182_30 < arg_179_1.time_ and arg_179_1.time_ <= var_182_30 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_32 = arg_179_1:FormatText(StoryNameCfg[236].name)

				arg_179_1.leftNameTxt_.text = var_182_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_33 = arg_179_1:GetWordFromCfg(416232041)
				local var_182_34 = arg_179_1:FormatText(var_182_33.content)

				arg_179_1.text_.text = var_182_34

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_35 = 34
				local var_182_36 = utf8.len(var_182_34)
				local var_182_37 = var_182_35 <= 0 and var_182_31 or var_182_31 * (var_182_36 / var_182_35)

				if var_182_37 > 0 and var_182_31 < var_182_37 then
					arg_179_1.talkMaxDuration = var_182_37

					if var_182_37 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_37 + var_182_30
					end
				end

				arg_179_1.text_.text = var_182_34
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232041", "story_v_out_416232.awb") ~= 0 then
					local var_182_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232041", "story_v_out_416232.awb") / 1000

					if var_182_38 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_38 + var_182_30
					end

					if var_182_33.prefab_name ~= "" and arg_179_1.actors_[var_182_33.prefab_name] ~= nil then
						local var_182_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_33.prefab_name].transform, "story_v_out_416232", "416232041", "story_v_out_416232.awb")

						arg_179_1:RecordAudio("416232041", var_182_39)
						arg_179_1:RecordAudio("416232041", var_182_39)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416232", "416232041", "story_v_out_416232.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416232", "416232041", "story_v_out_416232.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_40 = math.max(var_182_31, arg_179_1.talkMaxDuration)

			if var_182_30 <= arg_179_1.time_ and arg_179_1.time_ < var_182_30 + var_182_40 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_30) / var_182_40

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_30 + var_182_40 and arg_179_1.time_ < var_182_30 + var_182_40 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play416232042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416232042
		arg_183_1.duration_ = 7.87

		local var_183_0 = {
			zh = 4.7,
			ja = 7.866
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
				arg_183_0:Play416232043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.725

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[236].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(416232042)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 29
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232042", "story_v_out_416232.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232042", "story_v_out_416232.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_416232", "416232042", "story_v_out_416232.awb")

						arg_183_1:RecordAudio("416232042", var_186_9)
						arg_183_1:RecordAudio("416232042", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416232", "416232042", "story_v_out_416232.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416232", "416232042", "story_v_out_416232.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play416232043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416232043
		arg_187_1.duration_ = 4.5

		local var_187_0 = {
			zh = 4.5,
			ja = 3.8
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
				arg_187_0:Play416232044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1086"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps1086 == nil then
				arg_187_1.var_.actorSpriteComps1086 = var_190_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.actorSpriteComps1086 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								local var_190_4 = Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, var_190_3)
								local var_190_5 = Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, var_190_3)
								local var_190_6 = Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, var_190_3)

								iter_190_1.color = Color.New(var_190_4, var_190_5, var_190_6)
							else
								local var_190_7 = Mathf.Lerp(iter_190_1.color.r, 1, var_190_3)

								iter_190_1.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps1086 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_190_3 then
						if arg_187_1.isInRecall_ then
							iter_190_3.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1086 = nil
			end

			local var_190_8 = arg_187_1.actors_["10127"]
			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10127 == nil then
				arg_187_1.var_.actorSpriteComps10127 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_10 = 0.2

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 and not isNil(var_190_8) then
				local var_190_11 = (arg_187_1.time_ - var_190_9) / var_190_10

				if arg_187_1.var_.actorSpriteComps10127 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_190_5 then
							if arg_187_1.isInRecall_ then
								local var_190_12 = Mathf.Lerp(iter_190_5.color.r, arg_187_1.hightColor2.r, var_190_11)
								local var_190_13 = Mathf.Lerp(iter_190_5.color.g, arg_187_1.hightColor2.g, var_190_11)
								local var_190_14 = Mathf.Lerp(iter_190_5.color.b, arg_187_1.hightColor2.b, var_190_11)

								iter_190_5.color = Color.New(var_190_12, var_190_13, var_190_14)
							else
								local var_190_15 = Mathf.Lerp(iter_190_5.color.r, 0.5, var_190_11)

								iter_190_5.color = Color.New(var_190_15, var_190_15, var_190_15)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10127 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_190_7 then
						if arg_187_1.isInRecall_ then
							iter_190_7.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10127 = nil
			end

			local var_190_16 = 0
			local var_190_17 = 0.575

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_18 = arg_187_1:FormatText(StoryNameCfg[1080].name)

				arg_187_1.leftNameTxt_.text = var_190_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_19 = arg_187_1:GetWordFromCfg(416232043)
				local var_190_20 = arg_187_1:FormatText(var_190_19.content)

				arg_187_1.text_.text = var_190_20

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_21 = 23
				local var_190_22 = utf8.len(var_190_20)
				local var_190_23 = var_190_21 <= 0 and var_190_17 or var_190_17 * (var_190_22 / var_190_21)

				if var_190_23 > 0 and var_190_17 < var_190_23 then
					arg_187_1.talkMaxDuration = var_190_23

					if var_190_23 + var_190_16 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_16
					end
				end

				arg_187_1.text_.text = var_190_20
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232043", "story_v_out_416232.awb") ~= 0 then
					local var_190_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232043", "story_v_out_416232.awb") / 1000

					if var_190_24 + var_190_16 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_24 + var_190_16
					end

					if var_190_19.prefab_name ~= "" and arg_187_1.actors_[var_190_19.prefab_name] ~= nil then
						local var_190_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_19.prefab_name].transform, "story_v_out_416232", "416232043", "story_v_out_416232.awb")

						arg_187_1:RecordAudio("416232043", var_190_25)
						arg_187_1:RecordAudio("416232043", var_190_25)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416232", "416232043", "story_v_out_416232.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416232", "416232043", "story_v_out_416232.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_26 = math.max(var_190_17, arg_187_1.talkMaxDuration)

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_26 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_16) / var_190_26

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_16 + var_190_26 and arg_187_1.time_ < var_190_16 + var_190_26 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play416232044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416232044
		arg_191_1.duration_ = 2.9

		local var_191_0 = {
			zh = 2.9,
			ja = 2
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
				arg_191_0:Play416232045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1086"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1086 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1086", 4)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(390, -404.2, -237.9)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1086, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_194_7 = 0
			local var_194_8 = 0.325

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_9 = arg_191_1:FormatText(StoryNameCfg[1080].name)

				arg_191_1.leftNameTxt_.text = var_194_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(416232044)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_12 = 13
				local var_194_13 = utf8.len(var_194_11)
				local var_194_14 = var_194_12 <= 0 and var_194_8 or var_194_8 * (var_194_13 / var_194_12)

				if var_194_14 > 0 and var_194_8 < var_194_14 then
					arg_191_1.talkMaxDuration = var_194_14

					if var_194_14 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232044", "story_v_out_416232.awb") ~= 0 then
					local var_194_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232044", "story_v_out_416232.awb") / 1000

					if var_194_15 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_15 + var_194_7
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_416232", "416232044", "story_v_out_416232.awb")

						arg_191_1:RecordAudio("416232044", var_194_16)
						arg_191_1:RecordAudio("416232044", var_194_16)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416232", "416232044", "story_v_out_416232.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416232", "416232044", "story_v_out_416232.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_17 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_17 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_17

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_17 and arg_191_1.time_ < var_194_7 + var_194_17 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play416232045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416232045
		arg_195_1.duration_ = 6.7

		local var_195_0 = {
			zh = 3.9,
			ja = 6.7
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
				arg_195_0:Play416232046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1028"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1028 == nil then
				arg_195_1.var_.actorSpriteComps1028 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps1028 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 1, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1028 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1028 = nil
			end

			local var_198_8 = arg_195_1.actors_["1086"]
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps1086 == nil then
				arg_195_1.var_.actorSpriteComps1086 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_10 = 0.2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 and not isNil(var_198_8) then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10

				if arg_195_1.var_.actorSpriteComps1086 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								local var_198_12 = Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, var_198_11)
								local var_198_13 = Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, var_198_11)
								local var_198_14 = Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, var_198_11)

								iter_198_5.color = Color.New(var_198_12, var_198_13, var_198_14)
							else
								local var_198_15 = Mathf.Lerp(iter_198_5.color.r, 0.5, var_198_11)

								iter_198_5.color = Color.New(var_198_15, var_198_15, var_198_15)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps1086 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_198_7 then
						if arg_195_1.isInRecall_ then
							iter_198_7.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1086 = nil
			end

			local var_198_16 = arg_195_1.actors_["10127"].transform
			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.var_.moveOldPos10127 = var_198_16.localPosition
				var_198_16.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10127", 7)

				local var_198_18 = var_198_16.childCount

				for iter_198_8 = 0, var_198_18 - 1 do
					local var_198_19 = var_198_16:GetChild(iter_198_8)

					if var_198_19.name == "" or not string.find(var_198_19.name, "split") then
						var_198_19.gameObject:SetActive(true)
					else
						var_198_19.gameObject:SetActive(false)
					end
				end
			end

			local var_198_20 = 0.001

			if var_198_17 <= arg_195_1.time_ and arg_195_1.time_ < var_198_17 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_17) / var_198_20
				local var_198_22 = Vector3.New(0, -2000, 0)

				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10127, var_198_22, var_198_21)
			end

			if arg_195_1.time_ >= var_198_17 + var_198_20 and arg_195_1.time_ < var_198_17 + var_198_20 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_23 = arg_195_1.actors_["1028"].transform
			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1.var_.moveOldPos1028 = var_198_23.localPosition
				var_198_23.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1028", 2)

				local var_198_25 = var_198_23.childCount

				for iter_198_9 = 0, var_198_25 - 1 do
					local var_198_26 = var_198_23:GetChild(iter_198_9)

					if var_198_26.name == "" or not string.find(var_198_26.name, "split") then
						var_198_26.gameObject:SetActive(true)
					else
						var_198_26.gameObject:SetActive(false)
					end
				end
			end

			local var_198_27 = 0.001

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_27 then
				local var_198_28 = (arg_195_1.time_ - var_198_24) / var_198_27
				local var_198_29 = Vector3.New(-390, -402.7, -156.1)

				var_198_23.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1028, var_198_29, var_198_28)
			end

			if arg_195_1.time_ >= var_198_24 + var_198_27 and arg_195_1.time_ < var_198_24 + var_198_27 + arg_198_0 then
				var_198_23.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_198_30 = 0
			local var_198_31 = 0.475

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_32 = arg_195_1:FormatText(StoryNameCfg[327].name)

				arg_195_1.leftNameTxt_.text = var_198_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_33 = arg_195_1:GetWordFromCfg(416232045)
				local var_198_34 = arg_195_1:FormatText(var_198_33.content)

				arg_195_1.text_.text = var_198_34

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_35 = 19
				local var_198_36 = utf8.len(var_198_34)
				local var_198_37 = var_198_35 <= 0 and var_198_31 or var_198_31 * (var_198_36 / var_198_35)

				if var_198_37 > 0 and var_198_31 < var_198_37 then
					arg_195_1.talkMaxDuration = var_198_37

					if var_198_37 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_37 + var_198_30
					end
				end

				arg_195_1.text_.text = var_198_34
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232045", "story_v_out_416232.awb") ~= 0 then
					local var_198_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232045", "story_v_out_416232.awb") / 1000

					if var_198_38 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_38 + var_198_30
					end

					if var_198_33.prefab_name ~= "" and arg_195_1.actors_[var_198_33.prefab_name] ~= nil then
						local var_198_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_33.prefab_name].transform, "story_v_out_416232", "416232045", "story_v_out_416232.awb")

						arg_195_1:RecordAudio("416232045", var_198_39)
						arg_195_1:RecordAudio("416232045", var_198_39)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416232", "416232045", "story_v_out_416232.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416232", "416232045", "story_v_out_416232.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_40 = math.max(var_198_31, arg_195_1.talkMaxDuration)

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_40 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_40

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_40 and arg_195_1.time_ < var_198_30 + var_198_40 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416232046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416232046
		arg_199_1.duration_ = 5.53

		local var_199_0 = {
			zh = 4,
			ja = 5.533
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
				arg_199_0:Play416232047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1086"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1086 == nil then
				arg_199_1.var_.actorSpriteComps1086 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps1086 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 1, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1086 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1086 = nil
			end

			local var_202_8 = arg_199_1.actors_["1028"]
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps1028 == nil then
				arg_199_1.var_.actorSpriteComps1028 = var_202_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_10 = 0.2

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_10 and not isNil(var_202_8) then
				local var_202_11 = (arg_199_1.time_ - var_202_9) / var_202_10

				if arg_199_1.var_.actorSpriteComps1028 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								local var_202_12 = Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor2.r, var_202_11)
								local var_202_13 = Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor2.g, var_202_11)
								local var_202_14 = Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor2.b, var_202_11)

								iter_202_5.color = Color.New(var_202_12, var_202_13, var_202_14)
							else
								local var_202_15 = Mathf.Lerp(iter_202_5.color.r, 0.5, var_202_11)

								iter_202_5.color = Color.New(var_202_15, var_202_15, var_202_15)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_9 + var_202_10 and arg_199_1.time_ < var_202_9 + var_202_10 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps1028 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_202_7 then
						if arg_199_1.isInRecall_ then
							iter_202_7.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1028 = nil
			end

			local var_202_16 = 0
			local var_202_17 = 0.4

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_18 = arg_199_1:FormatText(StoryNameCfg[1080].name)

				arg_199_1.leftNameTxt_.text = var_202_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_19 = arg_199_1:GetWordFromCfg(416232046)
				local var_202_20 = arg_199_1:FormatText(var_202_19.content)

				arg_199_1.text_.text = var_202_20

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_21 = 16
				local var_202_22 = utf8.len(var_202_20)
				local var_202_23 = var_202_21 <= 0 and var_202_17 or var_202_17 * (var_202_22 / var_202_21)

				if var_202_23 > 0 and var_202_17 < var_202_23 then
					arg_199_1.talkMaxDuration = var_202_23

					if var_202_23 + var_202_16 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_16
					end
				end

				arg_199_1.text_.text = var_202_20
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232046", "story_v_out_416232.awb") ~= 0 then
					local var_202_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232046", "story_v_out_416232.awb") / 1000

					if var_202_24 + var_202_16 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_24 + var_202_16
					end

					if var_202_19.prefab_name ~= "" and arg_199_1.actors_[var_202_19.prefab_name] ~= nil then
						local var_202_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_19.prefab_name].transform, "story_v_out_416232", "416232046", "story_v_out_416232.awb")

						arg_199_1:RecordAudio("416232046", var_202_25)
						arg_199_1:RecordAudio("416232046", var_202_25)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416232", "416232046", "story_v_out_416232.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416232", "416232046", "story_v_out_416232.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_26 = math.max(var_202_17, arg_199_1.talkMaxDuration)

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_26 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_16) / var_202_26

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_16 + var_202_26 and arg_199_1.time_ < var_202_16 + var_202_26 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416232047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416232047
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416232048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1086"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1086 == nil then
				arg_203_1.var_.actorSpriteComps1086 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps1086 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 0.5, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1086 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1086 = nil
			end

			local var_206_8 = arg_203_1.actors_["1028"].transform
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.var_.moveOldPos1028 = var_206_8.localPosition
				var_206_8.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1028", 7)

				local var_206_10 = var_206_8.childCount

				for iter_206_4 = 0, var_206_10 - 1 do
					local var_206_11 = var_206_8:GetChild(iter_206_4)

					if var_206_11.name == "" or not string.find(var_206_11.name, "split") then
						var_206_11.gameObject:SetActive(true)
					else
						var_206_11.gameObject:SetActive(false)
					end
				end
			end

			local var_206_12 = 0.001

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_9) / var_206_12
				local var_206_14 = Vector3.New(0, -2000, 0)

				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1028, var_206_14, var_206_13)
			end

			if arg_203_1.time_ >= var_206_9 + var_206_12 and arg_203_1.time_ < var_206_9 + var_206_12 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_15 = arg_203_1.actors_["1086"].transform
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.var_.moveOldPos1086 = var_206_15.localPosition
				var_206_15.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1086", 7)

				local var_206_17 = var_206_15.childCount

				for iter_206_5 = 0, var_206_17 - 1 do
					local var_206_18 = var_206_15:GetChild(iter_206_5)

					if var_206_18.name == "" or not string.find(var_206_18.name, "split") then
						var_206_18.gameObject:SetActive(true)
					else
						var_206_18.gameObject:SetActive(false)
					end
				end
			end

			local var_206_19 = 0.001

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_19 then
				local var_206_20 = (arg_203_1.time_ - var_206_16) / var_206_19
				local var_206_21 = Vector3.New(0, -2000, 0)

				var_206_15.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1086, var_206_21, var_206_20)
			end

			if arg_203_1.time_ >= var_206_16 + var_206_19 and arg_203_1.time_ < var_206_16 + var_206_19 + arg_206_0 then
				var_206_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_22 = 0
			local var_206_23 = 0.825

			if var_206_22 < arg_203_1.time_ and arg_203_1.time_ <= var_206_22 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_24 = arg_203_1:GetWordFromCfg(416232047)
				local var_206_25 = arg_203_1:FormatText(var_206_24.content)

				arg_203_1.text_.text = var_206_25

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 33
				local var_206_27 = utf8.len(var_206_25)
				local var_206_28 = var_206_26 <= 0 and var_206_23 or var_206_23 * (var_206_27 / var_206_26)

				if var_206_28 > 0 and var_206_23 < var_206_28 then
					arg_203_1.talkMaxDuration = var_206_28

					if var_206_28 + var_206_22 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_28 + var_206_22
					end
				end

				arg_203_1.text_.text = var_206_25
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_29 = math.max(var_206_23, arg_203_1.talkMaxDuration)

			if var_206_22 <= arg_203_1.time_ and arg_203_1.time_ < var_206_22 + var_206_29 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_22) / var_206_29

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_22 + var_206_29 and arg_203_1.time_ < var_206_22 + var_206_29 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play416232048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416232048
		arg_207_1.duration_ = 6.5

		local var_207_0 = {
			zh = 3.2,
			ja = 6.5
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
				arg_207_0:Play416232049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10122"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10122 == nil then
				arg_207_1.var_.actorSpriteComps10122 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10122 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10122 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10122 = nil
			end

			local var_210_8 = arg_207_1.actors_["10122"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos10122 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10122", 2)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "split_5" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(-390, -380, -100)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10122, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_210_15 = 0
			local var_210_16 = 0.375

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

				local var_210_18 = arg_207_1:GetWordFromCfg(416232048)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232048", "story_v_out_416232.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232048", "story_v_out_416232.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_416232", "416232048", "story_v_out_416232.awb")

						arg_207_1:RecordAudio("416232048", var_210_24)
						arg_207_1:RecordAudio("416232048", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416232", "416232048", "story_v_out_416232.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416232", "416232048", "story_v_out_416232.awb")
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
				actorName = "10122",
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
	Play416232049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416232049
		arg_211_1.duration_ = 5.2

		local var_211_0 = {
			zh = 3,
			ja = 5.2
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
				arg_211_0:Play416232050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10127"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10127 == nil then
				arg_211_1.var_.actorSpriteComps10127 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps10127 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 1, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10127 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10127 = nil
			end

			local var_214_8 = arg_211_1.actors_["10122"]
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.actorSpriteComps10122 == nil then
				arg_211_1.var_.actorSpriteComps10122 = var_214_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_10 = 0.2

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_10 and not isNil(var_214_8) then
				local var_214_11 = (arg_211_1.time_ - var_214_9) / var_214_10

				if arg_211_1.var_.actorSpriteComps10122 then
					for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_214_5 then
							if arg_211_1.isInRecall_ then
								local var_214_12 = Mathf.Lerp(iter_214_5.color.r, arg_211_1.hightColor2.r, var_214_11)
								local var_214_13 = Mathf.Lerp(iter_214_5.color.g, arg_211_1.hightColor2.g, var_214_11)
								local var_214_14 = Mathf.Lerp(iter_214_5.color.b, arg_211_1.hightColor2.b, var_214_11)

								iter_214_5.color = Color.New(var_214_12, var_214_13, var_214_14)
							else
								local var_214_15 = Mathf.Lerp(iter_214_5.color.r, 0.5, var_214_11)

								iter_214_5.color = Color.New(var_214_15, var_214_15, var_214_15)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_9 + var_214_10 and arg_211_1.time_ < var_214_9 + var_214_10 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.actorSpriteComps10122 then
				for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_214_7 then
						if arg_211_1.isInRecall_ then
							iter_214_7.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10122 = nil
			end

			local var_214_16 = arg_211_1.actors_["10127"].transform
			local var_214_17 = 0

			if var_214_17 < arg_211_1.time_ and arg_211_1.time_ <= var_214_17 + arg_214_0 then
				arg_211_1.var_.moveOldPos10127 = var_214_16.localPosition
				var_214_16.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10127", 4)

				local var_214_18 = var_214_16.childCount

				for iter_214_8 = 0, var_214_18 - 1 do
					local var_214_19 = var_214_16:GetChild(iter_214_8)

					if var_214_19.name == "" or not string.find(var_214_19.name, "split") then
						var_214_19.gameObject:SetActive(true)
					else
						var_214_19.gameObject:SetActive(false)
					end
				end
			end

			local var_214_20 = 0.001

			if var_214_17 <= arg_211_1.time_ and arg_211_1.time_ < var_214_17 + var_214_20 then
				local var_214_21 = (arg_211_1.time_ - var_214_17) / var_214_20
				local var_214_22 = Vector3.New(345, -387.4, -316.5)

				var_214_16.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10127, var_214_22, var_214_21)
			end

			if arg_211_1.time_ >= var_214_17 + var_214_20 and arg_211_1.time_ < var_214_17 + var_214_20 + arg_214_0 then
				var_214_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_214_23 = 0
			local var_214_24 = 0.425

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_25 = arg_211_1:FormatText(StoryNameCfg[236].name)

				arg_211_1.leftNameTxt_.text = var_214_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_26 = arg_211_1:GetWordFromCfg(416232049)
				local var_214_27 = arg_211_1:FormatText(var_214_26.content)

				arg_211_1.text_.text = var_214_27

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_28 = 17
				local var_214_29 = utf8.len(var_214_27)
				local var_214_30 = var_214_28 <= 0 and var_214_24 or var_214_24 * (var_214_29 / var_214_28)

				if var_214_30 > 0 and var_214_24 < var_214_30 then
					arg_211_1.talkMaxDuration = var_214_30

					if var_214_30 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_30 + var_214_23
					end
				end

				arg_211_1.text_.text = var_214_27
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232049", "story_v_out_416232.awb") ~= 0 then
					local var_214_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232049", "story_v_out_416232.awb") / 1000

					if var_214_31 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_31 + var_214_23
					end

					if var_214_26.prefab_name ~= "" and arg_211_1.actors_[var_214_26.prefab_name] ~= nil then
						local var_214_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_26.prefab_name].transform, "story_v_out_416232", "416232049", "story_v_out_416232.awb")

						arg_211_1:RecordAudio("416232049", var_214_32)
						arg_211_1:RecordAudio("416232049", var_214_32)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416232", "416232049", "story_v_out_416232.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416232", "416232049", "story_v_out_416232.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_33 = math.max(var_214_24, arg_211_1.talkMaxDuration)

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_33 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_23) / var_214_33

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_23 + var_214_33 and arg_211_1.time_ < var_214_23 + var_214_33 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play416232050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416232050
		arg_215_1.duration_ = 4.63

		local var_215_0 = {
			zh = 4.633,
			ja = 4.6
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
				arg_215_0:Play416232051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10122"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10122 == nil then
				arg_215_1.var_.actorSpriteComps10122 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps10122 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10122 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10122 = nil
			end

			local var_218_8 = arg_215_1.actors_["10127"]
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 and not isNil(var_218_8) and arg_215_1.var_.actorSpriteComps10127 == nil then
				arg_215_1.var_.actorSpriteComps10127 = var_218_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_10 = 0.2

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_10 and not isNil(var_218_8) then
				local var_218_11 = (arg_215_1.time_ - var_218_9) / var_218_10

				if arg_215_1.var_.actorSpriteComps10127 then
					for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_218_5 then
							if arg_215_1.isInRecall_ then
								local var_218_12 = Mathf.Lerp(iter_218_5.color.r, arg_215_1.hightColor2.r, var_218_11)
								local var_218_13 = Mathf.Lerp(iter_218_5.color.g, arg_215_1.hightColor2.g, var_218_11)
								local var_218_14 = Mathf.Lerp(iter_218_5.color.b, arg_215_1.hightColor2.b, var_218_11)

								iter_218_5.color = Color.New(var_218_12, var_218_13, var_218_14)
							else
								local var_218_15 = Mathf.Lerp(iter_218_5.color.r, 0.5, var_218_11)

								iter_218_5.color = Color.New(var_218_15, var_218_15, var_218_15)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_9 + var_218_10 and arg_215_1.time_ < var_218_9 + var_218_10 + arg_218_0 and not isNil(var_218_8) and arg_215_1.var_.actorSpriteComps10127 then
				for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_218_7 then
						if arg_215_1.isInRecall_ then
							iter_218_7.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10127 = nil
			end

			local var_218_16 = arg_215_1.actors_["10122"].transform
			local var_218_17 = 0

			if var_218_17 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.var_.moveOldPos10122 = var_218_16.localPosition
				var_218_16.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10122", 2)

				local var_218_18 = var_218_16.childCount

				for iter_218_8 = 0, var_218_18 - 1 do
					local var_218_19 = var_218_16:GetChild(iter_218_8)

					if var_218_19.name == "split_4" or not string.find(var_218_19.name, "split") then
						var_218_19.gameObject:SetActive(true)
					else
						var_218_19.gameObject:SetActive(false)
					end
				end
			end

			local var_218_20 = 0.001

			if var_218_17 <= arg_215_1.time_ and arg_215_1.time_ < var_218_17 + var_218_20 then
				local var_218_21 = (arg_215_1.time_ - var_218_17) / var_218_20
				local var_218_22 = Vector3.New(-390, -380, -100)

				var_218_16.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10122, var_218_22, var_218_21)
			end

			if arg_215_1.time_ >= var_218_17 + var_218_20 and arg_215_1.time_ < var_218_17 + var_218_20 + arg_218_0 then
				var_218_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_218_23 = 0
			local var_218_24 = 0.55

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_25 = arg_215_1:FormatText(StoryNameCfg[8].name)

				arg_215_1.leftNameTxt_.text = var_218_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(416232050)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 22
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_24 or var_218_24 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_24 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_23
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232050", "story_v_out_416232.awb") ~= 0 then
					local var_218_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232050", "story_v_out_416232.awb") / 1000

					if var_218_31 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_23
					end

					if var_218_26.prefab_name ~= "" and arg_215_1.actors_[var_218_26.prefab_name] ~= nil then
						local var_218_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_26.prefab_name].transform, "story_v_out_416232", "416232050", "story_v_out_416232.awb")

						arg_215_1:RecordAudio("416232050", var_218_32)
						arg_215_1:RecordAudio("416232050", var_218_32)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416232", "416232050", "story_v_out_416232.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416232", "416232050", "story_v_out_416232.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_33 = math.max(var_218_24, arg_215_1.talkMaxDuration)

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_33 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_33

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_33 and arg_215_1.time_ < var_218_23 + var_218_33 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play416232051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416232051
		arg_219_1.duration_ = 6.63

		local var_219_0 = {
			zh = 6.633,
			ja = 6.566
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416232052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.65

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[8].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(416232051)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 26
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232051", "story_v_out_416232.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232051", "story_v_out_416232.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_416232", "416232051", "story_v_out_416232.awb")

						arg_219_1:RecordAudio("416232051", var_222_9)
						arg_219_1:RecordAudio("416232051", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416232", "416232051", "story_v_out_416232.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416232", "416232051", "story_v_out_416232.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play416232052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416232052
		arg_223_1.duration_ = 8.57

		local var_223_0 = {
			zh = 3.8,
			ja = 8.566
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
				arg_223_0:Play416232053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10127"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10127 == nil then
				arg_223_1.var_.actorSpriteComps10127 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10127 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10127 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10127 = nil
			end

			local var_226_8 = arg_223_1.actors_["10122"]
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps10122 == nil then
				arg_223_1.var_.actorSpriteComps10122 = var_226_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_10 = 0.2

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 and not isNil(var_226_8) then
				local var_226_11 = (arg_223_1.time_ - var_226_9) / var_226_10

				if arg_223_1.var_.actorSpriteComps10122 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								local var_226_12 = Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, var_226_11)
								local var_226_13 = Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, var_226_11)
								local var_226_14 = Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, var_226_11)

								iter_226_5.color = Color.New(var_226_12, var_226_13, var_226_14)
							else
								local var_226_15 = Mathf.Lerp(iter_226_5.color.r, 0.5, var_226_11)

								iter_226_5.color = Color.New(var_226_15, var_226_15, var_226_15)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps10122 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_226_7 then
						if arg_223_1.isInRecall_ then
							iter_226_7.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10122 = nil
			end

			local var_226_16 = 0
			local var_226_17 = 0.55

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_18 = arg_223_1:FormatText(StoryNameCfg[236].name)

				arg_223_1.leftNameTxt_.text = var_226_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_19 = arg_223_1:GetWordFromCfg(416232052)
				local var_226_20 = arg_223_1:FormatText(var_226_19.content)

				arg_223_1.text_.text = var_226_20

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_21 = 22
				local var_226_22 = utf8.len(var_226_20)
				local var_226_23 = var_226_21 <= 0 and var_226_17 or var_226_17 * (var_226_22 / var_226_21)

				if var_226_23 > 0 and var_226_17 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23

					if var_226_23 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_16
					end
				end

				arg_223_1.text_.text = var_226_20
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232052", "story_v_out_416232.awb") ~= 0 then
					local var_226_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232052", "story_v_out_416232.awb") / 1000

					if var_226_24 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_16
					end

					if var_226_19.prefab_name ~= "" and arg_223_1.actors_[var_226_19.prefab_name] ~= nil then
						local var_226_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_19.prefab_name].transform, "story_v_out_416232", "416232052", "story_v_out_416232.awb")

						arg_223_1:RecordAudio("416232052", var_226_25)
						arg_223_1:RecordAudio("416232052", var_226_25)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416232", "416232052", "story_v_out_416232.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416232", "416232052", "story_v_out_416232.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_26 = math.max(var_226_17, arg_223_1.talkMaxDuration)

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_26 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_16) / var_226_26

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_16 + var_226_26 and arg_223_1.time_ < var_226_16 + var_226_26 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play416232053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416232053
		arg_227_1.duration_ = 5.47

		local var_227_0 = {
			zh = 5.4,
			ja = 5.466
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
				arg_227_0:Play416232054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10122"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10122 == nil then
				arg_227_1.var_.actorSpriteComps10122 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps10122 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10122 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10122 = nil
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

			local var_230_16 = 0
			local var_230_17 = 0.675

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_18 = arg_227_1:FormatText(StoryNameCfg[8].name)

				arg_227_1.leftNameTxt_.text = var_230_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_19 = arg_227_1:GetWordFromCfg(416232053)
				local var_230_20 = arg_227_1:FormatText(var_230_19.content)

				arg_227_1.text_.text = var_230_20

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_21 = 27
				local var_230_22 = utf8.len(var_230_20)
				local var_230_23 = var_230_21 <= 0 and var_230_17 or var_230_17 * (var_230_22 / var_230_21)

				if var_230_23 > 0 and var_230_17 < var_230_23 then
					arg_227_1.talkMaxDuration = var_230_23

					if var_230_23 + var_230_16 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_16
					end
				end

				arg_227_1.text_.text = var_230_20
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232053", "story_v_out_416232.awb") ~= 0 then
					local var_230_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232053", "story_v_out_416232.awb") / 1000

					if var_230_24 + var_230_16 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_24 + var_230_16
					end

					if var_230_19.prefab_name ~= "" and arg_227_1.actors_[var_230_19.prefab_name] ~= nil then
						local var_230_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_19.prefab_name].transform, "story_v_out_416232", "416232053", "story_v_out_416232.awb")

						arg_227_1:RecordAudio("416232053", var_230_25)
						arg_227_1:RecordAudio("416232053", var_230_25)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416232", "416232053", "story_v_out_416232.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416232", "416232053", "story_v_out_416232.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_26 = math.max(var_230_17, arg_227_1.talkMaxDuration)

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_26 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_16) / var_230_26

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_16 + var_230_26 and arg_227_1.time_ < var_230_16 + var_230_26 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416232054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416232054
		arg_231_1.duration_ = 6.4

		local var_231_0 = {
			zh = 4.4,
			ja = 6.4
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
				arg_231_0:Play416232055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10122"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10122 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10122", 2)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "split_4" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(-390, -380, -100)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10122, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_234_7 = 0
			local var_234_8 = 0.375

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_9 = arg_231_1:FormatText(StoryNameCfg[8].name)

				arg_231_1.leftNameTxt_.text = var_234_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(416232054)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_12 = 15
				local var_234_13 = utf8.len(var_234_11)
				local var_234_14 = var_234_12 <= 0 and var_234_8 or var_234_8 * (var_234_13 / var_234_12)

				if var_234_14 > 0 and var_234_8 < var_234_14 then
					arg_231_1.talkMaxDuration = var_234_14

					if var_234_14 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_7
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232054", "story_v_out_416232.awb") ~= 0 then
					local var_234_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232054", "story_v_out_416232.awb") / 1000

					if var_234_15 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_7
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_416232", "416232054", "story_v_out_416232.awb")

						arg_231_1:RecordAudio("416232054", var_234_16)
						arg_231_1:RecordAudio("416232054", var_234_16)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416232", "416232054", "story_v_out_416232.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416232", "416232054", "story_v_out_416232.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_17 = math.max(var_234_8, arg_231_1.talkMaxDuration)

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_17 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_7) / var_234_17

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_7 + var_234_17 and arg_231_1.time_ < var_234_7 + var_234_17 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play416232055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416232055
		arg_235_1.duration_ = 6.1

		local var_235_0 = {
			zh = 5.233,
			ja = 6.1
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
				arg_235_0:Play416232056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10127"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10127 == nil then
				arg_235_1.var_.actorSpriteComps10127 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10127 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10127 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10127 = nil
			end

			local var_238_8 = arg_235_1.actors_["10122"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10122 == nil then
				arg_235_1.var_.actorSpriteComps10122 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps10122 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10122 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10122 = nil
			end

			local var_238_16 = 0
			local var_238_17 = 0.675

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_18 = arg_235_1:FormatText(StoryNameCfg[236].name)

				arg_235_1.leftNameTxt_.text = var_238_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_19 = arg_235_1:GetWordFromCfg(416232055)
				local var_238_20 = arg_235_1:FormatText(var_238_19.content)

				arg_235_1.text_.text = var_238_20

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_21 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232055", "story_v_out_416232.awb") ~= 0 then
					local var_238_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232055", "story_v_out_416232.awb") / 1000

					if var_238_24 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_16
					end

					if var_238_19.prefab_name ~= "" and arg_235_1.actors_[var_238_19.prefab_name] ~= nil then
						local var_238_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_19.prefab_name].transform, "story_v_out_416232", "416232055", "story_v_out_416232.awb")

						arg_235_1:RecordAudio("416232055", var_238_25)
						arg_235_1:RecordAudio("416232055", var_238_25)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416232", "416232055", "story_v_out_416232.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416232", "416232055", "story_v_out_416232.awb")
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
	Play416232056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416232056
		arg_239_1.duration_ = 8.93

		local var_239_0 = {
			zh = 5.666,
			ja = 8.933
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
				arg_239_0:Play416232057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.8

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

				local var_242_3 = arg_239_1:GetWordFromCfg(416232056)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232056", "story_v_out_416232.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232056", "story_v_out_416232.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_416232", "416232056", "story_v_out_416232.awb")

						arg_239_1:RecordAudio("416232056", var_242_9)
						arg_239_1:RecordAudio("416232056", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416232", "416232056", "story_v_out_416232.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416232", "416232056", "story_v_out_416232.awb")
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
	Play416232057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416232057
		arg_243_1.duration_ = 5.73

		local var_243_0 = {
			zh = 3.766,
			ja = 5.733
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
				arg_243_0:Play416232058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10122"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10122 == nil then
				arg_243_1.var_.actorSpriteComps10122 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10122 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10122 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10122 = nil
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

			local var_246_16 = 0
			local var_246_17 = 0.4

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_18 = arg_243_1:FormatText(StoryNameCfg[8].name)

				arg_243_1.leftNameTxt_.text = var_246_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_19 = arg_243_1:GetWordFromCfg(416232057)
				local var_246_20 = arg_243_1:FormatText(var_246_19.content)

				arg_243_1.text_.text = var_246_20

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_21 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232057", "story_v_out_416232.awb") ~= 0 then
					local var_246_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232057", "story_v_out_416232.awb") / 1000

					if var_246_24 + var_246_16 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_24 + var_246_16
					end

					if var_246_19.prefab_name ~= "" and arg_243_1.actors_[var_246_19.prefab_name] ~= nil then
						local var_246_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_19.prefab_name].transform, "story_v_out_416232", "416232057", "story_v_out_416232.awb")

						arg_243_1:RecordAudio("416232057", var_246_25)
						arg_243_1:RecordAudio("416232057", var_246_25)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416232", "416232057", "story_v_out_416232.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416232", "416232057", "story_v_out_416232.awb")
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
	Play416232058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416232058
		arg_247_1.duration_ = 10.87

		local var_247_0 = {
			zh = 7.633,
			ja = 10.866
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
				arg_247_0:Play416232059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10127"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10127 == nil then
				arg_247_1.var_.actorSpriteComps10127 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10127 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10127 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10127 = nil
			end

			local var_250_8 = arg_247_1.actors_["10122"]
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10122 == nil then
				arg_247_1.var_.actorSpriteComps10122 = var_250_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_10 = 0.2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 and not isNil(var_250_8) then
				local var_250_11 = (arg_247_1.time_ - var_250_9) / var_250_10

				if arg_247_1.var_.actorSpriteComps10122 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10122 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10122 = nil
			end

			local var_250_16 = arg_247_1.actors_["10127"].transform
			local var_250_17 = 0

			if var_250_17 < arg_247_1.time_ and arg_247_1.time_ <= var_250_17 + arg_250_0 then
				arg_247_1.var_.moveOldPos10127 = var_250_16.localPosition
				var_250_16.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10127", 4)

				local var_250_18 = var_250_16.childCount

				for iter_250_8 = 0, var_250_18 - 1 do
					local var_250_19 = var_250_16:GetChild(iter_250_8)

					if var_250_19.name == "" or not string.find(var_250_19.name, "split") then
						var_250_19.gameObject:SetActive(true)
					else
						var_250_19.gameObject:SetActive(false)
					end
				end
			end

			local var_250_20 = 0.001

			if var_250_17 <= arg_247_1.time_ and arg_247_1.time_ < var_250_17 + var_250_20 then
				local var_250_21 = (arg_247_1.time_ - var_250_17) / var_250_20
				local var_250_22 = Vector3.New(345, -387.4, -316.5)

				var_250_16.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10127, var_250_22, var_250_21)
			end

			if arg_247_1.time_ >= var_250_17 + var_250_20 and arg_247_1.time_ < var_250_17 + var_250_20 + arg_250_0 then
				var_250_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_250_23 = 0
			local var_250_24 = 0.95

			if var_250_23 < arg_247_1.time_ and arg_247_1.time_ <= var_250_23 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_25 = arg_247_1:FormatText(StoryNameCfg[236].name)

				arg_247_1.leftNameTxt_.text = var_250_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_26 = arg_247_1:GetWordFromCfg(416232058)
				local var_250_27 = arg_247_1:FormatText(var_250_26.content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_28 = 38
				local var_250_29 = utf8.len(var_250_27)
				local var_250_30 = var_250_28 <= 0 and var_250_24 or var_250_24 * (var_250_29 / var_250_28)

				if var_250_30 > 0 and var_250_24 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30

					if var_250_30 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_23
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232058", "story_v_out_416232.awb") ~= 0 then
					local var_250_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232058", "story_v_out_416232.awb") / 1000

					if var_250_31 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_31 + var_250_23
					end

					if var_250_26.prefab_name ~= "" and arg_247_1.actors_[var_250_26.prefab_name] ~= nil then
						local var_250_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_26.prefab_name].transform, "story_v_out_416232", "416232058", "story_v_out_416232.awb")

						arg_247_1:RecordAudio("416232058", var_250_32)
						arg_247_1:RecordAudio("416232058", var_250_32)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416232", "416232058", "story_v_out_416232.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416232", "416232058", "story_v_out_416232.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_33 = math.max(var_250_24, arg_247_1.talkMaxDuration)

			if var_250_23 <= arg_247_1.time_ and arg_247_1.time_ < var_250_23 + var_250_33 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_23) / var_250_33

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_23 + var_250_33 and arg_247_1.time_ < var_250_23 + var_250_33 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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
	Play416232059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416232059
		arg_251_1.duration_ = 11.53

		local var_251_0 = {
			zh = 7.566,
			ja = 11.533
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
				arg_251_0:Play416232060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.8

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[236].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(416232059)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 32
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232059", "story_v_out_416232.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232059", "story_v_out_416232.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_416232", "416232059", "story_v_out_416232.awb")

						arg_251_1:RecordAudio("416232059", var_254_9)
						arg_251_1:RecordAudio("416232059", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416232", "416232059", "story_v_out_416232.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416232", "416232059", "story_v_out_416232.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416232060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416232060
		arg_255_1.duration_ = 3

		local var_255_0 = {
			zh = 3,
			ja = 2.666
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
				arg_255_0:Play416232061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10122"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10122 == nil then
				arg_255_1.var_.actorSpriteComps10122 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10122 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10122 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10122 = nil
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

			local var_258_16 = 0
			local var_258_17 = 0.275

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_18 = arg_255_1:FormatText(StoryNameCfg[8].name)

				arg_255_1.leftNameTxt_.text = var_258_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_19 = arg_255_1:GetWordFromCfg(416232060)
				local var_258_20 = arg_255_1:FormatText(var_258_19.content)

				arg_255_1.text_.text = var_258_20

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_21 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232060", "story_v_out_416232.awb") ~= 0 then
					local var_258_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232060", "story_v_out_416232.awb") / 1000

					if var_258_24 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_16
					end

					if var_258_19.prefab_name ~= "" and arg_255_1.actors_[var_258_19.prefab_name] ~= nil then
						local var_258_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_19.prefab_name].transform, "story_v_out_416232", "416232060", "story_v_out_416232.awb")

						arg_255_1:RecordAudio("416232060", var_258_25)
						arg_255_1:RecordAudio("416232060", var_258_25)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416232", "416232060", "story_v_out_416232.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416232", "416232060", "story_v_out_416232.awb")
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
	Play416232061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416232061
		arg_259_1.duration_ = 6.53

		local var_259_0 = {
			zh = 3.966,
			ja = 6.533
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
				arg_259_0:Play416232062(arg_259_1)
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

			local var_262_8 = arg_259_1.actors_["10122"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10122 == nil then
				arg_259_1.var_.actorSpriteComps10122 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps10122 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10122 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10122 = nil
			end

			local var_262_16 = arg_259_1.actors_["10127"].transform
			local var_262_17 = 0

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 then
				arg_259_1.var_.moveOldPos10127 = var_262_16.localPosition
				var_262_16.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10127", 4)

				local var_262_18 = var_262_16.childCount

				for iter_262_8 = 0, var_262_18 - 1 do
					local var_262_19 = var_262_16:GetChild(iter_262_8)

					if var_262_19.name == "split_2" or not string.find(var_262_19.name, "split") then
						var_262_19.gameObject:SetActive(true)
					else
						var_262_19.gameObject:SetActive(false)
					end
				end
			end

			local var_262_20 = 0.001

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_20 then
				local var_262_21 = (arg_259_1.time_ - var_262_17) / var_262_20
				local var_262_22 = Vector3.New(345, -387.4, -316.5)

				var_262_16.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10127, var_262_22, var_262_21)
			end

			if arg_259_1.time_ >= var_262_17 + var_262_20 and arg_259_1.time_ < var_262_17 + var_262_20 + arg_262_0 then
				var_262_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_262_23 = 0
			local var_262_24 = 0.575

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_25 = arg_259_1:FormatText(StoryNameCfg[236].name)

				arg_259_1.leftNameTxt_.text = var_262_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_26 = arg_259_1:GetWordFromCfg(416232061)
				local var_262_27 = arg_259_1:FormatText(var_262_26.content)

				arg_259_1.text_.text = var_262_27

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_28 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232061", "story_v_out_416232.awb") ~= 0 then
					local var_262_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232061", "story_v_out_416232.awb") / 1000

					if var_262_31 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_31 + var_262_23
					end

					if var_262_26.prefab_name ~= "" and arg_259_1.actors_[var_262_26.prefab_name] ~= nil then
						local var_262_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_26.prefab_name].transform, "story_v_out_416232", "416232061", "story_v_out_416232.awb")

						arg_259_1:RecordAudio("416232061", var_262_32)
						arg_259_1:RecordAudio("416232061", var_262_32)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416232", "416232061", "story_v_out_416232.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416232", "416232061", "story_v_out_416232.awb")
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
				actorName = "10127",
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
	Play416232062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416232062
		arg_263_1.duration_ = 8.37

		local var_263_0 = {
			zh = 4.633,
			ja = 8.366
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
				arg_263_0:Play416232063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10122"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10122 == nil then
				arg_263_1.var_.actorSpriteComps10122 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10122 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10122 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10122 = nil
			end

			local var_266_8 = arg_263_1.actors_["10127"]
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps10127 == nil then
				arg_263_1.var_.actorSpriteComps10127 = var_266_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_10 = 0.2

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 and not isNil(var_266_8) then
				local var_266_11 = (arg_263_1.time_ - var_266_9) / var_266_10

				if arg_263_1.var_.actorSpriteComps10127 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								local var_266_12 = Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, var_266_11)
								local var_266_13 = Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, var_266_11)
								local var_266_14 = Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, var_266_11)

								iter_266_5.color = Color.New(var_266_12, var_266_13, var_266_14)
							else
								local var_266_15 = Mathf.Lerp(iter_266_5.color.r, 0.5, var_266_11)

								iter_266_5.color = Color.New(var_266_15, var_266_15, var_266_15)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps10127 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_266_7 then
						if arg_263_1.isInRecall_ then
							iter_266_7.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10127 = nil
			end

			local var_266_16 = arg_263_1.actors_["10122"].transform
			local var_266_17 = 0

			if var_266_17 < arg_263_1.time_ and arg_263_1.time_ <= var_266_17 + arg_266_0 then
				arg_263_1.var_.moveOldPos10122 = var_266_16.localPosition
				var_266_16.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10122", 2)

				local var_266_18 = var_266_16.childCount

				for iter_266_8 = 0, var_266_18 - 1 do
					local var_266_19 = var_266_16:GetChild(iter_266_8)

					if var_266_19.name == "split_4" or not string.find(var_266_19.name, "split") then
						var_266_19.gameObject:SetActive(true)
					else
						var_266_19.gameObject:SetActive(false)
					end
				end
			end

			local var_266_20 = 0.001

			if var_266_17 <= arg_263_1.time_ and arg_263_1.time_ < var_266_17 + var_266_20 then
				local var_266_21 = (arg_263_1.time_ - var_266_17) / var_266_20
				local var_266_22 = Vector3.New(-390, -380, -100)

				var_266_16.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10122, var_266_22, var_266_21)
			end

			if arg_263_1.time_ >= var_266_17 + var_266_20 and arg_263_1.time_ < var_266_17 + var_266_20 + arg_266_0 then
				var_266_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_266_23 = 0
			local var_266_24 = 0.375

			if var_266_23 < arg_263_1.time_ and arg_263_1.time_ <= var_266_23 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_25 = arg_263_1:FormatText(StoryNameCfg[8].name)

				arg_263_1.leftNameTxt_.text = var_266_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_26 = arg_263_1:GetWordFromCfg(416232062)
				local var_266_27 = arg_263_1:FormatText(var_266_26.content)

				arg_263_1.text_.text = var_266_27

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_28 = 15
				local var_266_29 = utf8.len(var_266_27)
				local var_266_30 = var_266_28 <= 0 and var_266_24 or var_266_24 * (var_266_29 / var_266_28)

				if var_266_30 > 0 and var_266_24 < var_266_30 then
					arg_263_1.talkMaxDuration = var_266_30

					if var_266_30 + var_266_23 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_30 + var_266_23
					end
				end

				arg_263_1.text_.text = var_266_27
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232062", "story_v_out_416232.awb") ~= 0 then
					local var_266_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232062", "story_v_out_416232.awb") / 1000

					if var_266_31 + var_266_23 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_31 + var_266_23
					end

					if var_266_26.prefab_name ~= "" and arg_263_1.actors_[var_266_26.prefab_name] ~= nil then
						local var_266_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_26.prefab_name].transform, "story_v_out_416232", "416232062", "story_v_out_416232.awb")

						arg_263_1:RecordAudio("416232062", var_266_32)
						arg_263_1:RecordAudio("416232062", var_266_32)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416232", "416232062", "story_v_out_416232.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416232", "416232062", "story_v_out_416232.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_33 = math.max(var_266_24, arg_263_1.talkMaxDuration)

			if var_266_23 <= arg_263_1.time_ and arg_263_1.time_ < var_266_23 + var_266_33 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_23) / var_266_33

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_23 + var_266_33 and arg_263_1.time_ < var_266_23 + var_266_33 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play416232063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416232063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416232064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10122"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10122 == nil then
				arg_267_1.var_.actorSpriteComps10122 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10122 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 0.5, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10122 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10122 = nil
			end

			local var_270_8 = 0
			local var_270_9 = 0.8

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_10 = arg_267_1:GetWordFromCfg(416232063)
				local var_270_11 = arg_267_1:FormatText(var_270_10.content)

				arg_267_1.text_.text = var_270_11

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_12 = 32
				local var_270_13 = utf8.len(var_270_11)
				local var_270_14 = var_270_12 <= 0 and var_270_9 or var_270_9 * (var_270_13 / var_270_12)

				if var_270_14 > 0 and var_270_9 < var_270_14 then
					arg_267_1.talkMaxDuration = var_270_14

					if var_270_14 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_11
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_15 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_15 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_15

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_15 and arg_267_1.time_ < var_270_8 + var_270_15 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416232064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416232064
		arg_271_1.duration_ = 6.27

		local var_271_0 = {
			zh = 5,
			ja = 6.266
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
				arg_271_0:Play416232065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10127"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10127 == nil then
				arg_271_1.var_.actorSpriteComps10127 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10127 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10127 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10127 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 0.65

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_10 = arg_271_1:FormatText(StoryNameCfg[236].name)

				arg_271_1.leftNameTxt_.text = var_274_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_11 = arg_271_1:GetWordFromCfg(416232064)
				local var_274_12 = arg_271_1:FormatText(var_274_11.content)

				arg_271_1.text_.text = var_274_12

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 26
				local var_274_14 = utf8.len(var_274_12)
				local var_274_15 = var_274_13 <= 0 and var_274_9 or var_274_9 * (var_274_14 / var_274_13)

				if var_274_15 > 0 and var_274_9 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_12
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232064", "story_v_out_416232.awb") ~= 0 then
					local var_274_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232064", "story_v_out_416232.awb") / 1000

					if var_274_16 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_16 + var_274_8
					end

					if var_274_11.prefab_name ~= "" and arg_271_1.actors_[var_274_11.prefab_name] ~= nil then
						local var_274_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_11.prefab_name].transform, "story_v_out_416232", "416232064", "story_v_out_416232.awb")

						arg_271_1:RecordAudio("416232064", var_274_17)
						arg_271_1:RecordAudio("416232064", var_274_17)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416232", "416232064", "story_v_out_416232.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416232", "416232064", "story_v_out_416232.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_18 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_18 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_18

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_18 and arg_271_1.time_ < var_274_8 + var_274_18 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play416232065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416232065
		arg_275_1.duration_ = 5.87

		local var_275_0 = {
			zh = 4.8,
			ja = 5.866
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
				arg_275_0:Play416232066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10127"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos10127 = var_278_0.localPosition
				var_278_0.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10127", 4)

				local var_278_2 = var_278_0.childCount

				for iter_278_0 = 0, var_278_2 - 1 do
					local var_278_3 = var_278_0:GetChild(iter_278_0)

					if var_278_3.name == "" or not string.find(var_278_3.name, "split") then
						var_278_3.gameObject:SetActive(true)
					else
						var_278_3.gameObject:SetActive(false)
					end
				end
			end

			local var_278_4 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_4 then
				local var_278_5 = (arg_275_1.time_ - var_278_1) / var_278_4
				local var_278_6 = Vector3.New(345, -387.4, -316.5)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10127, var_278_6, var_278_5)
			end

			if arg_275_1.time_ >= var_278_1 + var_278_4 and arg_275_1.time_ < var_278_1 + var_278_4 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_278_7 = 0
			local var_278_8 = 0.575

			if var_278_7 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_9 = arg_275_1:FormatText(StoryNameCfg[236].name)

				arg_275_1.leftNameTxt_.text = var_278_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(416232065)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 23
				local var_278_13 = utf8.len(var_278_11)
				local var_278_14 = var_278_12 <= 0 and var_278_8 or var_278_8 * (var_278_13 / var_278_12)

				if var_278_14 > 0 and var_278_8 < var_278_14 then
					arg_275_1.talkMaxDuration = var_278_14

					if var_278_14 + var_278_7 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_7
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232065", "story_v_out_416232.awb") ~= 0 then
					local var_278_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232065", "story_v_out_416232.awb") / 1000

					if var_278_15 + var_278_7 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_15 + var_278_7
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_416232", "416232065", "story_v_out_416232.awb")

						arg_275_1:RecordAudio("416232065", var_278_16)
						arg_275_1:RecordAudio("416232065", var_278_16)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416232", "416232065", "story_v_out_416232.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416232", "416232065", "story_v_out_416232.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_17 = math.max(var_278_8, arg_275_1.talkMaxDuration)

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_17 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_7) / var_278_17

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_7 + var_278_17 and arg_275_1.time_ < var_278_7 + var_278_17 + arg_278_0 then
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
	Play416232066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416232066
		arg_279_1.duration_ = 6.97

		local var_279_0 = {
			zh = 3.866,
			ja = 6.966
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
				arg_279_0:Play416232067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10122"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10122 == nil then
				arg_279_1.var_.actorSpriteComps10122 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10122 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10122 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10122 = nil
			end

			local var_282_8 = arg_279_1.actors_["10127"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10127 == nil then
				arg_279_1.var_.actorSpriteComps10127 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 0.2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps10127 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10127 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10127 = nil
			end

			local var_282_16 = 0
			local var_282_17 = 0.45

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_18 = arg_279_1:FormatText(StoryNameCfg[8].name)

				arg_279_1.leftNameTxt_.text = var_282_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_19 = arg_279_1:GetWordFromCfg(416232066)
				local var_282_20 = arg_279_1:FormatText(var_282_19.content)

				arg_279_1.text_.text = var_282_20

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_21 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232066", "story_v_out_416232.awb") ~= 0 then
					local var_282_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232066", "story_v_out_416232.awb") / 1000

					if var_282_24 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_16
					end

					if var_282_19.prefab_name ~= "" and arg_279_1.actors_[var_282_19.prefab_name] ~= nil then
						local var_282_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_19.prefab_name].transform, "story_v_out_416232", "416232066", "story_v_out_416232.awb")

						arg_279_1:RecordAudio("416232066", var_282_25)
						arg_279_1:RecordAudio("416232066", var_282_25)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416232", "416232066", "story_v_out_416232.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416232", "416232066", "story_v_out_416232.awb")
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
	Play416232067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416232067
		arg_283_1.duration_ = 8.9

		local var_283_0 = {
			zh = 4.566,
			ja = 8.9
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
				arg_283_0:Play416232068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10122"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10122 = var_286_0.localPosition
				var_286_0.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10122", 2)

				local var_286_2 = var_286_0.childCount

				for iter_286_0 = 0, var_286_2 - 1 do
					local var_286_3 = var_286_0:GetChild(iter_286_0)

					if var_286_3.name == "split_1" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_4 then
				local var_286_5 = (arg_283_1.time_ - var_286_1) / var_286_4
				local var_286_6 = Vector3.New(-390, -380, -100)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10122, var_286_6, var_286_5)
			end

			if arg_283_1.time_ >= var_286_1 + var_286_4 and arg_283_1.time_ < var_286_1 + var_286_4 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_286_7 = 0
			local var_286_8 = 0.475

			if var_286_7 < arg_283_1.time_ and arg_283_1.time_ <= var_286_7 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_9 = arg_283_1:FormatText(StoryNameCfg[8].name)

				arg_283_1.leftNameTxt_.text = var_286_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(416232067)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_12 = 19
				local var_286_13 = utf8.len(var_286_11)
				local var_286_14 = var_286_12 <= 0 and var_286_8 or var_286_8 * (var_286_13 / var_286_12)

				if var_286_14 > 0 and var_286_8 < var_286_14 then
					arg_283_1.talkMaxDuration = var_286_14

					if var_286_14 + var_286_7 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_7
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232067", "story_v_out_416232.awb") ~= 0 then
					local var_286_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232067", "story_v_out_416232.awb") / 1000

					if var_286_15 + var_286_7 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_7
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_out_416232", "416232067", "story_v_out_416232.awb")

						arg_283_1:RecordAudio("416232067", var_286_16)
						arg_283_1:RecordAudio("416232067", var_286_16)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_416232", "416232067", "story_v_out_416232.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_416232", "416232067", "story_v_out_416232.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_17 = math.max(var_286_8, arg_283_1.talkMaxDuration)

			if var_286_7 <= arg_283_1.time_ and arg_283_1.time_ < var_286_7 + var_286_17 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_7) / var_286_17

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_7 + var_286_17 and arg_283_1.time_ < var_286_7 + var_286_17 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play416232068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416232068
		arg_287_1.duration_ = 1.7

		local var_287_0 = {
			zh = 1,
			ja = 1.7
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
				arg_287_0:Play416232069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10127"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10127 == nil then
				arg_287_1.var_.actorSpriteComps10127 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10127 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10127 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10127 = nil
			end

			local var_290_8 = arg_287_1.actors_["10122"]
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10122 == nil then
				arg_287_1.var_.actorSpriteComps10122 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_10 = 0.2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 and not isNil(var_290_8) then
				local var_290_11 = (arg_287_1.time_ - var_290_9) / var_290_10

				if arg_287_1.var_.actorSpriteComps10122 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								local var_290_12 = Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, var_290_11)
								local var_290_13 = Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, var_290_11)
								local var_290_14 = Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, var_290_11)

								iter_290_5.color = Color.New(var_290_12, var_290_13, var_290_14)
							else
								local var_290_15 = Mathf.Lerp(iter_290_5.color.r, 0.5, var_290_11)

								iter_290_5.color = Color.New(var_290_15, var_290_15, var_290_15)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10122 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_290_7 then
						if arg_287_1.isInRecall_ then
							iter_290_7.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10122 = nil
			end

			local var_290_16 = arg_287_1.actors_["10127"].transform
			local var_290_17 = 0

			if var_290_17 < arg_287_1.time_ and arg_287_1.time_ <= var_290_17 + arg_290_0 then
				arg_287_1.var_.moveOldPos10127 = var_290_16.localPosition
				var_290_16.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10127", 4)

				local var_290_18 = var_290_16.childCount

				for iter_290_8 = 0, var_290_18 - 1 do
					local var_290_19 = var_290_16:GetChild(iter_290_8)

					if var_290_19.name == "split_2" or not string.find(var_290_19.name, "split") then
						var_290_19.gameObject:SetActive(true)
					else
						var_290_19.gameObject:SetActive(false)
					end
				end
			end

			local var_290_20 = 0.001

			if var_290_17 <= arg_287_1.time_ and arg_287_1.time_ < var_290_17 + var_290_20 then
				local var_290_21 = (arg_287_1.time_ - var_290_17) / var_290_20
				local var_290_22 = Vector3.New(345, -387.4, -316.5)

				var_290_16.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10127, var_290_22, var_290_21)
			end

			if arg_287_1.time_ >= var_290_17 + var_290_20 and arg_287_1.time_ < var_290_17 + var_290_20 + arg_290_0 then
				var_290_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_290_23 = 0
			local var_290_24 = 0.125

			if var_290_23 < arg_287_1.time_ and arg_287_1.time_ <= var_290_23 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_25 = arg_287_1:FormatText(StoryNameCfg[236].name)

				arg_287_1.leftNameTxt_.text = var_290_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_26 = arg_287_1:GetWordFromCfg(416232068)
				local var_290_27 = arg_287_1:FormatText(var_290_26.content)

				arg_287_1.text_.text = var_290_27

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_28 = 5
				local var_290_29 = utf8.len(var_290_27)
				local var_290_30 = var_290_28 <= 0 and var_290_24 or var_290_24 * (var_290_29 / var_290_28)

				if var_290_30 > 0 and var_290_24 < var_290_30 then
					arg_287_1.talkMaxDuration = var_290_30

					if var_290_30 + var_290_23 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_30 + var_290_23
					end
				end

				arg_287_1.text_.text = var_290_27
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232068", "story_v_out_416232.awb") ~= 0 then
					local var_290_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232068", "story_v_out_416232.awb") / 1000

					if var_290_31 + var_290_23 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_31 + var_290_23
					end

					if var_290_26.prefab_name ~= "" and arg_287_1.actors_[var_290_26.prefab_name] ~= nil then
						local var_290_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_26.prefab_name].transform, "story_v_out_416232", "416232068", "story_v_out_416232.awb")

						arg_287_1:RecordAudio("416232068", var_290_32)
						arg_287_1:RecordAudio("416232068", var_290_32)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416232", "416232068", "story_v_out_416232.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416232", "416232068", "story_v_out_416232.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_33 = math.max(var_290_24, arg_287_1.talkMaxDuration)

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_33 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_23) / var_290_33

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_23 + var_290_33 and arg_287_1.time_ < var_290_23 + var_290_33 + arg_290_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play416232069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416232069
		arg_291_1.duration_ = 6.43

		local var_291_0 = {
			zh = 4.333,
			ja = 6.433
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
				arg_291_0:Play416232070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1028"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1028 == nil then
				arg_291_1.var_.actorSpriteComps1028 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1028 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1028 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1028 = nil
			end

			local var_294_8 = arg_291_1.actors_["10127"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10127 == nil then
				arg_291_1.var_.actorSpriteComps10127 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 0.2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps10127 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10127 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10127 = nil
			end

			local var_294_16 = arg_291_1.actors_["10127"].transform
			local var_294_17 = 0

			if var_294_17 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.var_.moveOldPos10127 = var_294_16.localPosition
				var_294_16.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10127", 7)

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
				local var_294_22 = Vector3.New(0, -2000, 0)

				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10127, var_294_22, var_294_21)
			end

			if arg_291_1.time_ >= var_294_17 + var_294_20 and arg_291_1.time_ < var_294_17 + var_294_20 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_23 = arg_291_1.actors_["10122"].transform
			local var_294_24 = 0

			if var_294_24 < arg_291_1.time_ and arg_291_1.time_ <= var_294_24 + arg_294_0 then
				arg_291_1.var_.moveOldPos10122 = var_294_23.localPosition
				var_294_23.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10122", 7)

				local var_294_25 = var_294_23.childCount

				for iter_294_9 = 0, var_294_25 - 1 do
					local var_294_26 = var_294_23:GetChild(iter_294_9)

					if var_294_26.name == "" or not string.find(var_294_26.name, "split") then
						var_294_26.gameObject:SetActive(true)
					else
						var_294_26.gameObject:SetActive(false)
					end
				end
			end

			local var_294_27 = 0.001

			if var_294_24 <= arg_291_1.time_ and arg_291_1.time_ < var_294_24 + var_294_27 then
				local var_294_28 = (arg_291_1.time_ - var_294_24) / var_294_27
				local var_294_29 = Vector3.New(0, -2000, 0)

				var_294_23.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10122, var_294_29, var_294_28)
			end

			if arg_291_1.time_ >= var_294_24 + var_294_27 and arg_291_1.time_ < var_294_24 + var_294_27 + arg_294_0 then
				var_294_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_30 = arg_291_1.actors_["1028"].transform
			local var_294_31 = 0

			if var_294_31 < arg_291_1.time_ and arg_291_1.time_ <= var_294_31 + arg_294_0 then
				arg_291_1.var_.moveOldPos1028 = var_294_30.localPosition
				var_294_30.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1028", 3)

				local var_294_32 = var_294_30.childCount

				for iter_294_10 = 0, var_294_32 - 1 do
					local var_294_33 = var_294_30:GetChild(iter_294_10)

					if var_294_33.name == "split_6" or not string.find(var_294_33.name, "split") then
						var_294_33.gameObject:SetActive(true)
					else
						var_294_33.gameObject:SetActive(false)
					end
				end
			end

			local var_294_34 = 0.001

			if var_294_31 <= arg_291_1.time_ and arg_291_1.time_ < var_294_31 + var_294_34 then
				local var_294_35 = (arg_291_1.time_ - var_294_31) / var_294_34
				local var_294_36 = Vector3.New(0, -402.7, -156.1)

				var_294_30.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1028, var_294_36, var_294_35)
			end

			if arg_291_1.time_ >= var_294_31 + var_294_34 and arg_291_1.time_ < var_294_31 + var_294_34 + arg_294_0 then
				var_294_30.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_294_37 = 0
			local var_294_38 = 0.425

			if var_294_37 < arg_291_1.time_ and arg_291_1.time_ <= var_294_37 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_39 = arg_291_1:FormatText(StoryNameCfg[327].name)

				arg_291_1.leftNameTxt_.text = var_294_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_40 = arg_291_1:GetWordFromCfg(416232069)
				local var_294_41 = arg_291_1:FormatText(var_294_40.content)

				arg_291_1.text_.text = var_294_41

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_42 = 17
				local var_294_43 = utf8.len(var_294_41)
				local var_294_44 = var_294_42 <= 0 and var_294_38 or var_294_38 * (var_294_43 / var_294_42)

				if var_294_44 > 0 and var_294_38 < var_294_44 then
					arg_291_1.talkMaxDuration = var_294_44

					if var_294_44 + var_294_37 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_44 + var_294_37
					end
				end

				arg_291_1.text_.text = var_294_41
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232069", "story_v_out_416232.awb") ~= 0 then
					local var_294_45 = manager.audio:GetVoiceLength("story_v_out_416232", "416232069", "story_v_out_416232.awb") / 1000

					if var_294_45 + var_294_37 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_45 + var_294_37
					end

					if var_294_40.prefab_name ~= "" and arg_291_1.actors_[var_294_40.prefab_name] ~= nil then
						local var_294_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_40.prefab_name].transform, "story_v_out_416232", "416232069", "story_v_out_416232.awb")

						arg_291_1:RecordAudio("416232069", var_294_46)
						arg_291_1:RecordAudio("416232069", var_294_46)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416232", "416232069", "story_v_out_416232.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416232", "416232069", "story_v_out_416232.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_47 = math.max(var_294_38, arg_291_1.talkMaxDuration)

			if var_294_37 <= arg_291_1.time_ and arg_291_1.time_ < var_294_37 + var_294_47 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_37) / var_294_47

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_37 + var_294_47 and arg_291_1.time_ < var_294_37 + var_294_47 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play416232070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416232070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play416232071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1028"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1028 = var_298_0.localPosition
				var_298_0.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("1028", 7)

				local var_298_2 = var_298_0.childCount

				for iter_298_0 = 0, var_298_2 - 1 do
					local var_298_3 = var_298_0:GetChild(iter_298_0)

					if var_298_3.name == "" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_4 then
				local var_298_5 = (arg_295_1.time_ - var_298_1) / var_298_4
				local var_298_6 = Vector3.New(0, -2000, 0)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1028, var_298_6, var_298_5)
			end

			if arg_295_1.time_ >= var_298_1 + var_298_4 and arg_295_1.time_ < var_298_1 + var_298_4 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_298_7 = 0.05
			local var_298_8 = 1

			if var_298_7 < arg_295_1.time_ and arg_295_1.time_ <= var_298_7 + arg_298_0 then
				local var_298_9 = "play"
				local var_298_10 = "effect"

				arg_295_1:AudioAction(var_298_9, var_298_10, "se_story_138", "se_story_138_clap", "")
			end

			local var_298_11 = 0
			local var_298_12 = 1.05

			if var_298_11 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_13 = arg_295_1:GetWordFromCfg(416232070)
				local var_298_14 = arg_295_1:FormatText(var_298_13.content)

				arg_295_1.text_.text = var_298_14

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_15 = 42
				local var_298_16 = utf8.len(var_298_14)
				local var_298_17 = var_298_15 <= 0 and var_298_12 or var_298_12 * (var_298_16 / var_298_15)

				if var_298_17 > 0 and var_298_12 < var_298_17 then
					arg_295_1.talkMaxDuration = var_298_17

					if var_298_17 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_17 + var_298_11
					end
				end

				arg_295_1.text_.text = var_298_14
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_18 = math.max(var_298_12, arg_295_1.talkMaxDuration)

			if var_298_11 <= arg_295_1.time_ and arg_295_1.time_ < var_298_11 + var_298_18 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_11) / var_298_18

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_11 + var_298_18 and arg_295_1.time_ < var_298_11 + var_298_18 + arg_298_0 then
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
	Play416232071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416232071
		arg_299_1.duration_ = 4.67

		local var_299_0 = {
			zh = 2.766,
			ja = 4.666
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
				arg_299_0:Play416232072(arg_299_1)
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
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 1, var_302_3)

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
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
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

				arg_299_1:CheckSpriteTmpPos("1028", 3)

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
				local var_302_14 = Vector3.New(0, -402.7, -156.1)

				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1028, var_302_14, var_302_13)
			end

			if arg_299_1.time_ >= var_302_9 + var_302_12 and arg_299_1.time_ < var_302_9 + var_302_12 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_302_15 = 0
			local var_302_16 = 0.35

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[327].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(416232071)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 14
				local var_302_21 = utf8.len(var_302_19)
				local var_302_22 = var_302_20 <= 0 and var_302_16 or var_302_16 * (var_302_21 / var_302_20)

				if var_302_22 > 0 and var_302_16 < var_302_22 then
					arg_299_1.talkMaxDuration = var_302_22

					if var_302_22 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_22 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_19
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232071", "story_v_out_416232.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232071", "story_v_out_416232.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_416232", "416232071", "story_v_out_416232.awb")

						arg_299_1:RecordAudio("416232071", var_302_24)
						arg_299_1:RecordAudio("416232071", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416232", "416232071", "story_v_out_416232.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416232", "416232071", "story_v_out_416232.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_25 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_25 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_25

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_25 and arg_299_1.time_ < var_302_15 + var_302_25 + arg_302_0 then
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
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play416232072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416232072
		arg_303_1.duration_ = 4.27

		local var_303_0 = {
			zh = 4.233,
			ja = 4.266
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
				arg_303_0:Play416232073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1086"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1086 == nil then
				arg_303_1.var_.actorSpriteComps1086 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1086 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1086 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1086 = nil
			end

			local var_306_8 = arg_303_1.actors_["1028"]
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps1028 == nil then
				arg_303_1.var_.actorSpriteComps1028 = var_306_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_10 = 0.2

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_10 and not isNil(var_306_8) then
				local var_306_11 = (arg_303_1.time_ - var_306_9) / var_306_10

				if arg_303_1.var_.actorSpriteComps1028 then
					for iter_306_4, iter_306_5 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_306_5 then
							if arg_303_1.isInRecall_ then
								local var_306_12 = Mathf.Lerp(iter_306_5.color.r, arg_303_1.hightColor2.r, var_306_11)
								local var_306_13 = Mathf.Lerp(iter_306_5.color.g, arg_303_1.hightColor2.g, var_306_11)
								local var_306_14 = Mathf.Lerp(iter_306_5.color.b, arg_303_1.hightColor2.b, var_306_11)

								iter_306_5.color = Color.New(var_306_12, var_306_13, var_306_14)
							else
								local var_306_15 = Mathf.Lerp(iter_306_5.color.r, 0.5, var_306_11)

								iter_306_5.color = Color.New(var_306_15, var_306_15, var_306_15)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_9 + var_306_10 and arg_303_1.time_ < var_306_9 + var_306_10 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps1028 then
				for iter_306_6, iter_306_7 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_306_7 then
						if arg_303_1.isInRecall_ then
							iter_306_7.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1028 = nil
			end

			local var_306_16 = arg_303_1.actors_["1028"].transform
			local var_306_17 = 0

			if var_306_17 < arg_303_1.time_ and arg_303_1.time_ <= var_306_17 + arg_306_0 then
				arg_303_1.var_.moveOldPos1028 = var_306_16.localPosition
				var_306_16.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1028", 7)

				local var_306_18 = var_306_16.childCount

				for iter_306_8 = 0, var_306_18 - 1 do
					local var_306_19 = var_306_16:GetChild(iter_306_8)

					if var_306_19.name == "" or not string.find(var_306_19.name, "split") then
						var_306_19.gameObject:SetActive(true)
					else
						var_306_19.gameObject:SetActive(false)
					end
				end
			end

			local var_306_20 = 0.001

			if var_306_17 <= arg_303_1.time_ and arg_303_1.time_ < var_306_17 + var_306_20 then
				local var_306_21 = (arg_303_1.time_ - var_306_17) / var_306_20
				local var_306_22 = Vector3.New(0, -2000, 0)

				var_306_16.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1028, var_306_22, var_306_21)
			end

			if arg_303_1.time_ >= var_306_17 + var_306_20 and arg_303_1.time_ < var_306_17 + var_306_20 + arg_306_0 then
				var_306_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_23 = arg_303_1.actors_["1086"].transform
			local var_306_24 = 0

			if var_306_24 < arg_303_1.time_ and arg_303_1.time_ <= var_306_24 + arg_306_0 then
				arg_303_1.var_.moveOldPos1086 = var_306_23.localPosition
				var_306_23.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1086", 3)

				local var_306_25 = var_306_23.childCount

				for iter_306_9 = 0, var_306_25 - 1 do
					local var_306_26 = var_306_23:GetChild(iter_306_9)

					if var_306_26.name == "" or not string.find(var_306_26.name, "split") then
						var_306_26.gameObject:SetActive(true)
					else
						var_306_26.gameObject:SetActive(false)
					end
				end
			end

			local var_306_27 = 0.001

			if var_306_24 <= arg_303_1.time_ and arg_303_1.time_ < var_306_24 + var_306_27 then
				local var_306_28 = (arg_303_1.time_ - var_306_24) / var_306_27
				local var_306_29 = Vector3.New(0, -404.2, -237.9)

				var_306_23.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1086, var_306_29, var_306_28)
			end

			if arg_303_1.time_ >= var_306_24 + var_306_27 and arg_303_1.time_ < var_306_24 + var_306_27 + arg_306_0 then
				var_306_23.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_306_30 = 0
			local var_306_31 = 0.475

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_32 = arg_303_1:FormatText(StoryNameCfg[1080].name)

				arg_303_1.leftNameTxt_.text = var_306_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_33 = arg_303_1:GetWordFromCfg(416232072)
				local var_306_34 = arg_303_1:FormatText(var_306_33.content)

				arg_303_1.text_.text = var_306_34

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_35 = 19
				local var_306_36 = utf8.len(var_306_34)
				local var_306_37 = var_306_35 <= 0 and var_306_31 or var_306_31 * (var_306_36 / var_306_35)

				if var_306_37 > 0 and var_306_31 < var_306_37 then
					arg_303_1.talkMaxDuration = var_306_37

					if var_306_37 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_37 + var_306_30
					end
				end

				arg_303_1.text_.text = var_306_34
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232072", "story_v_out_416232.awb") ~= 0 then
					local var_306_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232072", "story_v_out_416232.awb") / 1000

					if var_306_38 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_38 + var_306_30
					end

					if var_306_33.prefab_name ~= "" and arg_303_1.actors_[var_306_33.prefab_name] ~= nil then
						local var_306_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_33.prefab_name].transform, "story_v_out_416232", "416232072", "story_v_out_416232.awb")

						arg_303_1:RecordAudio("416232072", var_306_39)
						arg_303_1:RecordAudio("416232072", var_306_39)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416232", "416232072", "story_v_out_416232.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416232", "416232072", "story_v_out_416232.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_40 = math.max(var_306_31, arg_303_1.talkMaxDuration)

			if var_306_30 <= arg_303_1.time_ and arg_303_1.time_ < var_306_30 + var_306_40 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_30) / var_306_40

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_30 + var_306_40 and arg_303_1.time_ < var_306_30 + var_306_40 + arg_306_0 then
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

		arg_303_1:InitPlayNodeList()
	end,
	Play416232073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416232073
		arg_307_1.duration_ = 9.63

		local var_307_0 = {
			zh = 5.466,
			ja = 9.633
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
				arg_307_0:Play416232074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10127"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10127 == nil then
				arg_307_1.var_.actorSpriteComps10127 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10127 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10127 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10127 = nil
			end

			local var_310_8 = arg_307_1.actors_["1086"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1086 == nil then
				arg_307_1.var_.actorSpriteComps1086 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 0.2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps1086 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1086 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1086 = nil
			end

			local var_310_16 = arg_307_1.actors_["1086"].transform
			local var_310_17 = 0

			if var_310_17 < arg_307_1.time_ and arg_307_1.time_ <= var_310_17 + arg_310_0 then
				arg_307_1.var_.moveOldPos1086 = var_310_16.localPosition
				var_310_16.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1086", 7)

				local var_310_18 = var_310_16.childCount

				for iter_310_8 = 0, var_310_18 - 1 do
					local var_310_19 = var_310_16:GetChild(iter_310_8)

					if var_310_19.name == "" or not string.find(var_310_19.name, "split") then
						var_310_19.gameObject:SetActive(true)
					else
						var_310_19.gameObject:SetActive(false)
					end
				end
			end

			local var_310_20 = 0.001

			if var_310_17 <= arg_307_1.time_ and arg_307_1.time_ < var_310_17 + var_310_20 then
				local var_310_21 = (arg_307_1.time_ - var_310_17) / var_310_20
				local var_310_22 = Vector3.New(0, -2000, 0)

				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1086, var_310_22, var_310_21)
			end

			if arg_307_1.time_ >= var_310_17 + var_310_20 and arg_307_1.time_ < var_310_17 + var_310_20 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_310_23 = arg_307_1.actors_["10127"].transform
			local var_310_24 = 0

			if var_310_24 < arg_307_1.time_ and arg_307_1.time_ <= var_310_24 + arg_310_0 then
				arg_307_1.var_.moveOldPos10127 = var_310_23.localPosition
				var_310_23.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10127", 3)

				local var_310_25 = var_310_23.childCount

				for iter_310_9 = 0, var_310_25 - 1 do
					local var_310_26 = var_310_23:GetChild(iter_310_9)

					if var_310_26.name == "" or not string.find(var_310_26.name, "split") then
						var_310_26.gameObject:SetActive(true)
					else
						var_310_26.gameObject:SetActive(false)
					end
				end
			end

			local var_310_27 = 0.001

			if var_310_24 <= arg_307_1.time_ and arg_307_1.time_ < var_310_24 + var_310_27 then
				local var_310_28 = (arg_307_1.time_ - var_310_24) / var_310_27
				local var_310_29 = Vector3.New(0, -387.4, -316.5)

				var_310_23.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10127, var_310_29, var_310_28)
			end

			if arg_307_1.time_ >= var_310_24 + var_310_27 and arg_307_1.time_ < var_310_24 + var_310_27 + arg_310_0 then
				var_310_23.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_310_30 = 0
			local var_310_31 = 0.575

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_32 = arg_307_1:FormatText(StoryNameCfg[236].name)

				arg_307_1.leftNameTxt_.text = var_310_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_33 = arg_307_1:GetWordFromCfg(416232073)
				local var_310_34 = arg_307_1:FormatText(var_310_33.content)

				arg_307_1.text_.text = var_310_34

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_35 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232073", "story_v_out_416232.awb") ~= 0 then
					local var_310_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232073", "story_v_out_416232.awb") / 1000

					if var_310_38 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_38 + var_310_30
					end

					if var_310_33.prefab_name ~= "" and arg_307_1.actors_[var_310_33.prefab_name] ~= nil then
						local var_310_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_33.prefab_name].transform, "story_v_out_416232", "416232073", "story_v_out_416232.awb")

						arg_307_1:RecordAudio("416232073", var_310_39)
						arg_307_1:RecordAudio("416232073", var_310_39)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416232", "416232073", "story_v_out_416232.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416232", "416232073", "story_v_out_416232.awb")
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

		arg_307_1:InitPlayNodeList()
	end,
	Play416232074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416232074
		arg_311_1.duration_ = 9.2

		local var_311_0 = {
			zh = 4.63266666666667,
			ja = 9.19966666666667
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
				arg_311_0:Play416232075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = "SS1610"

			if arg_311_1.bgs_[var_314_0] == nil then
				local var_314_1 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_314_0)
				var_314_1.name = var_314_0
				var_314_1.transform.parent = arg_311_1.stage_.transform
				var_314_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_[var_314_0] = var_314_1
			end

			local var_314_2 = 1.15

			if var_314_2 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				local var_314_3 = manager.ui.mainCamera.transform.localPosition
				local var_314_4 = Vector3.New(0, 0, 10) + Vector3.New(var_314_3.x, var_314_3.y, 0)
				local var_314_5 = arg_311_1.bgs_.SS1610

				var_314_5.transform.localPosition = var_314_4
				var_314_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_6 = var_314_5:GetComponent("SpriteRenderer")

				if var_314_6 and var_314_6.sprite then
					local var_314_7 = (var_314_5.transform.localPosition - var_314_3).z
					local var_314_8 = manager.ui.mainCameraCom_
					local var_314_9 = 2 * var_314_7 * Mathf.Tan(var_314_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_314_10 = var_314_9 * var_314_8.aspect
					local var_314_11 = var_314_6.sprite.bounds.size.x
					local var_314_12 = var_314_6.sprite.bounds.size.y
					local var_314_13 = var_314_10 / var_314_11
					local var_314_14 = var_314_9 / var_314_12
					local var_314_15 = var_314_14 < var_314_13 and var_314_13 or var_314_14

					var_314_5.transform.localScale = Vector3.New(var_314_15, var_314_15, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "SS1610" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_16 = 1.16666666666667

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			local var_314_17 = 0.3

			if arg_311_1.time_ >= var_314_16 + var_314_17 and arg_311_1.time_ < var_314_16 + var_314_17 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_18 = 0

			if var_314_18 < arg_311_1.time_ and arg_311_1.time_ <= var_314_18 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_19 = 1.16666666666667

			if var_314_18 <= arg_311_1.time_ and arg_311_1.time_ < var_314_18 + var_314_19 then
				local var_314_20 = (arg_311_1.time_ - var_314_18) / var_314_19
				local var_314_21 = Color.New(0, 0, 0)

				var_314_21.a = Mathf.Lerp(0, 1, var_314_20)
				arg_311_1.mask_.color = var_314_21
			end

			if arg_311_1.time_ >= var_314_18 + var_314_19 and arg_311_1.time_ < var_314_18 + var_314_19 + arg_314_0 then
				local var_314_22 = Color.New(0, 0, 0)

				var_314_22.a = 1
				arg_311_1.mask_.color = var_314_22
			end

			local var_314_23 = 1.16666666666667

			if var_314_23 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_24 = 1.825

			if var_314_23 <= arg_311_1.time_ and arg_311_1.time_ < var_314_23 + var_314_24 then
				local var_314_25 = (arg_311_1.time_ - var_314_23) / var_314_24
				local var_314_26 = Color.New(0, 0, 0)

				var_314_26.a = Mathf.Lerp(1, 0, var_314_25)
				arg_311_1.mask_.color = var_314_26
			end

			if arg_311_1.time_ >= var_314_23 + var_314_24 and arg_311_1.time_ < var_314_23 + var_314_24 + arg_314_0 then
				local var_314_27 = Color.New(0, 0, 0)
				local var_314_28 = 0

				arg_311_1.mask_.enabled = false
				var_314_27.a = var_314_28
				arg_311_1.mask_.color = var_314_27
			end

			local var_314_29 = arg_311_1.actors_["10127"].transform
			local var_314_30 = 1.16666666666667

			if var_314_30 < arg_311_1.time_ and arg_311_1.time_ <= var_314_30 + arg_314_0 then
				arg_311_1.var_.moveOldPos10127 = var_314_29.localPosition
				var_314_29.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10127", 7)

				local var_314_31 = var_314_29.childCount

				for iter_314_2 = 0, var_314_31 - 1 do
					local var_314_32 = var_314_29:GetChild(iter_314_2)

					if var_314_32.name == "" or not string.find(var_314_32.name, "split") then
						var_314_32.gameObject:SetActive(true)
					else
						var_314_32.gameObject:SetActive(false)
					end
				end
			end

			local var_314_33 = 0.001

			if var_314_30 <= arg_311_1.time_ and arg_311_1.time_ < var_314_30 + var_314_33 then
				local var_314_34 = (arg_311_1.time_ - var_314_30) / var_314_33
				local var_314_35 = Vector3.New(0, -2000, 0)

				var_314_29.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10127, var_314_35, var_314_34)
			end

			if arg_311_1.time_ >= var_314_30 + var_314_33 and arg_311_1.time_ < var_314_30 + var_314_33 + arg_314_0 then
				var_314_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_314_36 = 1.16666666666667

			arg_311_1.isInRecall_ = false

			if var_314_36 < arg_311_1.time_ and arg_311_1.time_ <= var_314_36 + arg_314_0 then
				arg_311_1.screenFilterGo_:SetActive(false)

				for iter_314_3, iter_314_4 in pairs(arg_311_1.actors_) do
					local var_314_37 = iter_314_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_314_5, iter_314_6 in ipairs(var_314_37) do
						if iter_314_6.color.r > 0.51 then
							iter_314_6.color = Color.New(1, 1, 1)
						else
							iter_314_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_314_38 = 0.034

			if var_314_36 <= arg_311_1.time_ and arg_311_1.time_ < var_314_36 + var_314_38 then
				local var_314_39 = (arg_311_1.time_ - var_314_36) / var_314_38

				arg_311_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_314_39)
			end

			if arg_311_1.time_ >= var_314_36 + var_314_38 and arg_311_1.time_ < var_314_36 + var_314_38 + arg_314_0 then
				arg_311_1.screenFilterEffect_.weight = 0
			end

			local var_314_40 = arg_311_1.bgs_.SS1610.transform
			local var_314_41 = 1.16666666666667

			if var_314_41 < arg_311_1.time_ and arg_311_1.time_ <= var_314_41 + arg_314_0 then
				arg_311_1.var_.moveOldPosSS1610 = var_314_40.localPosition
			end

			local var_314_42 = 0.001

			if var_314_41 <= arg_311_1.time_ and arg_311_1.time_ < var_314_41 + var_314_42 then
				local var_314_43 = (arg_311_1.time_ - var_314_41) / var_314_42
				local var_314_44 = Vector3.New(8, 1, 8)

				var_314_40.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPosSS1610, var_314_44, var_314_43)
			end

			if arg_311_1.time_ >= var_314_41 + var_314_42 and arg_311_1.time_ < var_314_41 + var_314_42 + arg_314_0 then
				var_314_40.localPosition = Vector3.New(8, 1, 8)
			end

			local var_314_45 = arg_311_1.bgs_.SS1610.transform
			local var_314_46 = 1.20066666666667

			if var_314_46 < arg_311_1.time_ and arg_311_1.time_ <= var_314_46 + arg_314_0 then
				arg_311_1.var_.moveOldPosSS1610 = var_314_45.localPosition
			end

			local var_314_47 = 2.39933333333333

			if var_314_46 <= arg_311_1.time_ and arg_311_1.time_ < var_314_46 + var_314_47 then
				local var_314_48 = (arg_311_1.time_ - var_314_46) / var_314_47
				local var_314_49 = Vector3.New(8, 1, 9)

				var_314_45.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPosSS1610, var_314_49, var_314_48)
			end

			if arg_311_1.time_ >= var_314_46 + var_314_47 and arg_311_1.time_ < var_314_46 + var_314_47 + arg_314_0 then
				var_314_45.localPosition = Vector3.New(8, 1, 9)
			end

			local var_314_50 = 2.86666666666667

			if var_314_50 < arg_311_1.time_ and arg_311_1.time_ <= var_314_50 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			local var_314_51 = 0.733333333333333

			if arg_311_1.time_ >= var_314_50 + var_314_51 and arg_311_1.time_ < var_314_50 + var_314_51 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_52 = 2.86666666666667
			local var_314_53 = 0.125

			if var_314_52 < arg_311_1.time_ and arg_311_1.time_ <= var_314_52 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_54 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_54:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_55 = arg_311_1:FormatText(StoryNameCfg[236].name)

				arg_311_1.leftNameTxt_.text = var_314_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_56 = arg_311_1:GetWordFromCfg(416232074)
				local var_314_57 = arg_311_1:FormatText(var_314_56.content)

				arg_311_1.text_.text = var_314_57

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_58 = 5
				local var_314_59 = utf8.len(var_314_57)
				local var_314_60 = var_314_58 <= 0 and var_314_53 or var_314_53 * (var_314_59 / var_314_58)

				if var_314_60 > 0 and var_314_53 < var_314_60 then
					arg_311_1.talkMaxDuration = var_314_60
					var_314_52 = var_314_52 + 0.3

					if var_314_60 + var_314_52 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_60 + var_314_52
					end
				end

				arg_311_1.text_.text = var_314_57
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232074", "story_v_out_416232.awb") ~= 0 then
					local var_314_61 = manager.audio:GetVoiceLength("story_v_out_416232", "416232074", "story_v_out_416232.awb") / 1000

					if var_314_61 + var_314_52 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_61 + var_314_52
					end

					if var_314_56.prefab_name ~= "" and arg_311_1.actors_[var_314_56.prefab_name] ~= nil then
						local var_314_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_56.prefab_name].transform, "story_v_out_416232", "416232074", "story_v_out_416232.awb")

						arg_311_1:RecordAudio("416232074", var_314_62)
						arg_311_1:RecordAudio("416232074", var_314_62)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416232", "416232074", "story_v_out_416232.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416232", "416232074", "story_v_out_416232.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_63 = var_314_52 + 0.3
			local var_314_64 = math.max(var_314_53, arg_311_1.talkMaxDuration)

			if var_314_63 <= arg_311_1.time_ and arg_311_1.time_ < var_314_63 + var_314_64 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_63) / var_314_64

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_63 + var_314_64 and arg_311_1.time_ < var_314_63 + var_314_64 + arg_314_0 then
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
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 1.20066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play416232075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 416232075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play416232076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.5

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(416232075)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 60
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play416232076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 416232076
		arg_321_1.duration_ = 5.1

		local var_321_0 = {
			zh = 3.3,
			ja = 5.1
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
				arg_321_0:Play416232077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.225

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[236].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(416232076)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 9
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232076", "story_v_out_416232.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232076", "story_v_out_416232.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_416232", "416232076", "story_v_out_416232.awb")

						arg_321_1:RecordAudio("416232076", var_324_9)
						arg_321_1:RecordAudio("416232076", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_416232", "416232076", "story_v_out_416232.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_416232", "416232076", "story_v_out_416232.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play416232077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 416232077
		arg_325_1.duration_ = 10.2

		local var_325_0 = {
			zh = 4.9,
			ja = 10.2
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
				arg_325_0:Play416232078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.375

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[236].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:GetWordFromCfg(416232077)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232077", "story_v_out_416232.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232077", "story_v_out_416232.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_416232", "416232077", "story_v_out_416232.awb")

						arg_325_1:RecordAudio("416232077", var_328_9)
						arg_325_1:RecordAudio("416232077", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_416232", "416232077", "story_v_out_416232.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_416232", "416232077", "story_v_out_416232.awb")
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
	Play416232078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 416232078
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play416232079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1.35

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(416232078)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 54
				local var_332_5 = utf8.len(var_332_3)
				local var_332_6 = var_332_4 <= 0 and var_332_1 or var_332_1 * (var_332_5 / var_332_4)

				if var_332_6 > 0 and var_332_1 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_7 and arg_329_1.time_ < var_332_0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play416232079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416232079
		arg_333_1.duration_ = 13.6

		local var_333_0 = {
			zh = 7.966,
			ja = 13.6
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
				arg_333_0:Play416232080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.475

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[1093].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:GetWordFromCfg(416232079)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 19
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232079", "story_v_out_416232.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232079", "story_v_out_416232.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_416232", "416232079", "story_v_out_416232.awb")

						arg_333_1:RecordAudio("416232079", var_336_9)
						arg_333_1:RecordAudio("416232079", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_416232", "416232079", "story_v_out_416232.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_416232", "416232079", "story_v_out_416232.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_10 and arg_333_1.time_ < var_336_0 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416232080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416232080
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play416232081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 1.15

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_2 = arg_337_1:GetWordFromCfg(416232080)
				local var_340_3 = arg_337_1:FormatText(var_340_2.content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 46
				local var_340_5 = utf8.len(var_340_3)
				local var_340_6 = var_340_4 <= 0 and var_340_1 or var_340_1 * (var_340_5 / var_340_4)

				if var_340_6 > 0 and var_340_1 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_7 and arg_337_1.time_ < var_340_0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416232081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416232081
		arg_341_1.duration_ = 10.2

		local var_341_0 = {
			zh = 7.166,
			ja = 10.2
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
				arg_341_0:Play416232082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.525

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[1093].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(416232081)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232081", "story_v_out_416232.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232081", "story_v_out_416232.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_416232", "416232081", "story_v_out_416232.awb")

						arg_341_1:RecordAudio("416232081", var_344_9)
						arg_341_1:RecordAudio("416232081", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416232", "416232081", "story_v_out_416232.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416232", "416232081", "story_v_out_416232.awb")
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
	Play416232082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416232082
		arg_345_1.duration_ = 8.27

		local var_345_0 = {
			zh = 7.9,
			ja = 8.266
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
				arg_345_0:Play416232083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = manager.ui.mainCamera.transform
			local var_348_1 = 0.5

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				local var_348_2 = arg_345_1.var_.effect778
				local var_348_3
				local var_348_4 = var_348_0

				if not var_348_2 then
					var_348_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_348_4)
					var_348_2.name = "778"
					arg_345_1.var_.effect778 = var_348_2
				else
					var_348_2.transform:SetParent(var_348_4)
				end

				var_348_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_348_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_348_5 = manager.ui.mainCamera.transform
			local var_348_6 = 1.26666666666667

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				local var_348_7 = arg_345_1.var_.effect778

				if var_348_7 then
					Object.Destroy(var_348_7)

					arg_345_1.var_.effect778 = nil
				end
			end

			local var_348_8 = 0

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_9 = 1.73333333333333

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_10 = 0
			local var_348_11 = 1

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 then
				local var_348_12 = "play"
				local var_348_13 = "effect"

				arg_345_1:AudioAction(var_348_12, var_348_13, "se_story_139", "se_story_2_stun_loop", "")
			end

			local var_348_14 = 0
			local var_348_15 = 0.625

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_16 = arg_345_1:FormatText(StoryNameCfg[236].name)

				arg_345_1.leftNameTxt_.text = var_348_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_17 = arg_345_1:GetWordFromCfg(416232082)
				local var_348_18 = arg_345_1:FormatText(var_348_17.content)

				arg_345_1.text_.text = var_348_18

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_19 = 25
				local var_348_20 = utf8.len(var_348_18)
				local var_348_21 = var_348_19 <= 0 and var_348_15 or var_348_15 * (var_348_20 / var_348_19)

				if var_348_21 > 0 and var_348_15 < var_348_21 then
					arg_345_1.talkMaxDuration = var_348_21

					if var_348_21 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_21 + var_348_14
					end
				end

				arg_345_1.text_.text = var_348_18
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232082", "story_v_out_416232.awb") ~= 0 then
					local var_348_22 = manager.audio:GetVoiceLength("story_v_out_416232", "416232082", "story_v_out_416232.awb") / 1000

					if var_348_22 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_14
					end

					if var_348_17.prefab_name ~= "" and arg_345_1.actors_[var_348_17.prefab_name] ~= nil then
						local var_348_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_17.prefab_name].transform, "story_v_out_416232", "416232082", "story_v_out_416232.awb")

						arg_345_1:RecordAudio("416232082", var_348_23)
						arg_345_1:RecordAudio("416232082", var_348_23)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_416232", "416232082", "story_v_out_416232.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_416232", "416232082", "story_v_out_416232.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_24 = math.max(var_348_15, arg_345_1.talkMaxDuration)

			if var_348_14 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_24 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_14) / var_348_24

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_14 + var_348_24 and arg_345_1.time_ < var_348_14 + var_348_24 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play416232083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 416232083
		arg_349_1.duration_ = 7.5

		local var_349_0 = {
			zh = 5.7,
			ja = 7.5
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
				arg_349_0:Play416232084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.525

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

				local var_352_3 = arg_349_1:GetWordFromCfg(416232083)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232083", "story_v_out_416232.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232083", "story_v_out_416232.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_416232", "416232083", "story_v_out_416232.awb")

						arg_349_1:RecordAudio("416232083", var_352_9)
						arg_349_1:RecordAudio("416232083", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_416232", "416232083", "story_v_out_416232.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_416232", "416232083", "story_v_out_416232.awb")
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
	Play416232084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 416232084
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play416232085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1.2

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:GetWordFromCfg(416232084)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 48
				local var_356_5 = utf8.len(var_356_3)
				local var_356_6 = var_356_4 <= 0 and var_356_1 or var_356_1 * (var_356_5 / var_356_4)

				if var_356_6 > 0 and var_356_1 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_7 and arg_353_1.time_ < var_356_0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play416232085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 416232085
		arg_357_1.duration_ = 10.6

		local var_357_0 = {
			zh = 9.2,
			ja = 10.6
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
				arg_357_0:Play416232086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.6

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[1093].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:GetWordFromCfg(416232085)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 24
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232085", "story_v_out_416232.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232085", "story_v_out_416232.awb") / 1000

					if var_360_8 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_0
					end

					if var_360_3.prefab_name ~= "" and arg_357_1.actors_[var_360_3.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_3.prefab_name].transform, "story_v_out_416232", "416232085", "story_v_out_416232.awb")

						arg_357_1:RecordAudio("416232085", var_360_9)
						arg_357_1:RecordAudio("416232085", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_416232", "416232085", "story_v_out_416232.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_416232", "416232085", "story_v_out_416232.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_10 and arg_357_1.time_ < var_360_0 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play416232086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 416232086
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play416232087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			local var_364_1 = 2.23333333333333

			if arg_361_1.time_ >= var_364_0 + var_364_1 and arg_361_1.time_ < var_364_0 + var_364_1 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_2 = 0
			local var_364_3 = 1.45

			if var_364_2 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:GetWordFromCfg(416232086)
				local var_364_5 = arg_361_1:FormatText(var_364_4.content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 58
				local var_364_7 = utf8.len(var_364_5)
				local var_364_8 = var_364_6 <= 0 and var_364_3 or var_364_3 * (var_364_7 / var_364_6)

				if var_364_8 > 0 and var_364_3 < var_364_8 then
					arg_361_1.talkMaxDuration = var_364_8

					if var_364_8 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_9 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_9 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_9

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_9 and arg_361_1.time_ < var_364_2 + var_364_9 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play416232087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 416232087
		arg_365_1.duration_ = 11.1

		local var_365_0 = {
			zh = 6.1,
			ja = 11.1
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play416232088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.475

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[1093].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(416232087)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232087", "story_v_out_416232.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232087", "story_v_out_416232.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_416232", "416232087", "story_v_out_416232.awb")

						arg_365_1:RecordAudio("416232087", var_368_9)
						arg_365_1:RecordAudio("416232087", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_416232", "416232087", "story_v_out_416232.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_416232", "416232087", "story_v_out_416232.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play416232088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 416232088
		arg_369_1.duration_ = 4.4

		local var_369_0 = {
			zh = 4.399999999999,
			ja = 3.132999999999
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
				arg_369_0:Play416232089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_1 = 0.6

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_1 then
				local var_372_2 = (arg_369_1.time_ - var_372_0) / var_372_1
				local var_372_3 = Color.New(1, 1, 1)

				var_372_3.a = Mathf.Lerp(1, 0, var_372_2)
				arg_369_1.mask_.color = var_372_3
			end

			if arg_369_1.time_ >= var_372_0 + var_372_1 and arg_369_1.time_ < var_372_0 + var_372_1 + arg_372_0 then
				local var_372_4 = Color.New(1, 1, 1)
				local var_372_5 = 0

				arg_369_1.mask_.enabled = false
				var_372_4.a = var_372_5
				arg_369_1.mask_.color = var_372_4
			end

			local var_372_6 = manager.ui.mainCamera.transform
			local var_372_7 = 0.208333333333333

			if var_372_7 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 then
				arg_369_1.var_.shakeOldPos = var_372_6.localPosition
			end

			local var_372_8 = 0.666666666666667

			if var_372_7 <= arg_369_1.time_ and arg_369_1.time_ < var_372_7 + var_372_8 then
				local var_372_9 = (arg_369_1.time_ - var_372_7) / 0.066
				local var_372_10, var_372_11 = math.modf(var_372_9)

				var_372_6.localPosition = Vector3.New(var_372_11 * 0.13, var_372_11 * 0.13, var_372_11 * 0.13) + arg_369_1.var_.shakeOldPos
			end

			if arg_369_1.time_ >= var_372_7 + var_372_8 and arg_369_1.time_ < var_372_7 + var_372_8 + arg_372_0 then
				var_372_6.localPosition = arg_369_1.var_.shakeOldPos
			end

			local var_372_12 = 0

			if var_372_12 < arg_369_1.time_ and arg_369_1.time_ <= var_372_12 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			local var_372_13 = 0.875

			if arg_369_1.time_ >= var_372_12 + var_372_13 and arg_369_1.time_ < var_372_12 + var_372_13 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_14 = 0.999999999999
			local var_372_15 = 0.275

			if var_372_14 < arg_369_1.time_ and arg_369_1.time_ <= var_372_14 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_16 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_16:setOnUpdate(LuaHelper.FloatAction(function(arg_373_0)
					arg_369_1.dialogCg_.alpha = arg_373_0
				end))
				var_372_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[327].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(416232088)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 11
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_15 or var_372_15 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_15 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22
					var_372_14 = var_372_14 + 0.3

					if var_372_22 + var_372_14 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_14
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232088", "story_v_out_416232.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232088", "story_v_out_416232.awb") / 1000

					if var_372_23 + var_372_14 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_14
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_416232", "416232088", "story_v_out_416232.awb")

						arg_369_1:RecordAudio("416232088", var_372_24)
						arg_369_1:RecordAudio("416232088", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_416232", "416232088", "story_v_out_416232.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_416232", "416232088", "story_v_out_416232.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = var_372_14 + 0.3
			local var_372_26 = math.max(var_372_15, arg_369_1.talkMaxDuration)

			if var_372_25 <= arg_369_1.time_ and arg_369_1.time_ < var_372_25 + var_372_26 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_25) / var_372_26

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_25 + var_372_26 and arg_369_1.time_ < var_372_25 + var_372_26 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play416232089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 416232089
		arg_375_1.duration_ = 7.13

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play416232090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.bgs_.SS1610.transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPosSS1610 = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(8, 1, 10)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPosSS1610, var_378_4, var_378_3)
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(8, 1, 10)
			end

			local var_378_5 = arg_375_1.bgs_.SS1610.transform
			local var_378_6 = 0.0166666666666667

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.var_.moveOldPosSS1610 = var_378_5.localPosition
			end

			local var_378_7 = 2.41666666666667

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_7 then
				local var_378_8 = (arg_375_1.time_ - var_378_6) / var_378_7
				local var_378_9 = Vector3.New(-5.84, 1, 10)

				var_378_5.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPosSS1610, var_378_9, var_378_8)
			end

			if arg_375_1.time_ >= var_378_6 + var_378_7 and arg_375_1.time_ < var_378_6 + var_378_7 + arg_378_0 then
				var_378_5.localPosition = Vector3.New(-5.84, 1, 10)
			end

			local var_378_10 = manager.ui.mainCamera.transform
			local var_378_11 = 0.5

			if var_378_11 < arg_375_1.time_ and arg_375_1.time_ <= var_378_11 + arg_378_0 then
				local var_378_12 = arg_375_1.var_.effect116
				local var_378_13
				local var_378_14 = var_378_10

				if not var_378_12 then
					var_378_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_378_14)
					var_378_12.name = "116"
					arg_375_1.var_.effect116 = var_378_12
				else
					var_378_12.transform:SetParent(var_378_14)
				end

				var_378_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_378_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_378_15 = manager.ui.mainCameraCom_
				local var_378_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_378_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_378_17 = var_378_12.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_378_18 = 15
				local var_378_19 = 2 * var_378_18 * Mathf.Tan(var_378_15.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_378_15.aspect
				local var_378_20 = 1
				local var_378_21 = 1.7777777777777777

				if var_378_21 < var_378_15.aspect then
					var_378_20 = var_378_19 / (2 * var_378_18 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_378_21)
				end

				for iter_378_0, iter_378_1 in ipairs(var_378_17) do
					local var_378_22 = iter_378_1.transform.localScale

					iter_378_1.transform.localScale = Vector3.New(var_378_22.x / var_378_16 * var_378_20, var_378_22.y / var_378_16, var_378_22.z)
				end
			end

			local var_378_23 = manager.ui.mainCamera.transform
			local var_378_24 = 1.1

			if var_378_24 < arg_375_1.time_ and arg_375_1.time_ <= var_378_24 + arg_378_0 then
				local var_378_25 = arg_375_1.var_.effect116

				if var_378_25 then
					Object.Destroy(var_378_25)

					arg_375_1.var_.effect116 = nil
				end
			end

			local var_378_26 = 0

			if var_378_26 < arg_375_1.time_ and arg_375_1.time_ <= var_378_26 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			local var_378_27 = 3.13333333333333

			if arg_375_1.time_ >= var_378_26 + var_378_27 and arg_375_1.time_ < var_378_26 + var_378_27 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			local var_378_28 = manager.ui.mainCamera.transform
			local var_378_29 = 0.933333333333334

			if var_378_29 < arg_375_1.time_ and arg_375_1.time_ <= var_378_29 + arg_378_0 then
				local var_378_30 = arg_375_1.var_.effect118
				local var_378_31
				local var_378_32 = var_378_28

				if not var_378_30 then
					var_378_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_378_32)
					var_378_30.name = "118"
					arg_375_1.var_.effect118 = var_378_30
				else
					var_378_30.transform:SetParent(var_378_32)
				end

				var_378_30.transform.localPosition = Vector3.New(-0.55, 0.42, 0)
				var_378_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_378_33 = manager.ui.mainCameraCom_
				local var_378_34 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_378_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_378_35 = var_378_30.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_378_36 = 15
				local var_378_37 = 2 * var_378_36 * Mathf.Tan(var_378_33.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_378_33.aspect
				local var_378_38 = 1
				local var_378_39 = 1.7777777777777777

				if var_378_39 < var_378_33.aspect then
					var_378_38 = var_378_37 / (2 * var_378_36 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_378_39)
				end

				for iter_378_2, iter_378_3 in ipairs(var_378_35) do
					local var_378_40 = iter_378_3.transform.localScale

					iter_378_3.transform.localScale = Vector3.New(var_378_40.x / var_378_34 * var_378_38, var_378_40.y / var_378_34, var_378_40.z)
				end
			end

			local var_378_41 = manager.ui.mainCamera.transform
			local var_378_42 = 1.53333333333333

			if var_378_42 < arg_375_1.time_ and arg_375_1.time_ <= var_378_42 + arg_378_0 then
				local var_378_43 = arg_375_1.var_.effect118

				if var_378_43 then
					Object.Destroy(var_378_43)

					arg_375_1.var_.effect118 = nil
				end
			end

			local var_378_44 = 1.4

			if var_378_44 < arg_375_1.time_ and arg_375_1.time_ <= var_378_44 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_45 = 0.466666666666667

			if var_378_44 <= arg_375_1.time_ and arg_375_1.time_ < var_378_44 + var_378_45 then
				local var_378_46 = (arg_375_1.time_ - var_378_44) / var_378_45
				local var_378_47 = Color.New(1, 1, 1)

				var_378_47.a = Mathf.Lerp(1, 0, var_378_46)
				arg_375_1.mask_.color = var_378_47
			end

			if arg_375_1.time_ >= var_378_44 + var_378_45 and arg_375_1.time_ < var_378_44 + var_378_45 + arg_378_0 then
				local var_378_48 = Color.New(1, 1, 1)
				local var_378_49 = 0

				arg_375_1.mask_.enabled = false
				var_378_48.a = var_378_49
				arg_375_1.mask_.color = var_378_48
			end

			local var_378_50 = 0
			local var_378_51 = 1

			if var_378_50 < arg_375_1.time_ and arg_375_1.time_ <= var_378_50 + arg_378_0 then
				local var_378_52 = "stop"
				local var_378_53 = "effect"

				arg_375_1:AudioAction(var_378_52, var_378_53, "se_story_139", "se_story_2_stun_loop", "")
			end

			local var_378_54 = 1.43333333333333
			local var_378_55 = 1

			if var_378_54 < arg_375_1.time_ and arg_375_1.time_ <= var_378_54 + arg_378_0 then
				local var_378_56 = "play"
				local var_378_57 = "effect"

				arg_375_1:AudioAction(var_378_56, var_378_57, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_378_58 = 0.5
			local var_378_59 = 1

			if var_378_58 < arg_375_1.time_ and arg_375_1.time_ <= var_378_58 + arg_378_0 then
				local var_378_60 = "play"
				local var_378_61 = "effect"

				arg_375_1:AudioAction(var_378_60, var_378_61, "se_story_122_01", "se_story_122_01_thunder", "")
			end

			if arg_375_1.frameCnt_ <= 1 then
				arg_375_1.dialog_:SetActive(false)
			end

			local var_378_62 = 2.13333333333333
			local var_378_63 = 1.6

			if var_378_62 < arg_375_1.time_ and arg_375_1.time_ <= var_378_62 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_64 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_64:setOnUpdate(LuaHelper.FloatAction(function(arg_379_0)
					arg_375_1.dialogCg_.alpha = arg_379_0
				end))
				var_378_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_65 = arg_375_1:GetWordFromCfg(416232089)
				local var_378_66 = arg_375_1:FormatText(var_378_65.content)

				arg_375_1.text_.text = var_378_66

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_67 = 64
				local var_378_68 = utf8.len(var_378_66)
				local var_378_69 = var_378_67 <= 0 and var_378_63 or var_378_63 * (var_378_68 / var_378_67)

				if var_378_69 > 0 and var_378_63 < var_378_69 then
					arg_375_1.talkMaxDuration = var_378_69
					var_378_62 = var_378_62 + 0.3

					if var_378_69 + var_378_62 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_69 + var_378_62
					end
				end

				arg_375_1.text_.text = var_378_66
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_70 = var_378_62 + 0.3
			local var_378_71 = math.max(var_378_63, arg_375_1.talkMaxDuration)

			if var_378_70 <= arg_375_1.time_ and arg_375_1.time_ < var_378_70 + var_378_71 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_70) / var_378_71

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_70 + var_378_71 and arg_375_1.time_ < var_378_70 + var_378_71 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.41666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play416232090 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 416232090
		arg_381_1.duration_ = 3.13

		local var_381_0 = {
			zh = 2.133,
			ja = 3.133
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play416232091(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.275

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[327].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_3 = arg_381_1:GetWordFromCfg(416232090)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 11
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232090", "story_v_out_416232.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232090", "story_v_out_416232.awb") / 1000

					if var_384_8 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_0
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_out_416232", "416232090", "story_v_out_416232.awb")

						arg_381_1:RecordAudio("416232090", var_384_9)
						arg_381_1:RecordAudio("416232090", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_416232", "416232090", "story_v_out_416232.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_416232", "416232090", "story_v_out_416232.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_10 and arg_381_1.time_ < var_384_0 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play416232091 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 416232091
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play416232092(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.1
			local var_388_1 = 1

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				local var_388_2 = "play"
				local var_388_3 = "effect"

				arg_385_1:AudioAction(var_388_2, var_388_3, "se_story_139", "se_story_139_thunderenergy", "")
			end

			local var_388_4 = 0
			local var_388_5 = 1.325

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(416232091)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_8 = 53
				local var_388_9 = utf8.len(var_388_7)
				local var_388_10 = var_388_8 <= 0 and var_388_5 or var_388_5 * (var_388_9 / var_388_8)

				if var_388_10 > 0 and var_388_5 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_11 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_11 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_11

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_11 and arg_385_1.time_ < var_388_4 + var_388_11 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play416232092 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 416232092
		arg_389_1.duration_ = 1.9

		local var_389_0 = {
			zh = 1.9,
			ja = 1.566
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play416232093(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1028"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps1028 == nil then
				arg_389_1.var_.actorSpriteComps1028 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps1028 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								local var_392_4 = Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, var_392_3)
								local var_392_5 = Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, var_392_3)
								local var_392_6 = Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, var_392_3)

								iter_392_1.color = Color.New(var_392_4, var_392_5, var_392_6)
							else
								local var_392_7 = Mathf.Lerp(iter_392_1.color.r, 1, var_392_3)

								iter_392_1.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps1028 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_392_3 then
						if arg_389_1.isInRecall_ then
							iter_392_3.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1028 = nil
			end

			local var_392_8 = 0
			local var_392_9 = 0.15

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_10 = arg_389_1:FormatText(StoryNameCfg[327].name)

				arg_389_1.leftNameTxt_.text = var_392_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_11 = arg_389_1:GetWordFromCfg(416232092)
				local var_392_12 = arg_389_1:FormatText(var_392_11.content)

				arg_389_1.text_.text = var_392_12

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_13 = 6
				local var_392_14 = utf8.len(var_392_12)
				local var_392_15 = var_392_13 <= 0 and var_392_9 or var_392_9 * (var_392_14 / var_392_13)

				if var_392_15 > 0 and var_392_9 < var_392_15 then
					arg_389_1.talkMaxDuration = var_392_15

					if var_392_15 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_15 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_12
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232092", "story_v_out_416232.awb") ~= 0 then
					local var_392_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232092", "story_v_out_416232.awb") / 1000

					if var_392_16 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_16 + var_392_8
					end

					if var_392_11.prefab_name ~= "" and arg_389_1.actors_[var_392_11.prefab_name] ~= nil then
						local var_392_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_11.prefab_name].transform, "story_v_out_416232", "416232092", "story_v_out_416232.awb")

						arg_389_1:RecordAudio("416232092", var_392_17)
						arg_389_1:RecordAudio("416232092", var_392_17)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_416232", "416232092", "story_v_out_416232.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_416232", "416232092", "story_v_out_416232.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_18 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_18 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_18

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_18 and arg_389_1.time_ < var_392_8 + var_392_18 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play416232093 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 416232093
		arg_393_1.duration_ = 3.77

		local var_393_0 = {
			zh = 2.33266666666667,
			ja = 3.76666666666667
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play416232094(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				local var_396_1 = manager.ui.mainCamera.transform.localPosition
				local var_396_2 = Vector3.New(0, 0, 10) + Vector3.New(var_396_1.x, var_396_1.y, 0)
				local var_396_3 = arg_393_1.bgs_.STwhite

				var_396_3.transform.localPosition = var_396_2
				var_396_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_4 = var_396_3:GetComponent("SpriteRenderer")

				if var_396_4 and var_396_4.sprite then
					local var_396_5 = (var_396_3.transform.localPosition - var_396_1).z
					local var_396_6 = manager.ui.mainCameraCom_
					local var_396_7 = 2 * var_396_5 * Mathf.Tan(var_396_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_396_8 = var_396_7 * var_396_6.aspect
					local var_396_9 = var_396_4.sprite.bounds.size.x
					local var_396_10 = var_396_4.sprite.bounds.size.y
					local var_396_11 = var_396_8 / var_396_9
					local var_396_12 = var_396_7 / var_396_10
					local var_396_13 = var_396_12 < var_396_11 and var_396_11 or var_396_12

					var_396_3.transform.localScale = Vector3.New(var_396_13, var_396_13, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STwhite" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			local var_396_15 = 0.3

			if arg_393_1.time_ >= var_396_14 + var_396_15 and arg_393_1.time_ < var_396_14 + var_396_15 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_16 = 0

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_17 = 1.63333333333333

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_17 then
				local var_396_18 = (arg_393_1.time_ - var_396_16) / var_396_17
				local var_396_19 = Color.New(0, 0, 0)

				var_396_19.a = Mathf.Lerp(1, 0, var_396_18)
				arg_393_1.mask_.color = var_396_19
			end

			if arg_393_1.time_ >= var_396_16 + var_396_17 and arg_393_1.time_ < var_396_16 + var_396_17 + arg_396_0 then
				local var_396_20 = Color.New(0, 0, 0)
				local var_396_21 = 0

				arg_393_1.mask_.enabled = false
				var_396_20.a = var_396_21
				arg_393_1.mask_.color = var_396_20
			end

			local var_396_22 = arg_393_1.actors_["1028"]
			local var_396_23 = 0

			if var_396_23 < arg_393_1.time_ and arg_393_1.time_ <= var_396_23 + arg_396_0 and not isNil(var_396_22) and arg_393_1.var_.actorSpriteComps1028 == nil then
				arg_393_1.var_.actorSpriteComps1028 = var_396_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_24 = 0.2

			if var_396_23 <= arg_393_1.time_ and arg_393_1.time_ < var_396_23 + var_396_24 and not isNil(var_396_22) then
				local var_396_25 = (arg_393_1.time_ - var_396_23) / var_396_24

				if arg_393_1.var_.actorSpriteComps1028 then
					for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_396_3 then
							if arg_393_1.isInRecall_ then
								local var_396_26 = Mathf.Lerp(iter_396_3.color.r, arg_393_1.hightColor1.r, var_396_25)
								local var_396_27 = Mathf.Lerp(iter_396_3.color.g, arg_393_1.hightColor1.g, var_396_25)
								local var_396_28 = Mathf.Lerp(iter_396_3.color.b, arg_393_1.hightColor1.b, var_396_25)

								iter_396_3.color = Color.New(var_396_26, var_396_27, var_396_28)
							else
								local var_396_29 = Mathf.Lerp(iter_396_3.color.r, 1, var_396_25)

								iter_396_3.color = Color.New(var_396_29, var_396_29, var_396_29)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_23 + var_396_24 and arg_393_1.time_ < var_396_23 + var_396_24 + arg_396_0 and not isNil(var_396_22) and arg_393_1.var_.actorSpriteComps1028 then
				for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_396_5 then
						if arg_393_1.isInRecall_ then
							iter_396_5.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1028 = nil
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_30 = 0.566666666666667
			local var_396_31 = 0.125

			if var_396_30 < arg_393_1.time_ and arg_393_1.time_ <= var_396_30 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_32 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_32:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_33 = arg_393_1:FormatText(StoryNameCfg[327].name)

				arg_393_1.leftNameTxt_.text = var_396_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_34 = arg_393_1:GetWordFromCfg(416232093)
				local var_396_35 = arg_393_1:FormatText(var_396_34.content)

				arg_393_1.text_.text = var_396_35

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_36 = 5
				local var_396_37 = utf8.len(var_396_35)
				local var_396_38 = var_396_36 <= 0 and var_396_31 or var_396_31 * (var_396_37 / var_396_36)

				if var_396_38 > 0 and var_396_31 < var_396_38 then
					arg_393_1.talkMaxDuration = var_396_38
					var_396_30 = var_396_30 + 0.3

					if var_396_38 + var_396_30 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_38 + var_396_30
					end
				end

				arg_393_1.text_.text = var_396_35
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232093", "story_v_out_416232.awb") ~= 0 then
					local var_396_39 = manager.audio:GetVoiceLength("story_v_out_416232", "416232093", "story_v_out_416232.awb") / 1000

					if var_396_39 + var_396_30 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_39 + var_396_30
					end

					if var_396_34.prefab_name ~= "" and arg_393_1.actors_[var_396_34.prefab_name] ~= nil then
						local var_396_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_34.prefab_name].transform, "story_v_out_416232", "416232093", "story_v_out_416232.awb")

						arg_393_1:RecordAudio("416232093", var_396_40)
						arg_393_1:RecordAudio("416232093", var_396_40)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_416232", "416232093", "story_v_out_416232.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_416232", "416232093", "story_v_out_416232.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_41 = var_396_30 + 0.3
			local var_396_42 = math.max(var_396_31, arg_393_1.talkMaxDuration)

			if var_396_41 <= arg_393_1.time_ and arg_393_1.time_ < var_396_41 + var_396_42 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_41) / var_396_42

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_41 + var_396_42 and arg_393_1.time_ < var_396_41 + var_396_42 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play416232094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 416232094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play416232095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.0249999999999999
			local var_402_1 = 1

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				local var_402_2 = "play"
				local var_402_3 = "effect"

				arg_399_1:AudioAction(var_402_2, var_402_3, "se_story_139", "se_story_139_thunderskill", "")
			end

			local var_402_4 = 0
			local var_402_5 = 1.025

			if var_402_4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(416232094)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_8 = 41
				local var_402_9 = utf8.len(var_402_7)
				local var_402_10 = var_402_8 <= 0 and var_402_5 or var_402_5 * (var_402_9 / var_402_8)

				if var_402_10 > 0 and var_402_5 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_11 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_11 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_11

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_11 and arg_399_1.time_ < var_402_4 + var_402_11 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play416232095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 416232095
		arg_403_1.duration_ = 9.9

		local var_403_0 = {
			zh = 8.066,
			ja = 9.9
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
				arg_403_0:Play416232096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 2.5

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				local var_406_1 = manager.ui.mainCamera.transform.localPosition
				local var_406_2 = Vector3.New(0, 0, 10) + Vector3.New(var_406_1.x, var_406_1.y, 0)
				local var_406_3 = arg_403_1.bgs_.F09f

				var_406_3.transform.localPosition = var_406_2
				var_406_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_4 = var_406_3:GetComponent("SpriteRenderer")

				if var_406_4 and var_406_4.sprite then
					local var_406_5 = (var_406_3.transform.localPosition - var_406_1).z
					local var_406_6 = manager.ui.mainCameraCom_
					local var_406_7 = 2 * var_406_5 * Mathf.Tan(var_406_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_406_8 = var_406_7 * var_406_6.aspect
					local var_406_9 = var_406_4.sprite.bounds.size.x
					local var_406_10 = var_406_4.sprite.bounds.size.y
					local var_406_11 = var_406_8 / var_406_9
					local var_406_12 = var_406_7 / var_406_10
					local var_406_13 = var_406_12 < var_406_11 and var_406_11 or var_406_12

					var_406_3.transform.localScale = Vector3.New(var_406_13, var_406_13, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "F09f" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_14 = 2.5

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			local var_406_15 = 0.3

			if arg_403_1.time_ >= var_406_14 + var_406_15 and arg_403_1.time_ < var_406_14 + var_406_15 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end

			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_17 = 2.5

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17
				local var_406_19 = Color.New(0, 0, 0)

				var_406_19.a = Mathf.Lerp(0, 1, var_406_18)
				arg_403_1.mask_.color = var_406_19
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 then
				local var_406_20 = Color.New(0, 0, 0)

				var_406_20.a = 1
				arg_403_1.mask_.color = var_406_20
			end

			local var_406_21 = 2.5

			if var_406_21 < arg_403_1.time_ and arg_403_1.time_ <= var_406_21 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_22 = 2

			if var_406_21 <= arg_403_1.time_ and arg_403_1.time_ < var_406_21 + var_406_22 then
				local var_406_23 = (arg_403_1.time_ - var_406_21) / var_406_22
				local var_406_24 = Color.New(0, 0, 0)

				var_406_24.a = Mathf.Lerp(1, 0, var_406_23)
				arg_403_1.mask_.color = var_406_24
			end

			if arg_403_1.time_ >= var_406_21 + var_406_22 and arg_403_1.time_ < var_406_21 + var_406_22 + arg_406_0 then
				local var_406_25 = Color.New(0, 0, 0)
				local var_406_26 = 0

				arg_403_1.mask_.enabled = false
				var_406_25.a = var_406_26
				arg_403_1.mask_.color = var_406_25
			end

			local var_406_27 = 0.733333333333333
			local var_406_28 = 0.2

			if var_406_27 < arg_403_1.time_ and arg_403_1.time_ <= var_406_27 + arg_406_0 then
				local var_406_29 = "play"
				local var_406_30 = "music"

				arg_403_1:AudioAction(var_406_29, var_406_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_406_31 = ""
				local var_406_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_406_32 ~= "" then
					if arg_403_1.bgmTxt_.text ~= var_406_32 and arg_403_1.bgmTxt_.text ~= "" then
						if arg_403_1.bgmTxt2_.text ~= "" then
							arg_403_1.bgmTxt_.text = arg_403_1.bgmTxt2_.text
						end

						arg_403_1.bgmTxt2_.text = var_406_32

						arg_403_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_403_1.bgmTxt_.text = var_406_32
						arg_403_1.bgmTxt2_.text = var_406_32
					end

					if arg_403_1.bgmTimer then
						arg_403_1.bgmTimer:Stop()

						arg_403_1.bgmTimer = nil
					end

					if arg_403_1.settingData.show_music_name == 1 then
						arg_403_1.musicController:SetSelectedState("show")
						arg_403_1.musicAnimator_:Play("open", 0, 0)

						if arg_403_1.settingData.music_time ~= 0 then
							arg_403_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_403_1.settingData.music_time), function()
								if arg_403_1 == nil or isNil(arg_403_1.bgmTxt_) then
									return
								end

								arg_403_1.musicController:SetSelectedState("hide")
								arg_403_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_406_33 = 1.2
			local var_406_34 = 1

			if var_406_33 < arg_403_1.time_ and arg_403_1.time_ <= var_406_33 + arg_406_0 then
				local var_406_35 = "play"
				local var_406_36 = "music"

				arg_403_1:AudioAction(var_406_35, var_406_36, "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_406_37 = ""
				local var_406_38 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

				if var_406_38 ~= "" then
					if arg_403_1.bgmTxt_.text ~= var_406_38 and arg_403_1.bgmTxt_.text ~= "" then
						if arg_403_1.bgmTxt2_.text ~= "" then
							arg_403_1.bgmTxt_.text = arg_403_1.bgmTxt2_.text
						end

						arg_403_1.bgmTxt2_.text = var_406_38

						arg_403_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_403_1.bgmTxt_.text = var_406_38
						arg_403_1.bgmTxt2_.text = var_406_38
					end

					if arg_403_1.bgmTimer then
						arg_403_1.bgmTimer:Stop()

						arg_403_1.bgmTimer = nil
					end

					if arg_403_1.settingData.show_music_name == 1 then
						arg_403_1.musicController:SetSelectedState("show")
						arg_403_1.musicAnimator_:Play("open", 0, 0)

						if arg_403_1.settingData.music_time ~= 0 then
							arg_403_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_403_1.settingData.music_time), function()
								if arg_403_1 == nil or isNil(arg_403_1.bgmTxt_) then
									return
								end

								arg_403_1.musicController:SetSelectedState("hide")
								arg_403_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_39 = 4.5
			local var_406_40 = 0.2

			if var_406_39 < arg_403_1.time_ and arg_403_1.time_ <= var_406_39 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_41 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_41:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_403_1.dialogCg_.alpha = arg_409_0
				end))
				var_406_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_42 = arg_403_1:FormatText(StoryNameCfg[236].name)

				arg_403_1.leftNameTxt_.text = var_406_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_43 = arg_403_1:GetWordFromCfg(416232095)
				local var_406_44 = arg_403_1:FormatText(var_406_43.content)

				arg_403_1.text_.text = var_406_44

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_45 = 8
				local var_406_46 = utf8.len(var_406_44)
				local var_406_47 = var_406_45 <= 0 and var_406_40 or var_406_40 * (var_406_46 / var_406_45)

				if var_406_47 > 0 and var_406_40 < var_406_47 then
					arg_403_1.talkMaxDuration = var_406_47
					var_406_39 = var_406_39 + 0.3

					if var_406_47 + var_406_39 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_47 + var_406_39
					end
				end

				arg_403_1.text_.text = var_406_44
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232095", "story_v_out_416232.awb") ~= 0 then
					local var_406_48 = manager.audio:GetVoiceLength("story_v_out_416232", "416232095", "story_v_out_416232.awb") / 1000

					if var_406_48 + var_406_39 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_48 + var_406_39
					end

					if var_406_43.prefab_name ~= "" and arg_403_1.actors_[var_406_43.prefab_name] ~= nil then
						local var_406_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_43.prefab_name].transform, "story_v_out_416232", "416232095", "story_v_out_416232.awb")

						arg_403_1:RecordAudio("416232095", var_406_49)
						arg_403_1:RecordAudio("416232095", var_406_49)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_416232", "416232095", "story_v_out_416232.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_416232", "416232095", "story_v_out_416232.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_50 = var_406_39 + 0.3
			local var_406_51 = math.max(var_406_40, arg_403_1.talkMaxDuration)

			if var_406_50 <= arg_403_1.time_ and arg_403_1.time_ < var_406_50 + var_406_51 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_50) / var_406_51

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_50 + var_406_51 and arg_403_1.time_ < var_406_50 + var_406_51 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play416232096 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 416232096
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play416232097(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 1.3

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(416232096)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 52
				local var_414_5 = utf8.len(var_414_3)
				local var_414_6 = var_414_4 <= 0 and var_414_1 or var_414_1 * (var_414_5 / var_414_4)

				if var_414_6 > 0 and var_414_1 < var_414_6 then
					arg_411_1.talkMaxDuration = var_414_6

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_7 and arg_411_1.time_ < var_414_0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play416232097 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 416232097
		arg_415_1.duration_ = 4.37

		local var_415_0 = {
			zh = 4.3,
			ja = 4.366
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
				arg_415_0:Play416232098(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1028"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1028 == nil then
				arg_415_1.var_.actorSpriteComps1028 = var_418_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.actorSpriteComps1028 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1028 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_418_3 then
						if arg_415_1.isInRecall_ then
							iter_418_3.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps1028 = nil
			end

			local var_418_8 = arg_415_1.actors_["1028"].transform
			local var_418_9 = 0

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 then
				arg_415_1.var_.moveOldPos1028 = var_418_8.localPosition
				var_418_8.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("1028", 3)

				local var_418_10 = var_418_8.childCount

				for iter_418_4 = 0, var_418_10 - 1 do
					local var_418_11 = var_418_8:GetChild(iter_418_4)

					if var_418_11.name == "split_2" or not string.find(var_418_11.name, "split") then
						var_418_11.gameObject:SetActive(true)
					else
						var_418_11.gameObject:SetActive(false)
					end
				end
			end

			local var_418_12 = 0.001

			if var_418_9 <= arg_415_1.time_ and arg_415_1.time_ < var_418_9 + var_418_12 then
				local var_418_13 = (arg_415_1.time_ - var_418_9) / var_418_12
				local var_418_14 = Vector3.New(0, -402.7, -156.1)

				var_418_8.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1028, var_418_14, var_418_13)
			end

			if arg_415_1.time_ >= var_418_9 + var_418_12 and arg_415_1.time_ < var_418_9 + var_418_12 + arg_418_0 then
				var_418_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_418_15 = 0
			local var_418_16 = 0.55

			if var_418_15 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_17 = arg_415_1:FormatText(StoryNameCfg[327].name)

				arg_415_1.leftNameTxt_.text = var_418_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_18 = arg_415_1:GetWordFromCfg(416232097)
				local var_418_19 = arg_415_1:FormatText(var_418_18.content)

				arg_415_1.text_.text = var_418_19

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_20 = 22
				local var_418_21 = utf8.len(var_418_19)
				local var_418_22 = var_418_20 <= 0 and var_418_16 or var_418_16 * (var_418_21 / var_418_20)

				if var_418_22 > 0 and var_418_16 < var_418_22 then
					arg_415_1.talkMaxDuration = var_418_22

					if var_418_22 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_22 + var_418_15
					end
				end

				arg_415_1.text_.text = var_418_19
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232097", "story_v_out_416232.awb") ~= 0 then
					local var_418_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232097", "story_v_out_416232.awb") / 1000

					if var_418_23 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_15
					end

					if var_418_18.prefab_name ~= "" and arg_415_1.actors_[var_418_18.prefab_name] ~= nil then
						local var_418_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_18.prefab_name].transform, "story_v_out_416232", "416232097", "story_v_out_416232.awb")

						arg_415_1:RecordAudio("416232097", var_418_24)
						arg_415_1:RecordAudio("416232097", var_418_24)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_416232", "416232097", "story_v_out_416232.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_416232", "416232097", "story_v_out_416232.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_25 = math.max(var_418_16, arg_415_1.talkMaxDuration)

			if var_418_15 <= arg_415_1.time_ and arg_415_1.time_ < var_418_15 + var_418_25 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_15) / var_418_25

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_15 + var_418_25 and arg_415_1.time_ < var_418_15 + var_418_25 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
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

		arg_415_1:InitPlayNodeList()
	end,
	Play416232098 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 416232098
		arg_419_1.duration_ = 2.43

		local var_419_0 = {
			zh = 2.266,
			ja = 2.433
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play416232099(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.1

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[327].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:GetWordFromCfg(416232098)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 4
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232098", "story_v_out_416232.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232098", "story_v_out_416232.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_416232", "416232098", "story_v_out_416232.awb")

						arg_419_1:RecordAudio("416232098", var_422_9)
						arg_419_1:RecordAudio("416232098", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_416232", "416232098", "story_v_out_416232.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_416232", "416232098", "story_v_out_416232.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play416232099 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 416232099
		arg_423_1.duration_ = 8.5

		local var_423_0 = {
			zh = 8.433,
			ja = 8.5
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play416232100(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1028"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.actorSpriteComps1028 == nil then
				arg_423_1.var_.actorSpriteComps1028 = var_426_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.actorSpriteComps1028 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								local var_426_4 = Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor2.r, var_426_3)
								local var_426_5 = Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor2.g, var_426_3)
								local var_426_6 = Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor2.b, var_426_3)

								iter_426_1.color = Color.New(var_426_4, var_426_5, var_426_6)
							else
								local var_426_7 = Mathf.Lerp(iter_426_1.color.r, 0.5, var_426_3)

								iter_426_1.color = Color.New(var_426_7, var_426_7, var_426_7)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.actorSpriteComps1028 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_426_3 then
						if arg_423_1.isInRecall_ then
							iter_426_3.color = arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_426_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_423_1.var_.actorSpriteComps1028 = nil
			end

			local var_426_8 = 0
			local var_426_9 = 0.425

			if var_426_8 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_10 = arg_423_1:FormatText(StoryNameCfg[1093].name)

				arg_423_1.leftNameTxt_.text = var_426_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_11 = arg_423_1:GetWordFromCfg(416232099)
				local var_426_12 = arg_423_1:FormatText(var_426_11.content)

				arg_423_1.text_.text = var_426_12

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_13 = 17
				local var_426_14 = utf8.len(var_426_12)
				local var_426_15 = var_426_13 <= 0 and var_426_9 or var_426_9 * (var_426_14 / var_426_13)

				if var_426_15 > 0 and var_426_9 < var_426_15 then
					arg_423_1.talkMaxDuration = var_426_15

					if var_426_15 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_15 + var_426_8
					end
				end

				arg_423_1.text_.text = var_426_12
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232099", "story_v_out_416232.awb") ~= 0 then
					local var_426_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232099", "story_v_out_416232.awb") / 1000

					if var_426_16 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_16 + var_426_8
					end

					if var_426_11.prefab_name ~= "" and arg_423_1.actors_[var_426_11.prefab_name] ~= nil then
						local var_426_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_11.prefab_name].transform, "story_v_out_416232", "416232099", "story_v_out_416232.awb")

						arg_423_1:RecordAudio("416232099", var_426_17)
						arg_423_1:RecordAudio("416232099", var_426_17)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_416232", "416232099", "story_v_out_416232.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_416232", "416232099", "story_v_out_416232.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_18 = math.max(var_426_9, arg_423_1.talkMaxDuration)

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_18 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_8) / var_426_18

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_8 + var_426_18 and arg_423_1.time_ < var_426_8 + var_426_18 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play416232100 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 416232100
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play416232101(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10109"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.actorSpriteComps10109 == nil then
				arg_427_1.var_.actorSpriteComps10109 = var_430_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_2 = 0.2

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.actorSpriteComps10109 then
					for iter_430_0, iter_430_1 in pairs(arg_427_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_430_1 then
							if arg_427_1.isInRecall_ then
								local var_430_4 = Mathf.Lerp(iter_430_1.color.r, arg_427_1.hightColor2.r, var_430_3)
								local var_430_5 = Mathf.Lerp(iter_430_1.color.g, arg_427_1.hightColor2.g, var_430_3)
								local var_430_6 = Mathf.Lerp(iter_430_1.color.b, arg_427_1.hightColor2.b, var_430_3)

								iter_430_1.color = Color.New(var_430_4, var_430_5, var_430_6)
							else
								local var_430_7 = Mathf.Lerp(iter_430_1.color.r, 0.5, var_430_3)

								iter_430_1.color = Color.New(var_430_7, var_430_7, var_430_7)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.actorSpriteComps10109 then
				for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_430_3 then
						if arg_427_1.isInRecall_ then
							iter_430_3.color = arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_430_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_427_1.var_.actorSpriteComps10109 = nil
			end

			local var_430_8 = arg_427_1.actors_["1028"].transform
			local var_430_9 = 0

			if var_430_9 < arg_427_1.time_ and arg_427_1.time_ <= var_430_9 + arg_430_0 then
				arg_427_1.var_.moveOldPos1028 = var_430_8.localPosition
				var_430_8.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("1028", 7)

				local var_430_10 = var_430_8.childCount

				for iter_430_4 = 0, var_430_10 - 1 do
					local var_430_11 = var_430_8:GetChild(iter_430_4)

					if var_430_11.name == "" or not string.find(var_430_11.name, "split") then
						var_430_11.gameObject:SetActive(true)
					else
						var_430_11.gameObject:SetActive(false)
					end
				end
			end

			local var_430_12 = 0.001

			if var_430_9 <= arg_427_1.time_ and arg_427_1.time_ < var_430_9 + var_430_12 then
				local var_430_13 = (arg_427_1.time_ - var_430_9) / var_430_12
				local var_430_14 = Vector3.New(0, -2000, 0)

				var_430_8.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1028, var_430_14, var_430_13)
			end

			if arg_427_1.time_ >= var_430_9 + var_430_12 and arg_427_1.time_ < var_430_9 + var_430_12 + arg_430_0 then
				var_430_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_430_15 = 0.2
			local var_430_16 = 1

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 then
				local var_430_17 = "play"
				local var_430_18 = "effect"

				arg_427_1:AudioAction(var_430_17, var_430_18, "se_story_16", "se_story_16_thunder", "")
			end

			local var_430_19 = 0
			local var_430_20 = 1.525

			if var_430_19 < arg_427_1.time_ and arg_427_1.time_ <= var_430_19 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_21 = arg_427_1:GetWordFromCfg(416232100)
				local var_430_22 = arg_427_1:FormatText(var_430_21.content)

				arg_427_1.text_.text = var_430_22

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_23 = 61
				local var_430_24 = utf8.len(var_430_22)
				local var_430_25 = var_430_23 <= 0 and var_430_20 or var_430_20 * (var_430_24 / var_430_23)

				if var_430_25 > 0 and var_430_20 < var_430_25 then
					arg_427_1.talkMaxDuration = var_430_25

					if var_430_25 + var_430_19 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_25 + var_430_19
					end
				end

				arg_427_1.text_.text = var_430_22
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_26 = math.max(var_430_20, arg_427_1.talkMaxDuration)

			if var_430_19 <= arg_427_1.time_ and arg_427_1.time_ < var_430_19 + var_430_26 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_19) / var_430_26

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_19 + var_430_26 and arg_427_1.time_ < var_430_19 + var_430_26 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play416232101 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 416232101
		arg_431_1.duration_ = 7.23

		local var_431_0 = {
			zh = 5.133,
			ja = 7.233
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play416232102(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["10109"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps10109 == nil then
				arg_431_1.var_.actorSpriteComps10109 = var_434_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.actorSpriteComps10109 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								local var_434_4 = Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor1.r, var_434_3)
								local var_434_5 = Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor1.g, var_434_3)
								local var_434_6 = Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor1.b, var_434_3)

								iter_434_1.color = Color.New(var_434_4, var_434_5, var_434_6)
							else
								local var_434_7 = Mathf.Lerp(iter_434_1.color.r, 1, var_434_3)

								iter_434_1.color = Color.New(var_434_7, var_434_7, var_434_7)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps10109 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_434_3 then
						if arg_431_1.isInRecall_ then
							iter_434_3.color = arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_434_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_431_1.var_.actorSpriteComps10109 = nil
			end

			local var_434_8 = 0
			local var_434_9 = 0.175

			if var_434_8 < arg_431_1.time_ and arg_431_1.time_ <= var_434_8 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_10 = arg_431_1:FormatText(StoryNameCfg[1093].name)

				arg_431_1.leftNameTxt_.text = var_434_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_11 = arg_431_1:GetWordFromCfg(416232101)
				local var_434_12 = arg_431_1:FormatText(var_434_11.content)

				arg_431_1.text_.text = var_434_12

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_13 = 7
				local var_434_14 = utf8.len(var_434_12)
				local var_434_15 = var_434_13 <= 0 and var_434_9 or var_434_9 * (var_434_14 / var_434_13)

				if var_434_15 > 0 and var_434_9 < var_434_15 then
					arg_431_1.talkMaxDuration = var_434_15

					if var_434_15 + var_434_8 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_15 + var_434_8
					end
				end

				arg_431_1.text_.text = var_434_12
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232101", "story_v_out_416232.awb") ~= 0 then
					local var_434_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232101", "story_v_out_416232.awb") / 1000

					if var_434_16 + var_434_8 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_16 + var_434_8
					end

					if var_434_11.prefab_name ~= "" and arg_431_1.actors_[var_434_11.prefab_name] ~= nil then
						local var_434_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_11.prefab_name].transform, "story_v_out_416232", "416232101", "story_v_out_416232.awb")

						arg_431_1:RecordAudio("416232101", var_434_17)
						arg_431_1:RecordAudio("416232101", var_434_17)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_416232", "416232101", "story_v_out_416232.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_416232", "416232101", "story_v_out_416232.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_18 = math.max(var_434_9, arg_431_1.talkMaxDuration)

			if var_434_8 <= arg_431_1.time_ and arg_431_1.time_ < var_434_8 + var_434_18 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_8) / var_434_18

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_8 + var_434_18 and arg_431_1.time_ < var_434_8 + var_434_18 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play416232102 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 416232102
		arg_435_1.duration_ = 4.87

		local var_435_0 = {
			zh = 4.4,
			ja = 4.866
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play416232103(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1028"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps1028 == nil then
				arg_435_1.var_.actorSpriteComps1028 = var_438_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.actorSpriteComps1028 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								local var_438_4 = Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor1.r, var_438_3)
								local var_438_5 = Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor1.g, var_438_3)
								local var_438_6 = Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor1.b, var_438_3)

								iter_438_1.color = Color.New(var_438_4, var_438_5, var_438_6)
							else
								local var_438_7 = Mathf.Lerp(iter_438_1.color.r, 1, var_438_3)

								iter_438_1.color = Color.New(var_438_7, var_438_7, var_438_7)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps1028 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_438_3 then
						if arg_435_1.isInRecall_ then
							iter_438_3.color = arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_438_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps1028 = nil
			end

			local var_438_8 = arg_435_1.actors_["10109"]
			local var_438_9 = 0

			if var_438_9 < arg_435_1.time_ and arg_435_1.time_ <= var_438_9 + arg_438_0 and not isNil(var_438_8) and arg_435_1.var_.actorSpriteComps10109 == nil then
				arg_435_1.var_.actorSpriteComps10109 = var_438_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_10 = 0.2

			if var_438_9 <= arg_435_1.time_ and arg_435_1.time_ < var_438_9 + var_438_10 and not isNil(var_438_8) then
				local var_438_11 = (arg_435_1.time_ - var_438_9) / var_438_10

				if arg_435_1.var_.actorSpriteComps10109 then
					for iter_438_4, iter_438_5 in pairs(arg_435_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_438_5 then
							if arg_435_1.isInRecall_ then
								local var_438_12 = Mathf.Lerp(iter_438_5.color.r, arg_435_1.hightColor2.r, var_438_11)
								local var_438_13 = Mathf.Lerp(iter_438_5.color.g, arg_435_1.hightColor2.g, var_438_11)
								local var_438_14 = Mathf.Lerp(iter_438_5.color.b, arg_435_1.hightColor2.b, var_438_11)

								iter_438_5.color = Color.New(var_438_12, var_438_13, var_438_14)
							else
								local var_438_15 = Mathf.Lerp(iter_438_5.color.r, 0.5, var_438_11)

								iter_438_5.color = Color.New(var_438_15, var_438_15, var_438_15)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_9 + var_438_10 and arg_435_1.time_ < var_438_9 + var_438_10 + arg_438_0 and not isNil(var_438_8) and arg_435_1.var_.actorSpriteComps10109 then
				for iter_438_6, iter_438_7 in pairs(arg_435_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_438_7 then
						if arg_435_1.isInRecall_ then
							iter_438_7.color = arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_438_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps10109 = nil
			end

			local var_438_16 = arg_435_1.actors_["1028"].transform
			local var_438_17 = 0

			if var_438_17 < arg_435_1.time_ and arg_435_1.time_ <= var_438_17 + arg_438_0 then
				arg_435_1.var_.moveOldPos1028 = var_438_16.localPosition
				var_438_16.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("1028", 2)

				local var_438_18 = var_438_16.childCount

				for iter_438_8 = 0, var_438_18 - 1 do
					local var_438_19 = var_438_16:GetChild(iter_438_8)

					if var_438_19.name == "" or not string.find(var_438_19.name, "split") then
						var_438_19.gameObject:SetActive(true)
					else
						var_438_19.gameObject:SetActive(false)
					end
				end
			end

			local var_438_20 = 0.001

			if var_438_17 <= arg_435_1.time_ and arg_435_1.time_ < var_438_17 + var_438_20 then
				local var_438_21 = (arg_435_1.time_ - var_438_17) / var_438_20
				local var_438_22 = Vector3.New(-390, -402.7, -156.1)

				var_438_16.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1028, var_438_22, var_438_21)
			end

			if arg_435_1.time_ >= var_438_17 + var_438_20 and arg_435_1.time_ < var_438_17 + var_438_20 + arg_438_0 then
				var_438_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_438_23 = 0
			local var_438_24 = 0.375

			if var_438_23 < arg_435_1.time_ and arg_435_1.time_ <= var_438_23 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_25 = arg_435_1:FormatText(StoryNameCfg[327].name)

				arg_435_1.leftNameTxt_.text = var_438_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_26 = arg_435_1:GetWordFromCfg(416232102)
				local var_438_27 = arg_435_1:FormatText(var_438_26.content)

				arg_435_1.text_.text = var_438_27

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_28 = 15
				local var_438_29 = utf8.len(var_438_27)
				local var_438_30 = var_438_28 <= 0 and var_438_24 or var_438_24 * (var_438_29 / var_438_28)

				if var_438_30 > 0 and var_438_24 < var_438_30 then
					arg_435_1.talkMaxDuration = var_438_30

					if var_438_30 + var_438_23 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_30 + var_438_23
					end
				end

				arg_435_1.text_.text = var_438_27
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232102", "story_v_out_416232.awb") ~= 0 then
					local var_438_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232102", "story_v_out_416232.awb") / 1000

					if var_438_31 + var_438_23 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_31 + var_438_23
					end

					if var_438_26.prefab_name ~= "" and arg_435_1.actors_[var_438_26.prefab_name] ~= nil then
						local var_438_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_26.prefab_name].transform, "story_v_out_416232", "416232102", "story_v_out_416232.awb")

						arg_435_1:RecordAudio("416232102", var_438_32)
						arg_435_1:RecordAudio("416232102", var_438_32)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_416232", "416232102", "story_v_out_416232.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_416232", "416232102", "story_v_out_416232.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_33 = math.max(var_438_24, arg_435_1.talkMaxDuration)

			if var_438_23 <= arg_435_1.time_ and arg_435_1.time_ < var_438_23 + var_438_33 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_23) / var_438_33

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_23 + var_438_33 and arg_435_1.time_ < var_438_23 + var_438_33 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
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

		arg_435_1:InitPlayNodeList()
	end,
	Play416232103 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 416232103
		arg_439_1.duration_ = 6.2

		local var_439_0 = {
			zh = 4.666,
			ja = 6.2
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play416232104(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["10127"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.actorSpriteComps10127 == nil then
				arg_439_1.var_.actorSpriteComps10127 = var_442_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_2 = 0.2

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.actorSpriteComps10127 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_442_1 then
							if arg_439_1.isInRecall_ then
								local var_442_4 = Mathf.Lerp(iter_442_1.color.r, arg_439_1.hightColor1.r, var_442_3)
								local var_442_5 = Mathf.Lerp(iter_442_1.color.g, arg_439_1.hightColor1.g, var_442_3)
								local var_442_6 = Mathf.Lerp(iter_442_1.color.b, arg_439_1.hightColor1.b, var_442_3)

								iter_442_1.color = Color.New(var_442_4, var_442_5, var_442_6)
							else
								local var_442_7 = Mathf.Lerp(iter_442_1.color.r, 1, var_442_3)

								iter_442_1.color = Color.New(var_442_7, var_442_7, var_442_7)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.actorSpriteComps10127 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_442_3 then
						if arg_439_1.isInRecall_ then
							iter_442_3.color = arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_442_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_439_1.var_.actorSpriteComps10127 = nil
			end

			local var_442_8 = arg_439_1.actors_["1028"]
			local var_442_9 = 0

			if var_442_9 < arg_439_1.time_ and arg_439_1.time_ <= var_442_9 + arg_442_0 and not isNil(var_442_8) and arg_439_1.var_.actorSpriteComps1028 == nil then
				arg_439_1.var_.actorSpriteComps1028 = var_442_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_10 = 0.2

			if var_442_9 <= arg_439_1.time_ and arg_439_1.time_ < var_442_9 + var_442_10 and not isNil(var_442_8) then
				local var_442_11 = (arg_439_1.time_ - var_442_9) / var_442_10

				if arg_439_1.var_.actorSpriteComps1028 then
					for iter_442_4, iter_442_5 in pairs(arg_439_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_442_5 then
							if arg_439_1.isInRecall_ then
								local var_442_12 = Mathf.Lerp(iter_442_5.color.r, arg_439_1.hightColor2.r, var_442_11)
								local var_442_13 = Mathf.Lerp(iter_442_5.color.g, arg_439_1.hightColor2.g, var_442_11)
								local var_442_14 = Mathf.Lerp(iter_442_5.color.b, arg_439_1.hightColor2.b, var_442_11)

								iter_442_5.color = Color.New(var_442_12, var_442_13, var_442_14)
							else
								local var_442_15 = Mathf.Lerp(iter_442_5.color.r, 0.5, var_442_11)

								iter_442_5.color = Color.New(var_442_15, var_442_15, var_442_15)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_9 + var_442_10 and arg_439_1.time_ < var_442_9 + var_442_10 + arg_442_0 and not isNil(var_442_8) and arg_439_1.var_.actorSpriteComps1028 then
				for iter_442_6, iter_442_7 in pairs(arg_439_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_442_7 then
						if arg_439_1.isInRecall_ then
							iter_442_7.color = arg_439_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_442_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_439_1.var_.actorSpriteComps1028 = nil
			end

			local var_442_16 = arg_439_1.actors_["10127"].transform
			local var_442_17 = 0

			if var_442_17 < arg_439_1.time_ and arg_439_1.time_ <= var_442_17 + arg_442_0 then
				arg_439_1.var_.moveOldPos10127 = var_442_16.localPosition
				var_442_16.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("10127", 4)

				local var_442_18 = var_442_16.childCount

				for iter_442_8 = 0, var_442_18 - 1 do
					local var_442_19 = var_442_16:GetChild(iter_442_8)

					if var_442_19.name == "split_5" or not string.find(var_442_19.name, "split") then
						var_442_19.gameObject:SetActive(true)
					else
						var_442_19.gameObject:SetActive(false)
					end
				end
			end

			local var_442_20 = 0.001

			if var_442_17 <= arg_439_1.time_ and arg_439_1.time_ < var_442_17 + var_442_20 then
				local var_442_21 = (arg_439_1.time_ - var_442_17) / var_442_20
				local var_442_22 = Vector3.New(345, -387.4, -316.5)

				var_442_16.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10127, var_442_22, var_442_21)
			end

			if arg_439_1.time_ >= var_442_17 + var_442_20 and arg_439_1.time_ < var_442_17 + var_442_20 + arg_442_0 then
				var_442_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_442_23 = 0
			local var_442_24 = 0.45

			if var_442_23 < arg_439_1.time_ and arg_439_1.time_ <= var_442_23 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_25 = arg_439_1:FormatText(StoryNameCfg[236].name)

				arg_439_1.leftNameTxt_.text = var_442_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_26 = arg_439_1:GetWordFromCfg(416232103)
				local var_442_27 = arg_439_1:FormatText(var_442_26.content)

				arg_439_1.text_.text = var_442_27

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_28 = 18
				local var_442_29 = utf8.len(var_442_27)
				local var_442_30 = var_442_28 <= 0 and var_442_24 or var_442_24 * (var_442_29 / var_442_28)

				if var_442_30 > 0 and var_442_24 < var_442_30 then
					arg_439_1.talkMaxDuration = var_442_30

					if var_442_30 + var_442_23 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_30 + var_442_23
					end
				end

				arg_439_1.text_.text = var_442_27
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232103", "story_v_out_416232.awb") ~= 0 then
					local var_442_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232103", "story_v_out_416232.awb") / 1000

					if var_442_31 + var_442_23 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_31 + var_442_23
					end

					if var_442_26.prefab_name ~= "" and arg_439_1.actors_[var_442_26.prefab_name] ~= nil then
						local var_442_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_26.prefab_name].transform, "story_v_out_416232", "416232103", "story_v_out_416232.awb")

						arg_439_1:RecordAudio("416232103", var_442_32)
						arg_439_1:RecordAudio("416232103", var_442_32)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_416232", "416232103", "story_v_out_416232.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_416232", "416232103", "story_v_out_416232.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_33 = math.max(var_442_24, arg_439_1.talkMaxDuration)

			if var_442_23 <= arg_439_1.time_ and arg_439_1.time_ < var_442_23 + var_442_33 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_23) / var_442_33

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_23 + var_442_33 and arg_439_1.time_ < var_442_23 + var_442_33 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
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

		arg_439_1:InitPlayNodeList()
	end,
	Play416232104 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 416232104
		arg_443_1.duration_ = 3.63

		local var_443_0 = {
			zh = 2.16666666666667,
			ja = 3.63266666666667
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play416232105(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["10127"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.actorSpriteComps10127 == nil then
				arg_443_1.var_.actorSpriteComps10127 = var_446_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.actorSpriteComps10127 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								local var_446_4 = Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, var_446_3)
								local var_446_5 = Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, var_446_3)
								local var_446_6 = Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, var_446_3)

								iter_446_1.color = Color.New(var_446_4, var_446_5, var_446_6)
							else
								local var_446_7 = Mathf.Lerp(iter_446_1.color.r, 0.5, var_446_3)

								iter_446_1.color = Color.New(var_446_7, var_446_7, var_446_7)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.actorSpriteComps10127 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_446_3 then
						if arg_443_1.isInRecall_ then
							iter_446_3.color = arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_446_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_443_1.var_.actorSpriteComps10127 = nil
			end

			local var_446_8 = 0

			if var_446_8 < arg_443_1.time_ and arg_443_1.time_ <= var_446_8 + arg_446_0 then
				arg_443_1.allBtn_.enabled = false
			end

			local var_446_9 = 0.466666666666667

			if arg_443_1.time_ >= var_446_8 + var_446_9 and arg_443_1.time_ < var_446_8 + var_446_9 + arg_446_0 then
				arg_443_1.allBtn_.enabled = true
			end

			if arg_443_1.frameCnt_ <= 1 then
				arg_443_1.dialog_:SetActive(false)
			end

			local var_446_10 = 0.466666666666667
			local var_446_11 = 0.2

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_12 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_12:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_13 = arg_443_1:FormatText(StoryNameCfg[254].name)

				arg_443_1.leftNameTxt_.text = var_446_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_443_1.callingController_:SetSelectedState("calling")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_14 = arg_443_1:GetWordFromCfg(416232104)
				local var_446_15 = arg_443_1:FormatText(var_446_14.content)

				arg_443_1.text_.text = var_446_15

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_16 = 8
				local var_446_17 = utf8.len(var_446_15)
				local var_446_18 = var_446_16 <= 0 and var_446_11 or var_446_11 * (var_446_17 / var_446_16)

				if var_446_18 > 0 and var_446_11 < var_446_18 then
					arg_443_1.talkMaxDuration = var_446_18
					var_446_10 = var_446_10 + 0.3

					if var_446_18 + var_446_10 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_18 + var_446_10
					end
				end

				arg_443_1.text_.text = var_446_15
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232104", "story_v_out_416232.awb") ~= 0 then
					local var_446_19 = manager.audio:GetVoiceLength("story_v_out_416232", "416232104", "story_v_out_416232.awb") / 1000

					if var_446_19 + var_446_10 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_19 + var_446_10
					end

					if var_446_14.prefab_name ~= "" and arg_443_1.actors_[var_446_14.prefab_name] ~= nil then
						local var_446_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_14.prefab_name].transform, "story_v_out_416232", "416232104", "story_v_out_416232.awb")

						arg_443_1:RecordAudio("416232104", var_446_20)
						arg_443_1:RecordAudio("416232104", var_446_20)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_416232", "416232104", "story_v_out_416232.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_416232", "416232104", "story_v_out_416232.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_21 = var_446_10 + 0.3
			local var_446_22 = math.max(var_446_11, arg_443_1.talkMaxDuration)

			if var_446_21 <= arg_443_1.time_ and arg_443_1.time_ < var_446_21 + var_446_22 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_21) / var_446_22

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_21 + var_446_22 and arg_443_1.time_ < var_446_21 + var_446_22 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play416232105 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 416232105
		arg_449_1.duration_ = 3.67

		local var_449_0 = {
			zh = 3.666,
			ja = 3.633
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play416232106(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10127"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10127 == nil then
				arg_449_1.var_.actorSpriteComps10127 = var_452_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.actorSpriteComps10127 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								local var_452_4 = Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor1.r, var_452_3)
								local var_452_5 = Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor1.g, var_452_3)
								local var_452_6 = Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor1.b, var_452_3)

								iter_452_1.color = Color.New(var_452_4, var_452_5, var_452_6)
							else
								local var_452_7 = Mathf.Lerp(iter_452_1.color.r, 1, var_452_3)

								iter_452_1.color = Color.New(var_452_7, var_452_7, var_452_7)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10127 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_452_3 then
						if arg_449_1.isInRecall_ then
							iter_452_3.color = arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_452_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_449_1.var_.actorSpriteComps10127 = nil
			end

			local var_452_8 = arg_449_1.actors_["10127"].transform
			local var_452_9 = 0

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1.var_.moveOldPos10127 = var_452_8.localPosition
				var_452_8.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10127", 4)

				local var_452_10 = var_452_8.childCount

				for iter_452_4 = 0, var_452_10 - 1 do
					local var_452_11 = var_452_8:GetChild(iter_452_4)

					if var_452_11.name == "split_1" or not string.find(var_452_11.name, "split") then
						var_452_11.gameObject:SetActive(true)
					else
						var_452_11.gameObject:SetActive(false)
					end
				end
			end

			local var_452_12 = 0.001

			if var_452_9 <= arg_449_1.time_ and arg_449_1.time_ < var_452_9 + var_452_12 then
				local var_452_13 = (arg_449_1.time_ - var_452_9) / var_452_12
				local var_452_14 = Vector3.New(345, -387.4, -316.5)

				var_452_8.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10127, var_452_14, var_452_13)
			end

			if arg_449_1.time_ >= var_452_9 + var_452_12 and arg_449_1.time_ < var_452_9 + var_452_12 + arg_452_0 then
				var_452_8.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_452_15 = 0
			local var_452_16 = 0.25

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[236].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(416232105)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 10
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232105", "story_v_out_416232.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232105", "story_v_out_416232.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_out_416232", "416232105", "story_v_out_416232.awb")

						arg_449_1:RecordAudio("416232105", var_452_24)
						arg_449_1:RecordAudio("416232105", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_416232", "416232105", "story_v_out_416232.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_416232", "416232105", "story_v_out_416232.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
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

		arg_449_1:InitPlayNodeList()
	end,
	Play416232106 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 416232106
		arg_453_1.duration_ = 5.63

		local var_453_0 = {
			zh = 4.6,
			ja = 5.633
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play416232107(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["10127"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10127 == nil then
				arg_453_1.var_.actorSpriteComps10127 = var_456_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_2 = 0.2

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.actorSpriteComps10127 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								local var_456_4 = Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor2.r, var_456_3)
								local var_456_5 = Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor2.g, var_456_3)
								local var_456_6 = Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor2.b, var_456_3)

								iter_456_1.color = Color.New(var_456_4, var_456_5, var_456_6)
							else
								local var_456_7 = Mathf.Lerp(iter_456_1.color.r, 0.5, var_456_3)

								iter_456_1.color = Color.New(var_456_7, var_456_7, var_456_7)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10127 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_456_3 then
						if arg_453_1.isInRecall_ then
							iter_456_3.color = arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_456_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_453_1.var_.actorSpriteComps10127 = nil
			end

			local var_456_8 = 0
			local var_456_9 = 0.575

			if var_456_8 < arg_453_1.time_ and arg_453_1.time_ <= var_456_8 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_10 = arg_453_1:FormatText(StoryNameCfg[254].name)

				arg_453_1.leftNameTxt_.text = var_456_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_453_1.callingController_:SetSelectedState("calling")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_11 = arg_453_1:GetWordFromCfg(416232106)
				local var_456_12 = arg_453_1:FormatText(var_456_11.content)

				arg_453_1.text_.text = var_456_12

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_13 = 23
				local var_456_14 = utf8.len(var_456_12)
				local var_456_15 = var_456_13 <= 0 and var_456_9 or var_456_9 * (var_456_14 / var_456_13)

				if var_456_15 > 0 and var_456_9 < var_456_15 then
					arg_453_1.talkMaxDuration = var_456_15

					if var_456_15 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_15 + var_456_8
					end
				end

				arg_453_1.text_.text = var_456_12
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232106", "story_v_out_416232.awb") ~= 0 then
					local var_456_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232106", "story_v_out_416232.awb") / 1000

					if var_456_16 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_16 + var_456_8
					end

					if var_456_11.prefab_name ~= "" and arg_453_1.actors_[var_456_11.prefab_name] ~= nil then
						local var_456_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_11.prefab_name].transform, "story_v_out_416232", "416232106", "story_v_out_416232.awb")

						arg_453_1:RecordAudio("416232106", var_456_17)
						arg_453_1:RecordAudio("416232106", var_456_17)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_416232", "416232106", "story_v_out_416232.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_416232", "416232106", "story_v_out_416232.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_18 = math.max(var_456_9, arg_453_1.talkMaxDuration)

			if var_456_8 <= arg_453_1.time_ and arg_453_1.time_ < var_456_8 + var_456_18 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_8) / var_456_18

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_8 + var_456_18 and arg_453_1.time_ < var_456_8 + var_456_18 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play416232107 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 416232107
		arg_457_1.duration_ = 4.03

		local var_457_0 = {
			zh = 3.4,
			ja = 4.033
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play416232108(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.525

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[254].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_457_1.callingController_:SetSelectedState("calling")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(416232107)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 21
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232107", "story_v_out_416232.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232107", "story_v_out_416232.awb") / 1000

					if var_460_8 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_0
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_out_416232", "416232107", "story_v_out_416232.awb")

						arg_457_1:RecordAudio("416232107", var_460_9)
						arg_457_1:RecordAudio("416232107", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_416232", "416232107", "story_v_out_416232.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_416232", "416232107", "story_v_out_416232.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_10 and arg_457_1.time_ < var_460_0 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play416232108 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 416232108
		arg_461_1.duration_ = 5.7

		local var_461_0 = {
			zh = 3.9,
			ja = 5.7
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play416232109(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10127"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.actorSpriteComps10127 == nil then
				arg_461_1.var_.actorSpriteComps10127 = var_464_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_2 = 0.2

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.actorSpriteComps10127 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								local var_464_4 = Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, var_464_3)
								local var_464_5 = Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, var_464_3)
								local var_464_6 = Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, var_464_3)

								iter_464_1.color = Color.New(var_464_4, var_464_5, var_464_6)
							else
								local var_464_7 = Mathf.Lerp(iter_464_1.color.r, 1, var_464_3)

								iter_464_1.color = Color.New(var_464_7, var_464_7, var_464_7)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.actorSpriteComps10127 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_464_3 then
						if arg_461_1.isInRecall_ then
							iter_464_3.color = arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_464_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_461_1.var_.actorSpriteComps10127 = nil
			end

			local var_464_8 = 0
			local var_464_9 = 0.375

			if var_464_8 < arg_461_1.time_ and arg_461_1.time_ <= var_464_8 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_10 = arg_461_1:FormatText(StoryNameCfg[236].name)

				arg_461_1.leftNameTxt_.text = var_464_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_11 = arg_461_1:GetWordFromCfg(416232108)
				local var_464_12 = arg_461_1:FormatText(var_464_11.content)

				arg_461_1.text_.text = var_464_12

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 15
				local var_464_14 = utf8.len(var_464_12)
				local var_464_15 = var_464_13 <= 0 and var_464_9 or var_464_9 * (var_464_14 / var_464_13)

				if var_464_15 > 0 and var_464_9 < var_464_15 then
					arg_461_1.talkMaxDuration = var_464_15

					if var_464_15 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_15 + var_464_8
					end
				end

				arg_461_1.text_.text = var_464_12
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232108", "story_v_out_416232.awb") ~= 0 then
					local var_464_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232108", "story_v_out_416232.awb") / 1000

					if var_464_16 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_16 + var_464_8
					end

					if var_464_11.prefab_name ~= "" and arg_461_1.actors_[var_464_11.prefab_name] ~= nil then
						local var_464_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_11.prefab_name].transform, "story_v_out_416232", "416232108", "story_v_out_416232.awb")

						arg_461_1:RecordAudio("416232108", var_464_17)
						arg_461_1:RecordAudio("416232108", var_464_17)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_416232", "416232108", "story_v_out_416232.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_416232", "416232108", "story_v_out_416232.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_18 = math.max(var_464_9, arg_461_1.talkMaxDuration)

			if var_464_8 <= arg_461_1.time_ and arg_461_1.time_ < var_464_8 + var_464_18 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_8) / var_464_18

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_8 + var_464_18 and arg_461_1.time_ < var_464_8 + var_464_18 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play416232109 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 416232109
		arg_465_1.duration_ = 6.83

		local var_465_0 = {
			zh = 5.666,
			ja = 6.833
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play416232110(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10127"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10127 == nil then
				arg_465_1.var_.actorSpriteComps10127 = var_468_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_2 = 0.2

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.actorSpriteComps10127 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								local var_468_4 = Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, var_468_3)
								local var_468_5 = Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, var_468_3)
								local var_468_6 = Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, var_468_3)

								iter_468_1.color = Color.New(var_468_4, var_468_5, var_468_6)
							else
								local var_468_7 = Mathf.Lerp(iter_468_1.color.r, 0.5, var_468_3)

								iter_468_1.color = Color.New(var_468_7, var_468_7, var_468_7)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10127 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_468_3 then
						if arg_465_1.isInRecall_ then
							iter_468_3.color = arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_468_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_465_1.var_.actorSpriteComps10127 = nil
			end

			local var_468_8 = 0
			local var_468_9 = 0.75

			if var_468_8 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_10 = arg_465_1:FormatText(StoryNameCfg[254].name)

				arg_465_1.leftNameTxt_.text = var_468_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_465_1.callingController_:SetSelectedState("calling")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_11 = arg_465_1:GetWordFromCfg(416232109)
				local var_468_12 = arg_465_1:FormatText(var_468_11.content)

				arg_465_1.text_.text = var_468_12

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_13 = 30
				local var_468_14 = utf8.len(var_468_12)
				local var_468_15 = var_468_13 <= 0 and var_468_9 or var_468_9 * (var_468_14 / var_468_13)

				if var_468_15 > 0 and var_468_9 < var_468_15 then
					arg_465_1.talkMaxDuration = var_468_15

					if var_468_15 + var_468_8 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_15 + var_468_8
					end
				end

				arg_465_1.text_.text = var_468_12
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232109", "story_v_out_416232.awb") ~= 0 then
					local var_468_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232109", "story_v_out_416232.awb") / 1000

					if var_468_16 + var_468_8 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_16 + var_468_8
					end

					if var_468_11.prefab_name ~= "" and arg_465_1.actors_[var_468_11.prefab_name] ~= nil then
						local var_468_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_11.prefab_name].transform, "story_v_out_416232", "416232109", "story_v_out_416232.awb")

						arg_465_1:RecordAudio("416232109", var_468_17)
						arg_465_1:RecordAudio("416232109", var_468_17)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_416232", "416232109", "story_v_out_416232.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_416232", "416232109", "story_v_out_416232.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_18 = math.max(var_468_9, arg_465_1.talkMaxDuration)

			if var_468_8 <= arg_465_1.time_ and arg_465_1.time_ < var_468_8 + var_468_18 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_8) / var_468_18

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_8 + var_468_18 and arg_465_1.time_ < var_468_8 + var_468_18 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play416232110 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 416232110
		arg_469_1.duration_ = 7.8

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play416232111(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 1.2

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				local var_472_1 = manager.ui.mainCamera.transform.localPosition
				local var_472_2 = Vector3.New(0, 0, 10) + Vector3.New(var_472_1.x, var_472_1.y, 0)
				local var_472_3 = arg_469_1.bgs_.F09f

				var_472_3.transform.localPosition = var_472_2
				var_472_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_4 = var_472_3:GetComponent("SpriteRenderer")

				if var_472_4 and var_472_4.sprite then
					local var_472_5 = (var_472_3.transform.localPosition - var_472_1).z
					local var_472_6 = manager.ui.mainCameraCom_
					local var_472_7 = 2 * var_472_5 * Mathf.Tan(var_472_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_472_8 = var_472_7 * var_472_6.aspect
					local var_472_9 = var_472_4.sprite.bounds.size.x
					local var_472_10 = var_472_4.sprite.bounds.size.y
					local var_472_11 = var_472_8 / var_472_9
					local var_472_12 = var_472_7 / var_472_10
					local var_472_13 = var_472_12 < var_472_11 and var_472_11 or var_472_12

					var_472_3.transform.localScale = Vector3.New(var_472_13, var_472_13, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "F09f" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_14 = 1.2

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_15 = 0.3

			if arg_469_1.time_ >= var_472_14 + var_472_15 and arg_469_1.time_ < var_472_14 + var_472_15 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_16 = 0

			if var_472_16 < arg_469_1.time_ and arg_469_1.time_ <= var_472_16 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_17 = 1.2

			if var_472_16 <= arg_469_1.time_ and arg_469_1.time_ < var_472_16 + var_472_17 then
				local var_472_18 = (arg_469_1.time_ - var_472_16) / var_472_17
				local var_472_19 = Color.New(0, 0, 0)

				var_472_19.a = Mathf.Lerp(0, 1, var_472_18)
				arg_469_1.mask_.color = var_472_19
			end

			if arg_469_1.time_ >= var_472_16 + var_472_17 and arg_469_1.time_ < var_472_16 + var_472_17 + arg_472_0 then
				local var_472_20 = Color.New(0, 0, 0)

				var_472_20.a = 1
				arg_469_1.mask_.color = var_472_20
			end

			local var_472_21 = 1.2

			if var_472_21 < arg_469_1.time_ and arg_469_1.time_ <= var_472_21 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_22 = 2

			if var_472_21 <= arg_469_1.time_ and arg_469_1.time_ < var_472_21 + var_472_22 then
				local var_472_23 = (arg_469_1.time_ - var_472_21) / var_472_22
				local var_472_24 = Color.New(0, 0, 0)

				var_472_24.a = Mathf.Lerp(1, 0, var_472_23)
				arg_469_1.mask_.color = var_472_24
			end

			if arg_469_1.time_ >= var_472_21 + var_472_22 and arg_469_1.time_ < var_472_21 + var_472_22 + arg_472_0 then
				local var_472_25 = Color.New(0, 0, 0)
				local var_472_26 = 0

				arg_469_1.mask_.enabled = false
				var_472_25.a = var_472_26
				arg_469_1.mask_.color = var_472_25
			end

			local var_472_27 = arg_469_1.actors_["1028"].transform
			local var_472_28 = 1.2

			if var_472_28 < arg_469_1.time_ and arg_469_1.time_ <= var_472_28 + arg_472_0 then
				arg_469_1.var_.moveOldPos1028 = var_472_27.localPosition
				var_472_27.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("1028", 7)

				local var_472_29 = var_472_27.childCount

				for iter_472_2 = 0, var_472_29 - 1 do
					local var_472_30 = var_472_27:GetChild(iter_472_2)

					if var_472_30.name == "" or not string.find(var_472_30.name, "split") then
						var_472_30.gameObject:SetActive(true)
					else
						var_472_30.gameObject:SetActive(false)
					end
				end
			end

			local var_472_31 = 0.001

			if var_472_28 <= arg_469_1.time_ and arg_469_1.time_ < var_472_28 + var_472_31 then
				local var_472_32 = (arg_469_1.time_ - var_472_28) / var_472_31
				local var_472_33 = Vector3.New(0, -2000, 0)

				var_472_27.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1028, var_472_33, var_472_32)
			end

			if arg_469_1.time_ >= var_472_28 + var_472_31 and arg_469_1.time_ < var_472_28 + var_472_31 + arg_472_0 then
				var_472_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_472_34 = arg_469_1.actors_["10127"].transform
			local var_472_35 = 1.2

			if var_472_35 < arg_469_1.time_ and arg_469_1.time_ <= var_472_35 + arg_472_0 then
				arg_469_1.var_.moveOldPos10127 = var_472_34.localPosition
				var_472_34.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10127", 7)

				local var_472_36 = var_472_34.childCount

				for iter_472_3 = 0, var_472_36 - 1 do
					local var_472_37 = var_472_34:GetChild(iter_472_3)

					if var_472_37.name == "" or not string.find(var_472_37.name, "split") then
						var_472_37.gameObject:SetActive(true)
					else
						var_472_37.gameObject:SetActive(false)
					end
				end
			end

			local var_472_38 = 0.001

			if var_472_35 <= arg_469_1.time_ and arg_469_1.time_ < var_472_35 + var_472_38 then
				local var_472_39 = (arg_469_1.time_ - var_472_35) / var_472_38
				local var_472_40 = Vector3.New(0, -2000, 0)

				var_472_34.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10127, var_472_40, var_472_39)
			end

			if arg_469_1.time_ >= var_472_35 + var_472_38 and arg_469_1.time_ < var_472_35 + var_472_38 + arg_472_0 then
				var_472_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_41 = 2.8
			local var_472_42 = 1.25

			if var_472_41 < arg_469_1.time_ and arg_469_1.time_ <= var_472_41 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_43 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_43:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_44 = arg_469_1:GetWordFromCfg(416232110)
				local var_472_45 = arg_469_1:FormatText(var_472_44.content)

				arg_469_1.text_.text = var_472_45

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_46 = 50
				local var_472_47 = utf8.len(var_472_45)
				local var_472_48 = var_472_46 <= 0 and var_472_42 or var_472_42 * (var_472_47 / var_472_46)

				if var_472_48 > 0 and var_472_42 < var_472_48 then
					arg_469_1.talkMaxDuration = var_472_48
					var_472_41 = var_472_41 + 0.3

					if var_472_48 + var_472_41 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_48 + var_472_41
					end
				end

				arg_469_1.text_.text = var_472_45
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_49 = var_472_41 + 0.3
			local var_472_50 = math.max(var_472_42, arg_469_1.talkMaxDuration)

			if var_472_49 <= arg_469_1.time_ and arg_469_1.time_ < var_472_49 + var_472_50 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_49) / var_472_50

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_49 + var_472_50 and arg_469_1.time_ < var_472_49 + var_472_50 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play416232111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 416232111
		arg_475_1.duration_ = 6.33

		local var_475_0 = {
			zh = 4.6,
			ja = 6.333
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play416232112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["10122"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps10122 == nil then
				arg_475_1.var_.actorSpriteComps10122 = var_478_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_2 = 0.2

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.actorSpriteComps10122 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								local var_478_4 = Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, var_478_3)
								local var_478_5 = Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, var_478_3)
								local var_478_6 = Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, var_478_3)

								iter_478_1.color = Color.New(var_478_4, var_478_5, var_478_6)
							else
								local var_478_7 = Mathf.Lerp(iter_478_1.color.r, 1, var_478_3)

								iter_478_1.color = Color.New(var_478_7, var_478_7, var_478_7)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps10122 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_478_3 then
						if arg_475_1.isInRecall_ then
							iter_478_3.color = arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_478_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_475_1.var_.actorSpriteComps10122 = nil
			end

			local var_478_8 = arg_475_1.actors_["10122"].transform
			local var_478_9 = 0

			if var_478_9 < arg_475_1.time_ and arg_475_1.time_ <= var_478_9 + arg_478_0 then
				arg_475_1.var_.moveOldPos10122 = var_478_8.localPosition
				var_478_8.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10122", 3)

				local var_478_10 = var_478_8.childCount

				for iter_478_4 = 0, var_478_10 - 1 do
					local var_478_11 = var_478_8:GetChild(iter_478_4)

					if var_478_11.name == "" or not string.find(var_478_11.name, "split") then
						var_478_11.gameObject:SetActive(true)
					else
						var_478_11.gameObject:SetActive(false)
					end
				end
			end

			local var_478_12 = 0.001

			if var_478_9 <= arg_475_1.time_ and arg_475_1.time_ < var_478_9 + var_478_12 then
				local var_478_13 = (arg_475_1.time_ - var_478_9) / var_478_12
				local var_478_14 = Vector3.New(0, -380, -100)

				var_478_8.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10122, var_478_14, var_478_13)
			end

			if arg_475_1.time_ >= var_478_9 + var_478_12 and arg_475_1.time_ < var_478_9 + var_478_12 + arg_478_0 then
				var_478_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_478_15 = 0
			local var_478_16 = 0.525

			if var_478_15 < arg_475_1.time_ and arg_475_1.time_ <= var_478_15 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_17 = arg_475_1:FormatText(StoryNameCfg[8].name)

				arg_475_1.leftNameTxt_.text = var_478_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_18 = arg_475_1:GetWordFromCfg(416232111)
				local var_478_19 = arg_475_1:FormatText(var_478_18.content)

				arg_475_1.text_.text = var_478_19

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_20 = 21
				local var_478_21 = utf8.len(var_478_19)
				local var_478_22 = var_478_20 <= 0 and var_478_16 or var_478_16 * (var_478_21 / var_478_20)

				if var_478_22 > 0 and var_478_16 < var_478_22 then
					arg_475_1.talkMaxDuration = var_478_22

					if var_478_22 + var_478_15 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_22 + var_478_15
					end
				end

				arg_475_1.text_.text = var_478_19
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232111", "story_v_out_416232.awb") ~= 0 then
					local var_478_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232111", "story_v_out_416232.awb") / 1000

					if var_478_23 + var_478_15 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_23 + var_478_15
					end

					if var_478_18.prefab_name ~= "" and arg_475_1.actors_[var_478_18.prefab_name] ~= nil then
						local var_478_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_18.prefab_name].transform, "story_v_out_416232", "416232111", "story_v_out_416232.awb")

						arg_475_1:RecordAudio("416232111", var_478_24)
						arg_475_1:RecordAudio("416232111", var_478_24)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_416232", "416232111", "story_v_out_416232.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_416232", "416232111", "story_v_out_416232.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_25 = math.max(var_478_16, arg_475_1.talkMaxDuration)

			if var_478_15 <= arg_475_1.time_ and arg_475_1.time_ < var_478_15 + var_478_25 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_15) / var_478_25

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_15 + var_478_25 and arg_475_1.time_ < var_478_15 + var_478_25 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
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

		arg_475_1:InitPlayNodeList()
	end,
	Play416232112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 416232112
		arg_479_1.duration_ = 2.67

		local var_479_0 = {
			zh = 1.866,
			ja = 2.666
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play416232113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1086"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps1086 == nil then
				arg_479_1.var_.actorSpriteComps1086 = var_482_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_2 = 0.2

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.actorSpriteComps1086 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								local var_482_4 = Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor1.r, var_482_3)
								local var_482_5 = Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor1.g, var_482_3)
								local var_482_6 = Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor1.b, var_482_3)

								iter_482_1.color = Color.New(var_482_4, var_482_5, var_482_6)
							else
								local var_482_7 = Mathf.Lerp(iter_482_1.color.r, 1, var_482_3)

								iter_482_1.color = Color.New(var_482_7, var_482_7, var_482_7)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps1086 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_482_3 then
						if arg_479_1.isInRecall_ then
							iter_482_3.color = arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_482_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps1086 = nil
			end

			local var_482_8 = arg_479_1.actors_["10122"]
			local var_482_9 = 0

			if var_482_9 < arg_479_1.time_ and arg_479_1.time_ <= var_482_9 + arg_482_0 and not isNil(var_482_8) and arg_479_1.var_.actorSpriteComps10122 == nil then
				arg_479_1.var_.actorSpriteComps10122 = var_482_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_10 = 0.2

			if var_482_9 <= arg_479_1.time_ and arg_479_1.time_ < var_482_9 + var_482_10 and not isNil(var_482_8) then
				local var_482_11 = (arg_479_1.time_ - var_482_9) / var_482_10

				if arg_479_1.var_.actorSpriteComps10122 then
					for iter_482_4, iter_482_5 in pairs(arg_479_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_482_5 then
							if arg_479_1.isInRecall_ then
								local var_482_12 = Mathf.Lerp(iter_482_5.color.r, arg_479_1.hightColor2.r, var_482_11)
								local var_482_13 = Mathf.Lerp(iter_482_5.color.g, arg_479_1.hightColor2.g, var_482_11)
								local var_482_14 = Mathf.Lerp(iter_482_5.color.b, arg_479_1.hightColor2.b, var_482_11)

								iter_482_5.color = Color.New(var_482_12, var_482_13, var_482_14)
							else
								local var_482_15 = Mathf.Lerp(iter_482_5.color.r, 0.5, var_482_11)

								iter_482_5.color = Color.New(var_482_15, var_482_15, var_482_15)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_9 + var_482_10 and arg_479_1.time_ < var_482_9 + var_482_10 + arg_482_0 and not isNil(var_482_8) and arg_479_1.var_.actorSpriteComps10122 then
				for iter_482_6, iter_482_7 in pairs(arg_479_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_482_7 then
						if arg_479_1.isInRecall_ then
							iter_482_7.color = arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_482_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps10122 = nil
			end

			local var_482_16 = arg_479_1.actors_["10122"].transform
			local var_482_17 = 0

			if var_482_17 < arg_479_1.time_ and arg_479_1.time_ <= var_482_17 + arg_482_0 then
				arg_479_1.var_.moveOldPos10122 = var_482_16.localPosition
				var_482_16.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10122", 7)

				local var_482_18 = var_482_16.childCount

				for iter_482_8 = 0, var_482_18 - 1 do
					local var_482_19 = var_482_16:GetChild(iter_482_8)

					if var_482_19.name == "" or not string.find(var_482_19.name, "split") then
						var_482_19.gameObject:SetActive(true)
					else
						var_482_19.gameObject:SetActive(false)
					end
				end
			end

			local var_482_20 = 0.001

			if var_482_17 <= arg_479_1.time_ and arg_479_1.time_ < var_482_17 + var_482_20 then
				local var_482_21 = (arg_479_1.time_ - var_482_17) / var_482_20
				local var_482_22 = Vector3.New(0, -2000, 0)

				var_482_16.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10122, var_482_22, var_482_21)
			end

			if arg_479_1.time_ >= var_482_17 + var_482_20 and arg_479_1.time_ < var_482_17 + var_482_20 + arg_482_0 then
				var_482_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_482_23 = arg_479_1.actors_["1086"].transform
			local var_482_24 = 0

			if var_482_24 < arg_479_1.time_ and arg_479_1.time_ <= var_482_24 + arg_482_0 then
				arg_479_1.var_.moveOldPos1086 = var_482_23.localPosition
				var_482_23.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("1086", 3)

				local var_482_25 = var_482_23.childCount

				for iter_482_9 = 0, var_482_25 - 1 do
					local var_482_26 = var_482_23:GetChild(iter_482_9)

					if var_482_26.name == "" or not string.find(var_482_26.name, "split") then
						var_482_26.gameObject:SetActive(true)
					else
						var_482_26.gameObject:SetActive(false)
					end
				end
			end

			local var_482_27 = 0.001

			if var_482_24 <= arg_479_1.time_ and arg_479_1.time_ < var_482_24 + var_482_27 then
				local var_482_28 = (arg_479_1.time_ - var_482_24) / var_482_27
				local var_482_29 = Vector3.New(0, -404.2, -237.9)

				var_482_23.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1086, var_482_29, var_482_28)
			end

			if arg_479_1.time_ >= var_482_24 + var_482_27 and arg_479_1.time_ < var_482_24 + var_482_27 + arg_482_0 then
				var_482_23.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_482_30 = 0
			local var_482_31 = 0.2

			if var_482_30 < arg_479_1.time_ and arg_479_1.time_ <= var_482_30 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_32 = arg_479_1:FormatText(StoryNameCfg[1080].name)

				arg_479_1.leftNameTxt_.text = var_482_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_33 = arg_479_1:GetWordFromCfg(416232112)
				local var_482_34 = arg_479_1:FormatText(var_482_33.content)

				arg_479_1.text_.text = var_482_34

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_35 = 8
				local var_482_36 = utf8.len(var_482_34)
				local var_482_37 = var_482_35 <= 0 and var_482_31 or var_482_31 * (var_482_36 / var_482_35)

				if var_482_37 > 0 and var_482_31 < var_482_37 then
					arg_479_1.talkMaxDuration = var_482_37

					if var_482_37 + var_482_30 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_37 + var_482_30
					end
				end

				arg_479_1.text_.text = var_482_34
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232112", "story_v_out_416232.awb") ~= 0 then
					local var_482_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232112", "story_v_out_416232.awb") / 1000

					if var_482_38 + var_482_30 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_38 + var_482_30
					end

					if var_482_33.prefab_name ~= "" and arg_479_1.actors_[var_482_33.prefab_name] ~= nil then
						local var_482_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_33.prefab_name].transform, "story_v_out_416232", "416232112", "story_v_out_416232.awb")

						arg_479_1:RecordAudio("416232112", var_482_39)
						arg_479_1:RecordAudio("416232112", var_482_39)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_416232", "416232112", "story_v_out_416232.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_416232", "416232112", "story_v_out_416232.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_40 = math.max(var_482_31, arg_479_1.talkMaxDuration)

			if var_482_30 <= arg_479_1.time_ and arg_479_1.time_ < var_482_30 + var_482_40 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_30) / var_482_40

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_30 + var_482_40 and arg_479_1.time_ < var_482_30 + var_482_40 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
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

		arg_479_1:InitPlayNodeList()
	end,
	Play416232113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 416232113
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play416232114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1086"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.actorSpriteComps1086 == nil then
				arg_483_1.var_.actorSpriteComps1086 = var_486_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_2 = 0.2

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.actorSpriteComps1086 then
					for iter_486_0, iter_486_1 in pairs(arg_483_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_486_1 then
							if arg_483_1.isInRecall_ then
								local var_486_4 = Mathf.Lerp(iter_486_1.color.r, arg_483_1.hightColor2.r, var_486_3)
								local var_486_5 = Mathf.Lerp(iter_486_1.color.g, arg_483_1.hightColor2.g, var_486_3)
								local var_486_6 = Mathf.Lerp(iter_486_1.color.b, arg_483_1.hightColor2.b, var_486_3)

								iter_486_1.color = Color.New(var_486_4, var_486_5, var_486_6)
							else
								local var_486_7 = Mathf.Lerp(iter_486_1.color.r, 0.5, var_486_3)

								iter_486_1.color = Color.New(var_486_7, var_486_7, var_486_7)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.actorSpriteComps1086 then
				for iter_486_2, iter_486_3 in pairs(arg_483_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_486_3 then
						if arg_483_1.isInRecall_ then
							iter_486_3.color = arg_483_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_486_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_483_1.var_.actorSpriteComps1086 = nil
			end

			local var_486_8 = arg_483_1.actors_["1086"].transform
			local var_486_9 = 0

			if var_486_9 < arg_483_1.time_ and arg_483_1.time_ <= var_486_9 + arg_486_0 then
				arg_483_1.var_.moveOldPos1086 = var_486_8.localPosition
				var_486_8.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("1086", 7)

				local var_486_10 = var_486_8.childCount

				for iter_486_4 = 0, var_486_10 - 1 do
					local var_486_11 = var_486_8:GetChild(iter_486_4)

					if var_486_11.name == "" or not string.find(var_486_11.name, "split") then
						var_486_11.gameObject:SetActive(true)
					else
						var_486_11.gameObject:SetActive(false)
					end
				end
			end

			local var_486_12 = 0.001

			if var_486_9 <= arg_483_1.time_ and arg_483_1.time_ < var_486_9 + var_486_12 then
				local var_486_13 = (arg_483_1.time_ - var_486_9) / var_486_12
				local var_486_14 = Vector3.New(0, -2000, 0)

				var_486_8.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1086, var_486_14, var_486_13)
			end

			if arg_483_1.time_ >= var_486_9 + var_486_12 and arg_483_1.time_ < var_486_9 + var_486_12 + arg_486_0 then
				var_486_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_486_15 = 0
			local var_486_16 = 1.275

			if var_486_15 < arg_483_1.time_ and arg_483_1.time_ <= var_486_15 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_17 = arg_483_1:GetWordFromCfg(416232113)
				local var_486_18 = arg_483_1:FormatText(var_486_17.content)

				arg_483_1.text_.text = var_486_18

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_19 = 51
				local var_486_20 = utf8.len(var_486_18)
				local var_486_21 = var_486_19 <= 0 and var_486_16 or var_486_16 * (var_486_20 / var_486_19)

				if var_486_21 > 0 and var_486_16 < var_486_21 then
					arg_483_1.talkMaxDuration = var_486_21

					if var_486_21 + var_486_15 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_21 + var_486_15
					end
				end

				arg_483_1.text_.text = var_486_18
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_22 = math.max(var_486_16, arg_483_1.talkMaxDuration)

			if var_486_15 <= arg_483_1.time_ and arg_483_1.time_ < var_486_15 + var_486_22 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_15) / var_486_22

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_15 + var_486_22 and arg_483_1.time_ < var_486_15 + var_486_22 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
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

		arg_483_1:InitPlayNodeList()
	end,
	Play416232114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 416232114
		arg_487_1.duration_ = 6.87

		local var_487_0 = {
			zh = 3.8,
			ja = 6.866
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play416232115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["10122"]
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.actorSpriteComps10122 == nil then
				arg_487_1.var_.actorSpriteComps10122 = var_490_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_2 = 0.2

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 and not isNil(var_490_0) then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2

				if arg_487_1.var_.actorSpriteComps10122 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								local var_490_4 = Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor1.r, var_490_3)
								local var_490_5 = Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor1.g, var_490_3)
								local var_490_6 = Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor1.b, var_490_3)

								iter_490_1.color = Color.New(var_490_4, var_490_5, var_490_6)
							else
								local var_490_7 = Mathf.Lerp(iter_490_1.color.r, 1, var_490_3)

								iter_490_1.color = Color.New(var_490_7, var_490_7, var_490_7)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.actorSpriteComps10122 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_490_3 then
						if arg_487_1.isInRecall_ then
							iter_490_3.color = arg_487_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_490_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_487_1.var_.actorSpriteComps10122 = nil
			end

			local var_490_8 = arg_487_1.actors_["10122"].transform
			local var_490_9 = 0

			if var_490_9 < arg_487_1.time_ and arg_487_1.time_ <= var_490_9 + arg_490_0 then
				arg_487_1.var_.moveOldPos10122 = var_490_8.localPosition
				var_490_8.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10122", 2)

				local var_490_10 = var_490_8.childCount

				for iter_490_4 = 0, var_490_10 - 1 do
					local var_490_11 = var_490_8:GetChild(iter_490_4)

					if var_490_11.name == "" or not string.find(var_490_11.name, "split") then
						var_490_11.gameObject:SetActive(true)
					else
						var_490_11.gameObject:SetActive(false)
					end
				end
			end

			local var_490_12 = 0.001

			if var_490_9 <= arg_487_1.time_ and arg_487_1.time_ < var_490_9 + var_490_12 then
				local var_490_13 = (arg_487_1.time_ - var_490_9) / var_490_12
				local var_490_14 = Vector3.New(-390, -380, -100)

				var_490_8.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10122, var_490_14, var_490_13)
			end

			if arg_487_1.time_ >= var_490_9 + var_490_12 and arg_487_1.time_ < var_490_9 + var_490_12 + arg_490_0 then
				var_490_8.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_490_15 = 0
			local var_490_16 = 0.5

			if var_490_15 < arg_487_1.time_ and arg_487_1.time_ <= var_490_15 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_17 = arg_487_1:FormatText(StoryNameCfg[8].name)

				arg_487_1.leftNameTxt_.text = var_490_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_18 = arg_487_1:GetWordFromCfg(416232114)
				local var_490_19 = arg_487_1:FormatText(var_490_18.content)

				arg_487_1.text_.text = var_490_19

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_20 = 20
				local var_490_21 = utf8.len(var_490_19)
				local var_490_22 = var_490_20 <= 0 and var_490_16 or var_490_16 * (var_490_21 / var_490_20)

				if var_490_22 > 0 and var_490_16 < var_490_22 then
					arg_487_1.talkMaxDuration = var_490_22

					if var_490_22 + var_490_15 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_22 + var_490_15
					end
				end

				arg_487_1.text_.text = var_490_19
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232114", "story_v_out_416232.awb") ~= 0 then
					local var_490_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232114", "story_v_out_416232.awb") / 1000

					if var_490_23 + var_490_15 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_23 + var_490_15
					end

					if var_490_18.prefab_name ~= "" and arg_487_1.actors_[var_490_18.prefab_name] ~= nil then
						local var_490_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_18.prefab_name].transform, "story_v_out_416232", "416232114", "story_v_out_416232.awb")

						arg_487_1:RecordAudio("416232114", var_490_24)
						arg_487_1:RecordAudio("416232114", var_490_24)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_416232", "416232114", "story_v_out_416232.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_416232", "416232114", "story_v_out_416232.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_25 = math.max(var_490_16, arg_487_1.talkMaxDuration)

			if var_490_15 <= arg_487_1.time_ and arg_487_1.time_ < var_490_15 + var_490_25 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_15) / var_490_25

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_15 + var_490_25 and arg_487_1.time_ < var_490_15 + var_490_25 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
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

		arg_487_1:InitPlayNodeList()
	end,
	Play416232115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 416232115
		arg_491_1.duration_ = 8.63

		local var_491_0 = {
			zh = 5.5,
			ja = 8.633
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play416232116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1086"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps1086 == nil then
				arg_491_1.var_.actorSpriteComps1086 = var_494_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_2 = 0.2

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.actorSpriteComps1086 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								local var_494_4 = Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor1.r, var_494_3)
								local var_494_5 = Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor1.g, var_494_3)
								local var_494_6 = Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor1.b, var_494_3)

								iter_494_1.color = Color.New(var_494_4, var_494_5, var_494_6)
							else
								local var_494_7 = Mathf.Lerp(iter_494_1.color.r, 1, var_494_3)

								iter_494_1.color = Color.New(var_494_7, var_494_7, var_494_7)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps1086 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_494_3 then
						if arg_491_1.isInRecall_ then
							iter_494_3.color = arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_494_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps1086 = nil
			end

			local var_494_8 = arg_491_1.actors_["10122"]
			local var_494_9 = 0

			if var_494_9 < arg_491_1.time_ and arg_491_1.time_ <= var_494_9 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10122 == nil then
				arg_491_1.var_.actorSpriteComps10122 = var_494_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_10 = 0.2

			if var_494_9 <= arg_491_1.time_ and arg_491_1.time_ < var_494_9 + var_494_10 and not isNil(var_494_8) then
				local var_494_11 = (arg_491_1.time_ - var_494_9) / var_494_10

				if arg_491_1.var_.actorSpriteComps10122 then
					for iter_494_4, iter_494_5 in pairs(arg_491_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_494_5 then
							if arg_491_1.isInRecall_ then
								local var_494_12 = Mathf.Lerp(iter_494_5.color.r, arg_491_1.hightColor2.r, var_494_11)
								local var_494_13 = Mathf.Lerp(iter_494_5.color.g, arg_491_1.hightColor2.g, var_494_11)
								local var_494_14 = Mathf.Lerp(iter_494_5.color.b, arg_491_1.hightColor2.b, var_494_11)

								iter_494_5.color = Color.New(var_494_12, var_494_13, var_494_14)
							else
								local var_494_15 = Mathf.Lerp(iter_494_5.color.r, 0.5, var_494_11)

								iter_494_5.color = Color.New(var_494_15, var_494_15, var_494_15)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_9 + var_494_10 and arg_491_1.time_ < var_494_9 + var_494_10 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10122 then
				for iter_494_6, iter_494_7 in pairs(arg_491_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_494_7 then
						if arg_491_1.isInRecall_ then
							iter_494_7.color = arg_491_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_494_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps10122 = nil
			end

			local var_494_16 = arg_491_1.actors_["1086"].transform
			local var_494_17 = 0

			if var_494_17 < arg_491_1.time_ and arg_491_1.time_ <= var_494_17 + arg_494_0 then
				arg_491_1.var_.moveOldPos1086 = var_494_16.localPosition
				var_494_16.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1086", 4)

				local var_494_18 = var_494_16.childCount

				for iter_494_8 = 0, var_494_18 - 1 do
					local var_494_19 = var_494_16:GetChild(iter_494_8)

					if var_494_19.name == "" or not string.find(var_494_19.name, "split") then
						var_494_19.gameObject:SetActive(true)
					else
						var_494_19.gameObject:SetActive(false)
					end
				end
			end

			local var_494_20 = 0.001

			if var_494_17 <= arg_491_1.time_ and arg_491_1.time_ < var_494_17 + var_494_20 then
				local var_494_21 = (arg_491_1.time_ - var_494_17) / var_494_20
				local var_494_22 = Vector3.New(390, -404.2, -237.9)

				var_494_16.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1086, var_494_22, var_494_21)
			end

			if arg_491_1.time_ >= var_494_17 + var_494_20 and arg_491_1.time_ < var_494_17 + var_494_20 + arg_494_0 then
				var_494_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_494_23 = 0
			local var_494_24 = 0.65

			if var_494_23 < arg_491_1.time_ and arg_491_1.time_ <= var_494_23 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_25 = arg_491_1:FormatText(StoryNameCfg[1080].name)

				arg_491_1.leftNameTxt_.text = var_494_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_26 = arg_491_1:GetWordFromCfg(416232115)
				local var_494_27 = arg_491_1:FormatText(var_494_26.content)

				arg_491_1.text_.text = var_494_27

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_28 = 26
				local var_494_29 = utf8.len(var_494_27)
				local var_494_30 = var_494_28 <= 0 and var_494_24 or var_494_24 * (var_494_29 / var_494_28)

				if var_494_30 > 0 and var_494_24 < var_494_30 then
					arg_491_1.talkMaxDuration = var_494_30

					if var_494_30 + var_494_23 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_30 + var_494_23
					end
				end

				arg_491_1.text_.text = var_494_27
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232115", "story_v_out_416232.awb") ~= 0 then
					local var_494_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232115", "story_v_out_416232.awb") / 1000

					if var_494_31 + var_494_23 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_31 + var_494_23
					end

					if var_494_26.prefab_name ~= "" and arg_491_1.actors_[var_494_26.prefab_name] ~= nil then
						local var_494_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_26.prefab_name].transform, "story_v_out_416232", "416232115", "story_v_out_416232.awb")

						arg_491_1:RecordAudio("416232115", var_494_32)
						arg_491_1:RecordAudio("416232115", var_494_32)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_416232", "416232115", "story_v_out_416232.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_416232", "416232115", "story_v_out_416232.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_33 = math.max(var_494_24, arg_491_1.talkMaxDuration)

			if var_494_23 <= arg_491_1.time_ and arg_491_1.time_ < var_494_23 + var_494_33 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_23) / var_494_33

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_23 + var_494_33 and arg_491_1.time_ < var_494_23 + var_494_33 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
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

		arg_491_1:InitPlayNodeList()
	end,
	Play416232116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 416232116
		arg_495_1.duration_ = 3.23

		local var_495_0 = {
			zh = 3.233,
			ja = 2.866
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play416232117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["10122"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps10122 == nil then
				arg_495_1.var_.actorSpriteComps10122 = var_498_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_2 = 0.2

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.actorSpriteComps10122 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								local var_498_4 = Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor1.r, var_498_3)
								local var_498_5 = Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor1.g, var_498_3)
								local var_498_6 = Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor1.b, var_498_3)

								iter_498_1.color = Color.New(var_498_4, var_498_5, var_498_6)
							else
								local var_498_7 = Mathf.Lerp(iter_498_1.color.r, 1, var_498_3)

								iter_498_1.color = Color.New(var_498_7, var_498_7, var_498_7)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps10122 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_498_3 then
						if arg_495_1.isInRecall_ then
							iter_498_3.color = arg_495_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_498_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_495_1.var_.actorSpriteComps10122 = nil
			end

			local var_498_8 = arg_495_1.actors_["1086"]
			local var_498_9 = 0

			if var_498_9 < arg_495_1.time_ and arg_495_1.time_ <= var_498_9 + arg_498_0 and not isNil(var_498_8) and arg_495_1.var_.actorSpriteComps1086 == nil then
				arg_495_1.var_.actorSpriteComps1086 = var_498_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_10 = 0.2

			if var_498_9 <= arg_495_1.time_ and arg_495_1.time_ < var_498_9 + var_498_10 and not isNil(var_498_8) then
				local var_498_11 = (arg_495_1.time_ - var_498_9) / var_498_10

				if arg_495_1.var_.actorSpriteComps1086 then
					for iter_498_4, iter_498_5 in pairs(arg_495_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_498_5 then
							if arg_495_1.isInRecall_ then
								local var_498_12 = Mathf.Lerp(iter_498_5.color.r, arg_495_1.hightColor2.r, var_498_11)
								local var_498_13 = Mathf.Lerp(iter_498_5.color.g, arg_495_1.hightColor2.g, var_498_11)
								local var_498_14 = Mathf.Lerp(iter_498_5.color.b, arg_495_1.hightColor2.b, var_498_11)

								iter_498_5.color = Color.New(var_498_12, var_498_13, var_498_14)
							else
								local var_498_15 = Mathf.Lerp(iter_498_5.color.r, 0.5, var_498_11)

								iter_498_5.color = Color.New(var_498_15, var_498_15, var_498_15)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_9 + var_498_10 and arg_495_1.time_ < var_498_9 + var_498_10 + arg_498_0 and not isNil(var_498_8) and arg_495_1.var_.actorSpriteComps1086 then
				for iter_498_6, iter_498_7 in pairs(arg_495_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_498_7 then
						if arg_495_1.isInRecall_ then
							iter_498_7.color = arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_498_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_495_1.var_.actorSpriteComps1086 = nil
			end

			local var_498_16 = arg_495_1.actors_["10122"].transform
			local var_498_17 = 0

			if var_498_17 < arg_495_1.time_ and arg_495_1.time_ <= var_498_17 + arg_498_0 then
				arg_495_1.var_.moveOldPos10122 = var_498_16.localPosition
				var_498_16.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10122", 2)

				local var_498_18 = var_498_16.childCount

				for iter_498_8 = 0, var_498_18 - 1 do
					local var_498_19 = var_498_16:GetChild(iter_498_8)

					if var_498_19.name == "split_2" or not string.find(var_498_19.name, "split") then
						var_498_19.gameObject:SetActive(true)
					else
						var_498_19.gameObject:SetActive(false)
					end
				end
			end

			local var_498_20 = 0.001

			if var_498_17 <= arg_495_1.time_ and arg_495_1.time_ < var_498_17 + var_498_20 then
				local var_498_21 = (arg_495_1.time_ - var_498_17) / var_498_20
				local var_498_22 = Vector3.New(-390, -380, -100)

				var_498_16.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10122, var_498_22, var_498_21)
			end

			if arg_495_1.time_ >= var_498_17 + var_498_20 and arg_495_1.time_ < var_498_17 + var_498_20 + arg_498_0 then
				var_498_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_498_23 = 0
			local var_498_24 = 0.4

			if var_498_23 < arg_495_1.time_ and arg_495_1.time_ <= var_498_23 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_25 = arg_495_1:FormatText(StoryNameCfg[8].name)

				arg_495_1.leftNameTxt_.text = var_498_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_26 = arg_495_1:GetWordFromCfg(416232116)
				local var_498_27 = arg_495_1:FormatText(var_498_26.content)

				arg_495_1.text_.text = var_498_27

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_28 = 16
				local var_498_29 = utf8.len(var_498_27)
				local var_498_30 = var_498_28 <= 0 and var_498_24 or var_498_24 * (var_498_29 / var_498_28)

				if var_498_30 > 0 and var_498_24 < var_498_30 then
					arg_495_1.talkMaxDuration = var_498_30

					if var_498_30 + var_498_23 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_30 + var_498_23
					end
				end

				arg_495_1.text_.text = var_498_27
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232116", "story_v_out_416232.awb") ~= 0 then
					local var_498_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232116", "story_v_out_416232.awb") / 1000

					if var_498_31 + var_498_23 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_31 + var_498_23
					end

					if var_498_26.prefab_name ~= "" and arg_495_1.actors_[var_498_26.prefab_name] ~= nil then
						local var_498_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_26.prefab_name].transform, "story_v_out_416232", "416232116", "story_v_out_416232.awb")

						arg_495_1:RecordAudio("416232116", var_498_32)
						arg_495_1:RecordAudio("416232116", var_498_32)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_416232", "416232116", "story_v_out_416232.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_416232", "416232116", "story_v_out_416232.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_33 = math.max(var_498_24, arg_495_1.talkMaxDuration)

			if var_498_23 <= arg_495_1.time_ and arg_495_1.time_ < var_498_23 + var_498_33 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_23) / var_498_33

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_23 + var_498_33 and arg_495_1.time_ < var_498_23 + var_498_33 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
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

		arg_495_1:InitPlayNodeList()
	end,
	Play416232117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 416232117
		arg_499_1.duration_ = 6.43

		local var_499_0 = {
			zh = 2.766,
			ja = 6.433
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play416232118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1086"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps1086 == nil then
				arg_499_1.var_.actorSpriteComps1086 = var_502_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_2 = 0.2

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.actorSpriteComps1086 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								local var_502_4 = Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, var_502_3)
								local var_502_5 = Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, var_502_3)
								local var_502_6 = Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, var_502_3)

								iter_502_1.color = Color.New(var_502_4, var_502_5, var_502_6)
							else
								local var_502_7 = Mathf.Lerp(iter_502_1.color.r, 1, var_502_3)

								iter_502_1.color = Color.New(var_502_7, var_502_7, var_502_7)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps1086 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_502_3 then
						if arg_499_1.isInRecall_ then
							iter_502_3.color = arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_502_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps1086 = nil
			end

			local var_502_8 = arg_499_1.actors_["10122"]
			local var_502_9 = 0

			if var_502_9 < arg_499_1.time_ and arg_499_1.time_ <= var_502_9 + arg_502_0 and not isNil(var_502_8) and arg_499_1.var_.actorSpriteComps10122 == nil then
				arg_499_1.var_.actorSpriteComps10122 = var_502_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_10 = 0.2

			if var_502_9 <= arg_499_1.time_ and arg_499_1.time_ < var_502_9 + var_502_10 and not isNil(var_502_8) then
				local var_502_11 = (arg_499_1.time_ - var_502_9) / var_502_10

				if arg_499_1.var_.actorSpriteComps10122 then
					for iter_502_4, iter_502_5 in pairs(arg_499_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_502_5 then
							if arg_499_1.isInRecall_ then
								local var_502_12 = Mathf.Lerp(iter_502_5.color.r, arg_499_1.hightColor2.r, var_502_11)
								local var_502_13 = Mathf.Lerp(iter_502_5.color.g, arg_499_1.hightColor2.g, var_502_11)
								local var_502_14 = Mathf.Lerp(iter_502_5.color.b, arg_499_1.hightColor2.b, var_502_11)

								iter_502_5.color = Color.New(var_502_12, var_502_13, var_502_14)
							else
								local var_502_15 = Mathf.Lerp(iter_502_5.color.r, 0.5, var_502_11)

								iter_502_5.color = Color.New(var_502_15, var_502_15, var_502_15)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_9 + var_502_10 and arg_499_1.time_ < var_502_9 + var_502_10 + arg_502_0 and not isNil(var_502_8) and arg_499_1.var_.actorSpriteComps10122 then
				for iter_502_6, iter_502_7 in pairs(arg_499_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_502_7 then
						if arg_499_1.isInRecall_ then
							iter_502_7.color = arg_499_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_502_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps10122 = nil
			end

			local var_502_16 = 0
			local var_502_17 = 0.325

			if var_502_16 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_18 = arg_499_1:FormatText(StoryNameCfg[1080].name)

				arg_499_1.leftNameTxt_.text = var_502_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_19 = arg_499_1:GetWordFromCfg(416232117)
				local var_502_20 = arg_499_1:FormatText(var_502_19.content)

				arg_499_1.text_.text = var_502_20

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_21 = 13
				local var_502_22 = utf8.len(var_502_20)
				local var_502_23 = var_502_21 <= 0 and var_502_17 or var_502_17 * (var_502_22 / var_502_21)

				if var_502_23 > 0 and var_502_17 < var_502_23 then
					arg_499_1.talkMaxDuration = var_502_23

					if var_502_23 + var_502_16 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_23 + var_502_16
					end
				end

				arg_499_1.text_.text = var_502_20
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232117", "story_v_out_416232.awb") ~= 0 then
					local var_502_24 = manager.audio:GetVoiceLength("story_v_out_416232", "416232117", "story_v_out_416232.awb") / 1000

					if var_502_24 + var_502_16 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_24 + var_502_16
					end

					if var_502_19.prefab_name ~= "" and arg_499_1.actors_[var_502_19.prefab_name] ~= nil then
						local var_502_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_19.prefab_name].transform, "story_v_out_416232", "416232117", "story_v_out_416232.awb")

						arg_499_1:RecordAudio("416232117", var_502_25)
						arg_499_1:RecordAudio("416232117", var_502_25)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_416232", "416232117", "story_v_out_416232.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_416232", "416232117", "story_v_out_416232.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_26 = math.max(var_502_17, arg_499_1.talkMaxDuration)

			if var_502_16 <= arg_499_1.time_ and arg_499_1.time_ < var_502_16 + var_502_26 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_16) / var_502_26

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_16 + var_502_26 and arg_499_1.time_ < var_502_16 + var_502_26 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play416232118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 416232118
		arg_503_1.duration_ = 6.67

		local var_503_0 = {
			zh = 6.666,
			ja = 4.133
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play416232119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["10122"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10122 == nil then
				arg_503_1.var_.actorSpriteComps10122 = var_506_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_2 = 0.2

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.actorSpriteComps10122 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								local var_506_4 = Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor1.r, var_506_3)
								local var_506_5 = Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor1.g, var_506_3)
								local var_506_6 = Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor1.b, var_506_3)

								iter_506_1.color = Color.New(var_506_4, var_506_5, var_506_6)
							else
								local var_506_7 = Mathf.Lerp(iter_506_1.color.r, 1, var_506_3)

								iter_506_1.color = Color.New(var_506_7, var_506_7, var_506_7)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10122 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_506_3 then
						if arg_503_1.isInRecall_ then
							iter_506_3.color = arg_503_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_506_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_503_1.var_.actorSpriteComps10122 = nil
			end

			local var_506_8 = arg_503_1.actors_["1086"]
			local var_506_9 = 0

			if var_506_9 < arg_503_1.time_ and arg_503_1.time_ <= var_506_9 + arg_506_0 and not isNil(var_506_8) and arg_503_1.var_.actorSpriteComps1086 == nil then
				arg_503_1.var_.actorSpriteComps1086 = var_506_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_10 = 0.2

			if var_506_9 <= arg_503_1.time_ and arg_503_1.time_ < var_506_9 + var_506_10 and not isNil(var_506_8) then
				local var_506_11 = (arg_503_1.time_ - var_506_9) / var_506_10

				if arg_503_1.var_.actorSpriteComps1086 then
					for iter_506_4, iter_506_5 in pairs(arg_503_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_506_5 then
							if arg_503_1.isInRecall_ then
								local var_506_12 = Mathf.Lerp(iter_506_5.color.r, arg_503_1.hightColor2.r, var_506_11)
								local var_506_13 = Mathf.Lerp(iter_506_5.color.g, arg_503_1.hightColor2.g, var_506_11)
								local var_506_14 = Mathf.Lerp(iter_506_5.color.b, arg_503_1.hightColor2.b, var_506_11)

								iter_506_5.color = Color.New(var_506_12, var_506_13, var_506_14)
							else
								local var_506_15 = Mathf.Lerp(iter_506_5.color.r, 0.5, var_506_11)

								iter_506_5.color = Color.New(var_506_15, var_506_15, var_506_15)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= var_506_9 + var_506_10 and arg_503_1.time_ < var_506_9 + var_506_10 + arg_506_0 and not isNil(var_506_8) and arg_503_1.var_.actorSpriteComps1086 then
				for iter_506_6, iter_506_7 in pairs(arg_503_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_506_7 then
						if arg_503_1.isInRecall_ then
							iter_506_7.color = arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_506_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_503_1.var_.actorSpriteComps1086 = nil
			end

			local var_506_16 = arg_503_1.actors_["10122"].transform
			local var_506_17 = 0

			if var_506_17 < arg_503_1.time_ and arg_503_1.time_ <= var_506_17 + arg_506_0 then
				arg_503_1.var_.moveOldPos10122 = var_506_16.localPosition
				var_506_16.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10122", 2)

				local var_506_18 = var_506_16.childCount

				for iter_506_8 = 0, var_506_18 - 1 do
					local var_506_19 = var_506_16:GetChild(iter_506_8)

					if var_506_19.name == "" or not string.find(var_506_19.name, "split") then
						var_506_19.gameObject:SetActive(true)
					else
						var_506_19.gameObject:SetActive(false)
					end
				end
			end

			local var_506_20 = 0.001

			if var_506_17 <= arg_503_1.time_ and arg_503_1.time_ < var_506_17 + var_506_20 then
				local var_506_21 = (arg_503_1.time_ - var_506_17) / var_506_20
				local var_506_22 = Vector3.New(-390, -380, -100)

				var_506_16.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10122, var_506_22, var_506_21)
			end

			if arg_503_1.time_ >= var_506_17 + var_506_20 and arg_503_1.time_ < var_506_17 + var_506_20 + arg_506_0 then
				var_506_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_506_23 = 0
			local var_506_24 = 0.775

			if var_506_23 < arg_503_1.time_ and arg_503_1.time_ <= var_506_23 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_25 = arg_503_1:FormatText(StoryNameCfg[8].name)

				arg_503_1.leftNameTxt_.text = var_506_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_26 = arg_503_1:GetWordFromCfg(416232118)
				local var_506_27 = arg_503_1:FormatText(var_506_26.content)

				arg_503_1.text_.text = var_506_27

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_28 = 31
				local var_506_29 = utf8.len(var_506_27)
				local var_506_30 = var_506_28 <= 0 and var_506_24 or var_506_24 * (var_506_29 / var_506_28)

				if var_506_30 > 0 and var_506_24 < var_506_30 then
					arg_503_1.talkMaxDuration = var_506_30

					if var_506_30 + var_506_23 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_30 + var_506_23
					end
				end

				arg_503_1.text_.text = var_506_27
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232118", "story_v_out_416232.awb") ~= 0 then
					local var_506_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232118", "story_v_out_416232.awb") / 1000

					if var_506_31 + var_506_23 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_31 + var_506_23
					end

					if var_506_26.prefab_name ~= "" and arg_503_1.actors_[var_506_26.prefab_name] ~= nil then
						local var_506_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_26.prefab_name].transform, "story_v_out_416232", "416232118", "story_v_out_416232.awb")

						arg_503_1:RecordAudio("416232118", var_506_32)
						arg_503_1:RecordAudio("416232118", var_506_32)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_416232", "416232118", "story_v_out_416232.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_416232", "416232118", "story_v_out_416232.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_33 = math.max(var_506_24, arg_503_1.talkMaxDuration)

			if var_506_23 <= arg_503_1.time_ and arg_503_1.time_ < var_506_23 + var_506_33 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_23) / var_506_33

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_23 + var_506_33 and arg_503_1.time_ < var_506_23 + var_506_33 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
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

		arg_503_1:InitPlayNodeList()
	end,
	Play416232119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 416232119
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play416232120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["10122"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10122 == nil then
				arg_507_1.var_.actorSpriteComps10122 = var_510_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_2 = 0.2

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.actorSpriteComps10122 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								local var_510_4 = Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor2.r, var_510_3)
								local var_510_5 = Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor2.g, var_510_3)
								local var_510_6 = Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor2.b, var_510_3)

								iter_510_1.color = Color.New(var_510_4, var_510_5, var_510_6)
							else
								local var_510_7 = Mathf.Lerp(iter_510_1.color.r, 0.5, var_510_3)

								iter_510_1.color = Color.New(var_510_7, var_510_7, var_510_7)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10122 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_510_3 then
						if arg_507_1.isInRecall_ then
							iter_510_3.color = arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_510_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_507_1.var_.actorSpriteComps10122 = nil
			end

			local var_510_8 = 0
			local var_510_9 = 0.75

			if var_510_8 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_10 = arg_507_1:GetWordFromCfg(416232119)
				local var_510_11 = arg_507_1:FormatText(var_510_10.content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_12 = 30
				local var_510_13 = utf8.len(var_510_11)
				local var_510_14 = var_510_12 <= 0 and var_510_9 or var_510_9 * (var_510_13 / var_510_12)

				if var_510_14 > 0 and var_510_9 < var_510_14 then
					arg_507_1.talkMaxDuration = var_510_14

					if var_510_14 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_8
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_15 = math.max(var_510_9, arg_507_1.talkMaxDuration)

			if var_510_8 <= arg_507_1.time_ and arg_507_1.time_ < var_510_8 + var_510_15 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_8) / var_510_15

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_8 + var_510_15 and arg_507_1.time_ < var_510_8 + var_510_15 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play416232120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 416232120
		arg_511_1.duration_ = 9.53

		local var_511_0 = {
			zh = 5.933,
			ja = 9.533
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play416232121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1086"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps1086 == nil then
				arg_511_1.var_.actorSpriteComps1086 = var_514_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_2 = 0.2

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.actorSpriteComps1086 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								local var_514_4 = Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor1.r, var_514_3)
								local var_514_5 = Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor1.g, var_514_3)
								local var_514_6 = Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor1.b, var_514_3)

								iter_514_1.color = Color.New(var_514_4, var_514_5, var_514_6)
							else
								local var_514_7 = Mathf.Lerp(iter_514_1.color.r, 1, var_514_3)

								iter_514_1.color = Color.New(var_514_7, var_514_7, var_514_7)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps1086 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_514_3 then
						if arg_511_1.isInRecall_ then
							iter_514_3.color = arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_514_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_511_1.var_.actorSpriteComps1086 = nil
			end

			local var_514_8 = 0
			local var_514_9 = 0.75

			if var_514_8 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_10 = arg_511_1:FormatText(StoryNameCfg[1080].name)

				arg_511_1.leftNameTxt_.text = var_514_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_11 = arg_511_1:GetWordFromCfg(416232120)
				local var_514_12 = arg_511_1:FormatText(var_514_11.content)

				arg_511_1.text_.text = var_514_12

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_13 = 30
				local var_514_14 = utf8.len(var_514_12)
				local var_514_15 = var_514_13 <= 0 and var_514_9 or var_514_9 * (var_514_14 / var_514_13)

				if var_514_15 > 0 and var_514_9 < var_514_15 then
					arg_511_1.talkMaxDuration = var_514_15

					if var_514_15 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_15 + var_514_8
					end
				end

				arg_511_1.text_.text = var_514_12
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232120", "story_v_out_416232.awb") ~= 0 then
					local var_514_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232120", "story_v_out_416232.awb") / 1000

					if var_514_16 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_16 + var_514_8
					end

					if var_514_11.prefab_name ~= "" and arg_511_1.actors_[var_514_11.prefab_name] ~= nil then
						local var_514_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_11.prefab_name].transform, "story_v_out_416232", "416232120", "story_v_out_416232.awb")

						arg_511_1:RecordAudio("416232120", var_514_17)
						arg_511_1:RecordAudio("416232120", var_514_17)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_416232", "416232120", "story_v_out_416232.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_416232", "416232120", "story_v_out_416232.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_18 = math.max(var_514_9, arg_511_1.talkMaxDuration)

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_18 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_8) / var_514_18

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_8 + var_514_18 and arg_511_1.time_ < var_514_8 + var_514_18 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play416232121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 416232121
		arg_515_1.duration_ = 5.5

		local var_515_0 = {
			zh = 5.5,
			ja = 4.7
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play416232122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["10122"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps10122 == nil then
				arg_515_1.var_.actorSpriteComps10122 = var_518_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_2 = 0.2

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.actorSpriteComps10122 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								local var_518_4 = Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor1.r, var_518_3)
								local var_518_5 = Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor1.g, var_518_3)
								local var_518_6 = Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor1.b, var_518_3)

								iter_518_1.color = Color.New(var_518_4, var_518_5, var_518_6)
							else
								local var_518_7 = Mathf.Lerp(iter_518_1.color.r, 1, var_518_3)

								iter_518_1.color = Color.New(var_518_7, var_518_7, var_518_7)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps10122 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_518_3 then
						if arg_515_1.isInRecall_ then
							iter_518_3.color = arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_518_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_515_1.var_.actorSpriteComps10122 = nil
			end

			local var_518_8 = arg_515_1.actors_["1086"]
			local var_518_9 = 0

			if var_518_9 < arg_515_1.time_ and arg_515_1.time_ <= var_518_9 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps1086 == nil then
				arg_515_1.var_.actorSpriteComps1086 = var_518_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_10 = 0.2

			if var_518_9 <= arg_515_1.time_ and arg_515_1.time_ < var_518_9 + var_518_10 and not isNil(var_518_8) then
				local var_518_11 = (arg_515_1.time_ - var_518_9) / var_518_10

				if arg_515_1.var_.actorSpriteComps1086 then
					for iter_518_4, iter_518_5 in pairs(arg_515_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_518_5 then
							if arg_515_1.isInRecall_ then
								local var_518_12 = Mathf.Lerp(iter_518_5.color.r, arg_515_1.hightColor2.r, var_518_11)
								local var_518_13 = Mathf.Lerp(iter_518_5.color.g, arg_515_1.hightColor2.g, var_518_11)
								local var_518_14 = Mathf.Lerp(iter_518_5.color.b, arg_515_1.hightColor2.b, var_518_11)

								iter_518_5.color = Color.New(var_518_12, var_518_13, var_518_14)
							else
								local var_518_15 = Mathf.Lerp(iter_518_5.color.r, 0.5, var_518_11)

								iter_518_5.color = Color.New(var_518_15, var_518_15, var_518_15)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= var_518_9 + var_518_10 and arg_515_1.time_ < var_518_9 + var_518_10 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps1086 then
				for iter_518_6, iter_518_7 in pairs(arg_515_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_518_7 then
						if arg_515_1.isInRecall_ then
							iter_518_7.color = arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_518_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_515_1.var_.actorSpriteComps1086 = nil
			end

			local var_518_16 = arg_515_1.actors_["10122"].transform
			local var_518_17 = 0

			if var_518_17 < arg_515_1.time_ and arg_515_1.time_ <= var_518_17 + arg_518_0 then
				arg_515_1.var_.moveOldPos10122 = var_518_16.localPosition
				var_518_16.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10122", 2)

				local var_518_18 = var_518_16.childCount

				for iter_518_8 = 0, var_518_18 - 1 do
					local var_518_19 = var_518_16:GetChild(iter_518_8)

					if var_518_19.name == "split_4" or not string.find(var_518_19.name, "split") then
						var_518_19.gameObject:SetActive(true)
					else
						var_518_19.gameObject:SetActive(false)
					end
				end
			end

			local var_518_20 = 0.001

			if var_518_17 <= arg_515_1.time_ and arg_515_1.time_ < var_518_17 + var_518_20 then
				local var_518_21 = (arg_515_1.time_ - var_518_17) / var_518_20
				local var_518_22 = Vector3.New(-390, -380, -100)

				var_518_16.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10122, var_518_22, var_518_21)
			end

			if arg_515_1.time_ >= var_518_17 + var_518_20 and arg_515_1.time_ < var_518_17 + var_518_20 + arg_518_0 then
				var_518_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_518_23 = 0
			local var_518_24 = 0.575

			if var_518_23 < arg_515_1.time_ and arg_515_1.time_ <= var_518_23 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_25 = arg_515_1:FormatText(StoryNameCfg[8].name)

				arg_515_1.leftNameTxt_.text = var_518_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_26 = arg_515_1:GetWordFromCfg(416232121)
				local var_518_27 = arg_515_1:FormatText(var_518_26.content)

				arg_515_1.text_.text = var_518_27

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_28 = 23
				local var_518_29 = utf8.len(var_518_27)
				local var_518_30 = var_518_28 <= 0 and var_518_24 or var_518_24 * (var_518_29 / var_518_28)

				if var_518_30 > 0 and var_518_24 < var_518_30 then
					arg_515_1.talkMaxDuration = var_518_30

					if var_518_30 + var_518_23 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_30 + var_518_23
					end
				end

				arg_515_1.text_.text = var_518_27
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232121", "story_v_out_416232.awb") ~= 0 then
					local var_518_31 = manager.audio:GetVoiceLength("story_v_out_416232", "416232121", "story_v_out_416232.awb") / 1000

					if var_518_31 + var_518_23 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_31 + var_518_23
					end

					if var_518_26.prefab_name ~= "" and arg_515_1.actors_[var_518_26.prefab_name] ~= nil then
						local var_518_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_26.prefab_name].transform, "story_v_out_416232", "416232121", "story_v_out_416232.awb")

						arg_515_1:RecordAudio("416232121", var_518_32)
						arg_515_1:RecordAudio("416232121", var_518_32)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_416232", "416232121", "story_v_out_416232.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_416232", "416232121", "story_v_out_416232.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_33 = math.max(var_518_24, arg_515_1.talkMaxDuration)

			if var_518_23 <= arg_515_1.time_ and arg_515_1.time_ < var_518_23 + var_518_33 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_23) / var_518_33

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_23 + var_518_33 and arg_515_1.time_ < var_518_23 + var_518_33 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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

		arg_515_1:InitPlayNodeList()
	end,
	Play416232122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 416232122
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play416232123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10122"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10122 == nil then
				arg_519_1.var_.actorSpriteComps10122 = var_522_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_2 = 0.2

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.actorSpriteComps10122 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_522_1 then
							if arg_519_1.isInRecall_ then
								local var_522_4 = Mathf.Lerp(iter_522_1.color.r, arg_519_1.hightColor2.r, var_522_3)
								local var_522_5 = Mathf.Lerp(iter_522_1.color.g, arg_519_1.hightColor2.g, var_522_3)
								local var_522_6 = Mathf.Lerp(iter_522_1.color.b, arg_519_1.hightColor2.b, var_522_3)

								iter_522_1.color = Color.New(var_522_4, var_522_5, var_522_6)
							else
								local var_522_7 = Mathf.Lerp(iter_522_1.color.r, 0.5, var_522_3)

								iter_522_1.color = Color.New(var_522_7, var_522_7, var_522_7)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10122 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_522_3 then
						if arg_519_1.isInRecall_ then
							iter_522_3.color = arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_522_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_519_1.var_.actorSpriteComps10122 = nil
			end

			local var_522_8 = arg_519_1.actors_["10122"].transform
			local var_522_9 = 0

			if var_522_9 < arg_519_1.time_ and arg_519_1.time_ <= var_522_9 + arg_522_0 then
				arg_519_1.var_.moveOldPos10122 = var_522_8.localPosition
				var_522_8.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10122", 7)

				local var_522_10 = var_522_8.childCount

				for iter_522_4 = 0, var_522_10 - 1 do
					local var_522_11 = var_522_8:GetChild(iter_522_4)

					if var_522_11.name == "" or not string.find(var_522_11.name, "split") then
						var_522_11.gameObject:SetActive(true)
					else
						var_522_11.gameObject:SetActive(false)
					end
				end
			end

			local var_522_12 = 0.001

			if var_522_9 <= arg_519_1.time_ and arg_519_1.time_ < var_522_9 + var_522_12 then
				local var_522_13 = (arg_519_1.time_ - var_522_9) / var_522_12
				local var_522_14 = Vector3.New(0, -2000, 0)

				var_522_8.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10122, var_522_14, var_522_13)
			end

			if arg_519_1.time_ >= var_522_9 + var_522_12 and arg_519_1.time_ < var_522_9 + var_522_12 + arg_522_0 then
				var_522_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_522_15 = arg_519_1.actors_["1086"].transform
			local var_522_16 = 0

			if var_522_16 < arg_519_1.time_ and arg_519_1.time_ <= var_522_16 + arg_522_0 then
				arg_519_1.var_.moveOldPos1086 = var_522_15.localPosition
				var_522_15.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("1086", 7)

				local var_522_17 = var_522_15.childCount

				for iter_522_5 = 0, var_522_17 - 1 do
					local var_522_18 = var_522_15:GetChild(iter_522_5)

					if var_522_18.name == "" or not string.find(var_522_18.name, "split") then
						var_522_18.gameObject:SetActive(true)
					else
						var_522_18.gameObject:SetActive(false)
					end
				end
			end

			local var_522_19 = 0.001

			if var_522_16 <= arg_519_1.time_ and arg_519_1.time_ < var_522_16 + var_522_19 then
				local var_522_20 = (arg_519_1.time_ - var_522_16) / var_522_19
				local var_522_21 = Vector3.New(0, -2000, 0)

				var_522_15.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1086, var_522_21, var_522_20)
			end

			if arg_519_1.time_ >= var_522_16 + var_522_19 and arg_519_1.time_ < var_522_16 + var_522_19 + arg_522_0 then
				var_522_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_522_22 = 0
			local var_522_23 = 0.775

			if var_522_22 < arg_519_1.time_ and arg_519_1.time_ <= var_522_22 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_24 = arg_519_1:GetWordFromCfg(416232122)
				local var_522_25 = arg_519_1:FormatText(var_522_24.content)

				arg_519_1.text_.text = var_522_25

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_26 = 31
				local var_522_27 = utf8.len(var_522_25)
				local var_522_28 = var_522_26 <= 0 and var_522_23 or var_522_23 * (var_522_27 / var_522_26)

				if var_522_28 > 0 and var_522_23 < var_522_28 then
					arg_519_1.talkMaxDuration = var_522_28

					if var_522_28 + var_522_22 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_28 + var_522_22
					end
				end

				arg_519_1.text_.text = var_522_25
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_29 = math.max(var_522_23, arg_519_1.talkMaxDuration)

			if var_522_22 <= arg_519_1.time_ and arg_519_1.time_ < var_522_22 + var_522_29 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_22) / var_522_29

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_22 + var_522_29 and arg_519_1.time_ < var_522_22 + var_522_29 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
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

		arg_519_1:InitPlayNodeList()
	end,
	Play416232123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 416232123
		arg_523_1.duration_ = 10.23

		local var_523_0 = {
			zh = 4.866,
			ja = 10.233
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play416232124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1086"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.actorSpriteComps1086 == nil then
				arg_523_1.var_.actorSpriteComps1086 = var_526_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_2 = 0.2

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.actorSpriteComps1086 then
					for iter_526_0, iter_526_1 in pairs(arg_523_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_526_1 then
							if arg_523_1.isInRecall_ then
								local var_526_4 = Mathf.Lerp(iter_526_1.color.r, arg_523_1.hightColor1.r, var_526_3)
								local var_526_5 = Mathf.Lerp(iter_526_1.color.g, arg_523_1.hightColor1.g, var_526_3)
								local var_526_6 = Mathf.Lerp(iter_526_1.color.b, arg_523_1.hightColor1.b, var_526_3)

								iter_526_1.color = Color.New(var_526_4, var_526_5, var_526_6)
							else
								local var_526_7 = Mathf.Lerp(iter_526_1.color.r, 1, var_526_3)

								iter_526_1.color = Color.New(var_526_7, var_526_7, var_526_7)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.actorSpriteComps1086 then
				for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_526_3 then
						if arg_523_1.isInRecall_ then
							iter_526_3.color = arg_523_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_526_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_523_1.var_.actorSpriteComps1086 = nil
			end

			local var_526_8 = arg_523_1.actors_["1086"].transform
			local var_526_9 = 0

			if var_526_9 < arg_523_1.time_ and arg_523_1.time_ <= var_526_9 + arg_526_0 then
				arg_523_1.var_.moveOldPos1086 = var_526_8.localPosition
				var_526_8.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("1086", 3)

				local var_526_10 = var_526_8.childCount

				for iter_526_4 = 0, var_526_10 - 1 do
					local var_526_11 = var_526_8:GetChild(iter_526_4)

					if var_526_11.name == "split_6" or not string.find(var_526_11.name, "split") then
						var_526_11.gameObject:SetActive(true)
					else
						var_526_11.gameObject:SetActive(false)
					end
				end
			end

			local var_526_12 = 0.001

			if var_526_9 <= arg_523_1.time_ and arg_523_1.time_ < var_526_9 + var_526_12 then
				local var_526_13 = (arg_523_1.time_ - var_526_9) / var_526_12
				local var_526_14 = Vector3.New(0, -404.2, -237.9)

				var_526_8.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1086, var_526_14, var_526_13)
			end

			if arg_523_1.time_ >= var_526_9 + var_526_12 and arg_523_1.time_ < var_526_9 + var_526_12 + arg_526_0 then
				var_526_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_526_15 = 0
			local var_526_16 = 0.675

			if var_526_15 < arg_523_1.time_ and arg_523_1.time_ <= var_526_15 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_17 = arg_523_1:FormatText(StoryNameCfg[1080].name)

				arg_523_1.leftNameTxt_.text = var_526_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_18 = arg_523_1:GetWordFromCfg(416232123)
				local var_526_19 = arg_523_1:FormatText(var_526_18.content)

				arg_523_1.text_.text = var_526_19

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_20 = 27
				local var_526_21 = utf8.len(var_526_19)
				local var_526_22 = var_526_20 <= 0 and var_526_16 or var_526_16 * (var_526_21 / var_526_20)

				if var_526_22 > 0 and var_526_16 < var_526_22 then
					arg_523_1.talkMaxDuration = var_526_22

					if var_526_22 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_22 + var_526_15
					end
				end

				arg_523_1.text_.text = var_526_19
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232123", "story_v_out_416232.awb") ~= 0 then
					local var_526_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232123", "story_v_out_416232.awb") / 1000

					if var_526_23 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_23 + var_526_15
					end

					if var_526_18.prefab_name ~= "" and arg_523_1.actors_[var_526_18.prefab_name] ~= nil then
						local var_526_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_18.prefab_name].transform, "story_v_out_416232", "416232123", "story_v_out_416232.awb")

						arg_523_1:RecordAudio("416232123", var_526_24)
						arg_523_1:RecordAudio("416232123", var_526_24)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_416232", "416232123", "story_v_out_416232.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_416232", "416232123", "story_v_out_416232.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_25 = math.max(var_526_16, arg_523_1.talkMaxDuration)

			if var_526_15 <= arg_523_1.time_ and arg_523_1.time_ < var_526_15 + var_526_25 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_15) / var_526_25

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_15 + var_526_25 and arg_523_1.time_ < var_526_15 + var_526_25 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
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

		arg_523_1:InitPlayNodeList()
	end,
	Play416232124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 416232124
		arg_527_1.duration_ = 4.53

		local var_527_0 = {
			zh = 3.666,
			ja = 4.533
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play416232125(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.225

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[1080].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_3 = arg_527_1:GetWordFromCfg(416232124)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 9
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232124", "story_v_out_416232.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232124", "story_v_out_416232.awb") / 1000

					if var_530_8 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_0
					end

					if var_530_3.prefab_name ~= "" and arg_527_1.actors_[var_530_3.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_3.prefab_name].transform, "story_v_out_416232", "416232124", "story_v_out_416232.awb")

						arg_527_1:RecordAudio("416232124", var_530_9)
						arg_527_1:RecordAudio("416232124", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_416232", "416232124", "story_v_out_416232.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_416232", "416232124", "story_v_out_416232.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_10 and arg_527_1.time_ < var_530_0 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play416232125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 416232125
		arg_531_1.duration_ = 7.03

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play416232126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_1 = 1.034

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_1 then
				local var_534_2 = (arg_531_1.time_ - var_534_0) / var_534_1
				local var_534_3 = Color.New(0, 0, 0)

				var_534_3.a = Mathf.Lerp(0, 1, var_534_2)
				arg_531_1.mask_.color = var_534_3
			end

			if arg_531_1.time_ >= var_534_0 + var_534_1 and arg_531_1.time_ < var_534_0 + var_534_1 + arg_534_0 then
				local var_534_4 = Color.New(0, 0, 0)

				var_534_4.a = 1
				arg_531_1.mask_.color = var_534_4
			end

			local var_534_5 = 1.034

			if var_534_5 < arg_531_1.time_ and arg_531_1.time_ <= var_534_5 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_6 = 1

			if var_534_5 <= arg_531_1.time_ and arg_531_1.time_ < var_534_5 + var_534_6 then
				local var_534_7 = (arg_531_1.time_ - var_534_5) / var_534_6
				local var_534_8 = Color.New(0, 0, 0)

				var_534_8.a = Mathf.Lerp(1, 0, var_534_7)
				arg_531_1.mask_.color = var_534_8
			end

			if arg_531_1.time_ >= var_534_5 + var_534_6 and arg_531_1.time_ < var_534_5 + var_534_6 + arg_534_0 then
				local var_534_9 = Color.New(0, 0, 0)
				local var_534_10 = 0

				arg_531_1.mask_.enabled = false
				var_534_9.a = var_534_10
				arg_531_1.mask_.color = var_534_9
			end

			local var_534_11 = manager.ui.mainCamera.transform
			local var_534_12 = 1.034

			if var_534_12 < arg_531_1.time_ and arg_531_1.time_ <= var_534_12 + arg_534_0 then
				arg_531_1.var_.shakeOldPos = var_534_11.localPosition
			end

			local var_534_13 = 0.666666666666667

			if var_534_12 <= arg_531_1.time_ and arg_531_1.time_ < var_534_12 + var_534_13 then
				local var_534_14 = (arg_531_1.time_ - var_534_12) / 0.066
				local var_534_15, var_534_16 = math.modf(var_534_14)

				var_534_11.localPosition = Vector3.New(var_534_16 * 0.13, var_534_16 * 0.13, var_534_16 * 0.13) + arg_531_1.var_.shakeOldPos
			end

			if arg_531_1.time_ >= var_534_12 + var_534_13 and arg_531_1.time_ < var_534_12 + var_534_13 + arg_534_0 then
				var_534_11.localPosition = arg_531_1.var_.shakeOldPos
			end

			local var_534_17 = 0

			if var_534_17 < arg_531_1.time_ and arg_531_1.time_ <= var_534_17 + arg_534_0 then
				arg_531_1.allBtn_.enabled = false
			end

			local var_534_18 = 1.16666666666667

			if arg_531_1.time_ >= var_534_17 + var_534_18 and arg_531_1.time_ < var_534_17 + var_534_18 + arg_534_0 then
				arg_531_1.allBtn_.enabled = true
			end

			local var_534_19 = arg_531_1.actors_["1086"].transform
			local var_534_20 = 1

			if var_534_20 < arg_531_1.time_ and arg_531_1.time_ <= var_534_20 + arg_534_0 then
				arg_531_1.var_.moveOldPos1086 = var_534_19.localPosition
				var_534_19.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("1086", 7)

				local var_534_21 = var_534_19.childCount

				for iter_534_0 = 0, var_534_21 - 1 do
					local var_534_22 = var_534_19:GetChild(iter_534_0)

					if var_534_22.name == "" or not string.find(var_534_22.name, "split") then
						var_534_22.gameObject:SetActive(true)
					else
						var_534_22.gameObject:SetActive(false)
					end
				end
			end

			local var_534_23 = 0.001

			if var_534_20 <= arg_531_1.time_ and arg_531_1.time_ < var_534_20 + var_534_23 then
				local var_534_24 = (arg_531_1.time_ - var_534_20) / var_534_23
				local var_534_25 = Vector3.New(0, -2000, 0)

				var_534_19.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1086, var_534_25, var_534_24)
			end

			if arg_531_1.time_ >= var_534_20 + var_534_23 and arg_531_1.time_ < var_534_20 + var_534_23 + arg_534_0 then
				var_534_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_534_26 = 0
			local var_534_27 = 1

			if var_534_26 < arg_531_1.time_ and arg_531_1.time_ <= var_534_26 + arg_534_0 then
				local var_534_28 = "play"
				local var_534_29 = "effect"

				arg_531_1:AudioAction(var_534_28, var_534_29, "se_story_130", "se_story_130__factorystartup", "")
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_30 = 2.034
			local var_534_31 = 1.475

			if var_534_30 < arg_531_1.time_ and arg_531_1.time_ <= var_534_30 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_32 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_32:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_33 = arg_531_1:GetWordFromCfg(416232125)
				local var_534_34 = arg_531_1:FormatText(var_534_33.content)

				arg_531_1.text_.text = var_534_34

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_35 = 59
				local var_534_36 = utf8.len(var_534_34)
				local var_534_37 = var_534_35 <= 0 and var_534_31 or var_534_31 * (var_534_36 / var_534_35)

				if var_534_37 > 0 and var_534_31 < var_534_37 then
					arg_531_1.talkMaxDuration = var_534_37
					var_534_30 = var_534_30 + 0.3

					if var_534_37 + var_534_30 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_37 + var_534_30
					end
				end

				arg_531_1.text_.text = var_534_34
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_38 = var_534_30 + 0.3
			local var_534_39 = math.max(var_534_31, arg_531_1.talkMaxDuration)

			if var_534_38 <= arg_531_1.time_ and arg_531_1.time_ < var_534_38 + var_534_39 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_38) / var_534_39

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_38 + var_534_39 and arg_531_1.time_ < var_534_38 + var_534_39 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play416232126 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 416232126
		arg_537_1.duration_ = 9.37

		local var_537_0 = {
			zh = 9.366,
			ja = 8.2
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play416232127(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1086"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps1086 == nil then
				arg_537_1.var_.actorSpriteComps1086 = var_540_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_2 = 0.2

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.actorSpriteComps1086 then
					for iter_540_0, iter_540_1 in pairs(arg_537_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_540_1 then
							if arg_537_1.isInRecall_ then
								local var_540_4 = Mathf.Lerp(iter_540_1.color.r, arg_537_1.hightColor1.r, var_540_3)
								local var_540_5 = Mathf.Lerp(iter_540_1.color.g, arg_537_1.hightColor1.g, var_540_3)
								local var_540_6 = Mathf.Lerp(iter_540_1.color.b, arg_537_1.hightColor1.b, var_540_3)

								iter_540_1.color = Color.New(var_540_4, var_540_5, var_540_6)
							else
								local var_540_7 = Mathf.Lerp(iter_540_1.color.r, 1, var_540_3)

								iter_540_1.color = Color.New(var_540_7, var_540_7, var_540_7)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps1086 then
				for iter_540_2, iter_540_3 in pairs(arg_537_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_540_3 then
						if arg_537_1.isInRecall_ then
							iter_540_3.color = arg_537_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_540_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_537_1.var_.actorSpriteComps1086 = nil
			end

			local var_540_8 = arg_537_1.actors_["1086"].transform
			local var_540_9 = 0

			if var_540_9 < arg_537_1.time_ and arg_537_1.time_ <= var_540_9 + arg_540_0 then
				arg_537_1.var_.moveOldPos1086 = var_540_8.localPosition
				var_540_8.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("1086", 3)

				local var_540_10 = var_540_8.childCount

				for iter_540_4 = 0, var_540_10 - 1 do
					local var_540_11 = var_540_8:GetChild(iter_540_4)

					if var_540_11.name == "split_1" or not string.find(var_540_11.name, "split") then
						var_540_11.gameObject:SetActive(true)
					else
						var_540_11.gameObject:SetActive(false)
					end
				end
			end

			local var_540_12 = 0.001

			if var_540_9 <= arg_537_1.time_ and arg_537_1.time_ < var_540_9 + var_540_12 then
				local var_540_13 = (arg_537_1.time_ - var_540_9) / var_540_12
				local var_540_14 = Vector3.New(0, -404.2, -237.9)

				var_540_8.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1086, var_540_14, var_540_13)
			end

			if arg_537_1.time_ >= var_540_9 + var_540_12 and arg_537_1.time_ < var_540_9 + var_540_12 + arg_540_0 then
				var_540_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_540_15 = 0
			local var_540_16 = 0.65

			if var_540_15 < arg_537_1.time_ and arg_537_1.time_ <= var_540_15 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_17 = arg_537_1:FormatText(StoryNameCfg[1080].name)

				arg_537_1.leftNameTxt_.text = var_540_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_18 = arg_537_1:GetWordFromCfg(416232126)
				local var_540_19 = arg_537_1:FormatText(var_540_18.content)

				arg_537_1.text_.text = var_540_19

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_20 = 26
				local var_540_21 = utf8.len(var_540_19)
				local var_540_22 = var_540_20 <= 0 and var_540_16 or var_540_16 * (var_540_21 / var_540_20)

				if var_540_22 > 0 and var_540_16 < var_540_22 then
					arg_537_1.talkMaxDuration = var_540_22

					if var_540_22 + var_540_15 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_22 + var_540_15
					end
				end

				arg_537_1.text_.text = var_540_19
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232126", "story_v_out_416232.awb") ~= 0 then
					local var_540_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232126", "story_v_out_416232.awb") / 1000

					if var_540_23 + var_540_15 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_23 + var_540_15
					end

					if var_540_18.prefab_name ~= "" and arg_537_1.actors_[var_540_18.prefab_name] ~= nil then
						local var_540_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_18.prefab_name].transform, "story_v_out_416232", "416232126", "story_v_out_416232.awb")

						arg_537_1:RecordAudio("416232126", var_540_24)
						arg_537_1:RecordAudio("416232126", var_540_24)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_416232", "416232126", "story_v_out_416232.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_416232", "416232126", "story_v_out_416232.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_25 = math.max(var_540_16, arg_537_1.talkMaxDuration)

			if var_540_15 <= arg_537_1.time_ and arg_537_1.time_ < var_540_15 + var_540_25 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_15) / var_540_25

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_15 + var_540_25 and arg_537_1.time_ < var_540_15 + var_540_25 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play416232127 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 416232127
		arg_541_1.duration_ = 6.6

		local var_541_0 = {
			zh = 5,
			ja = 6.6
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play416232128(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1086"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps1086 == nil then
				arg_541_1.var_.actorSpriteComps1086 = var_544_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.actorSpriteComps1086 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								local var_544_4 = Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, var_544_3)
								local var_544_5 = Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, var_544_3)
								local var_544_6 = Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, var_544_3)

								iter_544_1.color = Color.New(var_544_4, var_544_5, var_544_6)
							else
								local var_544_7 = Mathf.Lerp(iter_544_1.color.r, 0.5, var_544_3)

								iter_544_1.color = Color.New(var_544_7, var_544_7, var_544_7)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps1086 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_544_3 then
						if arg_541_1.isInRecall_ then
							iter_544_3.color = arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_544_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps1086 = nil
			end

			local var_544_8 = 0
			local var_544_9 = 0.45

			if var_544_8 < arg_541_1.time_ and arg_541_1.time_ <= var_544_8 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_10 = arg_541_1:FormatText(StoryNameCfg[487].name)

				arg_541_1.leftNameTxt_.text = var_544_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054_split_1")

				arg_541_1.callingController_:SetSelectedState("calling")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_11 = arg_541_1:GetWordFromCfg(416232127)
				local var_544_12 = arg_541_1:FormatText(var_544_11.content)

				arg_541_1.text_.text = var_544_12

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_13 = 18
				local var_544_14 = utf8.len(var_544_12)
				local var_544_15 = var_544_13 <= 0 and var_544_9 or var_544_9 * (var_544_14 / var_544_13)

				if var_544_15 > 0 and var_544_9 < var_544_15 then
					arg_541_1.talkMaxDuration = var_544_15

					if var_544_15 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_15 + var_544_8
					end
				end

				arg_541_1.text_.text = var_544_12
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232127", "story_v_out_416232.awb") ~= 0 then
					local var_544_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232127", "story_v_out_416232.awb") / 1000

					if var_544_16 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_16 + var_544_8
					end

					if var_544_11.prefab_name ~= "" and arg_541_1.actors_[var_544_11.prefab_name] ~= nil then
						local var_544_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_11.prefab_name].transform, "story_v_out_416232", "416232127", "story_v_out_416232.awb")

						arg_541_1:RecordAudio("416232127", var_544_17)
						arg_541_1:RecordAudio("416232127", var_544_17)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_416232", "416232127", "story_v_out_416232.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_416232", "416232127", "story_v_out_416232.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_18 = math.max(var_544_9, arg_541_1.talkMaxDuration)

			if var_544_8 <= arg_541_1.time_ and arg_541_1.time_ < var_544_8 + var_544_18 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_8) / var_544_18

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_8 + var_544_18 and arg_541_1.time_ < var_544_8 + var_544_18 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play416232128 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 416232128
		arg_545_1.duration_ = 14

		local var_545_0 = {
			zh = 6.966,
			ja = 14
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play416232129(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["1086"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps1086 == nil then
				arg_545_1.var_.actorSpriteComps1086 = var_548_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_2 = 0.2

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.actorSpriteComps1086 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								local var_548_4 = Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor1.r, var_548_3)
								local var_548_5 = Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor1.g, var_548_3)
								local var_548_6 = Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor1.b, var_548_3)

								iter_548_1.color = Color.New(var_548_4, var_548_5, var_548_6)
							else
								local var_548_7 = Mathf.Lerp(iter_548_1.color.r, 1, var_548_3)

								iter_548_1.color = Color.New(var_548_7, var_548_7, var_548_7)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps1086 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_548_3 then
						if arg_545_1.isInRecall_ then
							iter_548_3.color = arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_548_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_545_1.var_.actorSpriteComps1086 = nil
			end

			local var_548_8 = "10054"

			if arg_545_1.actors_[var_548_8] == nil then
				local var_548_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_548_9) then
					local var_548_10 = Object.Instantiate(var_548_9, arg_545_1.canvasGo_.transform)

					var_548_10.transform:SetSiblingIndex(1)

					var_548_10.name = var_548_8
					var_548_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_545_1.actors_[var_548_8] = var_548_10

					local var_548_11 = var_548_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_545_1.isInRecall_ then
						for iter_548_4, iter_548_5 in ipairs(var_548_11) do
							iter_548_5.color = arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_548_12 = arg_545_1.actors_["10054"]
			local var_548_13 = 0

			if var_548_13 < arg_545_1.time_ and arg_545_1.time_ <= var_548_13 + arg_548_0 and not isNil(var_548_12) and arg_545_1.var_.actorSpriteComps10054 == nil then
				arg_545_1.var_.actorSpriteComps10054 = var_548_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_14 = 0.2

			if var_548_13 <= arg_545_1.time_ and arg_545_1.time_ < var_548_13 + var_548_14 and not isNil(var_548_12) then
				local var_548_15 = (arg_545_1.time_ - var_548_13) / var_548_14

				if arg_545_1.var_.actorSpriteComps10054 then
					for iter_548_6, iter_548_7 in pairs(arg_545_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_548_7 then
							if arg_545_1.isInRecall_ then
								local var_548_16 = Mathf.Lerp(iter_548_7.color.r, arg_545_1.hightColor2.r, var_548_15)
								local var_548_17 = Mathf.Lerp(iter_548_7.color.g, arg_545_1.hightColor2.g, var_548_15)
								local var_548_18 = Mathf.Lerp(iter_548_7.color.b, arg_545_1.hightColor2.b, var_548_15)

								iter_548_7.color = Color.New(var_548_16, var_548_17, var_548_18)
							else
								local var_548_19 = Mathf.Lerp(iter_548_7.color.r, 0.5, var_548_15)

								iter_548_7.color = Color.New(var_548_19, var_548_19, var_548_19)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= var_548_13 + var_548_14 and arg_545_1.time_ < var_548_13 + var_548_14 + arg_548_0 and not isNil(var_548_12) and arg_545_1.var_.actorSpriteComps10054 then
				for iter_548_8, iter_548_9 in pairs(arg_545_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_548_9 then
						if arg_545_1.isInRecall_ then
							iter_548_9.color = arg_545_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_548_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_545_1.var_.actorSpriteComps10054 = nil
			end

			local var_548_20 = arg_545_1.actors_["1086"].transform
			local var_548_21 = 0

			if var_548_21 < arg_545_1.time_ and arg_545_1.time_ <= var_548_21 + arg_548_0 then
				arg_545_1.var_.moveOldPos1086 = var_548_20.localPosition
				var_548_20.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("1086", 3)

				local var_548_22 = var_548_20.childCount

				for iter_548_10 = 0, var_548_22 - 1 do
					local var_548_23 = var_548_20:GetChild(iter_548_10)

					if var_548_23.name == "split_5" or not string.find(var_548_23.name, "split") then
						var_548_23.gameObject:SetActive(true)
					else
						var_548_23.gameObject:SetActive(false)
					end
				end
			end

			local var_548_24 = 0.001

			if var_548_21 <= arg_545_1.time_ and arg_545_1.time_ < var_548_21 + var_548_24 then
				local var_548_25 = (arg_545_1.time_ - var_548_21) / var_548_24
				local var_548_26 = Vector3.New(0, -404.2, -237.9)

				var_548_20.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1086, var_548_26, var_548_25)
			end

			if arg_545_1.time_ >= var_548_21 + var_548_24 and arg_545_1.time_ < var_548_21 + var_548_24 + arg_548_0 then
				var_548_20.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_548_27 = 0
			local var_548_28 = 0.65

			if var_548_27 < arg_545_1.time_ and arg_545_1.time_ <= var_548_27 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_29 = arg_545_1:FormatText(StoryNameCfg[1080].name)

				arg_545_1.leftNameTxt_.text = var_548_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_30 = arg_545_1:GetWordFromCfg(416232128)
				local var_548_31 = arg_545_1:FormatText(var_548_30.content)

				arg_545_1.text_.text = var_548_31

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_32 = 26
				local var_548_33 = utf8.len(var_548_31)
				local var_548_34 = var_548_32 <= 0 and var_548_28 or var_548_28 * (var_548_33 / var_548_32)

				if var_548_34 > 0 and var_548_28 < var_548_34 then
					arg_545_1.talkMaxDuration = var_548_34

					if var_548_34 + var_548_27 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_34 + var_548_27
					end
				end

				arg_545_1.text_.text = var_548_31
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232128", "story_v_out_416232.awb") ~= 0 then
					local var_548_35 = manager.audio:GetVoiceLength("story_v_out_416232", "416232128", "story_v_out_416232.awb") / 1000

					if var_548_35 + var_548_27 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_35 + var_548_27
					end

					if var_548_30.prefab_name ~= "" and arg_545_1.actors_[var_548_30.prefab_name] ~= nil then
						local var_548_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_30.prefab_name].transform, "story_v_out_416232", "416232128", "story_v_out_416232.awb")

						arg_545_1:RecordAudio("416232128", var_548_36)
						arg_545_1:RecordAudio("416232128", var_548_36)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_416232", "416232128", "story_v_out_416232.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_416232", "416232128", "story_v_out_416232.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_37 = math.max(var_548_28, arg_545_1.talkMaxDuration)

			if var_548_27 <= arg_545_1.time_ and arg_545_1.time_ < var_548_27 + var_548_37 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_27) / var_548_37

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_27 + var_548_37 and arg_545_1.time_ < var_548_27 + var_548_37 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
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

		arg_545_1:InitPlayNodeList()
	end,
	Play416232129 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 416232129
		arg_549_1.duration_ = 3.77

		local var_549_0 = {
			zh = 3.766,
			ja = 2.7
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play416232130(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.4

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[1080].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(416232129)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 16
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232129", "story_v_out_416232.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232129", "story_v_out_416232.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_out_416232", "416232129", "story_v_out_416232.awb")

						arg_549_1:RecordAudio("416232129", var_552_9)
						arg_549_1:RecordAudio("416232129", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_416232", "416232129", "story_v_out_416232.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_416232", "416232129", "story_v_out_416232.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play416232130 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 416232130
		arg_553_1.duration_ = 2.77

		local var_553_0 = {
			zh = 2.766,
			ja = 1.9
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play416232131(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["10122"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps10122 == nil then
				arg_553_1.var_.actorSpriteComps10122 = var_556_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.actorSpriteComps10122 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								local var_556_4 = Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, var_556_3)
								local var_556_5 = Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, var_556_3)
								local var_556_6 = Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, var_556_3)

								iter_556_1.color = Color.New(var_556_4, var_556_5, var_556_6)
							else
								local var_556_7 = Mathf.Lerp(iter_556_1.color.r, 1, var_556_3)

								iter_556_1.color = Color.New(var_556_7, var_556_7, var_556_7)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps10122 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_556_3 then
						if arg_553_1.isInRecall_ then
							iter_556_3.color = arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_556_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps10122 = nil
			end

			local var_556_8 = arg_553_1.actors_["1086"]
			local var_556_9 = 0

			if var_556_9 < arg_553_1.time_ and arg_553_1.time_ <= var_556_9 + arg_556_0 and not isNil(var_556_8) and arg_553_1.var_.actorSpriteComps1086 == nil then
				arg_553_1.var_.actorSpriteComps1086 = var_556_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_10 = 0.2

			if var_556_9 <= arg_553_1.time_ and arg_553_1.time_ < var_556_9 + var_556_10 and not isNil(var_556_8) then
				local var_556_11 = (arg_553_1.time_ - var_556_9) / var_556_10

				if arg_553_1.var_.actorSpriteComps1086 then
					for iter_556_4, iter_556_5 in pairs(arg_553_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_556_5 then
							if arg_553_1.isInRecall_ then
								local var_556_12 = Mathf.Lerp(iter_556_5.color.r, arg_553_1.hightColor2.r, var_556_11)
								local var_556_13 = Mathf.Lerp(iter_556_5.color.g, arg_553_1.hightColor2.g, var_556_11)
								local var_556_14 = Mathf.Lerp(iter_556_5.color.b, arg_553_1.hightColor2.b, var_556_11)

								iter_556_5.color = Color.New(var_556_12, var_556_13, var_556_14)
							else
								local var_556_15 = Mathf.Lerp(iter_556_5.color.r, 0.5, var_556_11)

								iter_556_5.color = Color.New(var_556_15, var_556_15, var_556_15)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_9 + var_556_10 and arg_553_1.time_ < var_556_9 + var_556_10 + arg_556_0 and not isNil(var_556_8) and arg_553_1.var_.actorSpriteComps1086 then
				for iter_556_6, iter_556_7 in pairs(arg_553_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_556_7 then
						if arg_553_1.isInRecall_ then
							iter_556_7.color = arg_553_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_556_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps1086 = nil
			end

			local var_556_16 = arg_553_1.actors_["1086"].transform
			local var_556_17 = 0

			if var_556_17 < arg_553_1.time_ and arg_553_1.time_ <= var_556_17 + arg_556_0 then
				arg_553_1.var_.moveOldPos1086 = var_556_16.localPosition
				var_556_16.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("1086", 7)

				local var_556_18 = var_556_16.childCount

				for iter_556_8 = 0, var_556_18 - 1 do
					local var_556_19 = var_556_16:GetChild(iter_556_8)

					if var_556_19.name == "" or not string.find(var_556_19.name, "split") then
						var_556_19.gameObject:SetActive(true)
					else
						var_556_19.gameObject:SetActive(false)
					end
				end
			end

			local var_556_20 = 0.001

			if var_556_17 <= arg_553_1.time_ and arg_553_1.time_ < var_556_17 + var_556_20 then
				local var_556_21 = (arg_553_1.time_ - var_556_17) / var_556_20
				local var_556_22 = Vector3.New(0, -2000, 0)

				var_556_16.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1086, var_556_22, var_556_21)
			end

			if arg_553_1.time_ >= var_556_17 + var_556_20 and arg_553_1.time_ < var_556_17 + var_556_20 + arg_556_0 then
				var_556_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_556_23 = arg_553_1.actors_["10122"].transform
			local var_556_24 = 0

			if var_556_24 < arg_553_1.time_ and arg_553_1.time_ <= var_556_24 + arg_556_0 then
				arg_553_1.var_.moveOldPos10122 = var_556_23.localPosition
				var_556_23.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10122", 3)

				local var_556_25 = var_556_23.childCount

				for iter_556_9 = 0, var_556_25 - 1 do
					local var_556_26 = var_556_23:GetChild(iter_556_9)

					if var_556_26.name == "" or not string.find(var_556_26.name, "split") then
						var_556_26.gameObject:SetActive(true)
					else
						var_556_26.gameObject:SetActive(false)
					end
				end
			end

			local var_556_27 = 0.001

			if var_556_24 <= arg_553_1.time_ and arg_553_1.time_ < var_556_24 + var_556_27 then
				local var_556_28 = (arg_553_1.time_ - var_556_24) / var_556_27
				local var_556_29 = Vector3.New(0, -380, -100)

				var_556_23.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10122, var_556_29, var_556_28)
			end

			if arg_553_1.time_ >= var_556_24 + var_556_27 and arg_553_1.time_ < var_556_24 + var_556_27 + arg_556_0 then
				var_556_23.localPosition = Vector3.New(0, -380, -100)
			end

			local var_556_30 = 0
			local var_556_31 = 0.25

			if var_556_30 < arg_553_1.time_ and arg_553_1.time_ <= var_556_30 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_32 = arg_553_1:FormatText(StoryNameCfg[8].name)

				arg_553_1.leftNameTxt_.text = var_556_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_33 = arg_553_1:GetWordFromCfg(416232130)
				local var_556_34 = arg_553_1:FormatText(var_556_33.content)

				arg_553_1.text_.text = var_556_34

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_35 = 10
				local var_556_36 = utf8.len(var_556_34)
				local var_556_37 = var_556_35 <= 0 and var_556_31 or var_556_31 * (var_556_36 / var_556_35)

				if var_556_37 > 0 and var_556_31 < var_556_37 then
					arg_553_1.talkMaxDuration = var_556_37

					if var_556_37 + var_556_30 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_37 + var_556_30
					end
				end

				arg_553_1.text_.text = var_556_34
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232130", "story_v_out_416232.awb") ~= 0 then
					local var_556_38 = manager.audio:GetVoiceLength("story_v_out_416232", "416232130", "story_v_out_416232.awb") / 1000

					if var_556_38 + var_556_30 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_38 + var_556_30
					end

					if var_556_33.prefab_name ~= "" and arg_553_1.actors_[var_556_33.prefab_name] ~= nil then
						local var_556_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_33.prefab_name].transform, "story_v_out_416232", "416232130", "story_v_out_416232.awb")

						arg_553_1:RecordAudio("416232130", var_556_39)
						arg_553_1:RecordAudio("416232130", var_556_39)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_416232", "416232130", "story_v_out_416232.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_416232", "416232130", "story_v_out_416232.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_40 = math.max(var_556_31, arg_553_1.talkMaxDuration)

			if var_556_30 <= arg_553_1.time_ and arg_553_1.time_ < var_556_30 + var_556_40 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_30) / var_556_40

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_30 + var_556_40 and arg_553_1.time_ < var_556_30 + var_556_40 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play416232131 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 416232131
		arg_557_1.duration_ = 5.07

		local var_557_0 = {
			zh = 5,
			ja = 5.066
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play416232132(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10122"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10122 == nil then
				arg_557_1.var_.actorSpriteComps10122 = var_560_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.actorSpriteComps10122 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								local var_560_4 = Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, var_560_3)
								local var_560_5 = Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, var_560_3)
								local var_560_6 = Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, var_560_3)

								iter_560_1.color = Color.New(var_560_4, var_560_5, var_560_6)
							else
								local var_560_7 = Mathf.Lerp(iter_560_1.color.r, 0.5, var_560_3)

								iter_560_1.color = Color.New(var_560_7, var_560_7, var_560_7)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10122 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_560_3 then
						if arg_557_1.isInRecall_ then
							iter_560_3.color = arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_560_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_557_1.var_.actorSpriteComps10122 = nil
			end

			local var_560_8 = 0
			local var_560_9 = 0.35

			if var_560_8 < arg_557_1.time_ and arg_557_1.time_ <= var_560_8 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_10 = arg_557_1:FormatText(StoryNameCfg[1080].name)

				arg_557_1.leftNameTxt_.text = var_560_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_5")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_11 = arg_557_1:GetWordFromCfg(416232131)
				local var_560_12 = arg_557_1:FormatText(var_560_11.content)

				arg_557_1.text_.text = var_560_12

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_13 = 14
				local var_560_14 = utf8.len(var_560_12)
				local var_560_15 = var_560_13 <= 0 and var_560_9 or var_560_9 * (var_560_14 / var_560_13)

				if var_560_15 > 0 and var_560_9 < var_560_15 then
					arg_557_1.talkMaxDuration = var_560_15

					if var_560_15 + var_560_8 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_15 + var_560_8
					end
				end

				arg_557_1.text_.text = var_560_12
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232131", "story_v_out_416232.awb") ~= 0 then
					local var_560_16 = manager.audio:GetVoiceLength("story_v_out_416232", "416232131", "story_v_out_416232.awb") / 1000

					if var_560_16 + var_560_8 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_16 + var_560_8
					end

					if var_560_11.prefab_name ~= "" and arg_557_1.actors_[var_560_11.prefab_name] ~= nil then
						local var_560_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_11.prefab_name].transform, "story_v_out_416232", "416232131", "story_v_out_416232.awb")

						arg_557_1:RecordAudio("416232131", var_560_17)
						arg_557_1:RecordAudio("416232131", var_560_17)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_416232", "416232131", "story_v_out_416232.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_416232", "416232131", "story_v_out_416232.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_18 = math.max(var_560_9, arg_557_1.talkMaxDuration)

			if var_560_8 <= arg_557_1.time_ and arg_557_1.time_ < var_560_8 + var_560_18 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_8) / var_560_18

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_8 + var_560_18 and arg_557_1.time_ < var_560_8 + var_560_18 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play416232132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 416232132
		arg_561_1.duration_ = 4.6

		local var_561_0 = {
			zh = 2.233,
			ja = 4.6
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
			arg_561_1.auto_ = false
		end

		function arg_561_1.playNext_(arg_563_0)
			arg_561_1.onStoryFinished_()
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["10122"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps10122 == nil then
				arg_561_1.var_.actorSpriteComps10122 = var_564_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_2 = 0.2

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.actorSpriteComps10122 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								local var_564_4 = Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor1.r, var_564_3)
								local var_564_5 = Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor1.g, var_564_3)
								local var_564_6 = Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor1.b, var_564_3)

								iter_564_1.color = Color.New(var_564_4, var_564_5, var_564_6)
							else
								local var_564_7 = Mathf.Lerp(iter_564_1.color.r, 1, var_564_3)

								iter_564_1.color = Color.New(var_564_7, var_564_7, var_564_7)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps10122 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_564_3 then
						if arg_561_1.isInRecall_ then
							iter_564_3.color = arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_564_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_561_1.var_.actorSpriteComps10122 = nil
			end

			local var_564_8 = arg_561_1.actors_["10122"].transform
			local var_564_9 = 0

			if var_564_9 < arg_561_1.time_ and arg_561_1.time_ <= var_564_9 + arg_564_0 then
				arg_561_1.var_.moveOldPos10122 = var_564_8.localPosition
				var_564_8.localScale = Vector3.New(1, 1, 1)

				arg_561_1:CheckSpriteTmpPos("10122", 3)

				local var_564_10 = var_564_8.childCount

				for iter_564_4 = 0, var_564_10 - 1 do
					local var_564_11 = var_564_8:GetChild(iter_564_4)

					if var_564_11.name == "split_5" or not string.find(var_564_11.name, "split") then
						var_564_11.gameObject:SetActive(true)
					else
						var_564_11.gameObject:SetActive(false)
					end
				end
			end

			local var_564_12 = 0.001

			if var_564_9 <= arg_561_1.time_ and arg_561_1.time_ < var_564_9 + var_564_12 then
				local var_564_13 = (arg_561_1.time_ - var_564_9) / var_564_12
				local var_564_14 = Vector3.New(0, -380, -100)

				var_564_8.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10122, var_564_14, var_564_13)
			end

			if arg_561_1.time_ >= var_564_9 + var_564_12 and arg_561_1.time_ < var_564_9 + var_564_12 + arg_564_0 then
				var_564_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_564_15 = 0
			local var_564_16 = 0.2

			if var_564_15 < arg_561_1.time_ and arg_561_1.time_ <= var_564_15 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_17 = arg_561_1:FormatText(StoryNameCfg[8].name)

				arg_561_1.leftNameTxt_.text = var_564_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_18 = arg_561_1:GetWordFromCfg(416232132)
				local var_564_19 = arg_561_1:FormatText(var_564_18.content)

				arg_561_1.text_.text = var_564_19

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_20 = 8
				local var_564_21 = utf8.len(var_564_19)
				local var_564_22 = var_564_20 <= 0 and var_564_16 or var_564_16 * (var_564_21 / var_564_20)

				if var_564_22 > 0 and var_564_16 < var_564_22 then
					arg_561_1.talkMaxDuration = var_564_22

					if var_564_22 + var_564_15 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_22 + var_564_15
					end
				end

				arg_561_1.text_.text = var_564_19
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232132", "story_v_out_416232.awb") ~= 0 then
					local var_564_23 = manager.audio:GetVoiceLength("story_v_out_416232", "416232132", "story_v_out_416232.awb") / 1000

					if var_564_23 + var_564_15 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_23 + var_564_15
					end

					if var_564_18.prefab_name ~= "" and arg_561_1.actors_[var_564_18.prefab_name] ~= nil then
						local var_564_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_18.prefab_name].transform, "story_v_out_416232", "416232132", "story_v_out_416232.awb")

						arg_561_1:RecordAudio("416232132", var_564_24)
						arg_561_1:RecordAudio("416232132", var_564_24)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_416232", "416232132", "story_v_out_416232.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_416232", "416232132", "story_v_out_416232.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_25 = math.max(var_564_16, arg_561_1.talkMaxDuration)

			if var_564_15 <= arg_561_1.time_ and arg_561_1.time_ < var_564_15 + var_564_25 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_15) / var_564_25

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_15 + var_564_25 and arg_561_1.time_ < var_564_15 + var_564_25 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
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

		arg_561_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F09f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1610"
	},
	voices = {
		"story_v_out_416232.awb"
	}
}
