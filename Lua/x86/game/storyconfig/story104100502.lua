return {
	Play410052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410052001
		arg_1_1.duration_ = 8.83

		local var_1_0 = {
			zh = 7.499999999999,
			ja = 8.832999999999
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
				arg_1_0:Play410052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L01g"

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
				local var_4_5 = arg_1_1.bgs_.L01g

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
					if iter_4_0 ~= "L01g" then
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

			local var_4_22 = "1060"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_4_26 = arg_1_1.actors_["1060"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1060 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1060", 3)

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
				local var_4_32 = Vector3.New(33.4, -430.8, 6.9)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1060, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_4_33 = arg_1_1.actors_["1060"]
			local var_4_34 = 1.999999999999

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1060 == nil then
				arg_1_1.var_.actorSpriteComps1060 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps1060 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1060 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1060 = nil
			end

			local var_4_41 = 0
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 1.56666666666667
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 1.999999999999
			local var_4_54 = 0.575

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[584].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(410052001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 23
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052001", "story_v_out_410052.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_410052", "410052001", "story_v_out_410052.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_410052", "410052001", "story_v_out_410052.awb")

						arg_1_1:RecordAudio("410052001", var_4_63)
						arg_1_1:RecordAudio("410052001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410052", "410052001", "story_v_out_410052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410052", "410052001", "story_v_out_410052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1060"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1060 == nil then
				arg_9_1.var_.actorSpriteComps1060 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.034

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1060 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1060 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1060 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 1.375

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

				local var_12_10 = arg_9_1:GetWordFromCfg(410052002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 55
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
	Play410052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410052003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.65

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

				local var_16_2 = arg_13_1:GetWordFromCfg(410052003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 66
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
	Play410052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410052004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.6

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

				local var_20_2 = arg_17_1:GetWordFromCfg(410052004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 64
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
	Play410052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410052005
		arg_21_1.duration_ = 10.8

		local var_21_0 = {
			zh = 4.466,
			ja = 10.8
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
				arg_21_0:Play410052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1060"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1060 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1060", 3)

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
				local var_24_6 = Vector3.New(33.4, -430.8, 6.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1060, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_24_7 = arg_21_1.actors_["1060"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.55

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[584].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410052005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 22
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052005", "story_v_out_410052.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052005", "story_v_out_410052.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410052", "410052005", "story_v_out_410052.awb")

						arg_21_1:RecordAudio("410052005", var_24_24)
						arg_21_1:RecordAudio("410052005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410052", "410052005", "story_v_out_410052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410052", "410052005", "story_v_out_410052.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1060"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 1.175

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(410052006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 47
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_9 or var_28_9 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_9 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_15 and arg_25_1.time_ < var_28_8 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play410052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410052007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.075

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(410052007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 43
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410052008
		arg_33_1.duration_ = 3.8

		local var_33_0 = {
			zh = 3.8,
			ja = 1.4
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
				arg_33_0:Play410052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_5" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(33.4, -430.8, 6.9)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_36_7 = arg_33_1.actors_["1060"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.175

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[584].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410052008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052008", "story_v_out_410052.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052008", "story_v_out_410052.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410052", "410052008", "story_v_out_410052.awb")

						arg_33_1:RecordAudio("410052008", var_36_24)
						arg_33_1:RecordAudio("410052008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410052", "410052008", "story_v_out_410052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410052", "410052008", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410052009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1060"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1060 == nil then
				arg_37_1.var_.actorSpriteComps1060 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1060 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1060 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1060 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 0.525

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(410052009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 21
				local var_40_13 = utf8.len(var_40_11)
				local var_40_14 = var_40_12 <= 0 and var_40_9 or var_40_9 * (var_40_13 / var_40_12)

				if var_40_14 > 0 and var_40_9 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_15 and arg_37_1.time_ < var_40_8 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410052010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play410052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.2

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(410052010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 48
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play410052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410052011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_128", "se_story_128_magic", "")
			end

			local var_48_4 = 0
			local var_48_5 = 1.6

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(410052011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 64
				local var_48_9 = utf8.len(var_48_7)
				local var_48_10 = var_48_8 <= 0 and var_48_5 or var_48_5 * (var_48_9 / var_48_8)

				if var_48_10 > 0 and var_48_5 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_11 and arg_45_1.time_ < var_48_4 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410052012
		arg_49_1.duration_ = 5.3

		local var_49_0 = {
			zh = 5.3,
			ja = 4.5
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
				arg_49_0:Play410052013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1060"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 3)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_3" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(33.4, -430.8, 6.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_52_7 = arg_49_1.actors_["1060"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 == nil then
				arg_49_1.var_.actorSpriteComps1060 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1060 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 0.45

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[584].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(410052012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052012", "story_v_out_410052.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052012", "story_v_out_410052.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_410052", "410052012", "story_v_out_410052.awb")

						arg_49_1:RecordAudio("410052012", var_52_24)
						arg_49_1:RecordAudio("410052012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410052", "410052012", "story_v_out_410052.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410052", "410052012", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410052013
		arg_53_1.duration_ = 4.37

		local var_53_0 = {
			zh = 4.366,
			ja = 3.766
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
				arg_53_0:Play410052014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1060"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.034

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.5

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_10 = arg_53_1:FormatText(StoryNameCfg[598].name)

				arg_53_1.leftNameTxt_.text = var_56_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_11 = arg_53_1:GetWordFromCfg(410052013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 20
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_9 or var_56_9 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_9 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052013", "story_v_out_410052.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052013", "story_v_out_410052.awb") / 1000

					if var_56_16 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_8
					end

					if var_56_11.prefab_name ~= "" and arg_53_1.actors_[var_56_11.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_11.prefab_name].transform, "story_v_out_410052", "410052013", "story_v_out_410052.awb")

						arg_53_1:RecordAudio("410052013", var_56_17)
						arg_53_1:RecordAudio("410052013", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410052", "410052013", "story_v_out_410052.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410052", "410052013", "story_v_out_410052.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_18 and arg_53_1.time_ < var_56_8 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410052014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410052014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410052015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.275

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(410052014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 51
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410052015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410052015
		arg_61_1.duration_ = 6.57

		local var_61_0 = {
			zh = 4.566,
			ja = 6.566
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
				arg_61_0:Play410052016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1060"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1060 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1060", 3)

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
				local var_64_6 = Vector3.New(33.4, -430.8, 6.9)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1060, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_64_7 = arg_61_1.actors_["1060"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1060 == nil then
				arg_61_1.var_.actorSpriteComps1060 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps1060 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								local var_64_11 = Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, var_64_10)
								local var_64_12 = Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, var_64_10)
								local var_64_13 = Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, var_64_10)

								iter_64_2.color = Color.New(var_64_11, var_64_12, var_64_13)
							else
								local var_64_14 = Mathf.Lerp(iter_64_2.color.r, 1, var_64_10)

								iter_64_2.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1060 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1060 = nil
			end

			local var_64_15 = 0
			local var_64_16 = 0.675

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[584].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(410052015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 27
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052015", "story_v_out_410052.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052015", "story_v_out_410052.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_410052", "410052015", "story_v_out_410052.awb")

						arg_61_1:RecordAudio("410052015", var_64_24)
						arg_61_1:RecordAudio("410052015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410052", "410052015", "story_v_out_410052.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410052", "410052015", "story_v_out_410052.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410052016
		arg_65_1.duration_ = 3.77

		local var_65_0 = {
			zh = 3.766,
			ja = 3.733
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
				arg_65_0:Play410052017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1060"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1060 == nil then
				arg_65_1.var_.actorSpriteComps1060 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.034

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1060 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1060 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1060 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.425

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[598].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_11 = arg_65_1:GetWordFromCfg(410052016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052016", "story_v_out_410052.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052016", "story_v_out_410052.awb") / 1000

					if var_68_16 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_8
					end

					if var_68_11.prefab_name ~= "" and arg_65_1.actors_[var_68_11.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_11.prefab_name].transform, "story_v_out_410052", "410052016", "story_v_out_410052.awb")

						arg_65_1:RecordAudio("410052016", var_68_17)
						arg_65_1:RecordAudio("410052016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410052", "410052016", "story_v_out_410052.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410052", "410052016", "story_v_out_410052.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_18 and arg_65_1.time_ < var_68_8 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play410052017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410052017
		arg_69_1.duration_ = 5.9

		local var_69_0 = {
			zh = 1.8,
			ja = 5.9
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
				arg_69_0:Play410052018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1060"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1060 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1060", 3)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(33.4, -430.8, 6.9)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1060, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_72_7 = arg_69_1.actors_["1060"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1060 == nil then
				arg_69_1.var_.actorSpriteComps1060 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1060 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1060 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1060 = nil
			end

			local var_72_15 = 0
			local var_72_16 = 0.175

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[584].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(410052017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 7
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052017", "story_v_out_410052.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052017", "story_v_out_410052.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_410052", "410052017", "story_v_out_410052.awb")

						arg_69_1:RecordAudio("410052017", var_72_24)
						arg_69_1:RecordAudio("410052017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410052", "410052017", "story_v_out_410052.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410052", "410052017", "story_v_out_410052.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410052018
		arg_73_1.duration_ = 9.53

		local var_73_0 = {
			zh = 7.4,
			ja = 9.533
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
				arg_73_0:Play410052019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1060"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1060 == nil then
				arg_73_1.var_.actorSpriteComps1060 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.034

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1060 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1060 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1060 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.975

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[598].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_11 = arg_73_1:GetWordFromCfg(410052018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052018", "story_v_out_410052.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052018", "story_v_out_410052.awb") / 1000

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end

					if var_76_11.prefab_name ~= "" and arg_73_1.actors_[var_76_11.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_11.prefab_name].transform, "story_v_out_410052", "410052018", "story_v_out_410052.awb")

						arg_73_1:RecordAudio("410052018", var_76_17)
						arg_73_1:RecordAudio("410052018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410052", "410052018", "story_v_out_410052.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410052", "410052018", "story_v_out_410052.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_18 and arg_73_1.time_ < var_76_8 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410052019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410052019
		arg_77_1.duration_ = 8.53

		local var_77_0 = {
			zh = 4.7,
			ja = 8.533
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
				arg_77_0:Play410052020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.6

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[598].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(410052019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052019", "story_v_out_410052.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052019", "story_v_out_410052.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_410052", "410052019", "story_v_out_410052.awb")

						arg_77_1:RecordAudio("410052019", var_80_9)
						arg_77_1:RecordAudio("410052019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410052", "410052019", "story_v_out_410052.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410052", "410052019", "story_v_out_410052.awb")
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
	Play410052020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410052020
		arg_81_1.duration_ = 5.47

		local var_81_0 = {
			zh = 1.966,
			ja = 5.466
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
				arg_81_0:Play410052021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1060"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1060 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1060", 3)

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
				local var_84_6 = Vector3.New(33.4, -430.8, 6.9)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1060, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_84_7 = arg_81_1.actors_["1060"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1060 == nil then
				arg_81_1.var_.actorSpriteComps1060 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.034

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps1060 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1060 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1060 = nil
			end

			local var_84_15 = 0
			local var_84_16 = 0.25

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[584].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(410052020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052020", "story_v_out_410052.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052020", "story_v_out_410052.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_410052", "410052020", "story_v_out_410052.awb")

						arg_81_1:RecordAudio("410052020", var_84_24)
						arg_81_1:RecordAudio("410052020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410052", "410052020", "story_v_out_410052.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410052", "410052020", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410052021
		arg_85_1.duration_ = 5.83

		local var_85_0 = {
			zh = 3.533,
			ja = 5.833
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
				arg_85_0:Play410052022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1060"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1060 == nil then
				arg_85_1.var_.actorSpriteComps1060 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.034

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1060 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1060 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1060 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.4

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[598].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_11 = arg_85_1:GetWordFromCfg(410052021)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 16
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052021", "story_v_out_410052.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052021", "story_v_out_410052.awb") / 1000

					if var_88_16 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_8
					end

					if var_88_11.prefab_name ~= "" and arg_85_1.actors_[var_88_11.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_11.prefab_name].transform, "story_v_out_410052", "410052021", "story_v_out_410052.awb")

						arg_85_1:RecordAudio("410052021", var_88_17)
						arg_85_1:RecordAudio("410052021", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410052", "410052021", "story_v_out_410052.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410052", "410052021", "story_v_out_410052.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_18 and arg_85_1.time_ < var_88_8 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play410052022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410052022
		arg_89_1.duration_ = 2.7

		local var_89_0 = {
			zh = 2.2,
			ja = 2.7
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
				arg_89_0:Play410052023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				local var_92_2 = "play"
				local var_92_3 = "effect"

				arg_89_1:AudioAction(var_92_2, var_92_3, "se_story_side_1094", "se_story_1094_gun", "")
			end

			local var_92_4 = 0
			local var_92_5 = 0.3

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_6 = arg_89_1:FormatText(StoryNameCfg[593].name)

				arg_89_1.leftNameTxt_.text = var_92_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_7 = arg_89_1:GetWordFromCfg(410052022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 12
				local var_92_10 = utf8.len(var_92_8)
				local var_92_11 = var_92_9 <= 0 and var_92_5 or var_92_5 * (var_92_10 / var_92_9)

				if var_92_11 > 0 and var_92_5 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052022", "story_v_out_410052.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_410052", "410052022", "story_v_out_410052.awb") / 1000

					if var_92_12 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_4
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_410052", "410052022", "story_v_out_410052.awb")

						arg_89_1:RecordAudio("410052022", var_92_13)
						arg_89_1:RecordAudio("410052022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410052", "410052022", "story_v_out_410052.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410052", "410052022", "story_v_out_410052.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_14 and arg_89_1.time_ < var_92_4 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play410052023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410052023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play410052024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.375

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

				local var_96_2 = arg_93_1:GetWordFromCfg(410052023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 55
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
	Play410052024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410052024
		arg_97_1.duration_ = 5.87

		local var_97_0 = {
			zh = 3.4,
			ja = 5.866
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
				arg_97_0:Play410052025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.5

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[593].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(410052024)
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052024", "story_v_out_410052.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052024", "story_v_out_410052.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_410052", "410052024", "story_v_out_410052.awb")

						arg_97_1:RecordAudio("410052024", var_100_9)
						arg_97_1:RecordAudio("410052024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410052", "410052024", "story_v_out_410052.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410052", "410052024", "story_v_out_410052.awb")
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
	Play410052025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410052025
		arg_101_1.duration_ = 6.27

		local var_101_0 = {
			zh = 3,
			ja = 6.266
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
				arg_101_0:Play410052026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1060"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1060 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1060", 3)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "split_3" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(33.4, -430.8, 6.9)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1060, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_104_7 = arg_101_1.actors_["1060"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps1060 == nil then
				arg_101_1.var_.actorSpriteComps1060 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 0.034

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps1060 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 1, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps1060 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1060 = nil
			end

			local var_104_15 = 0
			local var_104_16 = 0.45

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[584].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(410052025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052025", "story_v_out_410052.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052025", "story_v_out_410052.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_410052", "410052025", "story_v_out_410052.awb")

						arg_101_1:RecordAudio("410052025", var_104_24)
						arg_101_1:RecordAudio("410052025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410052", "410052025", "story_v_out_410052.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410052", "410052025", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410052026
		arg_105_1.duration_ = 5.1

		local var_105_0 = {
			zh = 5.1,
			ja = 4.466
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
				arg_105_0:Play410052027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1060"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1060 == nil then
				arg_105_1.var_.actorSpriteComps1060 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.034

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1060 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1060 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1060 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.45

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[593].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_11 = arg_105_1:GetWordFromCfg(410052026)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 18
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_9 or var_108_9 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_9 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052026", "story_v_out_410052.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052026", "story_v_out_410052.awb") / 1000

					if var_108_16 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_8
					end

					if var_108_11.prefab_name ~= "" and arg_105_1.actors_[var_108_11.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_11.prefab_name].transform, "story_v_out_410052", "410052026", "story_v_out_410052.awb")

						arg_105_1:RecordAudio("410052026", var_108_17)
						arg_105_1:RecordAudio("410052026", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410052", "410052026", "story_v_out_410052.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410052", "410052026", "story_v_out_410052.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_18 and arg_105_1.time_ < var_108_8 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410052027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410052027
		arg_109_1.duration_ = 10.77

		local var_109_0 = {
			zh = 7.366,
			ja = 10.766
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
				arg_109_0:Play410052028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1060"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1060 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1060", 3)

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
				local var_112_6 = Vector3.New(33.4, -430.8, 6.9)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1060, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_112_7 = arg_109_1.actors_["1060"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 0.95

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[584].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(410052027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052027", "story_v_out_410052.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052027", "story_v_out_410052.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_410052", "410052027", "story_v_out_410052.awb")

						arg_109_1:RecordAudio("410052027", var_112_24)
						arg_109_1:RecordAudio("410052027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410052", "410052027", "story_v_out_410052.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410052", "410052027", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410052028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play410052029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1060"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1060 == nil then
				arg_113_1.var_.actorSpriteComps1060 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.034

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1060 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1060 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1060 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.925

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

				local var_116_10 = arg_113_1:GetWordFromCfg(410052028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 37
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
	Play410052029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410052029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play410052030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.625

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(410052029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 25
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play410052030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410052030
		arg_121_1.duration_ = 2.1

		local var_121_0 = {
			zh = 2.1,
			ja = 1.566
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
				arg_121_0:Play410052031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.075

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[593].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(410052030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 3
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052030", "story_v_out_410052.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052030", "story_v_out_410052.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_410052", "410052030", "story_v_out_410052.awb")

						arg_121_1:RecordAudio("410052030", var_124_9)
						arg_121_1:RecordAudio("410052030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410052", "410052030", "story_v_out_410052.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410052", "410052030", "story_v_out_410052.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play410052031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410052031
		arg_125_1.duration_ = 5.5

		local var_125_0 = {
			zh = 2.233,
			ja = 5.5
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
				arg_125_0:Play410052032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1060"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1060 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1060", 3)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(33.4, -430.8, 6.9)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1060, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_128_7 = arg_125_1.actors_["1060"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1060 == nil then
				arg_125_1.var_.actorSpriteComps1060 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.034

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps1060 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1060 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1060 = nil
			end

			local var_128_15 = 0
			local var_128_16 = 0.2

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[584].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(410052031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052031", "story_v_out_410052.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052031", "story_v_out_410052.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_410052", "410052031", "story_v_out_410052.awb")

						arg_125_1:RecordAudio("410052031", var_128_24)
						arg_125_1:RecordAudio("410052031", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410052", "410052031", "story_v_out_410052.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410052", "410052031", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410052032
		arg_129_1.duration_ = 6.8

		local var_129_0 = {
			zh = 6.066,
			ja = 6.8
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
				arg_129_0:Play410052033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1060"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1060 == nil then
				arg_129_1.var_.actorSpriteComps1060 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.034

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps1060 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor2.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor2.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor2.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 0.5, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps1060 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1060 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.4

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_10 = arg_129_1:FormatText(StoryNameCfg[593].name)

				arg_129_1.leftNameTxt_.text = var_132_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_11 = arg_129_1:GetWordFromCfg(410052032)
				local var_132_12 = arg_129_1:FormatText(var_132_11.content)

				arg_129_1.text_.text = var_132_12

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052032", "story_v_out_410052.awb") ~= 0 then
					local var_132_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052032", "story_v_out_410052.awb") / 1000

					if var_132_16 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_8
					end

					if var_132_11.prefab_name ~= "" and arg_129_1.actors_[var_132_11.prefab_name] ~= nil then
						local var_132_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_11.prefab_name].transform, "story_v_out_410052", "410052032", "story_v_out_410052.awb")

						arg_129_1:RecordAudio("410052032", var_132_17)
						arg_129_1:RecordAudio("410052032", var_132_17)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410052", "410052032", "story_v_out_410052.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410052", "410052032", "story_v_out_410052.awb")
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
	Play410052033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410052033
		arg_133_1.duration_ = 7.13

		local var_133_0 = {
			zh = 3.7,
			ja = 7.133
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
				arg_133_0:Play410052034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1060"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1060 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1060", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(33.4, -430.8, 6.9)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1060, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_136_7 = arg_133_1.actors_["1060"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1060 == nil then
				arg_133_1.var_.actorSpriteComps1060 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 0.034

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps1060 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1060 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1060 = nil
			end

			local var_136_15 = 0
			local var_136_16 = 0.4

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[584].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(410052033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052033", "story_v_out_410052.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052033", "story_v_out_410052.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_410052", "410052033", "story_v_out_410052.awb")

						arg_133_1:RecordAudio("410052033", var_136_24)
						arg_133_1:RecordAudio("410052033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410052", "410052033", "story_v_out_410052.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410052", "410052033", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410052034
		arg_137_1.duration_ = 8.5

		local var_137_0 = {
			zh = 6.433,
			ja = 8.5
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
				arg_137_0:Play410052035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1060"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1060 == nil then
				arg_137_1.var_.actorSpriteComps1060 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.034

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1060 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1060 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1060 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.55

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[593].name)

				arg_137_1.leftNameTxt_.text = var_140_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_11 = arg_137_1:GetWordFromCfg(410052034)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052034", "story_v_out_410052.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052034", "story_v_out_410052.awb") / 1000

					if var_140_16 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_8
					end

					if var_140_11.prefab_name ~= "" and arg_137_1.actors_[var_140_11.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_11.prefab_name].transform, "story_v_out_410052", "410052034", "story_v_out_410052.awb")

						arg_137_1:RecordAudio("410052034", var_140_17)
						arg_137_1:RecordAudio("410052034", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410052", "410052034", "story_v_out_410052.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410052", "410052034", "story_v_out_410052.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_18 and arg_137_1.time_ < var_140_8 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play410052035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410052035
		arg_141_1.duration_ = 4.2

		local var_141_0 = {
			zh = 2.066,
			ja = 4.2
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
				arg_141_0:Play410052036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.25

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[598].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(410052035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052035", "story_v_out_410052.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052035", "story_v_out_410052.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_410052", "410052035", "story_v_out_410052.awb")

						arg_141_1:RecordAudio("410052035", var_144_9)
						arg_141_1:RecordAudio("410052035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410052", "410052035", "story_v_out_410052.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410052", "410052035", "story_v_out_410052.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410052036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410052036
		arg_145_1.duration_ = 3.87

		local var_145_0 = {
			zh = 3.3,
			ja = 3.866
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
				arg_145_0:Play410052037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1060"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1060 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1060", 3)

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
				local var_148_6 = Vector3.New(33.4, -430.8, 6.9)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1060, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_148_7 = arg_145_1.actors_["1060"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1060 == nil then
				arg_145_1.var_.actorSpriteComps1060 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.034

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps1060 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1060 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1060 = nil
			end

			local var_148_15 = 0
			local var_148_16 = 0.275

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[584].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(410052036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052036", "story_v_out_410052.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052036", "story_v_out_410052.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_410052", "410052036", "story_v_out_410052.awb")

						arg_145_1:RecordAudio("410052036", var_148_24)
						arg_145_1:RecordAudio("410052036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410052", "410052036", "story_v_out_410052.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410052", "410052036", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410052037
		arg_149_1.duration_ = 9.37

		local var_149_0 = {
			zh = 3.066,
			ja = 9.366
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
				arg_149_0:Play410052038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1060"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1060 == nil then
				arg_149_1.var_.actorSpriteComps1060 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.034

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1060 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1060 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1060 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.35

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[593].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_11 = arg_149_1:GetWordFromCfg(410052037)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 14
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052037", "story_v_out_410052.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_410052", "410052037", "story_v_out_410052.awb") / 1000

					if var_152_16 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_8
					end

					if var_152_11.prefab_name ~= "" and arg_149_1.actors_[var_152_11.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_11.prefab_name].transform, "story_v_out_410052", "410052037", "story_v_out_410052.awb")

						arg_149_1:RecordAudio("410052037", var_152_17)
						arg_149_1:RecordAudio("410052037", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410052", "410052037", "story_v_out_410052.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410052", "410052037", "story_v_out_410052.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_18 and arg_149_1.time_ < var_152_8 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410052038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410052038
		arg_153_1.duration_ = 3.2

		local var_153_0 = {
			zh = 3.2,
			ja = 3
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
				arg_153_0:Play410052039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.425

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[593].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(410052038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 17
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052038", "story_v_out_410052.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052038", "story_v_out_410052.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_410052", "410052038", "story_v_out_410052.awb")

						arg_153_1:RecordAudio("410052038", var_156_9)
						arg_153_1:RecordAudio("410052038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410052", "410052038", "story_v_out_410052.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410052", "410052038", "story_v_out_410052.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play410052039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410052039
		arg_157_1.duration_ = 9

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410052040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = "STblack"

			if arg_157_1.bgs_[var_160_0] == nil then
				local var_160_1 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_160_0)
				var_160_1.name = var_160_0
				var_160_1.transform.parent = arg_157_1.stage_.transform
				var_160_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_[var_160_0] = var_160_1
			end

			local var_160_2 = 2

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				local var_160_3 = manager.ui.mainCamera.transform.localPosition
				local var_160_4 = Vector3.New(0, 0, 10) + Vector3.New(var_160_3.x, var_160_3.y, 0)
				local var_160_5 = arg_157_1.bgs_.STblack

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
					if iter_160_0 ~= "STblack" then
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

			local var_160_27 = arg_157_1.actors_["1060"].transform
			local var_160_28 = 0

			if var_160_28 < arg_157_1.time_ and arg_157_1.time_ <= var_160_28 + arg_160_0 then
				arg_157_1.var_.moveOldPos1060 = var_160_27.localPosition
				var_160_27.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1060", 7)

				local var_160_29 = var_160_27.childCount

				for iter_160_2 = 0, var_160_29 - 1 do
					local var_160_30 = var_160_27:GetChild(iter_160_2)

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
				local var_160_33 = Vector3.New(0, -2000, -40)

				var_160_27.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1060, var_160_33, var_160_32)
			end

			if arg_157_1.time_ >= var_160_28 + var_160_31 and arg_157_1.time_ < var_160_28 + var_160_31 + arg_160_0 then
				var_160_27.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_160_34 = arg_157_1.actors_["1060"]
			local var_160_35 = 0

			if var_160_35 < arg_157_1.time_ and arg_157_1.time_ <= var_160_35 + arg_160_0 and not isNil(var_160_34) and arg_157_1.var_.actorSpriteComps1060 == nil then
				arg_157_1.var_.actorSpriteComps1060 = var_160_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_36 = 0.034

			if var_160_35 <= arg_157_1.time_ and arg_157_1.time_ < var_160_35 + var_160_36 and not isNil(var_160_34) then
				local var_160_37 = (arg_157_1.time_ - var_160_35) / var_160_36

				if arg_157_1.var_.actorSpriteComps1060 then
					for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_160_4 then
							if arg_157_1.isInRecall_ then
								local var_160_38 = Mathf.Lerp(iter_160_4.color.r, arg_157_1.hightColor2.r, var_160_37)
								local var_160_39 = Mathf.Lerp(iter_160_4.color.g, arg_157_1.hightColor2.g, var_160_37)
								local var_160_40 = Mathf.Lerp(iter_160_4.color.b, arg_157_1.hightColor2.b, var_160_37)

								iter_160_4.color = Color.New(var_160_38, var_160_39, var_160_40)
							else
								local var_160_41 = Mathf.Lerp(iter_160_4.color.r, 0.5, var_160_37)

								iter_160_4.color = Color.New(var_160_41, var_160_41, var_160_41)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_35 + var_160_36 and arg_157_1.time_ < var_160_35 + var_160_36 + arg_160_0 and not isNil(var_160_34) and arg_157_1.var_.actorSpriteComps1060 then
				for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_160_6 then
						if arg_157_1.isInRecall_ then
							iter_160_6.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1060 = nil
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_42 = 4
			local var_160_43 = 0.05

			if var_160_42 < arg_157_1.time_ and arg_157_1.time_ <= var_160_42 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_44 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_44:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_45 = arg_157_1:GetWordFromCfg(410052039)
				local var_160_46 = arg_157_1:FormatText(var_160_45.content)

				arg_157_1.text_.text = var_160_46

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_47 = 2
				local var_160_48 = utf8.len(var_160_46)
				local var_160_49 = var_160_47 <= 0 and var_160_43 or var_160_43 * (var_160_48 / var_160_47)

				if var_160_49 > 0 and var_160_43 < var_160_49 then
					arg_157_1.talkMaxDuration = var_160_49
					var_160_42 = var_160_42 + 0.3

					if var_160_49 + var_160_42 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_49 + var_160_42
					end
				end

				arg_157_1.text_.text = var_160_46
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_50 = var_160_42 + 0.3
			local var_160_51 = math.max(var_160_43, arg_157_1.talkMaxDuration)

			if var_160_50 <= arg_157_1.time_ and arg_157_1.time_ < var_160_50 + var_160_51 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_50) / var_160_51

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_50 + var_160_51 and arg_157_1.time_ < var_160_50 + var_160_51 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410052040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play410052041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.15

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(410052040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 46
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play410052041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410052041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play410052042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.55

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(410052041)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 22
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play410052042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410052042
		arg_171_1.duration_ = 5.07

		local var_171_0 = {
			zh = 2.4,
			ja = 5.066
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
				arg_171_0:Play410052043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.3

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[593].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(410052042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052042", "story_v_out_410052.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052042", "story_v_out_410052.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_410052", "410052042", "story_v_out_410052.awb")

						arg_171_1:RecordAudio("410052042", var_174_9)
						arg_171_1:RecordAudio("410052042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410052", "410052042", "story_v_out_410052.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410052", "410052042", "story_v_out_410052.awb")
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
	Play410052043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410052043
		arg_175_1.duration_ = 7.2

		local var_175_0 = {
			zh = 4.233,
			ja = 7.2
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
				arg_175_0:Play410052044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.5

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[605].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_3")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(410052043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052043", "story_v_out_410052.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052043", "story_v_out_410052.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_410052", "410052043", "story_v_out_410052.awb")

						arg_175_1:RecordAudio("410052043", var_178_9)
						arg_175_1:RecordAudio("410052043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410052", "410052043", "story_v_out_410052.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410052", "410052043", "story_v_out_410052.awb")
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
	Play410052044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410052044
		arg_179_1.duration_ = 8.97

		local var_179_0 = {
			zh = 4.8,
			ja = 8.966
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
				arg_179_0:Play410052045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.725

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[605].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_3")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(410052044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 29
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052044", "story_v_out_410052.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052044", "story_v_out_410052.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_410052", "410052044", "story_v_out_410052.awb")

						arg_179_1:RecordAudio("410052044", var_182_9)
						arg_179_1:RecordAudio("410052044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410052", "410052044", "story_v_out_410052.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410052", "410052044", "story_v_out_410052.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410052045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410052045
		arg_183_1.duration_ = 13.3

		local var_183_0 = {
			zh = 8.066,
			ja = 13.3
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
				arg_183_0:Play410052046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "1056"

			if arg_183_1.actors_[var_186_0] == nil then
				local var_186_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_186_1) then
					local var_186_2 = Object.Instantiate(var_186_1, arg_183_1.canvasGo_.transform)

					var_186_2.transform:SetSiblingIndex(1)

					var_186_2.name = var_186_0
					var_186_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_183_1.actors_[var_186_0] = var_186_2

					local var_186_3 = var_186_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_183_1.isInRecall_ then
						for iter_186_0, iter_186_1 in ipairs(var_186_3) do
							iter_186_1.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_186_4 = arg_183_1.actors_["1056"]
			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.actorSpriteComps1056 == nil then
				arg_183_1.var_.actorSpriteComps1056 = var_186_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_6 = 0.034

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 and not isNil(var_186_4) then
				local var_186_7 = (arg_183_1.time_ - var_186_5) / var_186_6

				if arg_183_1.var_.actorSpriteComps1056 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								local var_186_8 = Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor2.r, var_186_7)
								local var_186_9 = Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor2.g, var_186_7)
								local var_186_10 = Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor2.b, var_186_7)

								iter_186_3.color = Color.New(var_186_8, var_186_9, var_186_10)
							else
								local var_186_11 = Mathf.Lerp(iter_186_3.color.r, 0.5, var_186_7)

								iter_186_3.color = Color.New(var_186_11, var_186_11, var_186_11)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.actorSpriteComps1056 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_186_5 then
						if arg_183_1.isInRecall_ then
							iter_186_5.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1056 = nil
			end

			local var_186_12 = 0
			local var_186_13 = 0.925

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_14 = arg_183_1:FormatText(StoryNameCfg[593].name)

				arg_183_1.leftNameTxt_.text = var_186_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_15 = arg_183_1:GetWordFromCfg(410052045)
				local var_186_16 = arg_183_1:FormatText(var_186_15.content)

				arg_183_1.text_.text = var_186_16

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 37
				local var_186_18 = utf8.len(var_186_16)
				local var_186_19 = var_186_17 <= 0 and var_186_13 or var_186_13 * (var_186_18 / var_186_17)

				if var_186_19 > 0 and var_186_13 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19

					if var_186_19 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_16
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052045", "story_v_out_410052.awb") ~= 0 then
					local var_186_20 = manager.audio:GetVoiceLength("story_v_out_410052", "410052045", "story_v_out_410052.awb") / 1000

					if var_186_20 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_12
					end

					if var_186_15.prefab_name ~= "" and arg_183_1.actors_[var_186_15.prefab_name] ~= nil then
						local var_186_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_15.prefab_name].transform, "story_v_out_410052", "410052045", "story_v_out_410052.awb")

						arg_183_1:RecordAudio("410052045", var_186_21)
						arg_183_1:RecordAudio("410052045", var_186_21)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410052", "410052045", "story_v_out_410052.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410052", "410052045", "story_v_out_410052.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_22 and arg_183_1.time_ < var_186_12 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play410052046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410052046
		arg_187_1.duration_ = 3.9

		local var_187_0 = {
			zh = 2.766,
			ja = 3.9
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
				arg_187_0:Play410052047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.25

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[593].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(410052046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052046", "story_v_out_410052.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052046", "story_v_out_410052.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_410052", "410052046", "story_v_out_410052.awb")

						arg_187_1:RecordAudio("410052046", var_190_9)
						arg_187_1:RecordAudio("410052046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410052", "410052046", "story_v_out_410052.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410052", "410052046", "story_v_out_410052.awb")
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
	Play410052047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410052047
		arg_191_1.duration_ = 3.13

		local var_191_0 = {
			zh = 1.6,
			ja = 3.133
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
				arg_191_0:Play410052048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.15

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[605].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(410052047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052047", "story_v_out_410052.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_410052", "410052047", "story_v_out_410052.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_410052", "410052047", "story_v_out_410052.awb")

						arg_191_1:RecordAudio("410052047", var_194_9)
						arg_191_1:RecordAudio("410052047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_410052", "410052047", "story_v_out_410052.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_410052", "410052047", "story_v_out_410052.awb")
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
	Play410052048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410052048
		arg_195_1.duration_ = 9

		local var_195_0 = {
			zh = 4.666,
			ja = 9
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
				arg_195_0:Play410052049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1056"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1056 == nil then
				arg_195_1.var_.actorSpriteComps1056 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.034

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps1056 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor2.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor2.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor2.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 0.5, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1056 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1056 = nil
			end

			local var_198_8 = arg_195_1.actors_["1056"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos1056 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1056", 7)

				local var_198_10 = var_198_8.childCount

				for iter_198_4 = 0, var_198_10 - 1 do
					local var_198_11 = var_198_8:GetChild(iter_198_4)

					if var_198_11.name == "" or not string.find(var_198_11.name, "split") then
						var_198_11.gameObject:SetActive(true)
					else
						var_198_11.gameObject:SetActive(false)
					end
				end
			end

			local var_198_12 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_9) / var_198_12
				local var_198_14 = Vector3.New(0, -2000, -180)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1056, var_198_14, var_198_13)
			end

			if arg_195_1.time_ >= var_198_9 + var_198_12 and arg_195_1.time_ < var_198_9 + var_198_12 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_198_15 = 0
			local var_198_16 = 0.275

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[593].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_18 = arg_195_1:GetWordFromCfg(410052048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052048", "story_v_out_410052.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052048", "story_v_out_410052.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_410052", "410052048", "story_v_out_410052.awb")

						arg_195_1:RecordAudio("410052048", var_198_24)
						arg_195_1:RecordAudio("410052048", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_410052", "410052048", "story_v_out_410052.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_410052", "410052048", "story_v_out_410052.awb")
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
				actorName = "1056",
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
	Play410052049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410052049
		arg_199_1.duration_ = 5.5

		local var_199_0 = {
			zh = 5.5,
			ja = 5
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
				arg_199_0:Play410052050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "L01f"

			if arg_199_1.bgs_[var_202_0] == nil then
				local var_202_1 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_202_0)
				var_202_1.name = var_202_0
				var_202_1.transform.parent = arg_199_1.stage_.transform
				var_202_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_[var_202_0] = var_202_1
			end

			local var_202_2 = 1.999999999999

			if var_202_2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				local var_202_3 = manager.ui.mainCamera.transform.localPosition
				local var_202_4 = Vector3.New(0, 0, 10) + Vector3.New(var_202_3.x, var_202_3.y, 0)
				local var_202_5 = arg_199_1.bgs_.L01f

				var_202_5.transform.localPosition = var_202_4
				var_202_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_6 = var_202_5:GetComponent("SpriteRenderer")

				if var_202_6 and var_202_6.sprite then
					local var_202_7 = (var_202_5.transform.localPosition - var_202_3).z
					local var_202_8 = manager.ui.mainCameraCom_
					local var_202_9 = 2 * var_202_7 * Mathf.Tan(var_202_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_202_10 = var_202_9 * var_202_8.aspect
					local var_202_11 = var_202_6.sprite.bounds.size.x
					local var_202_12 = var_202_6.sprite.bounds.size.y
					local var_202_13 = var_202_10 / var_202_11
					local var_202_14 = var_202_9 / var_202_12
					local var_202_15 = var_202_14 < var_202_13 and var_202_13 or var_202_14

					var_202_5.transform.localScale = Vector3.New(var_202_15, var_202_15, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "L01f" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_17 = 2

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17
				local var_202_19 = Color.New(0, 0, 0)

				var_202_19.a = Mathf.Lerp(0, 1, var_202_18)
				arg_199_1.mask_.color = var_202_19
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				local var_202_20 = Color.New(0, 0, 0)

				var_202_20.a = 1
				arg_199_1.mask_.color = var_202_20
			end

			local var_202_21 = 2

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_22 = 2

			if var_202_21 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_22 then
				local var_202_23 = (arg_199_1.time_ - var_202_21) / var_202_22
				local var_202_24 = Color.New(0, 0, 0)

				var_202_24.a = Mathf.Lerp(1, 0, var_202_23)
				arg_199_1.mask_.color = var_202_24
			end

			if arg_199_1.time_ >= var_202_21 + var_202_22 and arg_199_1.time_ < var_202_21 + var_202_22 + arg_202_0 then
				local var_202_25 = Color.New(0, 0, 0)
				local var_202_26 = 0

				arg_199_1.mask_.enabled = false
				var_202_25.a = var_202_26
				arg_199_1.mask_.color = var_202_25
			end

			local var_202_27 = arg_199_1.actors_["1056"].transform
			local var_202_28 = 1.999999999999

			if var_202_28 < arg_199_1.time_ and arg_199_1.time_ <= var_202_28 + arg_202_0 then
				arg_199_1.var_.moveOldPos1056 = var_202_27.localPosition
				var_202_27.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1056", 2)

				local var_202_29 = var_202_27.childCount

				for iter_202_2 = 0, var_202_29 - 1 do
					local var_202_30 = var_202_27:GetChild(iter_202_2)

					if var_202_30.name == "split_3" or not string.find(var_202_30.name, "split") then
						var_202_30.gameObject:SetActive(true)
					else
						var_202_30.gameObject:SetActive(false)
					end
				end
			end

			local var_202_31 = 0.001

			if var_202_28 <= arg_199_1.time_ and arg_199_1.time_ < var_202_28 + var_202_31 then
				local var_202_32 = (arg_199_1.time_ - var_202_28) / var_202_31
				local var_202_33 = Vector3.New(-390, -350, -180)

				var_202_27.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1056, var_202_33, var_202_32)
			end

			if arg_199_1.time_ >= var_202_28 + var_202_31 and arg_199_1.time_ < var_202_28 + var_202_31 + arg_202_0 then
				var_202_27.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_202_34 = arg_199_1.actors_["1060"].transform
			local var_202_35 = 1.999999999999

			if var_202_35 < arg_199_1.time_ and arg_199_1.time_ <= var_202_35 + arg_202_0 then
				arg_199_1.var_.moveOldPos1060 = var_202_34.localPosition
				var_202_34.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1060", 4)

				local var_202_36 = var_202_34.childCount

				for iter_202_3 = 0, var_202_36 - 1 do
					local var_202_37 = var_202_34:GetChild(iter_202_3)

					if var_202_37.name == "" or not string.find(var_202_37.name, "split") then
						var_202_37.gameObject:SetActive(true)
					else
						var_202_37.gameObject:SetActive(false)
					end
				end
			end

			local var_202_38 = 0.001

			if var_202_35 <= arg_199_1.time_ and arg_199_1.time_ < var_202_35 + var_202_38 then
				local var_202_39 = (arg_199_1.time_ - var_202_35) / var_202_38
				local var_202_40 = Vector3.New(420.9, -430.8, 6.9)

				var_202_34.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1060, var_202_40, var_202_39)
			end

			if arg_199_1.time_ >= var_202_35 + var_202_38 and arg_199_1.time_ < var_202_35 + var_202_38 + arg_202_0 then
				var_202_34.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_202_41 = arg_199_1.actors_["1056"]
			local var_202_42 = 1.999999999999

			if var_202_42 < arg_199_1.time_ and arg_199_1.time_ <= var_202_42 + arg_202_0 and not isNil(var_202_41) and arg_199_1.var_.actorSpriteComps1056 == nil then
				arg_199_1.var_.actorSpriteComps1056 = var_202_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_43 = 0.034

			if var_202_42 <= arg_199_1.time_ and arg_199_1.time_ < var_202_42 + var_202_43 and not isNil(var_202_41) then
				local var_202_44 = (arg_199_1.time_ - var_202_42) / var_202_43

				if arg_199_1.var_.actorSpriteComps1056 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								local var_202_45 = Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor1.r, var_202_44)
								local var_202_46 = Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor1.g, var_202_44)
								local var_202_47 = Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor1.b, var_202_44)

								iter_202_5.color = Color.New(var_202_45, var_202_46, var_202_47)
							else
								local var_202_48 = Mathf.Lerp(iter_202_5.color.r, 1, var_202_44)

								iter_202_5.color = Color.New(var_202_48, var_202_48, var_202_48)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_42 + var_202_43 and arg_199_1.time_ < var_202_42 + var_202_43 + arg_202_0 and not isNil(var_202_41) and arg_199_1.var_.actorSpriteComps1056 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_202_7 then
						if arg_199_1.isInRecall_ then
							iter_202_7.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1056 = nil
			end

			local var_202_49 = arg_199_1.actors_["1060"]
			local var_202_50 = 1.999999999999

			if var_202_50 < arg_199_1.time_ and arg_199_1.time_ <= var_202_50 + arg_202_0 and not isNil(var_202_49) and arg_199_1.var_.actorSpriteComps1060 == nil then
				arg_199_1.var_.actorSpriteComps1060 = var_202_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_51 = 0.034

			if var_202_50 <= arg_199_1.time_ and arg_199_1.time_ < var_202_50 + var_202_51 and not isNil(var_202_49) then
				local var_202_52 = (arg_199_1.time_ - var_202_50) / var_202_51

				if arg_199_1.var_.actorSpriteComps1060 then
					for iter_202_8, iter_202_9 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_202_9 then
							if arg_199_1.isInRecall_ then
								local var_202_53 = Mathf.Lerp(iter_202_9.color.r, arg_199_1.hightColor2.r, var_202_52)
								local var_202_54 = Mathf.Lerp(iter_202_9.color.g, arg_199_1.hightColor2.g, var_202_52)
								local var_202_55 = Mathf.Lerp(iter_202_9.color.b, arg_199_1.hightColor2.b, var_202_52)

								iter_202_9.color = Color.New(var_202_53, var_202_54, var_202_55)
							else
								local var_202_56 = Mathf.Lerp(iter_202_9.color.r, 0.5, var_202_52)

								iter_202_9.color = Color.New(var_202_56, var_202_56, var_202_56)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_50 + var_202_51 and arg_199_1.time_ < var_202_50 + var_202_51 + arg_202_0 and not isNil(var_202_49) and arg_199_1.var_.actorSpriteComps1060 then
				for iter_202_10, iter_202_11 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_202_11 then
						if arg_199_1.isInRecall_ then
							iter_202_11.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1060 = nil
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_57 = 4
			local var_202_58 = 0.05

			if var_202_57 < arg_199_1.time_ and arg_199_1.time_ <= var_202_57 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_59 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_59:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_60 = arg_199_1:FormatText(StoryNameCfg[605].name)

				arg_199_1.leftNameTxt_.text = var_202_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_61 = arg_199_1:GetWordFromCfg(410052049)
				local var_202_62 = arg_199_1:FormatText(var_202_61.content)

				arg_199_1.text_.text = var_202_62

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_63 = 2
				local var_202_64 = utf8.len(var_202_62)
				local var_202_65 = var_202_63 <= 0 and var_202_58 or var_202_58 * (var_202_64 / var_202_63)

				if var_202_65 > 0 and var_202_58 < var_202_65 then
					arg_199_1.talkMaxDuration = var_202_65
					var_202_57 = var_202_57 + 0.3

					if var_202_65 + var_202_57 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_65 + var_202_57
					end
				end

				arg_199_1.text_.text = var_202_62
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052049", "story_v_out_410052.awb") ~= 0 then
					local var_202_66 = manager.audio:GetVoiceLength("story_v_out_410052", "410052049", "story_v_out_410052.awb") / 1000

					if var_202_66 + var_202_57 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_66 + var_202_57
					end

					if var_202_61.prefab_name ~= "" and arg_199_1.actors_[var_202_61.prefab_name] ~= nil then
						local var_202_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_61.prefab_name].transform, "story_v_out_410052", "410052049", "story_v_out_410052.awb")

						arg_199_1:RecordAudio("410052049", var_202_67)
						arg_199_1:RecordAudio("410052049", var_202_67)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410052", "410052049", "story_v_out_410052.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410052", "410052049", "story_v_out_410052.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_68 = var_202_57 + 0.3
			local var_202_69 = math.max(var_202_58, arg_199_1.talkMaxDuration)

			if var_202_68 <= arg_199_1.time_ and arg_199_1.time_ < var_202_68 + var_202_69 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_68) / var_202_69

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_68 + var_202_69 and arg_199_1.time_ < var_202_68 + var_202_69 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play410052050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410052050
		arg_205_1.duration_ = 1.6

		local var_205_0 = {
			zh = 1.5,
			ja = 1.6
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
				arg_205_0:Play410052051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1060"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1060 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1060", 4)

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
				local var_208_6 = Vector3.New(420.9, -430.8, 6.9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1060, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_208_7 = arg_205_1.actors_["1060"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1060 == nil then
				arg_205_1.var_.actorSpriteComps1060 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1060 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1060 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1060 = nil
			end

			local var_208_15 = arg_205_1.actors_["1056"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_17 = 0.034

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 and not isNil(var_208_15) then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17

				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								local var_208_19 = Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor2.r, var_208_18)
								local var_208_20 = Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor2.g, var_208_18)
								local var_208_21 = Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor2.b, var_208_18)

								iter_208_6.color = Color.New(var_208_19, var_208_20, var_208_21)
							else
								local var_208_22 = Mathf.Lerp(iter_208_6.color.r, 0.5, var_208_18)

								iter_208_6.color = Color.New(var_208_22, var_208_22, var_208_22)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_8 then
						if arg_205_1.isInRecall_ then
							iter_208_8.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_23 = 0
			local var_208_24 = 0.05

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[584].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(410052050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052050", "story_v_out_410052.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052050", "story_v_out_410052.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_410052", "410052050", "story_v_out_410052.awb")

						arg_205_1:RecordAudio("410052050", var_208_32)
						arg_205_1:RecordAudio("410052050", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410052", "410052050", "story_v_out_410052.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410052", "410052050", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410052051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410052052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1060"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1060 == nil then
				arg_209_1.var_.actorSpriteComps1060 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.034

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1060 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1060 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1060 = nil
			end

			local var_212_8 = arg_209_1.actors_["1056"]
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1056 == nil then
				arg_209_1.var_.actorSpriteComps1056 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_10 = 0.034

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 and not isNil(var_212_8) then
				local var_212_11 = (arg_209_1.time_ - var_212_9) / var_212_10

				if arg_209_1.var_.actorSpriteComps1056 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1056 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1056 = nil
			end

			local var_212_16 = 0
			local var_212_17 = 1.275

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(410052051)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 51
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_17 or var_212_17 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_17 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_23 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_23 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_23

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_23 and arg_209_1.time_ < var_212_16 + var_212_23 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play410052052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410052052
		arg_213_1.duration_ = 5.77

		local var_213_0 = {
			zh = 5.5,
			ja = 5.766
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
				arg_213_0:Play410052053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1056"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1056 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1056", 2)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_3" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(-390, -350, -180)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1056, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_216_7 = arg_213_1.actors_["1056"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps1056 == nil then
				arg_213_1.var_.actorSpriteComps1056 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 0.034

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 and not isNil(var_216_7) then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps1056 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								local var_216_11 = Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, var_216_10)
								local var_216_12 = Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, var_216_10)
								local var_216_13 = Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, var_216_10)

								iter_216_2.color = Color.New(var_216_11, var_216_12, var_216_13)
							else
								local var_216_14 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_10)

								iter_216_2.color = Color.New(var_216_14, var_216_14, var_216_14)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps1056 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1056 = nil
			end

			local var_216_15 = 0
			local var_216_16 = 0.65

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[605].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(410052052)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 26
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052052", "story_v_out_410052.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052052", "story_v_out_410052.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_410052", "410052052", "story_v_out_410052.awb")

						arg_213_1:RecordAudio("410052052", var_216_24)
						arg_213_1:RecordAudio("410052052", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410052", "410052052", "story_v_out_410052.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410052", "410052052", "story_v_out_410052.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410052053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410052053
		arg_217_1.duration_ = 11.9

		local var_217_0 = {
			zh = 4.933,
			ja = 11.9
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
				arg_217_0:Play410052054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1060"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1060 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1060", 4)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_4" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(420.9, -430.8, 6.9)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1060, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_220_7 = arg_217_1.actors_["1060"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1060 == nil then
				arg_217_1.var_.actorSpriteComps1060 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 0.034

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps1060 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								local var_220_11 = Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, var_220_10)
								local var_220_12 = Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, var_220_10)
								local var_220_13 = Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, var_220_10)

								iter_220_2.color = Color.New(var_220_11, var_220_12, var_220_13)
							else
								local var_220_14 = Mathf.Lerp(iter_220_2.color.r, 1, var_220_10)

								iter_220_2.color = Color.New(var_220_14, var_220_14, var_220_14)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1060 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1060 = nil
			end

			local var_220_15 = arg_217_1.actors_["1056"]
			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 and not isNil(var_220_15) and arg_217_1.var_.actorSpriteComps1056 == nil then
				arg_217_1.var_.actorSpriteComps1056 = var_220_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_17 = 0.034

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_17 and not isNil(var_220_15) then
				local var_220_18 = (arg_217_1.time_ - var_220_16) / var_220_17

				if arg_217_1.var_.actorSpriteComps1056 then
					for iter_220_5, iter_220_6 in pairs(arg_217_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_220_6 then
							if arg_217_1.isInRecall_ then
								local var_220_19 = Mathf.Lerp(iter_220_6.color.r, arg_217_1.hightColor2.r, var_220_18)
								local var_220_20 = Mathf.Lerp(iter_220_6.color.g, arg_217_1.hightColor2.g, var_220_18)
								local var_220_21 = Mathf.Lerp(iter_220_6.color.b, arg_217_1.hightColor2.b, var_220_18)

								iter_220_6.color = Color.New(var_220_19, var_220_20, var_220_21)
							else
								local var_220_22 = Mathf.Lerp(iter_220_6.color.r, 0.5, var_220_18)

								iter_220_6.color = Color.New(var_220_22, var_220_22, var_220_22)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 and not isNil(var_220_15) and arg_217_1.var_.actorSpriteComps1056 then
				for iter_220_7, iter_220_8 in pairs(arg_217_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_220_8 then
						if arg_217_1.isInRecall_ then
							iter_220_8.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1056 = nil
			end

			local var_220_23 = 0
			local var_220_24 = 0.55

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_25 = arg_217_1:FormatText(StoryNameCfg[584].name)

				arg_217_1.leftNameTxt_.text = var_220_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_26 = arg_217_1:GetWordFromCfg(410052053)
				local var_220_27 = arg_217_1:FormatText(var_220_26.content)

				arg_217_1.text_.text = var_220_27

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_28 = 22
				local var_220_29 = utf8.len(var_220_27)
				local var_220_30 = var_220_28 <= 0 and var_220_24 or var_220_24 * (var_220_29 / var_220_28)

				if var_220_30 > 0 and var_220_24 < var_220_30 then
					arg_217_1.talkMaxDuration = var_220_30

					if var_220_30 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_30 + var_220_23
					end
				end

				arg_217_1.text_.text = var_220_27
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052053", "story_v_out_410052.awb") ~= 0 then
					local var_220_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052053", "story_v_out_410052.awb") / 1000

					if var_220_31 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_31 + var_220_23
					end

					if var_220_26.prefab_name ~= "" and arg_217_1.actors_[var_220_26.prefab_name] ~= nil then
						local var_220_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_26.prefab_name].transform, "story_v_out_410052", "410052053", "story_v_out_410052.awb")

						arg_217_1:RecordAudio("410052053", var_220_32)
						arg_217_1:RecordAudio("410052053", var_220_32)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410052", "410052053", "story_v_out_410052.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410052", "410052053", "story_v_out_410052.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_33 = math.max(var_220_24, arg_217_1.talkMaxDuration)

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_33 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_23) / var_220_33

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_23 + var_220_33 and arg_217_1.time_ < var_220_23 + var_220_33 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410052054
		arg_221_1.duration_ = 9.1

		local var_221_0 = {
			zh = 6.2,
			ja = 9.1
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
				arg_221_0:Play410052055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1056"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 2)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_3" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(-390, -350, -180)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_224_7 = arg_221_1.actors_["1056"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_15 = arg_221_1.actors_["1060"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1060 == nil then
				arg_221_1.var_.actorSpriteComps1060 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 0.034

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps1060 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_19 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor2.r, var_224_18)
								local var_224_20 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor2.g, var_224_18)
								local var_224_21 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor2.b, var_224_18)

								iter_224_6.color = Color.New(var_224_19, var_224_20, var_224_21)
							else
								local var_224_22 = Mathf.Lerp(iter_224_6.color.r, 0.5, var_224_18)

								iter_224_6.color = Color.New(var_224_22, var_224_22, var_224_22)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1060 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1060 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.9

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[605].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(410052054)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 36
				local var_224_29 = utf8.len(var_224_27)
				local var_224_30 = var_224_28 <= 0 and var_224_24 or var_224_24 * (var_224_29 / var_224_28)

				if var_224_30 > 0 and var_224_24 < var_224_30 then
					arg_221_1.talkMaxDuration = var_224_30

					if var_224_30 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_30 + var_224_23
					end
				end

				arg_221_1.text_.text = var_224_27
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052054", "story_v_out_410052.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052054", "story_v_out_410052.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_410052", "410052054", "story_v_out_410052.awb")

						arg_221_1:RecordAudio("410052054", var_224_32)
						arg_221_1:RecordAudio("410052054", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410052", "410052054", "story_v_out_410052.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410052", "410052054", "story_v_out_410052.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_33 = math.max(var_224_24, arg_221_1.talkMaxDuration)

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_33 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_23) / var_224_33

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_23 + var_224_33 and arg_221_1.time_ < var_224_23 + var_224_33 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410052055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410052055
		arg_225_1.duration_ = 8.2

		local var_225_0 = {
			zh = 4.733,
			ja = 8.2
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
				arg_225_0:Play410052056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1060"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1060 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1060", 4)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(420.9, -430.8, 6.9)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1060, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_228_7 = arg_225_1.actors_["1060"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor1.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor1.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor1.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 1, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_15 = arg_225_1.actors_["1056"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1056 == nil then
				arg_225_1.var_.actorSpriteComps1056 = var_228_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_17 = 0.034

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.actorSpriteComps1056 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								local var_228_19 = Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, var_228_18)
								local var_228_20 = Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, var_228_18)
								local var_228_21 = Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, var_228_18)

								iter_228_6.color = Color.New(var_228_19, var_228_20, var_228_21)
							else
								local var_228_22 = Mathf.Lerp(iter_228_6.color.r, 0.5, var_228_18)

								iter_228_6.color = Color.New(var_228_22, var_228_22, var_228_22)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1056 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_228_8 then
						if arg_225_1.isInRecall_ then
							iter_228_8.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1056 = nil
			end

			local var_228_23 = 0
			local var_228_24 = 0.45

			if var_228_23 < arg_225_1.time_ and arg_225_1.time_ <= var_228_23 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_25 = arg_225_1:FormatText(StoryNameCfg[584].name)

				arg_225_1.leftNameTxt_.text = var_228_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_26 = arg_225_1:GetWordFromCfg(410052055)
				local var_228_27 = arg_225_1:FormatText(var_228_26.content)

				arg_225_1.text_.text = var_228_27

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_28 = 18
				local var_228_29 = utf8.len(var_228_27)
				local var_228_30 = var_228_28 <= 0 and var_228_24 or var_228_24 * (var_228_29 / var_228_28)

				if var_228_30 > 0 and var_228_24 < var_228_30 then
					arg_225_1.talkMaxDuration = var_228_30

					if var_228_30 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_23
					end
				end

				arg_225_1.text_.text = var_228_27
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052055", "story_v_out_410052.awb") ~= 0 then
					local var_228_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052055", "story_v_out_410052.awb") / 1000

					if var_228_31 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_31 + var_228_23
					end

					if var_228_26.prefab_name ~= "" and arg_225_1.actors_[var_228_26.prefab_name] ~= nil then
						local var_228_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_26.prefab_name].transform, "story_v_out_410052", "410052055", "story_v_out_410052.awb")

						arg_225_1:RecordAudio("410052055", var_228_32)
						arg_225_1:RecordAudio("410052055", var_228_32)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410052", "410052055", "story_v_out_410052.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410052", "410052055", "story_v_out_410052.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_33 = math.max(var_228_24, arg_225_1.talkMaxDuration)

			if var_228_23 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_33 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_23) / var_228_33

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_23 + var_228_33 and arg_225_1.time_ < var_228_23 + var_228_33 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play410052056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410052056
		arg_229_1.duration_ = 7.6

		local var_229_0 = {
			zh = 4.6,
			ja = 7.6
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
				arg_229_0:Play410052057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1056"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1056 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1056", 2)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "split_1" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(-390, -350, -180)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1056, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_232_7 = arg_229_1.actors_["1056"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1056 == nil then
				arg_229_1.var_.actorSpriteComps1056 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 0.034

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps1056 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								local var_232_11 = Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, var_232_10)
								local var_232_12 = Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, var_232_10)
								local var_232_13 = Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, var_232_10)

								iter_232_2.color = Color.New(var_232_11, var_232_12, var_232_13)
							else
								local var_232_14 = Mathf.Lerp(iter_232_2.color.r, 1, var_232_10)

								iter_232_2.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1056 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1056 = nil
			end

			local var_232_15 = arg_229_1.actors_["1060"]
			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.actorSpriteComps1060 == nil then
				arg_229_1.var_.actorSpriteComps1060 = var_232_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_17 = 0.034

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 and not isNil(var_232_15) then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17

				if arg_229_1.var_.actorSpriteComps1060 then
					for iter_232_5, iter_232_6 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_232_6 then
							if arg_229_1.isInRecall_ then
								local var_232_19 = Mathf.Lerp(iter_232_6.color.r, arg_229_1.hightColor2.r, var_232_18)
								local var_232_20 = Mathf.Lerp(iter_232_6.color.g, arg_229_1.hightColor2.g, var_232_18)
								local var_232_21 = Mathf.Lerp(iter_232_6.color.b, arg_229_1.hightColor2.b, var_232_18)

								iter_232_6.color = Color.New(var_232_19, var_232_20, var_232_21)
							else
								local var_232_22 = Mathf.Lerp(iter_232_6.color.r, 0.5, var_232_18)

								iter_232_6.color = Color.New(var_232_22, var_232_22, var_232_22)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.actorSpriteComps1060 then
				for iter_232_7, iter_232_8 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_232_8 then
						if arg_229_1.isInRecall_ then
							iter_232_8.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1060 = nil
			end

			local var_232_23 = 0
			local var_232_24 = 0.525

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_25 = arg_229_1:FormatText(StoryNameCfg[605].name)

				arg_229_1.leftNameTxt_.text = var_232_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_26 = arg_229_1:GetWordFromCfg(410052056)
				local var_232_27 = arg_229_1:FormatText(var_232_26.content)

				arg_229_1.text_.text = var_232_27

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_28 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052056", "story_v_out_410052.awb") ~= 0 then
					local var_232_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052056", "story_v_out_410052.awb") / 1000

					if var_232_31 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_31 + var_232_23
					end

					if var_232_26.prefab_name ~= "" and arg_229_1.actors_[var_232_26.prefab_name] ~= nil then
						local var_232_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_26.prefab_name].transform, "story_v_out_410052", "410052056", "story_v_out_410052.awb")

						arg_229_1:RecordAudio("410052056", var_232_32)
						arg_229_1:RecordAudio("410052056", var_232_32)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410052", "410052056", "story_v_out_410052.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410052", "410052056", "story_v_out_410052.awb")
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
				actorName = "1056",
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
	Play410052057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410052057
		arg_233_1.duration_ = 12.63

		local var_233_0 = {
			zh = 6.233,
			ja = 12.633
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410052058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1056"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1056 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1056", 2)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(-390, -350, -180)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1056, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_236_7 = arg_233_1.actors_["1056"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1056 == nil then
				arg_233_1.var_.actorSpriteComps1056 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 0.034

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 and not isNil(var_236_7) then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps1056 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								local var_236_11 = Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, var_236_10)
								local var_236_12 = Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, var_236_10)
								local var_236_13 = Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, var_236_10)

								iter_236_2.color = Color.New(var_236_11, var_236_12, var_236_13)
							else
								local var_236_14 = Mathf.Lerp(iter_236_2.color.r, 1, var_236_10)

								iter_236_2.color = Color.New(var_236_14, var_236_14, var_236_14)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1056 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_236_4 then
						if arg_233_1.isInRecall_ then
							iter_236_4.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1056 = nil
			end

			local var_236_15 = 0
			local var_236_16 = 0.925

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_17 = arg_233_1:FormatText(StoryNameCfg[605].name)

				arg_233_1.leftNameTxt_.text = var_236_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(410052057)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_20 = 37
				local var_236_21 = utf8.len(var_236_19)
				local var_236_22 = var_236_20 <= 0 and var_236_16 or var_236_16 * (var_236_21 / var_236_20)

				if var_236_22 > 0 and var_236_16 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_15
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052057", "story_v_out_410052.awb") ~= 0 then
					local var_236_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052057", "story_v_out_410052.awb") / 1000

					if var_236_23 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_15
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_out_410052", "410052057", "story_v_out_410052.awb")

						arg_233_1:RecordAudio("410052057", var_236_24)
						arg_233_1:RecordAudio("410052057", var_236_24)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410052", "410052057", "story_v_out_410052.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410052", "410052057", "story_v_out_410052.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_25 = math.max(var_236_16, arg_233_1.talkMaxDuration)

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_25 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_15) / var_236_25

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_15 + var_236_25 and arg_233_1.time_ < var_236_15 + var_236_25 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410052058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410052058
		arg_237_1.duration_ = 7.03

		local var_237_0 = {
			zh = 7.033,
			ja = 6.9
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
				arg_237_0:Play410052059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1056"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1056 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1056", 2)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_2" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(-390, -350, -180)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1056, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_240_7 = arg_237_1.actors_["1056"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1056 == nil then
				arg_237_1.var_.actorSpriteComps1056 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps1056 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 1, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1056 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1056 = nil
			end

			local var_240_15 = 0
			local var_240_16 = 0.975

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[605].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(410052058)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052058", "story_v_out_410052.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052058", "story_v_out_410052.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_out_410052", "410052058", "story_v_out_410052.awb")

						arg_237_1:RecordAudio("410052058", var_240_24)
						arg_237_1:RecordAudio("410052058", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410052", "410052058", "story_v_out_410052.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410052", "410052058", "story_v_out_410052.awb")
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
				actorName = "1056",
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
	Play410052059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410052059
		arg_241_1.duration_ = 2.57

		local var_241_0 = {
			zh = 1.466,
			ja = 2.566
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
				arg_241_0:Play410052060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1060"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1060 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1060", 4)

				local var_244_2 = var_244_0.childCount

				for iter_244_0 = 0, var_244_2 - 1 do
					local var_244_3 = var_244_0:GetChild(iter_244_0)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_4 then
				local var_244_5 = (arg_241_1.time_ - var_244_1) / var_244_4
				local var_244_6 = Vector3.New(420.9, -430.8, 6.9)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1060, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_244_7 = arg_241_1.actors_["1060"]
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1060 == nil then
				arg_241_1.var_.actorSpriteComps1060 = var_244_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 and not isNil(var_244_7) then
				local var_244_10 = (arg_241_1.time_ - var_244_8) / var_244_9

				if arg_241_1.var_.actorSpriteComps1060 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								local var_244_11 = Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, var_244_10)
								local var_244_12 = Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, var_244_10)
								local var_244_13 = Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, var_244_10)

								iter_244_2.color = Color.New(var_244_11, var_244_12, var_244_13)
							else
								local var_244_14 = Mathf.Lerp(iter_244_2.color.r, 1, var_244_10)

								iter_244_2.color = Color.New(var_244_14, var_244_14, var_244_14)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1060 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_244_4 then
						if arg_241_1.isInRecall_ then
							iter_244_4.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1060 = nil
			end

			local var_244_15 = arg_241_1.actors_["1056"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1056 == nil then
				arg_241_1.var_.actorSpriteComps1056 = var_244_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_17 = 0.034

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.actorSpriteComps1056 then
					for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_244_6 then
							if arg_241_1.isInRecall_ then
								local var_244_19 = Mathf.Lerp(iter_244_6.color.r, arg_241_1.hightColor2.r, var_244_18)
								local var_244_20 = Mathf.Lerp(iter_244_6.color.g, arg_241_1.hightColor2.g, var_244_18)
								local var_244_21 = Mathf.Lerp(iter_244_6.color.b, arg_241_1.hightColor2.b, var_244_18)

								iter_244_6.color = Color.New(var_244_19, var_244_20, var_244_21)
							else
								local var_244_22 = Mathf.Lerp(iter_244_6.color.r, 0.5, var_244_18)

								iter_244_6.color = Color.New(var_244_22, var_244_22, var_244_22)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1056 then
				for iter_244_7, iter_244_8 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_244_8 then
						if arg_241_1.isInRecall_ then
							iter_244_8.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1056 = nil
			end

			local var_244_23 = 0
			local var_244_24 = 0.175

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_25 = arg_241_1:FormatText(StoryNameCfg[584].name)

				arg_241_1.leftNameTxt_.text = var_244_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_26 = arg_241_1:GetWordFromCfg(410052059)
				local var_244_27 = arg_241_1:FormatText(var_244_26.content)

				arg_241_1.text_.text = var_244_27

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 7
				local var_244_29 = utf8.len(var_244_27)
				local var_244_30 = var_244_28 <= 0 and var_244_24 or var_244_24 * (var_244_29 / var_244_28)

				if var_244_30 > 0 and var_244_24 < var_244_30 then
					arg_241_1.talkMaxDuration = var_244_30

					if var_244_30 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_23
					end
				end

				arg_241_1.text_.text = var_244_27
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052059", "story_v_out_410052.awb") ~= 0 then
					local var_244_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052059", "story_v_out_410052.awb") / 1000

					if var_244_31 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_23
					end

					if var_244_26.prefab_name ~= "" and arg_241_1.actors_[var_244_26.prefab_name] ~= nil then
						local var_244_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_26.prefab_name].transform, "story_v_out_410052", "410052059", "story_v_out_410052.awb")

						arg_241_1:RecordAudio("410052059", var_244_32)
						arg_241_1:RecordAudio("410052059", var_244_32)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410052", "410052059", "story_v_out_410052.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410052", "410052059", "story_v_out_410052.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_24, arg_241_1.talkMaxDuration)

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_23) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_23 + var_244_33 and arg_241_1.time_ < var_244_23 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play410052060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410052060
		arg_245_1.duration_ = 3.8

		local var_245_0 = {
			zh = 2.066,
			ja = 3.8
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
				arg_245_0:Play410052061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1056"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1056 = var_248_0.localPosition
				var_248_0.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1056", 2)

				local var_248_2 = var_248_0.childCount

				for iter_248_0 = 0, var_248_2 - 1 do
					local var_248_3 = var_248_0:GetChild(iter_248_0)

					if var_248_3.name == "split_4" or not string.find(var_248_3.name, "split") then
						var_248_3.gameObject:SetActive(true)
					else
						var_248_3.gameObject:SetActive(false)
					end
				end
			end

			local var_248_4 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_4 then
				local var_248_5 = (arg_245_1.time_ - var_248_1) / var_248_4
				local var_248_6 = Vector3.New(-390, -350, -180)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1056, var_248_6, var_248_5)
			end

			if arg_245_1.time_ >= var_248_1 + var_248_4 and arg_245_1.time_ < var_248_1 + var_248_4 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_248_7 = arg_245_1.actors_["1056"]
			local var_248_8 = 0

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps1056 == nil then
				arg_245_1.var_.actorSpriteComps1056 = var_248_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_9 = 0.034

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_9 and not isNil(var_248_7) then
				local var_248_10 = (arg_245_1.time_ - var_248_8) / var_248_9

				if arg_245_1.var_.actorSpriteComps1056 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_248_2 then
							if arg_245_1.isInRecall_ then
								local var_248_11 = Mathf.Lerp(iter_248_2.color.r, arg_245_1.hightColor1.r, var_248_10)
								local var_248_12 = Mathf.Lerp(iter_248_2.color.g, arg_245_1.hightColor1.g, var_248_10)
								local var_248_13 = Mathf.Lerp(iter_248_2.color.b, arg_245_1.hightColor1.b, var_248_10)

								iter_248_2.color = Color.New(var_248_11, var_248_12, var_248_13)
							else
								local var_248_14 = Mathf.Lerp(iter_248_2.color.r, 1, var_248_10)

								iter_248_2.color = Color.New(var_248_14, var_248_14, var_248_14)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_8 + var_248_9 and arg_245_1.time_ < var_248_8 + var_248_9 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps1056 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_248_4 then
						if arg_245_1.isInRecall_ then
							iter_248_4.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1056 = nil
			end

			local var_248_15 = arg_245_1.actors_["1060"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps1060 == nil then
				arg_245_1.var_.actorSpriteComps1060 = var_248_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_17 = 0.034

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.actorSpriteComps1060 then
					for iter_248_5, iter_248_6 in pairs(arg_245_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_248_6 then
							if arg_245_1.isInRecall_ then
								local var_248_19 = Mathf.Lerp(iter_248_6.color.r, arg_245_1.hightColor2.r, var_248_18)
								local var_248_20 = Mathf.Lerp(iter_248_6.color.g, arg_245_1.hightColor2.g, var_248_18)
								local var_248_21 = Mathf.Lerp(iter_248_6.color.b, arg_245_1.hightColor2.b, var_248_18)

								iter_248_6.color = Color.New(var_248_19, var_248_20, var_248_21)
							else
								local var_248_22 = Mathf.Lerp(iter_248_6.color.r, 0.5, var_248_18)

								iter_248_6.color = Color.New(var_248_22, var_248_22, var_248_22)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps1060 then
				for iter_248_7, iter_248_8 in pairs(arg_245_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_248_8 then
						if arg_245_1.isInRecall_ then
							iter_248_8.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1060 = nil
			end

			local var_248_23 = 0
			local var_248_24 = 0.25

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_25 = arg_245_1:FormatText(StoryNameCfg[605].name)

				arg_245_1.leftNameTxt_.text = var_248_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_26 = arg_245_1:GetWordFromCfg(410052060)
				local var_248_27 = arg_245_1:FormatText(var_248_26.content)

				arg_245_1.text_.text = var_248_27

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_28 = 10
				local var_248_29 = utf8.len(var_248_27)
				local var_248_30 = var_248_28 <= 0 and var_248_24 or var_248_24 * (var_248_29 / var_248_28)

				if var_248_30 > 0 and var_248_24 < var_248_30 then
					arg_245_1.talkMaxDuration = var_248_30

					if var_248_30 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_23
					end
				end

				arg_245_1.text_.text = var_248_27
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052060", "story_v_out_410052.awb") ~= 0 then
					local var_248_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052060", "story_v_out_410052.awb") / 1000

					if var_248_31 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_23
					end

					if var_248_26.prefab_name ~= "" and arg_245_1.actors_[var_248_26.prefab_name] ~= nil then
						local var_248_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_26.prefab_name].transform, "story_v_out_410052", "410052060", "story_v_out_410052.awb")

						arg_245_1:RecordAudio("410052060", var_248_32)
						arg_245_1:RecordAudio("410052060", var_248_32)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410052", "410052060", "story_v_out_410052.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410052", "410052060", "story_v_out_410052.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_33 = math.max(var_248_24, arg_245_1.talkMaxDuration)

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_33 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_23) / var_248_33

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_23 + var_248_33 and arg_245_1.time_ < var_248_23 + var_248_33 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410052061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410052061
		arg_249_1.duration_ = 7.53

		local var_249_0 = {
			zh = 6.933,
			ja = 7.533
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play410052062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1060"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1060 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1060", 4)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(420.9, -430.8, 6.9)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1060, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_252_7 = arg_249_1.actors_["1060"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1060 == nil then
				arg_249_1.var_.actorSpriteComps1060 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps1060 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								local var_252_11 = Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, var_252_10)
								local var_252_12 = Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, var_252_10)
								local var_252_13 = Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, var_252_10)

								iter_252_2.color = Color.New(var_252_11, var_252_12, var_252_13)
							else
								local var_252_14 = Mathf.Lerp(iter_252_2.color.r, 1, var_252_10)

								iter_252_2.color = Color.New(var_252_14, var_252_14, var_252_14)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1060 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1060 = nil
			end

			local var_252_15 = arg_249_1.actors_["1056"]
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_17 = 0.034

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_17 and not isNil(var_252_15) then
				local var_252_18 = (arg_249_1.time_ - var_252_16) / var_252_17

				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_5, iter_252_6 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_6 then
							if arg_249_1.isInRecall_ then
								local var_252_19 = Mathf.Lerp(iter_252_6.color.r, arg_249_1.hightColor2.r, var_252_18)
								local var_252_20 = Mathf.Lerp(iter_252_6.color.g, arg_249_1.hightColor2.g, var_252_18)
								local var_252_21 = Mathf.Lerp(iter_252_6.color.b, arg_249_1.hightColor2.b, var_252_18)

								iter_252_6.color = Color.New(var_252_19, var_252_20, var_252_21)
							else
								local var_252_22 = Mathf.Lerp(iter_252_6.color.r, 0.5, var_252_18)

								iter_252_6.color = Color.New(var_252_22, var_252_22, var_252_22)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_7, iter_252_8 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_8 then
						if arg_249_1.isInRecall_ then
							iter_252_8.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_23 = 0
			local var_252_24 = 0.85

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_25 = arg_249_1:FormatText(StoryNameCfg[584].name)

				arg_249_1.leftNameTxt_.text = var_252_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_26 = arg_249_1:GetWordFromCfg(410052061)
				local var_252_27 = arg_249_1:FormatText(var_252_26.content)

				arg_249_1.text_.text = var_252_27

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_28 = 34
				local var_252_29 = utf8.len(var_252_27)
				local var_252_30 = var_252_28 <= 0 and var_252_24 or var_252_24 * (var_252_29 / var_252_28)

				if var_252_30 > 0 and var_252_24 < var_252_30 then
					arg_249_1.talkMaxDuration = var_252_30

					if var_252_30 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_30 + var_252_23
					end
				end

				arg_249_1.text_.text = var_252_27
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052061", "story_v_out_410052.awb") ~= 0 then
					local var_252_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052061", "story_v_out_410052.awb") / 1000

					if var_252_31 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_31 + var_252_23
					end

					if var_252_26.prefab_name ~= "" and arg_249_1.actors_[var_252_26.prefab_name] ~= nil then
						local var_252_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_26.prefab_name].transform, "story_v_out_410052", "410052061", "story_v_out_410052.awb")

						arg_249_1:RecordAudio("410052061", var_252_32)
						arg_249_1:RecordAudio("410052061", var_252_32)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410052", "410052061", "story_v_out_410052.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410052", "410052061", "story_v_out_410052.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_33 = math.max(var_252_24, arg_249_1.talkMaxDuration)

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_33 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_23) / var_252_33

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_23 + var_252_33 and arg_249_1.time_ < var_252_23 + var_252_33 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410052062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410052063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1060"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1060 == nil then
				arg_253_1.var_.actorSpriteComps1060 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.034

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps1060 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 0.5, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1060 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1060 = nil
			end

			local var_256_8 = arg_253_1.actors_["1056"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.034

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_16 = 0
			local var_256_17 = 1.325

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_18 = arg_253_1:GetWordFromCfg(410052062)
				local var_256_19 = arg_253_1:FormatText(var_256_18.content)

				arg_253_1.text_.text = var_256_19

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_20 = 53
				local var_256_21 = utf8.len(var_256_19)
				local var_256_22 = var_256_20 <= 0 and var_256_17 or var_256_17 * (var_256_21 / var_256_20)

				if var_256_22 > 0 and var_256_17 < var_256_22 then
					arg_253_1.talkMaxDuration = var_256_22

					if var_256_22 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_22 + var_256_16
					end
				end

				arg_253_1.text_.text = var_256_19
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_23 = math.max(var_256_17, arg_253_1.talkMaxDuration)

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_23 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_16) / var_256_23

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_16 + var_256_23 and arg_253_1.time_ < var_256_16 + var_256_23 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410052063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410052063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410052064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.95

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(410052063)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 38
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play410052064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410052064
		arg_261_1.duration_ = 3.97

		local var_261_0 = {
			zh = 3.966,
			ja = 3.533
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
				arg_261_0:Play410052065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1056"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1056 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1056", 2)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_4" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(-390, -350, -180)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1056, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_264_7 = arg_261_1.actors_["1056"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1056 == nil then
				arg_261_1.var_.actorSpriteComps1056 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps1056 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 1, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1056 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1056 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 0.325

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[605].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(410052064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 13
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052064", "story_v_out_410052.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052064", "story_v_out_410052.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_410052", "410052064", "story_v_out_410052.awb")

						arg_261_1:RecordAudio("410052064", var_264_24)
						arg_261_1:RecordAudio("410052064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410052", "410052064", "story_v_out_410052.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410052", "410052064", "story_v_out_410052.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play410052065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410052065
		arg_265_1.duration_ = 12.17

		local var_265_0 = {
			zh = 9.1,
			ja = 12.166
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play410052066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1060"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1060 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1060", 4)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(420.9, -430.8, 6.9)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1060, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_268_7 = arg_265_1.actors_["1060"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1060 == nil then
				arg_265_1.var_.actorSpriteComps1060 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 0.034

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps1060 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 1, var_268_10)

								iter_268_2.color = Color.New(var_268_14, var_268_14, var_268_14)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1060 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1060 = nil
			end

			local var_268_15 = arg_265_1.actors_["1056"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps1056 == nil then
				arg_265_1.var_.actorSpriteComps1056 = var_268_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_17 = 0.034

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.actorSpriteComps1056 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								local var_268_19 = Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor2.r, var_268_18)
								local var_268_20 = Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor2.g, var_268_18)
								local var_268_21 = Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor2.b, var_268_18)

								iter_268_6.color = Color.New(var_268_19, var_268_20, var_268_21)
							else
								local var_268_22 = Mathf.Lerp(iter_268_6.color.r, 0.5, var_268_18)

								iter_268_6.color = Color.New(var_268_22, var_268_22, var_268_22)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps1056 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1056 = nil
			end

			local var_268_23 = 0
			local var_268_24 = 1.05

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[584].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(410052065)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 42
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052065", "story_v_out_410052.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052065", "story_v_out_410052.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_410052", "410052065", "story_v_out_410052.awb")

						arg_265_1:RecordAudio("410052065", var_268_32)
						arg_265_1:RecordAudio("410052065", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410052", "410052065", "story_v_out_410052.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410052", "410052065", "story_v_out_410052.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410052066
		arg_269_1.duration_ = 3.1

		local var_269_0 = {
			zh = 1.6,
			ja = 3.1
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
				arg_269_0:Play410052067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1056"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1056 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1056", 2)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_4" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(-390, -350, -180)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1056, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_272_7 = arg_269_1.actors_["1056"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1056 == nil then
				arg_269_1.var_.actorSpriteComps1056 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.034

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps1056 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								local var_272_11 = Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, var_272_10)
								local var_272_12 = Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, var_272_10)
								local var_272_13 = Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, var_272_10)

								iter_272_2.color = Color.New(var_272_11, var_272_12, var_272_13)
							else
								local var_272_14 = Mathf.Lerp(iter_272_2.color.r, 1, var_272_10)

								iter_272_2.color = Color.New(var_272_14, var_272_14, var_272_14)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1056 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1056 = nil
			end

			local var_272_15 = arg_269_1.actors_["1060"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1060 == nil then
				arg_269_1.var_.actorSpriteComps1060 = var_272_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_17 = 0.034

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.actorSpriteComps1060 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								local var_272_19 = Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, var_272_18)
								local var_272_20 = Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, var_272_18)
								local var_272_21 = Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, var_272_18)

								iter_272_6.color = Color.New(var_272_19, var_272_20, var_272_21)
							else
								local var_272_22 = Mathf.Lerp(iter_272_6.color.r, 0.5, var_272_18)

								iter_272_6.color = Color.New(var_272_22, var_272_22, var_272_22)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1060 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_272_8 then
						if arg_269_1.isInRecall_ then
							iter_272_8.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1060 = nil
			end

			local var_272_23 = 0
			local var_272_24 = 0.15

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[605].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(410052066)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 6
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052066", "story_v_out_410052.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052066", "story_v_out_410052.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_out_410052", "410052066", "story_v_out_410052.awb")

						arg_269_1:RecordAudio("410052066", var_272_32)
						arg_269_1:RecordAudio("410052066", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410052", "410052066", "story_v_out_410052.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410052", "410052066", "story_v_out_410052.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play410052067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410052067
		arg_273_1.duration_ = 11.3

		local var_273_0 = {
			zh = 7.466,
			ja = 11.3
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play410052068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1060"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 4)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(420.9, -430.8, 6.9)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_276_7 = arg_273_1.actors_["1060"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 == nil then
				arg_273_1.var_.actorSpriteComps1060 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1060 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1060 = nil
			end

			local var_276_15 = arg_273_1.actors_["1056"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps1056 == nil then
				arg_273_1.var_.actorSpriteComps1056 = var_276_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_17 = 0.034

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.actorSpriteComps1056 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								local var_276_19 = Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, var_276_18)
								local var_276_20 = Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, var_276_18)
								local var_276_21 = Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, var_276_18)

								iter_276_6.color = Color.New(var_276_19, var_276_20, var_276_21)
							else
								local var_276_22 = Mathf.Lerp(iter_276_6.color.r, 0.5, var_276_18)

								iter_276_6.color = Color.New(var_276_22, var_276_22, var_276_22)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps1056 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_276_8 then
						if arg_273_1.isInRecall_ then
							iter_276_8.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1056 = nil
			end

			local var_276_23 = 0
			local var_276_24 = 0.875

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_25 = arg_273_1:FormatText(StoryNameCfg[584].name)

				arg_273_1.leftNameTxt_.text = var_276_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_26 = arg_273_1:GetWordFromCfg(410052067)
				local var_276_27 = arg_273_1:FormatText(var_276_26.content)

				arg_273_1.text_.text = var_276_27

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_28 = 35
				local var_276_29 = utf8.len(var_276_27)
				local var_276_30 = var_276_28 <= 0 and var_276_24 or var_276_24 * (var_276_29 / var_276_28)

				if var_276_30 > 0 and var_276_24 < var_276_30 then
					arg_273_1.talkMaxDuration = var_276_30

					if var_276_30 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_30 + var_276_23
					end
				end

				arg_273_1.text_.text = var_276_27
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052067", "story_v_out_410052.awb") ~= 0 then
					local var_276_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052067", "story_v_out_410052.awb") / 1000

					if var_276_31 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_31 + var_276_23
					end

					if var_276_26.prefab_name ~= "" and arg_273_1.actors_[var_276_26.prefab_name] ~= nil then
						local var_276_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_26.prefab_name].transform, "story_v_out_410052", "410052067", "story_v_out_410052.awb")

						arg_273_1:RecordAudio("410052067", var_276_32)
						arg_273_1:RecordAudio("410052067", var_276_32)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410052", "410052067", "story_v_out_410052.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410052", "410052067", "story_v_out_410052.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_33 = math.max(var_276_24, arg_273_1.talkMaxDuration)

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_33 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_23) / var_276_33

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_23 + var_276_33 and arg_273_1.time_ < var_276_23 + var_276_33 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410052068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410052068
		arg_277_1.duration_ = 9.2

		local var_277_0 = {
			zh = 9.2,
			ja = 7.7
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
				arg_277_0:Play410052069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1060"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1060 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1060", 4)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "split_4" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(420.9, -430.8, 6.9)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1060, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_280_7 = arg_277_1.actors_["1060"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1060 == nil then
				arg_277_1.var_.actorSpriteComps1060 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps1060 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 1, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1060 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1060 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 1.175

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[584].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(410052068)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 47
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052068", "story_v_out_410052.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052068", "story_v_out_410052.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_410052", "410052068", "story_v_out_410052.awb")

						arg_277_1:RecordAudio("410052068", var_280_24)
						arg_277_1:RecordAudio("410052068", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410052", "410052068", "story_v_out_410052.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410052", "410052068", "story_v_out_410052.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410052069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410052069
		arg_281_1.duration_ = 10.93

		local var_281_0 = {
			zh = 7.166,
			ja = 10.933
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
				arg_281_0:Play410052070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1060"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1060 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1060", 4)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "split_4" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(420.9, -430.8, 6.9)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1060, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_284_7 = arg_281_1.actors_["1060"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1060 == nil then
				arg_281_1.var_.actorSpriteComps1060 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.034

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps1060 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								local var_284_11 = Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, var_284_10)
								local var_284_12 = Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, var_284_10)
								local var_284_13 = Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, var_284_10)

								iter_284_2.color = Color.New(var_284_11, var_284_12, var_284_13)
							else
								local var_284_14 = Mathf.Lerp(iter_284_2.color.r, 1, var_284_10)

								iter_284_2.color = Color.New(var_284_14, var_284_14, var_284_14)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1060 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_284_4 then
						if arg_281_1.isInRecall_ then
							iter_284_4.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1060 = nil
			end

			local var_284_15 = 0
			local var_284_16 = 0.975

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[584].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(410052069)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052069", "story_v_out_410052.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052069", "story_v_out_410052.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_410052", "410052069", "story_v_out_410052.awb")

						arg_281_1:RecordAudio("410052069", var_284_24)
						arg_281_1:RecordAudio("410052069", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410052", "410052069", "story_v_out_410052.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410052", "410052069", "story_v_out_410052.awb")
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
				actorName = "1060",
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
	Play410052070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410052070
		arg_285_1.duration_ = 14.5

		local var_285_0 = {
			zh = 9.566,
			ja = 14.5
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410052071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1060"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 4)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "split_4" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(420.9, -430.8, 6.9)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_288_7 = arg_285_1.actors_["1060"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_15 = 0
			local var_288_16 = 1.4

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[584].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(410052070)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 56
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052070", "story_v_out_410052.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052070", "story_v_out_410052.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_410052", "410052070", "story_v_out_410052.awb")

						arg_285_1:RecordAudio("410052070", var_288_24)
						arg_285_1:RecordAudio("410052070", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410052", "410052070", "story_v_out_410052.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410052", "410052070", "story_v_out_410052.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410052071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410052071
		arg_289_1.duration_ = 11.3

		local var_289_0 = {
			zh = 11.3,
			ja = 7.8
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410052072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1060"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1060 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1060", 4)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(420.9, -430.8, 6.9)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1060, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_292_7 = arg_289_1.actors_["1060"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1060 == nil then
				arg_289_1.var_.actorSpriteComps1060 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps1060 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								local var_292_11 = Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, var_292_10)
								local var_292_12 = Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, var_292_10)
								local var_292_13 = Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, var_292_10)

								iter_292_2.color = Color.New(var_292_11, var_292_12, var_292_13)
							else
								local var_292_14 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

								iter_292_2.color = Color.New(var_292_14, var_292_14, var_292_14)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1060 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1060 = nil
			end

			local var_292_15 = 0
			local var_292_16 = 1.175

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[584].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(410052071)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 47
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052071", "story_v_out_410052.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052071", "story_v_out_410052.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_410052", "410052071", "story_v_out_410052.awb")

						arg_289_1:RecordAudio("410052071", var_292_24)
						arg_289_1:RecordAudio("410052071", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410052", "410052071", "story_v_out_410052.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410052", "410052071", "story_v_out_410052.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play410052072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410052072
		arg_293_1.duration_ = 11.67

		local var_293_0 = {
			zh = 4.966,
			ja = 11.666
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play410052073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1060"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1060 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1060", 4)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(420.9, -430.8, 6.9)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1060, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_296_7 = arg_293_1.actors_["1060"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1060 == nil then
				arg_293_1.var_.actorSpriteComps1060 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps1060 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								local var_296_11 = Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, var_296_10)
								local var_296_12 = Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, var_296_10)
								local var_296_13 = Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, var_296_10)

								iter_296_2.color = Color.New(var_296_11, var_296_12, var_296_13)
							else
								local var_296_14 = Mathf.Lerp(iter_296_2.color.r, 1, var_296_10)

								iter_296_2.color = Color.New(var_296_14, var_296_14, var_296_14)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1060 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1060 = nil
			end

			local var_296_15 = 0
			local var_296_16 = 0.4

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[584].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(410052072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 16
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052072", "story_v_out_410052.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052072", "story_v_out_410052.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_410052", "410052072", "story_v_out_410052.awb")

						arg_293_1:RecordAudio("410052072", var_296_24)
						arg_293_1:RecordAudio("410052072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410052", "410052072", "story_v_out_410052.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410052", "410052072", "story_v_out_410052.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play410052073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410052073
		arg_297_1.duration_ = 13.83

		local var_297_0 = {
			zh = 8.666,
			ja = 13.833
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410052074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1056"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1056 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1056", 2)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "split_4" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(-390, -350, -180)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1056, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_300_7 = arg_297_1.actors_["1056"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1056 == nil then
				arg_297_1.var_.actorSpriteComps1056 = var_300_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_9 = 0.034

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.actorSpriteComps1056 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								local var_300_11 = Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, var_300_10)
								local var_300_12 = Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, var_300_10)
								local var_300_13 = Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, var_300_10)

								iter_300_2.color = Color.New(var_300_11, var_300_12, var_300_13)
							else
								local var_300_14 = Mathf.Lerp(iter_300_2.color.r, 1, var_300_10)

								iter_300_2.color = Color.New(var_300_14, var_300_14, var_300_14)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1056 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_300_4 then
						if arg_297_1.isInRecall_ then
							iter_300_4.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1056 = nil
			end

			local var_300_15 = arg_297_1.actors_["1060"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps1060 == nil then
				arg_297_1.var_.actorSpriteComps1060 = var_300_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_17 = 0.034

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.actorSpriteComps1060 then
					for iter_300_5, iter_300_6 in pairs(arg_297_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_300_6 then
							if arg_297_1.isInRecall_ then
								local var_300_19 = Mathf.Lerp(iter_300_6.color.r, arg_297_1.hightColor2.r, var_300_18)
								local var_300_20 = Mathf.Lerp(iter_300_6.color.g, arg_297_1.hightColor2.g, var_300_18)
								local var_300_21 = Mathf.Lerp(iter_300_6.color.b, arg_297_1.hightColor2.b, var_300_18)

								iter_300_6.color = Color.New(var_300_19, var_300_20, var_300_21)
							else
								local var_300_22 = Mathf.Lerp(iter_300_6.color.r, 0.5, var_300_18)

								iter_300_6.color = Color.New(var_300_22, var_300_22, var_300_22)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps1060 then
				for iter_300_7, iter_300_8 in pairs(arg_297_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_300_8 then
						if arg_297_1.isInRecall_ then
							iter_300_8.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1060 = nil
			end

			local var_300_23 = 0
			local var_300_24 = 0.875

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[605].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_26 = arg_297_1:GetWordFromCfg(410052073)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 35
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_24 or var_300_24 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_24 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30

					if var_300_30 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052073", "story_v_out_410052.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052073", "story_v_out_410052.awb") / 1000

					if var_300_31 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_23
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_410052", "410052073", "story_v_out_410052.awb")

						arg_297_1:RecordAudio("410052073", var_300_32)
						arg_297_1:RecordAudio("410052073", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410052", "410052073", "story_v_out_410052.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410052", "410052073", "story_v_out_410052.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_33 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_33

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_33 and arg_297_1.time_ < var_300_23 + var_300_33 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play410052074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410052074
		arg_301_1.duration_ = 10.67

		local var_301_0 = {
			zh = 10.666,
			ja = 9.9
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410052075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1060"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1060 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1060", 4)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(420.9, -430.8, 6.9)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1060, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_304_7 = arg_301_1.actors_["1060"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1060 == nil then
				arg_301_1.var_.actorSpriteComps1060 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 0.034

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps1060 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								local var_304_11 = Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, var_304_10)
								local var_304_12 = Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, var_304_10)
								local var_304_13 = Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, var_304_10)

								iter_304_2.color = Color.New(var_304_11, var_304_12, var_304_13)
							else
								local var_304_14 = Mathf.Lerp(iter_304_2.color.r, 1, var_304_10)

								iter_304_2.color = Color.New(var_304_14, var_304_14, var_304_14)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps1060 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_304_4 then
						if arg_301_1.isInRecall_ then
							iter_304_4.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1060 = nil
			end

			local var_304_15 = arg_301_1.actors_["1056"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = var_304_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_17 = 0.034

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_6 then
							if arg_301_1.isInRecall_ then
								local var_304_19 = Mathf.Lerp(iter_304_6.color.r, arg_301_1.hightColor2.r, var_304_18)
								local var_304_20 = Mathf.Lerp(iter_304_6.color.g, arg_301_1.hightColor2.g, var_304_18)
								local var_304_21 = Mathf.Lerp(iter_304_6.color.b, arg_301_1.hightColor2.b, var_304_18)

								iter_304_6.color = Color.New(var_304_19, var_304_20, var_304_21)
							else
								local var_304_22 = Mathf.Lerp(iter_304_6.color.r, 0.5, var_304_18)

								iter_304_6.color = Color.New(var_304_22, var_304_22, var_304_22)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_8 then
						if arg_301_1.isInRecall_ then
							iter_304_8.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_23 = 0
			local var_304_24 = 1.325

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[584].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(410052074)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 53
				local var_304_29 = utf8.len(var_304_27)
				local var_304_30 = var_304_28 <= 0 and var_304_24 or var_304_24 * (var_304_29 / var_304_28)

				if var_304_30 > 0 and var_304_24 < var_304_30 then
					arg_301_1.talkMaxDuration = var_304_30

					if var_304_30 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_30 + var_304_23
					end
				end

				arg_301_1.text_.text = var_304_27
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052074", "story_v_out_410052.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_410052", "410052074", "story_v_out_410052.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_410052", "410052074", "story_v_out_410052.awb")

						arg_301_1:RecordAudio("410052074", var_304_32)
						arg_301_1:RecordAudio("410052074", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410052", "410052074", "story_v_out_410052.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410052", "410052074", "story_v_out_410052.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_33 = math.max(var_304_24, arg_301_1.talkMaxDuration)

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_33 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_23) / var_304_33

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_23 + var_304_33 and arg_301_1.time_ < var_304_23 + var_304_33 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play410052075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410052075
		arg_305_1.duration_ = 6.37

		local var_305_0 = {
			zh = 3.4,
			ja = 6.366
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
			arg_305_1.auto_ = false
		end

		function arg_305_1.playNext_(arg_307_0)
			arg_305_1.onStoryFinished_()
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1060"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1060 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1060", 4)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(420.9, -430.8, 6.9)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1060, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_308_7 = arg_305_1.actors_["1060"]
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps1060 == nil then
				arg_305_1.var_.actorSpriteComps1060 = var_308_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_9 = 0.034

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 and not isNil(var_308_7) then
				local var_308_10 = (arg_305_1.time_ - var_308_8) / var_308_9

				if arg_305_1.var_.actorSpriteComps1060 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								local var_308_11 = Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, var_308_10)
								local var_308_12 = Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, var_308_10)
								local var_308_13 = Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, var_308_10)

								iter_308_2.color = Color.New(var_308_11, var_308_12, var_308_13)
							else
								local var_308_14 = Mathf.Lerp(iter_308_2.color.r, 1, var_308_10)

								iter_308_2.color = Color.New(var_308_14, var_308_14, var_308_14)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps1060 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_308_4 then
						if arg_305_1.isInRecall_ then
							iter_308_4.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1060 = nil
			end

			local var_308_15 = 0
			local var_308_16 = 0.3

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_17 = arg_305_1:FormatText(StoryNameCfg[584].name)

				arg_305_1.leftNameTxt_.text = var_308_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_18 = arg_305_1:GetWordFromCfg(410052075)
				local var_308_19 = arg_305_1:FormatText(var_308_18.content)

				arg_305_1.text_.text = var_308_19

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_20 = 12
				local var_308_21 = utf8.len(var_308_19)
				local var_308_22 = var_308_20 <= 0 and var_308_16 or var_308_16 * (var_308_21 / var_308_20)

				if var_308_22 > 0 and var_308_16 < var_308_22 then
					arg_305_1.talkMaxDuration = var_308_22

					if var_308_22 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_22 + var_308_15
					end
				end

				arg_305_1.text_.text = var_308_19
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410052", "410052075", "story_v_out_410052.awb") ~= 0 then
					local var_308_23 = manager.audio:GetVoiceLength("story_v_out_410052", "410052075", "story_v_out_410052.awb") / 1000

					if var_308_23 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_15
					end

					if var_308_18.prefab_name ~= "" and arg_305_1.actors_[var_308_18.prefab_name] ~= nil then
						local var_308_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_18.prefab_name].transform, "story_v_out_410052", "410052075", "story_v_out_410052.awb")

						arg_305_1:RecordAudio("410052075", var_308_24)
						arg_305_1:RecordAudio("410052075", var_308_24)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410052", "410052075", "story_v_out_410052.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410052", "410052075", "story_v_out_410052.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_25 = math.max(var_308_16, arg_305_1.talkMaxDuration)

			if var_308_15 <= arg_305_1.time_ and arg_305_1.time_ < var_308_15 + var_308_25 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_15) / var_308_25

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_15 + var_308_25 and arg_305_1.time_ < var_308_15 + var_308_25 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L01f"
	},
	voices = {
		"story_v_out_410052.awb"
	}
}
