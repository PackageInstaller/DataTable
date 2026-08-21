return {
	Play416022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416022001
		arg_1_1.duration_ = 8.07

		local var_1_0 = {
			zh = 6.966,
			ja = 8.066
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
				arg_1_0:Play416022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H01"

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
				local var_4_5 = arg_1_1.bgs_.H01

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
					if iter_4_0 ~= "H01" then
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

			local var_4_24 = "1028"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

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

			local var_4_28 = arg_1_1.actors_["1028"].transform
			local var_4_29 = 1.76666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos1028 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1028", 3)

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
				local var_4_34 = Vector3.New(0, -402.7, -156.1)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1028, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_4_35 = arg_1_1.actors_["1028"]
			local var_4_36 = 1.76666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1028 == nil then
				arg_1_1.var_.actorSpriteComps1028 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.125

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps1028 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1028 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1028 = nil
			end

			local var_4_43 = arg_1_1.actors_["1028"]
			local var_4_44 = 1.76666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1028 = var_4_45.alpha
					arg_1_1.var_.characterEffect1028 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1028 = 0
			end

			local var_4_46 = 0.857666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1028, 1, var_4_47)

				if arg_1_1.var_.characterEffect1028 then
					arg_1_1.var_.characterEffect1028.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1028 then
				arg_1_1.var_.characterEffect1028.alpha = 1
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

			local var_4_61 = 2
			local var_4_62 = 0.375

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[327].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416022001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022001", "story_v_out_416022.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416022", "416022001", "story_v_out_416022.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416022", "416022001", "story_v_out_416022.awb")

						arg_1_1:RecordAudio("416022001", var_4_71)
						arg_1_1:RecordAudio("416022001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416022", "416022001", "story_v_out_416022.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416022", "416022001", "story_v_out_416022.awb")
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
				actorName = "1028",
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
	Play416022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416022002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1028"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1028 == nil then
				arg_9_1.var_.actorSpriteComps1028 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.125

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1028 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1028 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1028 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 1.4

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(416022002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 56
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_9 or var_12_9 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_9 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_15 and arg_9_1.time_ < var_12_8 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play416022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416022003
		arg_13_1.duration_ = 6.8

		local var_13_0 = {
			zh = 6.4,
			ja = 6.8
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
				arg_13_0:Play416022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1028"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1028 == nil then
				arg_13_1.var_.actorSpriteComps1028 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.125

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1028 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1028 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1028 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.55

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[327].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_11 = arg_13_1:GetWordFromCfg(416022003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022003", "story_v_out_416022.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_416022", "416022003", "story_v_out_416022.awb") / 1000

					if var_16_16 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_8
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_416022", "416022003", "story_v_out_416022.awb")

						arg_13_1:RecordAudio("416022003", var_16_17)
						arg_13_1:RecordAudio("416022003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416022", "416022003", "story_v_out_416022.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416022", "416022003", "story_v_out_416022.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_18 and arg_13_1.time_ < var_16_8 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416022004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416022004
		arg_17_1.duration_ = 4.27

		local var_17_0 = {
			zh = 3.5,
			ja = 4.266
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
				arg_17_0:Play416022005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				local var_20_2 = "play"
				local var_20_3 = "effect"

				arg_17_1:AudioAction(var_20_2, var_20_3, "se_story_138", "se_story_138_phonebusy", "")
			end

			local var_20_4 = 0
			local var_20_5 = 0.225

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_6 = arg_17_1:FormatText(StoryNameCfg[327].name)

				arg_17_1.leftNameTxt_.text = var_20_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(416022004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 9
				local var_20_10 = utf8.len(var_20_8)
				local var_20_11 = var_20_9 <= 0 and var_20_5 or var_20_5 * (var_20_10 / var_20_9)

				if var_20_11 > 0 and var_20_5 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022004", "story_v_out_416022.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_416022", "416022004", "story_v_out_416022.awb") / 1000

					if var_20_12 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_4
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_416022", "416022004", "story_v_out_416022.awb")

						arg_17_1:RecordAudio("416022004", var_20_13)
						arg_17_1:RecordAudio("416022004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416022", "416022004", "story_v_out_416022.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416022", "416022004", "story_v_out_416022.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_14 and arg_17_1.time_ < var_20_4 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416022005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416022005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416022006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1028"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1028 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1028", 7)

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

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1028, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_7 = 0
			local var_24_8 = 1.35

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

				local var_24_9 = arg_21_1:GetWordFromCfg(416022005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 54
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
				actorName = "1028",
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
	Play416022006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416022006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 3.766,
			ja = 4
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
				arg_25_0:Play416022007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1028"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1028 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1028", 3)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_2" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -402.7, -156.1)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1028, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_28_7 = arg_25_1.actors_["1028"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1028 == nil then
				arg_25_1.var_.actorSpriteComps1028 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.125

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1028 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1028 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1028 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.45

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[327].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(416022006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022006", "story_v_out_416022.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_416022", "416022006", "story_v_out_416022.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_416022", "416022006", "story_v_out_416022.awb")

						arg_25_1:RecordAudio("416022006", var_28_24)
						arg_25_1:RecordAudio("416022006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416022", "416022006", "story_v_out_416022.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416022", "416022006", "story_v_out_416022.awb")
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
				actorName = "1028",
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
	Play416022007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416022007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416022008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1028"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1028 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1028", 7)

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

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1028, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_7 = 0
			local var_32_8 = 1

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(416022007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 40
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_8 or var_32_8 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_8 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_14 and arg_29_1.time_ < var_32_7 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play416022008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416022008
		arg_33_1.duration_ = 7.83

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416022009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "ST0602"

			if arg_33_1.bgs_[var_36_0] == nil then
				local var_36_1 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_0)
				var_36_1.name = var_36_0
				var_36_1.transform.parent = arg_33_1.stage_.transform
				var_36_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_0] = var_36_1
			end

			local var_36_2 = 1.03333333333333

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				local var_36_3 = manager.ui.mainCamera.transform.localPosition
				local var_36_4 = Vector3.New(0, 0, 10) + Vector3.New(var_36_3.x, var_36_3.y, 0)
				local var_36_5 = arg_33_1.bgs_.ST0602

				var_36_5.transform.localPosition = var_36_4
				var_36_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_6 = var_36_5:GetComponent("SpriteRenderer")

				if var_36_6 and var_36_6.sprite then
					local var_36_7 = (var_36_5.transform.localPosition - var_36_3).z
					local var_36_8 = manager.ui.mainCameraCom_
					local var_36_9 = 2 * var_36_7 * Mathf.Tan(var_36_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_10 = var_36_9 * var_36_8.aspect
					local var_36_11 = var_36_6.sprite.bounds.size.x
					local var_36_12 = var_36_6.sprite.bounds.size.y
					local var_36_13 = var_36_10 / var_36_11
					local var_36_14 = var_36_9 / var_36_12
					local var_36_15 = var_36_14 < var_36_13 and var_36_13 or var_36_14

					var_36_5.transform.localScale = Vector3.New(var_36_15, var_36_15, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "ST0602" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_16 = 3.03333333333334

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			local var_36_17 = 0.3

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_19 = 1.03333333333333

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_19 then
				local var_36_20 = (arg_33_1.time_ - var_36_18) / var_36_19
				local var_36_21 = Color.New(0, 0, 0)

				var_36_21.a = Mathf.Lerp(0, 1, var_36_20)
				arg_33_1.mask_.color = var_36_21
			end

			if arg_33_1.time_ >= var_36_18 + var_36_19 and arg_33_1.time_ < var_36_18 + var_36_19 + arg_36_0 then
				local var_36_22 = Color.New(0, 0, 0)

				var_36_22.a = 1
				arg_33_1.mask_.color = var_36_22
			end

			local var_36_23 = 1.03333333333333

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_24 = 2

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 then
				local var_36_25 = (arg_33_1.time_ - var_36_23) / var_36_24
				local var_36_26 = Color.New(0, 0, 0)

				var_36_26.a = Mathf.Lerp(1, 0, var_36_25)
				arg_33_1.mask_.color = var_36_26
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 then
				local var_36_27 = Color.New(0, 0, 0)
				local var_36_28 = 0

				arg_33_1.mask_.enabled = false
				var_36_27.a = var_36_28
				arg_33_1.mask_.color = var_36_27
			end

			local var_36_29 = arg_33_1.actors_["123"]
			local var_36_30 = 1.03333333333333

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				local var_36_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_36_31 then
					var_36_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_36_31.radialBlurScale = 0
					var_36_31.radialBlurGradient = 1
					var_36_31.radialBlurIntensity = 1

					if var_36_29 then
						var_36_31.radialBlurTarget = var_36_29.transform
					end
				end
			end

			local var_36_32 = 1.13333333333433

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_32 then
				local var_36_33 = (arg_33_1.time_ - var_36_30) / var_36_32
				local var_36_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_36_34 then
					var_36_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_36_34.radialBlurScale = Mathf.Lerp(0, 0, var_36_33)
					var_36_34.radialBlurGradient = Mathf.Lerp(1, 1, var_36_33)
					var_36_34.radialBlurIntensity = Mathf.Lerp(1, 1, var_36_33)
				end
			end

			if arg_33_1.time_ >= var_36_30 + var_36_32 and arg_33_1.time_ < var_36_30 + var_36_32 + arg_36_0 then
				local var_36_35 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_36_35 then
					var_36_35.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_36_35.radialBlurScale = 0
					var_36_35.radialBlurGradient = 1
					var_36_35.radialBlurIntensity = 1
				end
			end

			local var_36_36 = manager.ui.mainCamera.transform
			local var_36_37 = 1.03333333333333

			if var_36_37 < arg_33_1.time_ and arg_33_1.time_ <= var_36_37 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_36.localPosition
			end

			local var_36_38 = 0.566666666666667

			if var_36_37 <= arg_33_1.time_ and arg_33_1.time_ < var_36_37 + var_36_38 then
				local var_36_39 = (arg_33_1.time_ - var_36_37) / 0.066
				local var_36_40, var_36_41 = math.modf(var_36_39)

				var_36_36.localPosition = Vector3.New(var_36_41 * 0.13, var_36_41 * 0.13, var_36_41 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= var_36_37 + var_36_38 and arg_33_1.time_ < var_36_37 + var_36_38 + arg_36_0 then
				var_36_36.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_42 = manager.ui.mainCamera.transform
			local var_36_43 = 1.33333333333333

			if var_36_43 < arg_33_1.time_ and arg_33_1.time_ <= var_36_43 + arg_36_0 then
				local var_36_44 = arg_33_1.var_.effect333333
				local var_36_45
				local var_36_46 = var_36_42

				if not var_36_44 then
					var_36_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), var_36_46)
					var_36_44.name = "333"
					arg_33_1.var_.effect333333 = var_36_44
				else
					var_36_44.transform:SetParent(var_36_46)
				end

				var_36_44.transform.localPosition = Vector3.New(0, 0, 0)
				var_36_44.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_36_47 = 1.36666666666667
			local var_36_48 = 1

			if var_36_47 < arg_33_1.time_ and arg_33_1.time_ <= var_36_47 + arg_36_0 then
				local var_36_49 = "play"
				local var_36_50 = "effect"

				arg_33_1:AudioAction(var_36_49, var_36_50, "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_51 = 2.82919060066342
			local var_36_52 = 1.5

			if var_36_51 < arg_33_1.time_ and arg_33_1.time_ <= var_36_51 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_53 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_53:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_54 = arg_33_1:GetWordFromCfg(416022008)
				local var_36_55 = arg_33_1:FormatText(var_36_54.content)

				arg_33_1.text_.text = var_36_55

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_56 = 60
				local var_36_57 = utf8.len(var_36_55)
				local var_36_58 = var_36_56 <= 0 and var_36_52 or var_36_52 * (var_36_57 / var_36_56)

				if var_36_58 > 0 and var_36_52 < var_36_58 then
					arg_33_1.talkMaxDuration = var_36_58
					var_36_51 = var_36_51 + 0.3

					if var_36_58 + var_36_51 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_58 + var_36_51
					end
				end

				arg_33_1.text_.text = var_36_55
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_59 = var_36_51 + 0.3
			local var_36_60 = math.max(var_36_52, arg_33_1.talkMaxDuration)

			if var_36_59 <= arg_33_1.time_ and arg_33_1.time_ < var_36_59 + var_36_60 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_59) / var_36_60

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_59 + var_36_60 and arg_33_1.time_ < var_36_59 + var_36_60 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 416022009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play416022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.5

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(416022009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 60
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play416022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 416022010
		arg_43_1.duration_ = 7.1

		local var_43_0 = {
			zh = 6.266,
			ja = 7.1
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
				arg_43_0:Play416022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.45

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[327].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(416022010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 18
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022010", "story_v_out_416022.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_416022", "416022010", "story_v_out_416022.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_416022", "416022010", "story_v_out_416022.awb")

						arg_43_1:RecordAudio("416022010", var_46_9)
						arg_43_1:RecordAudio("416022010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_416022", "416022010", "story_v_out_416022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_416022", "416022010", "story_v_out_416022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play416022011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 416022011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play416022012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1028"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1028 == nil then
				arg_47_1.var_.actorSpriteComps1028 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.125

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps1028 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 0.5, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1028 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1028 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 1.1

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(416022011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 44
				local var_50_13 = utf8.len(var_50_11)
				local var_50_14 = var_50_12 <= 0 and var_50_9 or var_50_9 * (var_50_13 / var_50_12)

				if var_50_14 > 0 and var_50_9 < var_50_14 then
					arg_47_1.talkMaxDuration = var_50_14

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_15 and arg_47_1.time_ < var_50_8 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play416022012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416022012
		arg_51_1.duration_ = 5.27

		local var_51_0 = {
			zh = 5.266,
			ja = 2.666
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
				arg_51_0:Play416022013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1028"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1028 == nil then
				arg_51_1.var_.actorSpriteComps1028 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.125

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1028 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1028 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1028 = nil
			end

			local var_54_8 = 0
			local var_54_9 = 0.425

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_10 = arg_51_1:FormatText(StoryNameCfg[327].name)

				arg_51_1.leftNameTxt_.text = var_54_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_11 = arg_51_1:GetWordFromCfg(416022012)
				local var_54_12 = arg_51_1:FormatText(var_54_11.content)

				arg_51_1.text_.text = var_54_12

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 17
				local var_54_14 = utf8.len(var_54_12)
				local var_54_15 = var_54_13 <= 0 and var_54_9 or var_54_9 * (var_54_14 / var_54_13)

				if var_54_15 > 0 and var_54_9 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_12
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022012", "story_v_out_416022.awb") ~= 0 then
					local var_54_16 = manager.audio:GetVoiceLength("story_v_out_416022", "416022012", "story_v_out_416022.awb") / 1000

					if var_54_16 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_8
					end

					if var_54_11.prefab_name ~= "" and arg_51_1.actors_[var_54_11.prefab_name] ~= nil then
						local var_54_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_11.prefab_name].transform, "story_v_out_416022", "416022012", "story_v_out_416022.awb")

						arg_51_1:RecordAudio("416022012", var_54_17)
						arg_51_1:RecordAudio("416022012", var_54_17)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416022", "416022012", "story_v_out_416022.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416022", "416022012", "story_v_out_416022.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_18 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_18

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_18 and arg_51_1.time_ < var_54_8 + var_54_18 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play416022013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416022013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play416022014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1028"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1028 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1028", 7)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(0, -2000, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1028, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_7 = 0
			local var_58_8 = 1.1

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_9 = arg_55_1:GetWordFromCfg(416022013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 44
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_8 or var_58_8 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_8 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_7) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_7 + var_58_14 and arg_55_1.time_ < var_58_7 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play416022014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 416022014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play416022015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1
			local var_62_1 = 0.4

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "effect"

				arg_59_1:AudioAction(var_62_2, var_62_3, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_62_4 = 0
			local var_62_5 = 1.725

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(416022014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 69
				local var_62_9 = utf8.len(var_62_7)
				local var_62_10 = var_62_8 <= 0 and var_62_5 or var_62_5 * (var_62_9 / var_62_8)

				if var_62_10 > 0 and var_62_5 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_11 and arg_59_1.time_ < var_62_4 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play416022015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416022015
		arg_63_1.duration_ = 4.9

		local var_63_0 = {
			zh = 3.7,
			ja = 4.9
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
				arg_63_0:Play416022016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.633333333333333
			local var_66_1 = 0.266666666666667

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				local var_66_2 = "play"
				local var_66_3 = "effect"

				arg_63_1:AudioAction(var_66_2, var_66_3, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_66_4 = 0
			local var_66_5 = 0.375

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_6 = arg_63_1:FormatText(StoryNameCfg[327].name)

				arg_63_1.leftNameTxt_.text = var_66_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_7 = arg_63_1:GetWordFromCfg(416022015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 15
				local var_66_10 = utf8.len(var_66_8)
				local var_66_11 = var_66_9 <= 0 and var_66_5 or var_66_5 * (var_66_10 / var_66_9)

				if var_66_11 > 0 and var_66_5 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022015", "story_v_out_416022.awb") ~= 0 then
					local var_66_12 = manager.audio:GetVoiceLength("story_v_out_416022", "416022015", "story_v_out_416022.awb") / 1000

					if var_66_12 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_4
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_416022", "416022015", "story_v_out_416022.awb")

						arg_63_1:RecordAudio("416022015", var_66_13)
						arg_63_1:RecordAudio("416022015", var_66_13)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416022", "416022015", "story_v_out_416022.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416022", "416022015", "story_v_out_416022.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_14 and arg_63_1.time_ < var_66_4 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play416022016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416022016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416022017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.46666666666667
			local var_70_1 = 0.233333333333333

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				local var_70_2 = "play"
				local var_70_3 = "effect"

				arg_67_1:AudioAction(var_70_2, var_70_3, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_70_4 = 0
			local var_70_5 = 2.075

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(416022016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 83
				local var_70_9 = utf8.len(var_70_7)
				local var_70_10 = var_70_8 <= 0 and var_70_5 or var_70_5 * (var_70_9 / var_70_8)

				if var_70_10 > 0 and var_70_5 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_11 and arg_67_1.time_ < var_70_4 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416022017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416022017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play416022018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = manager.ui.mainCamera.transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.shakeOldPos = var_74_0.localPosition
			end

			local var_74_2 = 0.666666666666667

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / 0.066
				local var_74_4, var_74_5 = math.modf(var_74_3)

				var_74_0.localPosition = Vector3.New(var_74_5 * 0.13, var_74_5 * 0.13, var_74_5 * 0.13) + arg_71_1.var_.shakeOldPos
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = arg_71_1.var_.shakeOldPos
			end

			local var_74_6 = 0
			local var_74_7 = 1

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				local var_74_8 = "play"
				local var_74_9 = "effect"

				arg_71_1:AudioAction(var_74_8, var_74_9, "se_story_138", "se_story_138_elecskill02", "")
			end

			local var_74_10 = 0
			local var_74_11 = 1.625

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_12 = arg_71_1:GetWordFromCfg(416022017)
				local var_74_13 = arg_71_1:FormatText(var_74_12.content)

				arg_71_1.text_.text = var_74_13

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_14 = 65
				local var_74_15 = utf8.len(var_74_13)
				local var_74_16 = var_74_14 <= 0 and var_74_11 or var_74_11 * (var_74_15 / var_74_14)

				if var_74_16 > 0 and var_74_11 < var_74_16 then
					arg_71_1.talkMaxDuration = var_74_16

					if var_74_16 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_13
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_17 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_17 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_17

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_17 and arg_71_1.time_ < var_74_10 + var_74_17 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play416022018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416022018
		arg_75_1.duration_ = 6.13

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play416022019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = manager.ui.mainCamera.transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_0.localPosition
			end

			local var_78_2 = 0.366666666666667

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / 0.066
				local var_78_4, var_78_5 = math.modf(var_78_3)

				var_78_0.localPosition = Vector3.New(var_78_5 * 0.13, var_78_5 * 0.13, var_78_5 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = false

				arg_75_1:SetGaussion(false)
			end

			local var_78_7 = 0.233333333333333

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7
				local var_78_9 = Color.New(1, 1, 1)

				var_78_9.a = Mathf.Lerp(1, 0, var_78_8)
				arg_75_1.mask_.color = var_78_9
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				local var_78_10 = Color.New(1, 1, 1)
				local var_78_11 = 0

				arg_75_1.mask_.enabled = false
				var_78_10.a = var_78_11
				arg_75_1.mask_.color = var_78_10
			end

			local var_78_12 = 0.233333333333333

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = false

				arg_75_1:SetGaussion(false)
			end

			local var_78_13 = 0.900000000001

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_13 then
				local var_78_14 = (arg_75_1.time_ - var_78_12) / var_78_13
				local var_78_15 = Color.New(1, 1, 1)

				var_78_15.a = Mathf.Lerp(1, 0, var_78_14)
				arg_75_1.mask_.color = var_78_15
			end

			if arg_75_1.time_ >= var_78_12 + var_78_13 and arg_75_1.time_ < var_78_12 + var_78_13 + arg_78_0 then
				local var_78_16 = Color.New(1, 1, 1)
				local var_78_17 = 0

				arg_75_1.mask_.enabled = false
				var_78_16.a = var_78_17
				arg_75_1.mask_.color = var_78_16
			end

			local var_78_18 = arg_75_1.actors_["123"]
			local var_78_19 = 0

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				local var_78_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_20 then
					var_78_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_20.radialBlurScale = 0
					var_78_20.radialBlurGradient = 1
					var_78_20.radialBlurIntensity = 1

					if var_78_18 then
						var_78_20.radialBlurTarget = var_78_18.transform
					end
				end
			end

			local var_78_21 = 1.13333333333433

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_21 then
				local var_78_22 = (arg_75_1.time_ - var_78_19) / var_78_21
				local var_78_23 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_23 then
					var_78_23.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_23.radialBlurScale = Mathf.Lerp(0, 0, var_78_22)
					var_78_23.radialBlurGradient = Mathf.Lerp(1, 1, var_78_22)
					var_78_23.radialBlurIntensity = Mathf.Lerp(1, 1, var_78_22)
				end
			end

			if arg_75_1.time_ >= var_78_19 + var_78_21 and arg_75_1.time_ < var_78_19 + var_78_21 + arg_78_0 then
				local var_78_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_24 then
					var_78_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_24.radialBlurScale = 0
					var_78_24.radialBlurGradient = 1
					var_78_24.radialBlurIntensity = 1
				end
			end

			local var_78_25 = manager.ui.mainCamera.transform
			local var_78_26 = 0

			if var_78_26 < arg_75_1.time_ and arg_75_1.time_ <= var_78_26 + arg_78_0 then
				local var_78_27 = arg_75_1.var_.effect333333

				if var_78_27 then
					Object.Destroy(var_78_27)

					arg_75_1.var_.effect333333 = nil
				end
			end

			local var_78_28 = 0
			local var_78_29 = 0.866666666666667

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 then
				local var_78_30 = "play"
				local var_78_31 = "effect"

				arg_75_1:AudioAction(var_78_30, var_78_31, "se_story_5", "se_story_5_heartbeat_stop", "")
			end

			local var_78_32 = 0
			local var_78_33 = 0.4

			if var_78_32 < arg_75_1.time_ and arg_75_1.time_ <= var_78_32 + arg_78_0 then
				local var_78_34 = "stop"
				local var_78_35 = "effect"

				arg_75_1:AudioAction(var_78_34, var_78_35, "se_story_5", "se_story_5_heartbeat", "")
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_36 = 1.13333333333433
			local var_78_37 = 1.875

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

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_39 = arg_75_1:GetWordFromCfg(416022018)
				local var_78_40 = arg_75_1:FormatText(var_78_39.content)

				arg_75_1.text_.text = var_78_40

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_41 = 75
				local var_78_42 = utf8.len(var_78_40)
				local var_78_43 = var_78_41 <= 0 and var_78_37 or var_78_37 * (var_78_42 / var_78_41)

				if var_78_43 > 0 and var_78_37 < var_78_43 then
					arg_75_1.talkMaxDuration = var_78_43
					var_78_36 = var_78_36 + 0.3

					if var_78_43 + var_78_36 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_43 + var_78_36
					end
				end

				arg_75_1.text_.text = var_78_40
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_44 = var_78_36 + 0.3
			local var_78_45 = math.max(var_78_37, arg_75_1.talkMaxDuration)

			if var_78_44 <= arg_75_1.time_ and arg_75_1.time_ < var_78_44 + var_78_45 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_44) / var_78_45

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_44 + var_78_45 and arg_75_1.time_ < var_78_44 + var_78_45 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416022019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416022019
		arg_81_1.duration_ = 6.6

		local var_81_0 = {
			zh = 3.633,
			ja = 6.6
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
				arg_81_0:Play416022020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1028"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1028 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1028", 3)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "split_2" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(0, -402.7, -156.1)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1028, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_84_7 = arg_81_1.actors_["1028"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1028 == nil then
				arg_81_1.var_.actorSpriteComps1028 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.125

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps1028 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 1, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1028 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1028 = nil
			end

			local var_84_15 = 0
			local var_84_16 = 0.375

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[327].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(416022019)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 15
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022019", "story_v_out_416022.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_416022", "416022019", "story_v_out_416022.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_416022", "416022019", "story_v_out_416022.awb")

						arg_81_1:RecordAudio("416022019", var_84_24)
						arg_81_1:RecordAudio("416022019", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416022", "416022019", "story_v_out_416022.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416022", "416022019", "story_v_out_416022.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
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
	Play416022020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416022020
		arg_85_1.duration_ = 15.67

		local var_85_0 = {
			zh = 14.067,
			ja = 15.667
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
				arg_85_0:Play416022021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_1 = 1.434

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_1 then
				local var_88_2 = (arg_85_1.time_ - var_88_0) / var_88_1
				local var_88_3 = Color.New(0, 0, 0)

				var_88_3.a = Mathf.Lerp(0, 1, var_88_2)
				arg_85_1.mask_.color = var_88_3
			end

			if arg_85_1.time_ >= var_88_0 + var_88_1 and arg_85_1.time_ < var_88_0 + var_88_1 + arg_88_0 then
				local var_88_4 = Color.New(0, 0, 0)

				var_88_4.a = 1
				arg_85_1.mask_.color = var_88_4
			end

			local var_88_5 = 1.434

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_6 = 2

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / var_88_6
				local var_88_8 = Color.New(0, 0, 0)

				var_88_8.a = Mathf.Lerp(1, 0, var_88_7)
				arg_85_1.mask_.color = var_88_8
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 then
				local var_88_9 = Color.New(0, 0, 0)
				local var_88_10 = 0

				arg_85_1.mask_.enabled = false
				var_88_9.a = var_88_10
				arg_85_1.mask_.color = var_88_9
			end

			local var_88_11 = 1.434

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				local var_88_12 = manager.ui.mainCamera.transform.localPosition
				local var_88_13 = Vector3.New(0, 0, 10) + Vector3.New(var_88_12.x, var_88_12.y, 0)
				local var_88_14 = arg_85_1.bgs_.ST0602

				var_88_14.transform.localPosition = var_88_13
				var_88_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_15 = var_88_14:GetComponent("SpriteRenderer")

				if var_88_15 and var_88_15.sprite then
					local var_88_16 = (var_88_14.transform.localPosition - var_88_12).z
					local var_88_17 = manager.ui.mainCameraCom_
					local var_88_18 = 2 * var_88_16 * Mathf.Tan(var_88_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_19 = var_88_18 * var_88_17.aspect
					local var_88_20 = var_88_15.sprite.bounds.size.x
					local var_88_21 = var_88_15.sprite.bounds.size.y
					local var_88_22 = var_88_19 / var_88_20
					local var_88_23 = var_88_18 / var_88_21
					local var_88_24 = var_88_23 < var_88_22 and var_88_22 or var_88_23

					var_88_14.transform.localScale = Vector3.New(var_88_24, var_88_24, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "ST0602" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_25 = 3.434

			if var_88_25 < arg_85_1.time_ and arg_85_1.time_ <= var_88_25 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_26 = 0.3

			if arg_85_1.time_ >= var_88_25 + var_88_26 and arg_85_1.time_ < var_88_25 + var_88_26 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_27 = arg_85_1.actors_["1028"].transform
			local var_88_28 = 1.4

			if var_88_28 < arg_85_1.time_ and arg_85_1.time_ <= var_88_28 + arg_88_0 then
				arg_85_1.var_.moveOldPos1028 = var_88_27.localPosition
				var_88_27.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1028", 7)

				local var_88_29 = var_88_27.childCount

				for iter_88_2 = 0, var_88_29 - 1 do
					local var_88_30 = var_88_27:GetChild(iter_88_2)

					if var_88_30.name == "" or not string.find(var_88_30.name, "split") then
						var_88_30.gameObject:SetActive(true)
					else
						var_88_30.gameObject:SetActive(false)
					end
				end
			end

			local var_88_31 = 0.001

			if var_88_28 <= arg_85_1.time_ and arg_85_1.time_ < var_88_28 + var_88_31 then
				local var_88_32 = (arg_85_1.time_ - var_88_28) / var_88_31
				local var_88_33 = Vector3.New(0, -2000, 0)

				var_88_27.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1028, var_88_33, var_88_32)
			end

			if arg_85_1.time_ >= var_88_28 + var_88_31 and arg_85_1.time_ < var_88_28 + var_88_31 + arg_88_0 then
				var_88_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_34 = 3.434
			local var_88_35 = 0.8

			if var_88_34 < arg_85_1.time_ and arg_85_1.time_ <= var_88_34 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_36 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_36:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_37 = arg_85_1:FormatText(StoryNameCfg[327].name)

				arg_85_1.leftNameTxt_.text = var_88_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_38 = arg_85_1:GetWordFromCfg(416022020)
				local var_88_39 = arg_85_1:FormatText(var_88_38.content)

				arg_85_1.text_.text = var_88_39

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_40 = 32
				local var_88_41 = utf8.len(var_88_39)
				local var_88_42 = var_88_40 <= 0 and var_88_35 or var_88_35 * (var_88_41 / var_88_40)

				if var_88_42 > 0 and var_88_35 < var_88_42 then
					arg_85_1.talkMaxDuration = var_88_42
					var_88_34 = var_88_34 + 0.3

					if var_88_42 + var_88_34 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_42 + var_88_34
					end
				end

				arg_85_1.text_.text = var_88_39
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022020", "story_v_out_416022.awb") ~= 0 then
					local var_88_43 = manager.audio:GetVoiceLength("story_v_out_416022", "416022020", "story_v_out_416022.awb") / 1000

					if var_88_43 + var_88_34 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_43 + var_88_34
					end

					if var_88_38.prefab_name ~= "" and arg_85_1.actors_[var_88_38.prefab_name] ~= nil then
						local var_88_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_38.prefab_name].transform, "story_v_out_416022", "416022020", "story_v_out_416022.awb")

						arg_85_1:RecordAudio("416022020", var_88_44)
						arg_85_1:RecordAudio("416022020", var_88_44)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416022", "416022020", "story_v_out_416022.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416022", "416022020", "story_v_out_416022.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_45 = var_88_34 + 0.3
			local var_88_46 = math.max(var_88_35, arg_85_1.talkMaxDuration)

			if var_88_45 <= arg_85_1.time_ and arg_85_1.time_ < var_88_45 + var_88_46 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_45) / var_88_46

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_45 + var_88_46 and arg_85_1.time_ < var_88_45 + var_88_46 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play416022021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416022021
		arg_91_1.duration_ = 4.6

		local var_91_0 = {
			zh = 2.466,
			ja = 4.6
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
				arg_91_0:Play416022022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.25

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[327].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(416022021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 10
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022021", "story_v_out_416022.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_416022", "416022021", "story_v_out_416022.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_416022", "416022021", "story_v_out_416022.awb")

						arg_91_1:RecordAudio("416022021", var_94_9)
						arg_91_1:RecordAudio("416022021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416022", "416022021", "story_v_out_416022.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416022", "416022021", "story_v_out_416022.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play416022022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416022022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play416022023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.233333333333333
			local var_98_1 = 1

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				local var_98_2 = "play"
				local var_98_3 = "effect"

				arg_95_1:AudioAction(var_98_2, var_98_3, "se_story_128", "se_story_128_metal", "")
			end

			local var_98_4 = 0
			local var_98_5 = 1.475

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(416022022)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 59
				local var_98_9 = utf8.len(var_98_7)
				local var_98_10 = var_98_8 <= 0 and var_98_5 or var_98_5 * (var_98_9 / var_98_8)

				if var_98_10 > 0 and var_98_5 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_11 and arg_95_1.time_ < var_98_4 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play416022023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416022023
		arg_99_1.duration_ = 6.5

		local var_99_0 = {
			zh = 4.2,
			ja = 6.5
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
				arg_99_0:Play416022024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1028"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1028 == nil then
				arg_99_1.var_.actorSpriteComps1028 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.125

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps1028 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 1, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1028 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1028 = nil
			end

			local var_102_8 = arg_99_1.actors_["1028"].transform
			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.var_.moveOldPos1028 = var_102_8.localPosition
				var_102_8.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1028", 3)

				local var_102_10 = var_102_8.childCount

				for iter_102_4 = 0, var_102_10 - 1 do
					local var_102_11 = var_102_8:GetChild(iter_102_4)

					if var_102_11.name == "" or not string.find(var_102_11.name, "split") then
						var_102_11.gameObject:SetActive(true)
					else
						var_102_11.gameObject:SetActive(false)
					end
				end
			end

			local var_102_12 = 0.001

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_12 then
				local var_102_13 = (arg_99_1.time_ - var_102_9) / var_102_12
				local var_102_14 = Vector3.New(0, -402.7, -156.1)

				var_102_8.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1028, var_102_14, var_102_13)
			end

			if arg_99_1.time_ >= var_102_9 + var_102_12 and arg_99_1.time_ < var_102_9 + var_102_12 + arg_102_0 then
				var_102_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_102_15 = 0
			local var_102_16 = 0.35

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[327].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(416022023)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 14
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022023", "story_v_out_416022.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_416022", "416022023", "story_v_out_416022.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_416022", "416022023", "story_v_out_416022.awb")

						arg_99_1:RecordAudio("416022023", var_102_24)
						arg_99_1:RecordAudio("416022023", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_416022", "416022023", "story_v_out_416022.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_416022", "416022023", "story_v_out_416022.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play416022024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416022024
		arg_103_1.duration_ = 5.67

		local var_103_0 = {
			zh = 5.666,
			ja = 5.1
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
				arg_103_0:Play416022025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.575

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[327].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(416022024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 23
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022024", "story_v_out_416022.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_416022", "416022024", "story_v_out_416022.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_416022", "416022024", "story_v_out_416022.awb")

						arg_103_1:RecordAudio("416022024", var_106_9)
						arg_103_1:RecordAudio("416022024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416022", "416022024", "story_v_out_416022.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416022", "416022024", "story_v_out_416022.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play416022025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416022025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416022026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1028"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1028 == nil then
				arg_107_1.var_.actorSpriteComps1028 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.125

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps1028 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1028 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1028 = nil
			end

			local var_110_8 = 0
			local var_110_9 = 1.65

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(416022025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 66
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_9 or var_110_9 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_9 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_15 and arg_107_1.time_ < var_110_8 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play416022026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416022026
		arg_111_1.duration_ = 8.2

		local var_111_0 = {
			zh = 4.466,
			ja = 8.2
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
				arg_111_0:Play416022027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1028"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1028 == nil then
				arg_111_1.var_.actorSpriteComps1028 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.125

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps1028 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 1, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1028 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1028 = nil
			end

			local var_114_8 = arg_111_1.actors_["1028"].transform
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.var_.moveOldPos1028 = var_114_8.localPosition
				var_114_8.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1028", 3)

				local var_114_10 = var_114_8.childCount

				for iter_114_4 = 0, var_114_10 - 1 do
					local var_114_11 = var_114_8:GetChild(iter_114_4)

					if var_114_11.name == "split_2" or not string.find(var_114_11.name, "split") then
						var_114_11.gameObject:SetActive(true)
					else
						var_114_11.gameObject:SetActive(false)
					end
				end
			end

			local var_114_12 = 0.001

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_12 then
				local var_114_13 = (arg_111_1.time_ - var_114_9) / var_114_12
				local var_114_14 = Vector3.New(0, -402.7, -156.1)

				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1028, var_114_14, var_114_13)
			end

			if arg_111_1.time_ >= var_114_9 + var_114_12 and arg_111_1.time_ < var_114_9 + var_114_12 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_114_15 = 0
			local var_114_16 = 0.4

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[327].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(416022026)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 16
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_16 or var_114_16 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_16 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_15
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022026", "story_v_out_416022.awb") ~= 0 then
					local var_114_23 = manager.audio:GetVoiceLength("story_v_out_416022", "416022026", "story_v_out_416022.awb") / 1000

					if var_114_23 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_15
					end

					if var_114_18.prefab_name ~= "" and arg_111_1.actors_[var_114_18.prefab_name] ~= nil then
						local var_114_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_18.prefab_name].transform, "story_v_out_416022", "416022026", "story_v_out_416022.awb")

						arg_111_1:RecordAudio("416022026", var_114_24)
						arg_111_1:RecordAudio("416022026", var_114_24)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416022", "416022026", "story_v_out_416022.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416022", "416022026", "story_v_out_416022.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_25 and arg_111_1.time_ < var_114_15 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play416022027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416022027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416022028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1028"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1028 == nil then
				arg_115_1.var_.actorSpriteComps1028 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.125

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps1028 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 0.5, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1028 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1028 = nil
			end

			local var_118_8 = 1
			local var_118_9 = 0.766666666666667

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				local var_118_10 = "play"
				local var_118_11 = "effect"

				arg_115_1:AudioAction(var_118_10, var_118_11, "se_story_138", "se_story_138_firemagic", "")
			end

			local var_118_12 = 0
			local var_118_13 = 1.95

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_14 = arg_115_1:GetWordFromCfg(416022027)
				local var_118_15 = arg_115_1:FormatText(var_118_14.content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_16 = 78
				local var_118_17 = utf8.len(var_118_15)
				local var_118_18 = var_118_16 <= 0 and var_118_13 or var_118_13 * (var_118_17 / var_118_16)

				if var_118_18 > 0 and var_118_13 < var_118_18 then
					arg_115_1.talkMaxDuration = var_118_18

					if var_118_18 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_19 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_19 and arg_115_1.time_ < var_118_12 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play416022028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416022028
		arg_119_1.duration_ = 3.83

		local var_119_0 = {
			zh = 2.266,
			ja = 3.833
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
				arg_119_0:Play416022029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1028"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1028 == nil then
				arg_119_1.var_.actorSpriteComps1028 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.125

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps1028 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1028 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1028 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 0.2

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_10 = arg_119_1:FormatText(StoryNameCfg[327].name)

				arg_119_1.leftNameTxt_.text = var_122_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_11 = arg_119_1:GetWordFromCfg(416022028)
				local var_122_12 = arg_119_1:FormatText(var_122_11.content)

				arg_119_1.text_.text = var_122_12

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 8
				local var_122_14 = utf8.len(var_122_12)
				local var_122_15 = var_122_13 <= 0 and var_122_9 or var_122_9 * (var_122_14 / var_122_13)

				if var_122_15 > 0 and var_122_9 < var_122_15 then
					arg_119_1.talkMaxDuration = var_122_15

					if var_122_15 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_12
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416022", "416022028", "story_v_out_416022.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_416022", "416022028", "story_v_out_416022.awb") / 1000

					if var_122_16 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_8
					end

					if var_122_11.prefab_name ~= "" and arg_119_1.actors_[var_122_11.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_11.prefab_name].transform, "story_v_out_416022", "416022028", "story_v_out_416022.awb")

						arg_119_1:RecordAudio("416022028", var_122_17)
						arg_119_1:RecordAudio("416022028", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416022", "416022028", "story_v_out_416022.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416022", "416022028", "story_v_out_416022.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_18 and arg_119_1.time_ < var_122_8 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416022029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416022029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1028"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1028 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1028", 7)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(0, -2000, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1028, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_7 = 0
			local var_126_8 = 1.325

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(416022029)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 53
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_8 or var_126_8 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_8 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_14 and arg_123_1.time_ < var_126_7 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H01",
		"TextureConfig/Background/ST0602"
	},
	voices = {
		"story_v_out_416022.awb"
	}
}
