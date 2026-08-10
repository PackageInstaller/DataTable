return {
	Play115201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "RO0205"

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
				local var_4_5 = arg_1_1.bgs_.RO0205

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
					if iter_4_0 ~= "RO0205" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_15", "se_story_15_blast03", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.3

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 0.475
			local var_4_33 = 0.525

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = manager.ui.mainCamera.transform
			local var_4_39 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_38.localPosition
			end

			local var_4_40 = 1

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / 0.066
				local var_4_42, var_4_43 = math.modf(var_4_41)

				var_4_38.localPosition = Vector3.New(var_4_43 * 0.13, var_4_43 * 0.13, var_4_43 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_44 = arg_1_1.bgs_.RO0205.transform
			local var_4_45 = 0

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0205 = var_4_44.localPosition
			end

			local var_4_46 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Vector3.New(-1, 1, 6)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0205, var_4_48, var_4_47)
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-1, 1, 6)
			end

			local var_4_49 = arg_1_1.bgs_.RO0205.transform
			local var_4_50 = 0.0166666666666667

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0205 = var_4_49.localPosition
			end

			local var_4_51 = 3.5

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_50) / var_4_51
				local var_4_53 = Vector3.New(-1, 0.5, 6)

				var_4_49.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0205, var_4_53, var_4_52)
			end

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				var_4_49.localPosition = Vector3.New(-1, 0.5, 6)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 2
			local var_4_55 = 0.475

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(115201001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 19
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_55 or var_4_55 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_55 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_54 = var_4_54 + 0.3

					if var_4_61 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_54 + 0.3
			local var_4_63 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.075

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(115201002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 43
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play115201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115201003
		arg_13_1.duration_ = 8.87

		local var_13_0 = {
			ja = 8.866,
			ko = 5.4,
			zh = 8.666,
			en = 6.833
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
				arg_13_0:Play115201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.475

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[263].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(115201003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 19
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201003", "story_v_out_115201.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201003", "story_v_out_115201.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_115201", "115201003", "story_v_out_115201.awb")

						arg_13_1:RecordAudio("115201003", var_16_9)
						arg_13_1:RecordAudio("115201003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115201", "115201003", "story_v_out_115201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115201", "115201003", "story_v_out_115201.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.375

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

				local var_20_2 = arg_17_1:GetWordFromCfg(115201004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 15
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
	Play115201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115201005
		arg_21_1.duration_ = 10.1

		local var_21_0 = {
			ja = 10.1,
			ko = 6.333,
			zh = 8.133,
			en = 5.966
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
				arg_21_0:Play115201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.45

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[263].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(115201005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201005", "story_v_out_115201.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201005", "story_v_out_115201.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_115201", "115201005", "story_v_out_115201.awb")

						arg_21_1:RecordAudio("115201005", var_24_9)
						arg_21_1:RecordAudio("115201005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115201", "115201005", "story_v_out_115201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115201", "115201005", "story_v_out_115201.awb")
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
	Play115201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115201006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.65

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(115201006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115201007
		arg_29_1.duration_ = 10.5

		local var_29_0 = {
			ja = 8.8,
			ko = 8.2,
			zh = 10.5,
			en = 7.666
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
				arg_29_0:Play115201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "G02j"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.G02j

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "G02j" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_17 = 2

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Color.New(0, 0, 0)

				var_32_19.a = Mathf.Lerp(0, 1, var_32_18)
				arg_29_1.mask_.color = var_32_19
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				local var_32_20 = Color.New(0, 0, 0)

				var_32_20.a = 1
				arg_29_1.mask_.color = var_32_20
			end

			local var_32_21 = 2

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_22 = 2

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Color.New(0, 0, 0)

				var_32_24.a = Mathf.Lerp(1, 0, var_32_23)
				arg_29_1.mask_.color = var_32_24
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				local var_32_25 = Color.New(0, 0, 0)
				local var_32_26 = 0

				arg_29_1.mask_.enabled = false
				var_32_25.a = var_32_26
				arg_29_1.mask_.color = var_32_25
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_27 = 4
			local var_32_28 = 0.25

			if var_32_27 < arg_29_1.time_ and arg_29_1.time_ <= var_32_27 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_29 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_29:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_30 = arg_29_1:FormatText(StoryNameCfg[263].name)

				arg_29_1.leftNameTxt_.text = var_32_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_31 = arg_29_1:GetWordFromCfg(115201007)
				local var_32_32 = arg_29_1:FormatText(var_32_31.content)

				arg_29_1.text_.text = var_32_32

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_33 = 10
				local var_32_34 = utf8.len(var_32_32)
				local var_32_35 = var_32_33 <= 0 and var_32_28 or var_32_28 * (var_32_34 / var_32_33)

				if var_32_35 > 0 and var_32_28 < var_32_35 then
					arg_29_1.talkMaxDuration = var_32_35
					var_32_27 = var_32_27 + 0.3

					if var_32_35 + var_32_27 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_35 + var_32_27
					end
				end

				arg_29_1.text_.text = var_32_32
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201007", "story_v_out_115201.awb") ~= 0 then
					local var_32_36 = manager.audio:GetVoiceLength("story_v_out_115201", "115201007", "story_v_out_115201.awb") / 1000

					if var_32_36 + var_32_27 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_27
					end

					if var_32_31.prefab_name ~= "" and arg_29_1.actors_[var_32_31.prefab_name] ~= nil then
						local var_32_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_31.prefab_name].transform, "story_v_out_115201", "115201007", "story_v_out_115201.awb")

						arg_29_1:RecordAudio("115201007", var_32_37)
						arg_29_1:RecordAudio("115201007", var_32_37)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115201", "115201007", "story_v_out_115201.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115201", "115201007", "story_v_out_115201.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_38 = var_32_27 + 0.3
			local var_32_39 = math.max(var_32_28, arg_29_1.talkMaxDuration)

			if var_32_38 <= arg_29_1.time_ and arg_29_1.time_ < var_32_38 + var_32_39 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_38) / var_32_39

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_38 + var_32_39 and arg_29_1.time_ < var_32_38 + var_32_39 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115201008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115201008
		arg_35_1.duration_ = 5

		local var_35_0 = {
			ja = 5,
			ko = 3,
			zh = 2.566,
			en = 3.633
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115201009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "1024ui_story"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_35_1.stage_.transform)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentInChildren(typeof(CharacterEffect))

					var_38_3.enabled = true

					local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_2, typeof(DynamicBoneHelper))

					if var_38_4 then
						var_38_4:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_3.transform, false)

					arg_35_1.var_[var_38_0 .. "Animator"] = var_38_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_0 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_0 .. "LipSync"] = var_38_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_5 = arg_35_1.actors_["1024ui_story"].transform
			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.var_.moveOldPos1024ui_story = var_38_5.localPosition
			end

			local var_38_7 = 0.001

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_7 then
				local var_38_8 = (arg_35_1.time_ - var_38_6) / var_38_7
				local var_38_9 = Vector3.New(0, -1, -6.05)

				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1024ui_story, var_38_9, var_38_8)

				local var_38_10 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_10.x, var_38_10.y, var_38_10.z)

				local var_38_11 = var_38_5.localEulerAngles

				var_38_11.z = 0
				var_38_11.x = 0
				var_38_5.localEulerAngles = var_38_11
			end

			if arg_35_1.time_ >= var_38_6 + var_38_7 and arg_35_1.time_ < var_38_6 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -1, -6.05)

				local var_38_12 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_12.x, var_38_12.y, var_38_12.z)

				local var_38_13 = var_38_5.localEulerAngles

				var_38_13.z = 0
				var_38_13.x = 0
				var_38_5.localEulerAngles = var_38_13
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_38_16 = arg_35_1.actors_["1024ui_story"]
			local var_38_17 = 0

			if var_38_17 < arg_35_1.time_ and arg_35_1.time_ <= var_38_17 + arg_38_0 and not isNil(var_38_16) and arg_35_1.var_.characterEffect1024ui_story == nil then
				arg_35_1.var_.characterEffect1024ui_story = var_38_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_18 = 0.2

			if var_38_17 <= arg_35_1.time_ and arg_35_1.time_ < var_38_17 + var_38_18 and not isNil(var_38_16) then
				local var_38_19 = (arg_35_1.time_ - var_38_17) / var_38_18

				if arg_35_1.var_.characterEffect1024ui_story and not isNil(var_38_16) then
					arg_35_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_17 + var_38_18 and arg_35_1.time_ < var_38_17 + var_38_18 + arg_38_0 and not isNil(var_38_16) and arg_35_1.var_.characterEffect1024ui_story then
				arg_35_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_38_20 = 0
			local var_38_21 = 0.4

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_22 = arg_35_1:FormatText(StoryNameCfg[265].name)

				arg_35_1.leftNameTxt_.text = var_38_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_23 = arg_35_1:GetWordFromCfg(115201008)
				local var_38_24 = arg_35_1:FormatText(var_38_23.content)

				arg_35_1.text_.text = var_38_24

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_25 = 16
				local var_38_26 = utf8.len(var_38_24)
				local var_38_27 = var_38_25 <= 0 and var_38_21 or var_38_21 * (var_38_26 / var_38_25)

				if var_38_27 > 0 and var_38_21 < var_38_27 then
					arg_35_1.talkMaxDuration = var_38_27

					if var_38_27 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_27 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_24
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201008", "story_v_out_115201.awb") ~= 0 then
					local var_38_28 = manager.audio:GetVoiceLength("story_v_out_115201", "115201008", "story_v_out_115201.awb") / 1000

					if var_38_28 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_20
					end

					if var_38_23.prefab_name ~= "" and arg_35_1.actors_[var_38_23.prefab_name] ~= nil then
						local var_38_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_23.prefab_name].transform, "story_v_out_115201", "115201008", "story_v_out_115201.awb")

						arg_35_1:RecordAudio("115201008", var_38_29)
						arg_35_1:RecordAudio("115201008", var_38_29)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115201", "115201008", "story_v_out_115201.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115201", "115201008", "story_v_out_115201.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_30 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_20 <= arg_35_1.time_ and arg_35_1.time_ < var_38_20 + var_38_30 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_20) / var_38_30

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_20 + var_38_30 and arg_35_1.time_ < var_38_20 + var_38_30 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play115201009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115201009
		arg_39_1.duration_ = 10.8

		local var_39_0 = {
			ja = 8.333,
			ko = 6.133,
			zh = 10.8,
			en = 6.766
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115201010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1024ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1024ui_story == nil then
				arg_39_1.var_.characterEffect1024ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1024ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1024ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1024ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1024ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.55

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[263].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(115201009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 22
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201009", "story_v_out_115201.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201009", "story_v_out_115201.awb") / 1000

					if var_42_14 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_6
					end

					if var_42_9.prefab_name ~= "" and arg_39_1.actors_[var_42_9.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_9.prefab_name].transform, "story_v_out_115201", "115201009", "story_v_out_115201.awb")

						arg_39_1:RecordAudio("115201009", var_42_15)
						arg_39_1:RecordAudio("115201009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115201", "115201009", "story_v_out_115201.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115201", "115201009", "story_v_out_115201.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_16 and arg_39_1.time_ < var_42_6 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115201010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115201010
		arg_43_1.duration_ = 3.03

		local var_43_0 = {
			ja = 2.866,
			ko = 2.4,
			zh = 3.033,
			en = 2.7
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
				arg_43_0:Play115201011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1024ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1024ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1024ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = 0
			local var_46_10 = 0.225

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_11 = arg_43_1:FormatText(StoryNameCfg[261].name)

				arg_43_1.leftNameTxt_.text = var_46_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_12 = arg_43_1:GetWordFromCfg(115201010)
				local var_46_13 = arg_43_1:FormatText(var_46_12.content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_14 = 9
				local var_46_15 = utf8.len(var_46_13)
				local var_46_16 = var_46_14 <= 0 and var_46_10 or var_46_10 * (var_46_15 / var_46_14)

				if var_46_16 > 0 and var_46_10 < var_46_16 then
					arg_43_1.talkMaxDuration = var_46_16

					if var_46_16 + var_46_9 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_9
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201010", "story_v_out_115201.awb") ~= 0 then
					local var_46_17 = manager.audio:GetVoiceLength("story_v_out_115201", "115201010", "story_v_out_115201.awb") / 1000

					if var_46_17 + var_46_9 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_9
					end

					if var_46_12.prefab_name ~= "" and arg_43_1.actors_[var_46_12.prefab_name] ~= nil then
						local var_46_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_12.prefab_name].transform, "story_v_out_115201", "115201010", "story_v_out_115201.awb")

						arg_43_1:RecordAudio("115201010", var_46_18)
						arg_43_1:RecordAudio("115201010", var_46_18)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_115201", "115201010", "story_v_out_115201.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_115201", "115201010", "story_v_out_115201.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_19 = math.max(var_46_10, arg_43_1.talkMaxDuration)

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_19 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_9) / var_46_19

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_9 + var_46_19 and arg_43_1.time_ < var_46_9 + var_46_19 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play115201011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115201011
		arg_47_1.duration_ = 2.6

		local var_47_0 = {
			ja = 2.6,
			ko = 2,
			zh = 1.866,
			en = 2.3
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
				arg_47_0:Play115201012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.15

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[262].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(115201011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 6
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201011", "story_v_out_115201.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201011", "story_v_out_115201.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_115201", "115201011", "story_v_out_115201.awb")

						arg_47_1:RecordAudio("115201011", var_50_9)
						arg_47_1:RecordAudio("115201011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115201", "115201011", "story_v_out_115201.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115201", "115201011", "story_v_out_115201.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play115201012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115201012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play115201013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.9

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(115201012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 36
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play115201013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115201013
		arg_55_1.duration_ = 7.3

		local var_55_0 = {
			ja = 7.3,
			ko = 6.266,
			zh = 5.933,
			en = 6.966
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play115201014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.675

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[261].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(115201013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 27
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201013", "story_v_out_115201.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201013", "story_v_out_115201.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_115201", "115201013", "story_v_out_115201.awb")

						arg_55_1:RecordAudio("115201013", var_58_9)
						arg_55_1:RecordAudio("115201013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115201", "115201013", "story_v_out_115201.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115201", "115201013", "story_v_out_115201.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play115201014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115201014
		arg_59_1.duration_ = 4.6

		local var_59_0 = {
			ja = 4.6,
			ko = 4.233,
			zh = 3.333,
			en = 3.7
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
				arg_59_0:Play115201015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.45

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[262].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(115201014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 18
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201014", "story_v_out_115201.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201014", "story_v_out_115201.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_115201", "115201014", "story_v_out_115201.awb")

						arg_59_1:RecordAudio("115201014", var_62_9)
						arg_59_1:RecordAudio("115201014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_115201", "115201014", "story_v_out_115201.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_115201", "115201014", "story_v_out_115201.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115201015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115201015
		arg_63_1.duration_ = 6.43

		local var_63_0 = {
			ja = 6.433,
			ko = 5.433,
			zh = 4.966,
			en = 6.266
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
				arg_63_0:Play115201016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.675

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[262].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(115201015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201015", "story_v_out_115201.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201015", "story_v_out_115201.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_115201", "115201015", "story_v_out_115201.awb")

						arg_63_1:RecordAudio("115201015", var_66_9)
						arg_63_1:RecordAudio("115201015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115201", "115201015", "story_v_out_115201.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115201", "115201015", "story_v_out_115201.awb")
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
	Play115201016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115201016
		arg_67_1.duration_ = 4.37

		local var_67_0 = {
			ja = 3.9,
			ko = 3.666,
			zh = 3.7,
			en = 4.366
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
				arg_67_0:Play115201017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = manager.ui.mainCamera.transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.shakeOldPos = var_70_0.localPosition
			end

			local var_70_2 = 0.6

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / 0.066
				local var_70_4, var_70_5 = math.modf(var_70_3)

				var_70_0.localPosition = Vector3.New(var_70_5 * 0.13, var_70_5 * 0.13, var_70_5 * 0.13) + arg_67_1.var_.shakeOldPos
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = arg_67_1.var_.shakeOldPos
			end

			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_7 = 0.6

			if arg_67_1.time_ >= var_70_6 + var_70_7 and arg_67_1.time_ < var_70_6 + var_70_7 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_8 = 0
			local var_70_9 = 0.35

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_10 = arg_67_1:FormatText(StoryNameCfg[260].name)

				arg_67_1.leftNameTxt_.text = var_70_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_11 = arg_67_1:GetWordFromCfg(115201016)
				local var_70_12 = arg_67_1:FormatText(var_70_11.content)

				arg_67_1.text_.text = var_70_12

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 14
				local var_70_14 = utf8.len(var_70_12)
				local var_70_15 = var_70_13 <= 0 and var_70_9 or var_70_9 * (var_70_14 / var_70_13)

				if var_70_15 > 0 and var_70_9 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_12
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201016", "story_v_out_115201.awb") ~= 0 then
					local var_70_16 = manager.audio:GetVoiceLength("story_v_out_115201", "115201016", "story_v_out_115201.awb") / 1000

					if var_70_16 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_8
					end

					if var_70_11.prefab_name ~= "" and arg_67_1.actors_[var_70_11.prefab_name] ~= nil then
						local var_70_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_11.prefab_name].transform, "story_v_out_115201", "115201016", "story_v_out_115201.awb")

						arg_67_1:RecordAudio("115201016", var_70_17)
						arg_67_1:RecordAudio("115201016", var_70_17)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115201", "115201016", "story_v_out_115201.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115201", "115201016", "story_v_out_115201.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_18 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_18 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_18

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_18 and arg_67_1.time_ < var_70_8 + var_70_18 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115201017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115201017
		arg_71_1.duration_ = 5.73

		local var_71_0 = {
			ja = 5.733,
			ko = 3.9,
			zh = 3,
			en = 3.7
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
				arg_71_0:Play115201018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.2

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[263].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(115201017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 8
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201017", "story_v_out_115201.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201017", "story_v_out_115201.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_115201", "115201017", "story_v_out_115201.awb")

						arg_71_1:RecordAudio("115201017", var_74_9)
						arg_71_1:RecordAudio("115201017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115201", "115201017", "story_v_out_115201.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115201", "115201017", "story_v_out_115201.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play115201018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115201018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play115201019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.65

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

				local var_78_2 = arg_75_1:GetWordFromCfg(115201018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 26
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
	Play115201019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115201019
		arg_79_1.duration_ = 2.9

		local var_79_0 = {
			ja = 2.633,
			ko = 2.9,
			zh = 2.1,
			en = 2.8
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
				arg_79_0:Play115201020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = "1052ui_story"

			if arg_79_1.actors_[var_82_0] == nil then
				local var_82_1 = Asset.Load("Char/" .. "1052ui_story")

				if not isNil(var_82_1) then
					local var_82_2 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_79_1.stage_.transform)

					var_82_2.name = var_82_0
					var_82_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_79_1.actors_[var_82_0] = var_82_2

					local var_82_3 = var_82_2:GetComponentInChildren(typeof(CharacterEffect))

					var_82_3.enabled = true

					local var_82_4 = GameObjectTools.GetOrAddComponent(var_82_2, typeof(DynamicBoneHelper))

					if var_82_4 then
						var_82_4:EnableDynamicBone(false)
					end

					arg_79_1:ShowWeapon(var_82_3.transform, false)

					arg_79_1.var_[var_82_0 .. "Animator"] = var_82_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_79_1.var_[var_82_0 .. "Animator"].applyRootMotion = true
					arg_79_1.var_[var_82_0 .. "LipSync"] = var_82_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_82_5 = arg_79_1.actors_["1052ui_story"].transform
			local var_82_6 = 0

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.var_.moveOldPos1052ui_story = var_82_5.localPosition
			end

			local var_82_7 = 0.001

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_7 then
				local var_82_8 = (arg_79_1.time_ - var_82_6) / var_82_7
				local var_82_9 = Vector3.New(0, -1.05, -6.2)

				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1052ui_story, var_82_9, var_82_8)

				local var_82_10 = manager.ui.mainCamera.transform.position - var_82_5.position

				var_82_5.forward = Vector3.New(var_82_10.x, var_82_10.y, var_82_10.z)

				local var_82_11 = var_82_5.localEulerAngles

				var_82_11.z = 0
				var_82_11.x = 0
				var_82_5.localEulerAngles = var_82_11
			end

			if arg_79_1.time_ >= var_82_6 + var_82_7 and arg_79_1.time_ < var_82_6 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_82_12 = manager.ui.mainCamera.transform.position - var_82_5.position

				var_82_5.forward = Vector3.New(var_82_12.x, var_82_12.y, var_82_12.z)

				local var_82_13 = var_82_5.localEulerAngles

				var_82_13.z = 0
				var_82_13.x = 0
				var_82_5.localEulerAngles = var_82_13
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_15 = 0

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_82_16 = arg_79_1.actors_["1052ui_story"]
			local var_82_17 = 0

			if var_82_17 < arg_79_1.time_ and arg_79_1.time_ <= var_82_17 + arg_82_0 and not isNil(var_82_16) and arg_79_1.var_.characterEffect1052ui_story == nil then
				arg_79_1.var_.characterEffect1052ui_story = var_82_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_18 = 0.2

			if var_82_17 <= arg_79_1.time_ and arg_79_1.time_ < var_82_17 + var_82_18 and not isNil(var_82_16) then
				local var_82_19 = (arg_79_1.time_ - var_82_17) / var_82_18

				if arg_79_1.var_.characterEffect1052ui_story and not isNil(var_82_16) then
					arg_79_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_17 + var_82_18 and arg_79_1.time_ < var_82_17 + var_82_18 + arg_82_0 and not isNil(var_82_16) and arg_79_1.var_.characterEffect1052ui_story then
				arg_79_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_82_20 = 0
			local var_82_21 = 0.25

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_22 = arg_79_1:FormatText(StoryNameCfg[263].name)

				arg_79_1.leftNameTxt_.text = var_82_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_23 = arg_79_1:GetWordFromCfg(115201019)
				local var_82_24 = arg_79_1:FormatText(var_82_23.content)

				arg_79_1.text_.text = var_82_24

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 10
				local var_82_26 = utf8.len(var_82_24)
				local var_82_27 = var_82_25 <= 0 and var_82_21 or var_82_21 * (var_82_26 / var_82_25)

				if var_82_27 > 0 and var_82_21 < var_82_27 then
					arg_79_1.talkMaxDuration = var_82_27

					if var_82_27 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_27 + var_82_20
					end
				end

				arg_79_1.text_.text = var_82_24
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201019", "story_v_out_115201.awb") ~= 0 then
					local var_82_28 = manager.audio:GetVoiceLength("story_v_out_115201", "115201019", "story_v_out_115201.awb") / 1000

					if var_82_28 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_20
					end

					if var_82_23.prefab_name ~= "" and arg_79_1.actors_[var_82_23.prefab_name] ~= nil then
						local var_82_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_23.prefab_name].transform, "story_v_out_115201", "115201019", "story_v_out_115201.awb")

						arg_79_1:RecordAudio("115201019", var_82_29)
						arg_79_1:RecordAudio("115201019", var_82_29)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115201", "115201019", "story_v_out_115201.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115201", "115201019", "story_v_out_115201.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_30 = math.max(var_82_21, arg_79_1.talkMaxDuration)

			if var_82_20 <= arg_79_1.time_ and arg_79_1.time_ < var_82_20 + var_82_30 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_20) / var_82_30

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_20 + var_82_30 and arg_79_1.time_ < var_82_20 + var_82_30 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play115201020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115201020
		arg_83_1.duration_ = 5.13

		local var_83_0 = {
			ja = 5.133,
			ko = 4.7,
			zh = 4.233,
			en = 4.066
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
				arg_83_0:Play115201021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1052ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1052ui_story == nil then
				arg_83_1.var_.characterEffect1052ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1052ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1052ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1052ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1052ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.425

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[262].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_9 = arg_83_1:GetWordFromCfg(115201020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 17
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201020", "story_v_out_115201.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201020", "story_v_out_115201.awb") / 1000

					if var_86_14 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_6
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_115201", "115201020", "story_v_out_115201.awb")

						arg_83_1:RecordAudio("115201020", var_86_15)
						arg_83_1:RecordAudio("115201020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_115201", "115201020", "story_v_out_115201.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_115201", "115201020", "story_v_out_115201.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_16 and arg_83_1.time_ < var_86_6 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115201021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115201021
		arg_87_1.duration_ = 4.9

		local var_87_0 = {
			ja = 4.9,
			ko = 4.733,
			zh = 3.733,
			en = 4.466
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
				arg_87_0:Play115201022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.4

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[291].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(115201021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201021", "story_v_out_115201.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201021", "story_v_out_115201.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_115201", "115201021", "story_v_out_115201.awb")

						arg_87_1:RecordAudio("115201021", var_90_9)
						arg_87_1:RecordAudio("115201021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115201", "115201021", "story_v_out_115201.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115201", "115201021", "story_v_out_115201.awb")
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
	Play115201022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115201022
		arg_91_1.duration_ = 6.6

		local var_91_0 = {
			ja = 6.6,
			ko = 4.033,
			zh = 3.233,
			en = 5.666
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
				arg_91_0:Play115201023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_1 = arg_91_1.actors_["1052ui_story"]
			local var_94_2 = 0

			if var_94_2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1052ui_story == nil then
				arg_91_1.var_.characterEffect1052ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.2

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_3 and not isNil(var_94_1) then
				local var_94_4 = (arg_91_1.time_ - var_94_2) / var_94_3

				if arg_91_1.var_.characterEffect1052ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_2 + var_94_3 and arg_91_1.time_ < var_94_2 + var_94_3 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1052ui_story then
				arg_91_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action2_1")
			end

			local var_94_6 = arg_91_1.actors_["1052ui_story"].transform
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.var_.moveOldPos1052ui_story = var_94_6.localPosition

				local var_94_8 = "1052ui_story"

				arg_91_1:ShowWeapon(arg_91_1.var_[var_94_8 .. "Animator"].transform, true)
			end

			local var_94_9 = 0.001

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_9 then
				local var_94_10 = (arg_91_1.time_ - var_94_7) / var_94_9
				local var_94_11 = Vector3.New(0, -1.05, -6.2)

				var_94_6.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1052ui_story, var_94_11, var_94_10)

				local var_94_12 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_12.x, var_94_12.y, var_94_12.z)

				local var_94_13 = var_94_6.localEulerAngles

				var_94_13.z = 0
				var_94_13.x = 0
				var_94_6.localEulerAngles = var_94_13
			end

			if arg_91_1.time_ >= var_94_7 + var_94_9 and arg_91_1.time_ < var_94_7 + var_94_9 + arg_94_0 then
				var_94_6.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_94_14 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_14.x, var_94_14.y, var_94_14.z)

				local var_94_15 = var_94_6.localEulerAngles

				var_94_15.z = 0
				var_94_15.x = 0
				var_94_6.localEulerAngles = var_94_15
			end

			local var_94_16 = 0
			local var_94_17 = 0.35

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_18 = arg_91_1:FormatText(StoryNameCfg[263].name)

				arg_91_1.leftNameTxt_.text = var_94_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(115201022)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 14
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_17 or var_94_17 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_17 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23

					if var_94_23 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_16
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201022", "story_v_out_115201.awb") ~= 0 then
					local var_94_24 = manager.audio:GetVoiceLength("story_v_out_115201", "115201022", "story_v_out_115201.awb") / 1000

					if var_94_24 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_24 + var_94_16
					end

					if var_94_19.prefab_name ~= "" and arg_91_1.actors_[var_94_19.prefab_name] ~= nil then
						local var_94_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_19.prefab_name].transform, "story_v_out_115201", "115201022", "story_v_out_115201.awb")

						arg_91_1:RecordAudio("115201022", var_94_25)
						arg_91_1:RecordAudio("115201022", var_94_25)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115201", "115201022", "story_v_out_115201.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115201", "115201022", "story_v_out_115201.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_26 = math.max(var_94_17, arg_91_1.talkMaxDuration)

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_26 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_16) / var_94_26

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_16 + var_94_26 and arg_91_1.time_ < var_94_16 + var_94_26 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play115201023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115201023
		arg_95_1.duration_ = 7.9

		local var_95_0 = {
			ja = 5.566,
			ko = 3.633,
			zh = 3.266,
			en = 7.9
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
				arg_95_0:Play115201024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1052ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1052ui_story == nil then
				arg_95_1.var_.characterEffect1052ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1052ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1052ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1052ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1052ui_story.fillRatio = var_98_5
			end

			local var_98_6 = arg_95_1.actors_["1052ui_story"].transform
			local var_98_7 = 0

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.var_.moveOldPos1052ui_story = var_98_6.localPosition
			end

			local var_98_8 = 0.001

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 then
				local var_98_9 = (arg_95_1.time_ - var_98_7) / var_98_8
				local var_98_10 = Vector3.New(0, 100, 0)

				var_98_6.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1052ui_story, var_98_10, var_98_9)

				local var_98_11 = manager.ui.mainCamera.transform.position - var_98_6.position

				var_98_6.forward = Vector3.New(var_98_11.x, var_98_11.y, var_98_11.z)

				local var_98_12 = var_98_6.localEulerAngles

				var_98_12.z = 0
				var_98_12.x = 0
				var_98_6.localEulerAngles = var_98_12
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 then
				var_98_6.localPosition = Vector3.New(0, 100, 0)

				local var_98_13 = manager.ui.mainCamera.transform.position - var_98_6.position

				var_98_6.forward = Vector3.New(var_98_13.x, var_98_13.y, var_98_13.z)

				local var_98_14 = var_98_6.localEulerAngles

				var_98_14.z = 0
				var_98_14.x = 0
				var_98_6.localEulerAngles = var_98_14
			end

			local var_98_15 = 0
			local var_98_16 = 0.375

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[292].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_18 = arg_95_1:GetWordFromCfg(115201023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 15
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201023", "story_v_out_115201.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_115201", "115201023", "story_v_out_115201.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_115201", "115201023", "story_v_out_115201.awb")

						arg_95_1:RecordAudio("115201023", var_98_24)
						arg_95_1:RecordAudio("115201023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_115201", "115201023", "story_v_out_115201.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_115201", "115201023", "story_v_out_115201.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play115201024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115201024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play115201025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = manager.ui.mainCamera.transform
			local var_102_1 = 0.666666666666667

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = var_102_0.localPosition
			end

			local var_102_2 = 1

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / 0.066
				local var_102_4, var_102_5 = math.modf(var_102_3)

				var_102_0.localPosition = Vector3.New(var_102_5 * 0.13, var_102_5 * 0.13, var_102_5 * 0.13) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = arg_99_1.var_.shakeOldPos
			end

			local var_102_6 = 0.666666666666667
			local var_102_7 = 0.833333333333333

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				local var_102_8 = "play"
				local var_102_9 = "effect"

				arg_99_1:AudioAction(var_102_8, var_102_9, "se_story_15", "se_story_15_gun02", "")
			end

			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			local var_102_11 = 1.66666666666667

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_12 = 0
			local var_102_13 = 1.5

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(115201024)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 60
				local var_102_17 = utf8.len(var_102_15)
				local var_102_18 = var_102_16 <= 0 and var_102_13 or var_102_13 * (var_102_17 / var_102_16)

				if var_102_18 > 0 and var_102_13 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18

					if var_102_18 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_19 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_12) / var_102_19

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_12 + var_102_19 and arg_99_1.time_ < var_102_12 + var_102_19 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play115201025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115201025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115201026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.675
			local var_106_1 = 1

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_2 = "play"
				local var_106_3 = "effect"

				arg_103_1:AudioAction(var_106_2, var_106_3, "se_story_15", "se_story_15_repel", "")
			end

			local var_106_4 = 0
			local var_106_5 = 1.675

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(115201025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_8 = 67
				local var_106_9 = utf8.len(var_106_7)
				local var_106_10 = var_106_8 <= 0 and var_106_5 or var_106_5 * (var_106_9 / var_106_8)

				if var_106_10 > 0 and var_106_5 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_11 and arg_103_1.time_ < var_106_4 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115201026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115201026
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			ja = 4.766,
			ko = 4.466,
			zh = 3.033,
			en = 4.3
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
				arg_107_0:Play115201027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = "4010ui_story"

			if arg_107_1.actors_[var_110_0] == nil then
				local var_110_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_110_1) then
					local var_110_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_107_1.stage_.transform)

					var_110_2.name = var_110_0
					var_110_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_107_1.actors_[var_110_0] = var_110_2

					local var_110_3 = var_110_2:GetComponentInChildren(typeof(CharacterEffect))

					var_110_3.enabled = true

					local var_110_4 = GameObjectTools.GetOrAddComponent(var_110_2, typeof(DynamicBoneHelper))

					if var_110_4 then
						var_110_4:EnableDynamicBone(false)
					end

					arg_107_1:ShowWeapon(var_110_3.transform, false)

					arg_107_1.var_[var_110_0 .. "Animator"] = var_110_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_107_1.var_[var_110_0 .. "Animator"].applyRootMotion = true
					arg_107_1.var_[var_110_0 .. "LipSync"] = var_110_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_110_5 = arg_107_1.actors_["4010ui_story"].transform
			local var_110_6 = 0

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.var_.moveOldPos4010ui_story = var_110_5.localPosition
			end

			local var_110_7 = 0.001

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 then
				local var_110_8 = (arg_107_1.time_ - var_110_6) / var_110_7
				local var_110_9 = Vector3.New(-0.7, -1.59, -5.2)

				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos4010ui_story, var_110_9, var_110_8)

				local var_110_10 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_10.x, var_110_10.y, var_110_10.z)

				local var_110_11 = var_110_5.localEulerAngles

				var_110_11.z = 0
				var_110_11.x = 0
				var_110_5.localEulerAngles = var_110_11
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_110_12 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_12.x, var_110_12.y, var_110_12.z)

				local var_110_13 = var_110_5.localEulerAngles

				var_110_13.z = 0
				var_110_13.x = 0
				var_110_5.localEulerAngles = var_110_13
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_110_16 = arg_107_1.actors_["4010ui_story"]
			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 and not isNil(var_110_16) and arg_107_1.var_.characterEffect4010ui_story == nil then
				arg_107_1.var_.characterEffect4010ui_story = var_110_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_18 = 0.2

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_18 and not isNil(var_110_16) then
				local var_110_19 = (arg_107_1.time_ - var_110_17) / var_110_18

				if arg_107_1.var_.characterEffect4010ui_story and not isNil(var_110_16) then
					arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_17 + var_110_18 and arg_107_1.time_ < var_110_17 + var_110_18 + arg_110_0 and not isNil(var_110_16) and arg_107_1.var_.characterEffect4010ui_story then
				arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_110_20 = 0
			local var_110_21 = 0.325

			if var_110_20 < arg_107_1.time_ and arg_107_1.time_ <= var_110_20 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_22 = arg_107_1:FormatText(StoryNameCfg[42].name)

				arg_107_1.leftNameTxt_.text = var_110_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_23 = arg_107_1:GetWordFromCfg(115201026)
				local var_110_24 = arg_107_1:FormatText(var_110_23.content)

				arg_107_1.text_.text = var_110_24

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_25 = 13
				local var_110_26 = utf8.len(var_110_24)
				local var_110_27 = var_110_25 <= 0 and var_110_21 or var_110_21 * (var_110_26 / var_110_25)

				if var_110_27 > 0 and var_110_21 < var_110_27 then
					arg_107_1.talkMaxDuration = var_110_27

					if var_110_27 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_27 + var_110_20
					end
				end

				arg_107_1.text_.text = var_110_24
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201026", "story_v_out_115201.awb") ~= 0 then
					local var_110_28 = manager.audio:GetVoiceLength("story_v_out_115201", "115201026", "story_v_out_115201.awb") / 1000

					if var_110_28 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_28 + var_110_20
					end

					if var_110_23.prefab_name ~= "" and arg_107_1.actors_[var_110_23.prefab_name] ~= nil then
						local var_110_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_23.prefab_name].transform, "story_v_out_115201", "115201026", "story_v_out_115201.awb")

						arg_107_1:RecordAudio("115201026", var_110_29)
						arg_107_1:RecordAudio("115201026", var_110_29)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_115201", "115201026", "story_v_out_115201.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_115201", "115201026", "story_v_out_115201.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_30 = math.max(var_110_21, arg_107_1.talkMaxDuration)

			if var_110_20 <= arg_107_1.time_ and arg_107_1.time_ < var_110_20 + var_110_30 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_20) / var_110_30

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_20 + var_110_30 and arg_107_1.time_ < var_110_20 + var_110_30 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play115201027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115201027
		arg_111_1.duration_ = 5.97

		local var_111_0 = {
			ja = 4.333,
			ko = 4.666,
			zh = 5.966,
			en = 4.3
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
				arg_111_0:Play115201028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1052ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1052ui_story = var_114_0.localPosition

				local var_114_2 = "1052ui_story"

				arg_111_1:ShowWeapon(arg_111_1.var_[var_114_2 .. "Animator"].transform, false)
			end

			local var_114_3 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = Vector3.New(0.7, -1.05, -6.2)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1052ui_story, var_114_5, var_114_4)

				local var_114_6 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_6.x, var_114_6.y, var_114_6.z)

				local var_114_7 = var_114_0.localEulerAngles

				var_114_7.z = 0
				var_114_7.x = 0
				var_114_0.localEulerAngles = var_114_7
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_114_8 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_8.x, var_114_8.y, var_114_8.z)

				local var_114_9 = var_114_0.localEulerAngles

				var_114_9.z = 0
				var_114_9.x = 0
				var_114_0.localEulerAngles = var_114_9
			end

			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_114_12 = arg_111_1.actors_["1052ui_story"]
			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 and not isNil(var_114_12) and arg_111_1.var_.characterEffect1052ui_story == nil then
				arg_111_1.var_.characterEffect1052ui_story = var_114_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_14 = 0.2

			if var_114_13 <= arg_111_1.time_ and arg_111_1.time_ < var_114_13 + var_114_14 and not isNil(var_114_12) then
				local var_114_15 = (arg_111_1.time_ - var_114_13) / var_114_14

				if arg_111_1.var_.characterEffect1052ui_story and not isNil(var_114_12) then
					arg_111_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_13 + var_114_14 and arg_111_1.time_ < var_114_13 + var_114_14 + arg_114_0 and not isNil(var_114_12) and arg_111_1.var_.characterEffect1052ui_story then
				arg_111_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_114_16 = arg_111_1.actors_["4010ui_story"]
			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect4010ui_story == nil then
				arg_111_1.var_.characterEffect4010ui_story = var_114_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_18 = 0.2

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_18 and not isNil(var_114_16) then
				local var_114_19 = (arg_111_1.time_ - var_114_17) / var_114_18

				if arg_111_1.var_.characterEffect4010ui_story and not isNil(var_114_16) then
					local var_114_20 = Mathf.Lerp(0, 0.5, var_114_19)

					arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_111_1.var_.characterEffect4010ui_story.fillRatio = var_114_20
				end
			end

			if arg_111_1.time_ >= var_114_17 + var_114_18 and arg_111_1.time_ < var_114_17 + var_114_18 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect4010ui_story then
				local var_114_21 = 0.5

				arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_111_1.var_.characterEffect4010ui_story.fillRatio = var_114_21
			end

			local var_114_22 = 0
			local var_114_23 = 0.375

			if var_114_22 < arg_111_1.time_ and arg_111_1.time_ <= var_114_22 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_24 = arg_111_1:FormatText(StoryNameCfg[263].name)

				arg_111_1.leftNameTxt_.text = var_114_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_25 = arg_111_1:GetWordFromCfg(115201027)
				local var_114_26 = arg_111_1:FormatText(var_114_25.content)

				arg_111_1.text_.text = var_114_26

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_27 = 15
				local var_114_28 = utf8.len(var_114_26)
				local var_114_29 = var_114_27 <= 0 and var_114_23 or var_114_23 * (var_114_28 / var_114_27)

				if var_114_29 > 0 and var_114_23 < var_114_29 then
					arg_111_1.talkMaxDuration = var_114_29

					if var_114_29 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_29 + var_114_22
					end
				end

				arg_111_1.text_.text = var_114_26
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201027", "story_v_out_115201.awb") ~= 0 then
					local var_114_30 = manager.audio:GetVoiceLength("story_v_out_115201", "115201027", "story_v_out_115201.awb") / 1000

					if var_114_30 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_22
					end

					if var_114_25.prefab_name ~= "" and arg_111_1.actors_[var_114_25.prefab_name] ~= nil then
						local var_114_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_25.prefab_name].transform, "story_v_out_115201", "115201027", "story_v_out_115201.awb")

						arg_111_1:RecordAudio("115201027", var_114_31)
						arg_111_1:RecordAudio("115201027", var_114_31)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_115201", "115201027", "story_v_out_115201.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_115201", "115201027", "story_v_out_115201.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_32 = math.max(var_114_23, arg_111_1.talkMaxDuration)

			if var_114_22 <= arg_111_1.time_ and arg_111_1.time_ < var_114_22 + var_114_32 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_22) / var_114_32

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_22 + var_114_32 and arg_111_1.time_ < var_114_22 + var_114_32 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play115201028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115201028
		arg_115_1.duration_ = 8.43

		local var_115_0 = {
			ja = 7.3,
			ko = 7.066,
			zh = 6.466,
			en = 8.433
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
				arg_115_0:Play115201029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_2 = arg_115_1.actors_["4010ui_story"]
			local var_118_3 = 0

			if var_118_3 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect4010ui_story == nil then
				arg_115_1.var_.characterEffect4010ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.2

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_4 and not isNil(var_118_2) then
				local var_118_5 = (arg_115_1.time_ - var_118_3) / var_118_4

				if arg_115_1.var_.characterEffect4010ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_3 + var_118_4 and arg_115_1.time_ < var_118_3 + var_118_4 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect4010ui_story then
				arg_115_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_118_6 = arg_115_1.actors_["1052ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1052ui_story == nil then
				arg_115_1.var_.characterEffect1052ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.2

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect1052ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1052ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1052ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1052ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.775

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[42].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(115201028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 31
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201028", "story_v_out_115201.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_115201", "115201028", "story_v_out_115201.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_115201", "115201028", "story_v_out_115201.awb")

						arg_115_1:RecordAudio("115201028", var_118_21)
						arg_115_1:RecordAudio("115201028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115201", "115201028", "story_v_out_115201.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115201", "115201028", "story_v_out_115201.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play115201029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115201029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play115201030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["4010ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4010ui_story == nil then
				arg_119_1.var_.characterEffect4010ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect4010ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4010ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4010ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4010ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.95

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(115201029)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 38
				local var_122_11 = utf8.len(var_122_9)
				local var_122_12 = var_122_10 <= 0 and var_122_7 or var_122_7 * (var_122_11 / var_122_10)

				if var_122_12 > 0 and var_122_7 < var_122_12 then
					arg_119_1.talkMaxDuration = var_122_12

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_13 and arg_119_1.time_ < var_122_6 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play115201030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115201030
		arg_123_1.duration_ = 5.53

		local var_123_0 = {
			ja = 5.533,
			ko = 3.5,
			zh = 3.266,
			en = 5.366
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
				arg_123_0:Play115201031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_126_1 = arg_123_1.actors_["1052ui_story"]
			local var_126_2 = 0

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1052ui_story == nil then
				arg_123_1.var_.characterEffect1052ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.2

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_3 and not isNil(var_126_1) then
				local var_126_4 = (arg_123_1.time_ - var_126_2) / var_126_3

				if arg_123_1.var_.characterEffect1052ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_2 + var_126_3 and arg_123_1.time_ < var_126_2 + var_126_3 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1052ui_story then
				arg_123_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_126_5 = 0
			local var_126_6 = 0.325

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_7 = arg_123_1:FormatText(StoryNameCfg[263].name)

				arg_123_1.leftNameTxt_.text = var_126_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(115201030)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 13
				local var_126_11 = utf8.len(var_126_9)
				local var_126_12 = var_126_10 <= 0 and var_126_6 or var_126_6 * (var_126_11 / var_126_10)

				if var_126_12 > 0 and var_126_6 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201030", "story_v_out_115201.awb") ~= 0 then
					local var_126_13 = manager.audio:GetVoiceLength("story_v_out_115201", "115201030", "story_v_out_115201.awb") / 1000

					if var_126_13 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_5
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_115201", "115201030", "story_v_out_115201.awb")

						arg_123_1:RecordAudio("115201030", var_126_14)
						arg_123_1:RecordAudio("115201030", var_126_14)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_115201", "115201030", "story_v_out_115201.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_115201", "115201030", "story_v_out_115201.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_15 and arg_123_1.time_ < var_126_5 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115201031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115201031
		arg_127_1.duration_ = 12.6

		local var_127_0 = {
			ja = 12.6,
			ko = 8.733,
			zh = 6.733,
			en = 8.6
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
				arg_127_0:Play115201032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_130_2 = arg_127_1.actors_["4010ui_story"]
			local var_130_3 = 0

			if var_130_3 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect4010ui_story == nil then
				arg_127_1.var_.characterEffect4010ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_4 and not isNil(var_130_2) then
				local var_130_5 = (arg_127_1.time_ - var_130_3) / var_130_4

				if arg_127_1.var_.characterEffect4010ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_3 + var_130_4 and arg_127_1.time_ < var_130_3 + var_130_4 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect4010ui_story then
				arg_127_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_130_6 = arg_127_1.actors_["1052ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1052ui_story == nil then
				arg_127_1.var_.characterEffect1052ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.2

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1052ui_story and not isNil(var_130_6) then
					local var_130_10 = Mathf.Lerp(0, 0.5, var_130_9)

					arg_127_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1052ui_story.fillRatio = var_130_10
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1052ui_story then
				local var_130_11 = 0.5

				arg_127_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1052ui_story.fillRatio = var_130_11
			end

			local var_130_12 = 0
			local var_130_13 = 0.7

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[42].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(115201031)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 28
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201031", "story_v_out_115201.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_115201", "115201031", "story_v_out_115201.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_115201", "115201031", "story_v_out_115201.awb")

						arg_127_1:RecordAudio("115201031", var_130_21)
						arg_127_1:RecordAudio("115201031", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115201", "115201031", "story_v_out_115201.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115201", "115201031", "story_v_out_115201.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play115201032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115201032
		arg_131_1.duration_ = 20.63

		local var_131_0 = {
			ja = 11.833,
			ko = 15.1,
			zh = 14.833,
			en = 20.633
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
				arg_131_0:Play115201033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1052ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1052ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1052ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["4010ui_story"].transform
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.var_.moveOldPos4010ui_story = var_134_9.localPosition
			end

			local var_134_11 = 0.001

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11
				local var_134_13 = Vector3.New(0, 100, 0)

				var_134_9.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos4010ui_story, var_134_13, var_134_12)

				local var_134_14 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_14.x, var_134_14.y, var_134_14.z)

				local var_134_15 = var_134_9.localEulerAngles

				var_134_15.z = 0
				var_134_15.x = 0
				var_134_9.localEulerAngles = var_134_15
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 then
				var_134_9.localPosition = Vector3.New(0, 100, 0)

				local var_134_16 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_16.x, var_134_16.y, var_134_16.z)

				local var_134_17 = var_134_9.localEulerAngles

				var_134_17.z = 0
				var_134_17.x = 0
				var_134_9.localEulerAngles = var_134_17
			end

			local var_134_18 = arg_131_1.actors_["1024ui_story"].transform
			local var_134_19 = 0

			if var_134_19 < arg_131_1.time_ and arg_131_1.time_ <= var_134_19 + arg_134_0 then
				arg_131_1.var_.moveOldPos1024ui_story = var_134_18.localPosition

				local var_134_20 = "1024ui_story"

				arg_131_1:ShowWeapon(arg_131_1.var_[var_134_20 .. "Animator"].transform, true)
			end

			local var_134_21 = 0.001

			if var_134_19 <= arg_131_1.time_ and arg_131_1.time_ < var_134_19 + var_134_21 then
				local var_134_22 = (arg_131_1.time_ - var_134_19) / var_134_21
				local var_134_23 = Vector3.New(0, -1, -6.05)

				var_134_18.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1024ui_story, var_134_23, var_134_22)

				local var_134_24 = manager.ui.mainCamera.transform.position - var_134_18.position

				var_134_18.forward = Vector3.New(var_134_24.x, var_134_24.y, var_134_24.z)

				local var_134_25 = var_134_18.localEulerAngles

				var_134_25.z = 0
				var_134_25.x = 0
				var_134_18.localEulerAngles = var_134_25
			end

			if arg_131_1.time_ >= var_134_19 + var_134_21 and arg_131_1.time_ < var_134_19 + var_134_21 + arg_134_0 then
				var_134_18.localPosition = Vector3.New(0, -1, -6.05)

				local var_134_26 = manager.ui.mainCamera.transform.position - var_134_18.position

				var_134_18.forward = Vector3.New(var_134_26.x, var_134_26.y, var_134_26.z)

				local var_134_27 = var_134_18.localEulerAngles

				var_134_27.z = 0
				var_134_27.x = 0
				var_134_18.localEulerAngles = var_134_27
			end

			local var_134_28 = 0

			if var_134_28 < arg_131_1.time_ and arg_131_1.time_ <= var_134_28 + arg_134_0 then
				arg_131_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action7_1")
			end

			local var_134_29 = 0

			if var_134_29 < arg_131_1.time_ and arg_131_1.time_ <= var_134_29 + arg_134_0 then
				arg_131_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_134_30 = arg_131_1.actors_["1024ui_story"]
			local var_134_31 = 0

			if var_134_31 < arg_131_1.time_ and arg_131_1.time_ <= var_134_31 + arg_134_0 and not isNil(var_134_30) and arg_131_1.var_.characterEffect1024ui_story == nil then
				arg_131_1.var_.characterEffect1024ui_story = var_134_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_32 = 0.2

			if var_134_31 <= arg_131_1.time_ and arg_131_1.time_ < var_134_31 + var_134_32 and not isNil(var_134_30) then
				local var_134_33 = (arg_131_1.time_ - var_134_31) / var_134_32

				if arg_131_1.var_.characterEffect1024ui_story and not isNil(var_134_30) then
					arg_131_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_31 + var_134_32 and arg_131_1.time_ < var_134_31 + var_134_32 + arg_134_0 and not isNil(var_134_30) and arg_131_1.var_.characterEffect1024ui_story then
				arg_131_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_134_34 = 0
			local var_134_35 = 1.75

			if var_134_34 < arg_131_1.time_ and arg_131_1.time_ <= var_134_34 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_36 = arg_131_1:FormatText(StoryNameCfg[265].name)

				arg_131_1.leftNameTxt_.text = var_134_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_37 = arg_131_1:GetWordFromCfg(115201032)
				local var_134_38 = arg_131_1:FormatText(var_134_37.content)

				arg_131_1.text_.text = var_134_38

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_39 = 70
				local var_134_40 = utf8.len(var_134_38)
				local var_134_41 = var_134_39 <= 0 and var_134_35 or var_134_35 * (var_134_40 / var_134_39)

				if var_134_41 > 0 and var_134_35 < var_134_41 then
					arg_131_1.talkMaxDuration = var_134_41

					if var_134_41 + var_134_34 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_41 + var_134_34
					end
				end

				arg_131_1.text_.text = var_134_38
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201032", "story_v_out_115201.awb") ~= 0 then
					local var_134_42 = manager.audio:GetVoiceLength("story_v_out_115201", "115201032", "story_v_out_115201.awb") / 1000

					if var_134_42 + var_134_34 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_42 + var_134_34
					end

					if var_134_37.prefab_name ~= "" and arg_131_1.actors_[var_134_37.prefab_name] ~= nil then
						local var_134_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_37.prefab_name].transform, "story_v_out_115201", "115201032", "story_v_out_115201.awb")

						arg_131_1:RecordAudio("115201032", var_134_43)
						arg_131_1:RecordAudio("115201032", var_134_43)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_115201", "115201032", "story_v_out_115201.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_115201", "115201032", "story_v_out_115201.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_44 = math.max(var_134_35, arg_131_1.talkMaxDuration)

			if var_134_34 <= arg_131_1.time_ and arg_131_1.time_ < var_134_34 + var_134_44 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_34) / var_134_44

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_34 + var_134_44 and arg_131_1.time_ < var_134_34 + var_134_44 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play115201033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115201033
		arg_135_1.duration_ = 5.73

		local var_135_0 = {
			ja = 5.733,
			ko = 5.433,
			zh = 5.2,
			en = 4.066
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
				arg_135_0:Play115201034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "1035ui_story"

			if arg_135_1.actors_[var_138_0] == nil then
				local var_138_1 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_138_1) then
					local var_138_2 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_135_1.stage_.transform)

					var_138_2.name = var_138_0
					var_138_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_135_1.actors_[var_138_0] = var_138_2

					local var_138_3 = var_138_2:GetComponentInChildren(typeof(CharacterEffect))

					var_138_3.enabled = true

					local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_2, typeof(DynamicBoneHelper))

					if var_138_4 then
						var_138_4:EnableDynamicBone(false)
					end

					arg_135_1:ShowWeapon(var_138_3.transform, false)

					arg_135_1.var_[var_138_0 .. "Animator"] = var_138_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_135_1.var_[var_138_0 .. "Animator"].applyRootMotion = true
					arg_135_1.var_[var_138_0 .. "LipSync"] = var_138_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_138_5 = arg_135_1.actors_["1035ui_story"].transform
			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.var_.moveOldPos1035ui_story = var_138_5.localPosition
			end

			local var_138_7 = 0.001

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_7 then
				local var_138_8 = (arg_135_1.time_ - var_138_6) / var_138_7
				local var_138_9 = Vector3.New(0, -1.05, -5.6)

				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1035ui_story, var_138_9, var_138_8)

				local var_138_10 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_10.x, var_138_10.y, var_138_10.z)

				local var_138_11 = var_138_5.localEulerAngles

				var_138_11.z = 0
				var_138_11.x = 0
				var_138_5.localEulerAngles = var_138_11
			end

			if arg_135_1.time_ >= var_138_6 + var_138_7 and arg_135_1.time_ < var_138_6 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_138_12 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_12.x, var_138_12.y, var_138_12.z)

				local var_138_13 = var_138_5.localEulerAngles

				var_138_13.z = 0
				var_138_13.x = 0
				var_138_5.localEulerAngles = var_138_13
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_138_15 = arg_135_1.actors_["1035ui_story"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.characterEffect1035ui_story == nil then
				arg_135_1.var_.characterEffect1035ui_story = var_138_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_17 = 0.2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.characterEffect1035ui_story and not isNil(var_138_15) then
					arg_135_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.characterEffect1035ui_story then
				arg_135_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_138_19 = arg_135_1.actors_["1024ui_story"].transform
			local var_138_20 = 0

			if var_138_20 < arg_135_1.time_ and arg_135_1.time_ <= var_138_20 + arg_138_0 then
				arg_135_1.var_.moveOldPos1024ui_story = var_138_19.localPosition

				local var_138_21 = "1024ui_story"

				arg_135_1:ShowWeapon(arg_135_1.var_[var_138_21 .. "Animator"].transform, true)
			end

			local var_138_22 = 0.001

			if var_138_20 <= arg_135_1.time_ and arg_135_1.time_ < var_138_20 + var_138_22 then
				local var_138_23 = (arg_135_1.time_ - var_138_20) / var_138_22
				local var_138_24 = Vector3.New(0, 100, 0)

				var_138_19.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1024ui_story, var_138_24, var_138_23)

				local var_138_25 = manager.ui.mainCamera.transform.position - var_138_19.position

				var_138_19.forward = Vector3.New(var_138_25.x, var_138_25.y, var_138_25.z)

				local var_138_26 = var_138_19.localEulerAngles

				var_138_26.z = 0
				var_138_26.x = 0
				var_138_19.localEulerAngles = var_138_26
			end

			if arg_135_1.time_ >= var_138_20 + var_138_22 and arg_135_1.time_ < var_138_20 + var_138_22 + arg_138_0 then
				var_138_19.localPosition = Vector3.New(0, 100, 0)

				local var_138_27 = manager.ui.mainCamera.transform.position - var_138_19.position

				var_138_19.forward = Vector3.New(var_138_27.x, var_138_27.y, var_138_27.z)

				local var_138_28 = var_138_19.localEulerAngles

				var_138_28.z = 0
				var_138_28.x = 0
				var_138_19.localEulerAngles = var_138_28
			end

			local var_138_29 = 0
			local var_138_30 = 0.525

			if var_138_29 < arg_135_1.time_ and arg_135_1.time_ <= var_138_29 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_31 = arg_135_1:FormatText(StoryNameCfg[21].name)

				arg_135_1.leftNameTxt_.text = var_138_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_32 = arg_135_1:GetWordFromCfg(115201033)
				local var_138_33 = arg_135_1:FormatText(var_138_32.content)

				arg_135_1.text_.text = var_138_33

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_34 = 21
				local var_138_35 = utf8.len(var_138_33)
				local var_138_36 = var_138_34 <= 0 and var_138_30 or var_138_30 * (var_138_35 / var_138_34)

				if var_138_36 > 0 and var_138_30 < var_138_36 then
					arg_135_1.talkMaxDuration = var_138_36

					if var_138_36 + var_138_29 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_36 + var_138_29
					end
				end

				arg_135_1.text_.text = var_138_33
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201033", "story_v_out_115201.awb") ~= 0 then
					local var_138_37 = manager.audio:GetVoiceLength("story_v_out_115201", "115201033", "story_v_out_115201.awb") / 1000

					if var_138_37 + var_138_29 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_37 + var_138_29
					end

					if var_138_32.prefab_name ~= "" and arg_135_1.actors_[var_138_32.prefab_name] ~= nil then
						local var_138_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_32.prefab_name].transform, "story_v_out_115201", "115201033", "story_v_out_115201.awb")

						arg_135_1:RecordAudio("115201033", var_138_38)
						arg_135_1:RecordAudio("115201033", var_138_38)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115201", "115201033", "story_v_out_115201.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115201", "115201033", "story_v_out_115201.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_39 = math.max(var_138_30, arg_135_1.talkMaxDuration)

			if var_138_29 <= arg_135_1.time_ and arg_135_1.time_ < var_138_29 + var_138_39 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_29) / var_138_39

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_29 + var_138_39 and arg_135_1.time_ < var_138_29 + var_138_39 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115201034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115201034
		arg_139_1.duration_ = 6.5

		local var_139_0 = {
			ja = 6.5,
			ko = 5.7,
			zh = 5.1,
			en = 6.266
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
				arg_139_0:Play115201035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1035ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1035ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, 100, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1035ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, 100, 0)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = 0
			local var_142_10 = 0.575

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_11 = arg_139_1:FormatText(StoryNameCfg[273].name)

				arg_139_1.leftNameTxt_.text = var_142_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_12 = arg_139_1:GetWordFromCfg(115201034)
				local var_142_13 = arg_139_1:FormatText(var_142_12.content)

				arg_139_1.text_.text = var_142_13

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_14 = 23
				local var_142_15 = utf8.len(var_142_13)
				local var_142_16 = var_142_14 <= 0 and var_142_10 or var_142_10 * (var_142_15 / var_142_14)

				if var_142_16 > 0 and var_142_10 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_9 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_9
					end
				end

				arg_139_1.text_.text = var_142_13
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201034", "story_v_out_115201.awb") ~= 0 then
					local var_142_17 = manager.audio:GetVoiceLength("story_v_out_115201", "115201034", "story_v_out_115201.awb") / 1000

					if var_142_17 + var_142_9 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_9
					end

					if var_142_12.prefab_name ~= "" and arg_139_1.actors_[var_142_12.prefab_name] ~= nil then
						local var_142_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_12.prefab_name].transform, "story_v_out_115201", "115201034", "story_v_out_115201.awb")

						arg_139_1:RecordAudio("115201034", var_142_18)
						arg_139_1:RecordAudio("115201034", var_142_18)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115201", "115201034", "story_v_out_115201.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115201", "115201034", "story_v_out_115201.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = math.max(var_142_10, arg_139_1.talkMaxDuration)

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_19 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_9) / var_142_19

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_9 + var_142_19 and arg_139_1.time_ < var_142_9 + var_142_19 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115201035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115201035
		arg_143_1.duration_ = 16.3

		local var_143_0 = {
			ja = 15.8,
			ko = 14.8,
			zh = 13.2,
			en = 16.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115201036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["4010ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos4010ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -1.59, -5.2)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos4010ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_146_11 = arg_143_1.actors_["4010ui_story"]
			local var_146_12 = 0

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect4010ui_story == nil then
				arg_143_1.var_.characterEffect4010ui_story = var_146_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_13 = 0.2

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_13 and not isNil(var_146_11) then
				local var_146_14 = (arg_143_1.time_ - var_146_12) / var_146_13

				if arg_143_1.var_.characterEffect4010ui_story and not isNil(var_146_11) then
					arg_143_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_12 + var_146_13 and arg_143_1.time_ < var_146_12 + var_146_13 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect4010ui_story then
				arg_143_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_146_15 = 0
			local var_146_16 = 1.175

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_17 = arg_143_1:FormatText(StoryNameCfg[42].name)

				arg_143_1.leftNameTxt_.text = var_146_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_18 = arg_143_1:GetWordFromCfg(115201035)
				local var_146_19 = arg_143_1:FormatText(var_146_18.content)

				arg_143_1.text_.text = var_146_19

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 47
				local var_146_21 = utf8.len(var_146_19)
				local var_146_22 = var_146_20 <= 0 and var_146_16 or var_146_16 * (var_146_21 / var_146_20)

				if var_146_22 > 0 and var_146_16 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22

					if var_146_22 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_19
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201035", "story_v_out_115201.awb") ~= 0 then
					local var_146_23 = manager.audio:GetVoiceLength("story_v_out_115201", "115201035", "story_v_out_115201.awb") / 1000

					if var_146_23 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_23 + var_146_15
					end

					if var_146_18.prefab_name ~= "" and arg_143_1.actors_[var_146_18.prefab_name] ~= nil then
						local var_146_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_18.prefab_name].transform, "story_v_out_115201", "115201035", "story_v_out_115201.awb")

						arg_143_1:RecordAudio("115201035", var_146_24)
						arg_143_1:RecordAudio("115201035", var_146_24)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115201", "115201035", "story_v_out_115201.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115201", "115201035", "story_v_out_115201.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_25 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_25 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_25

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_25 and arg_143_1.time_ < var_146_15 + var_146_25 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115201036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115201036
		arg_147_1.duration_ = 6.07

		local var_147_0 = {
			ja = 6.066,
			ko = 4.033,
			zh = 3.6,
			en = 3.6
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115201037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_150_2 = 0
			local var_150_3 = 0.4

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_4 = arg_147_1:FormatText(StoryNameCfg[42].name)

				arg_147_1.leftNameTxt_.text = var_150_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_5 = arg_147_1:GetWordFromCfg(115201036)
				local var_150_6 = arg_147_1:FormatText(var_150_5.content)

				arg_147_1.text_.text = var_150_6

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 17
				local var_150_8 = utf8.len(var_150_6)
				local var_150_9 = var_150_7 <= 0 and var_150_3 or var_150_3 * (var_150_8 / var_150_7)

				if var_150_9 > 0 and var_150_3 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_6
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201036", "story_v_out_115201.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201036", "story_v_out_115201.awb") / 1000

					if var_150_10 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_2
					end

					if var_150_5.prefab_name ~= "" and arg_147_1.actors_[var_150_5.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_5.prefab_name].transform, "story_v_out_115201", "115201036", "story_v_out_115201.awb")

						arg_147_1:RecordAudio("115201036", var_150_11)
						arg_147_1:RecordAudio("115201036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115201", "115201036", "story_v_out_115201.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115201", "115201036", "story_v_out_115201.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_12 and arg_147_1.time_ < var_150_2 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115201037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115201037
		arg_151_1.duration_ = 2.1

		local var_151_0 = {
			ja = 1.633,
			ko = 1.266,
			zh = 1.6,
			en = 2.1
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115201038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["4010ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect4010ui_story == nil then
				arg_151_1.var_.characterEffect4010ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect4010ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_151_1.var_.characterEffect4010ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect4010ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_151_1.var_.characterEffect4010ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.05

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[260].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(115201037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 2
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201037", "story_v_out_115201.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201037", "story_v_out_115201.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_115201", "115201037", "story_v_out_115201.awb")

						arg_151_1:RecordAudio("115201037", var_154_15)
						arg_151_1:RecordAudio("115201037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115201", "115201037", "story_v_out_115201.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115201", "115201037", "story_v_out_115201.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115201038
		arg_155_1.duration_ = 10.2

		local var_155_0 = {
			ja = 9,
			ko = 6.5,
			zh = 6.433,
			en = 10.2
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
				arg_155_0:Play115201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_158_2 = arg_155_1.actors_["4010ui_story"]
			local var_158_3 = 0

			if var_158_3 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect4010ui_story == nil then
				arg_155_1.var_.characterEffect4010ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.2

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_4 and not isNil(var_158_2) then
				local var_158_5 = (arg_155_1.time_ - var_158_3) / var_158_4

				if arg_155_1.var_.characterEffect4010ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_3 + var_158_4 and arg_155_1.time_ < var_158_3 + var_158_4 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect4010ui_story then
				arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_158_6 = 0
			local var_158_7 = 0.8

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[42].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(115201038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 32
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201038", "story_v_out_115201.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201038", "story_v_out_115201.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_115201", "115201038", "story_v_out_115201.awb")

						arg_155_1:RecordAudio("115201038", var_158_15)
						arg_155_1:RecordAudio("115201038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115201", "115201038", "story_v_out_115201.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115201", "115201038", "story_v_out_115201.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115201039
		arg_159_1.duration_ = 8.67

		local var_159_0 = {
			ja = 6.1,
			ko = 8.666,
			zh = 5.833,
			en = 7.4
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_162_1 = 0
			local var_162_2 = 0.8

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_3 = arg_159_1:FormatText(StoryNameCfg[42].name)

				arg_159_1.leftNameTxt_.text = var_162_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(115201039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 32
				local var_162_7 = utf8.len(var_162_5)
				local var_162_8 = var_162_6 <= 0 and var_162_2 or var_162_2 * (var_162_7 / var_162_6)

				if var_162_8 > 0 and var_162_2 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201039", "story_v_out_115201.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201039", "story_v_out_115201.awb") / 1000

					if var_162_9 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_1
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_115201", "115201039", "story_v_out_115201.awb")

						arg_159_1:RecordAudio("115201039", var_162_10)
						arg_159_1:RecordAudio("115201039", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115201", "115201039", "story_v_out_115201.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115201", "115201039", "story_v_out_115201.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_11 and arg_159_1.time_ < var_162_1 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115201040
		arg_163_1.duration_ = 6.13

		local var_163_0 = {
			ja = 2.9,
			ko = 6.133,
			zh = 5.133,
			en = 5.8
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
				arg_163_0:Play115201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["4010ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos4010ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4010ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0
			local var_166_10 = 0.625

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_11 = arg_163_1:FormatText(StoryNameCfg[261].name)

				arg_163_1.leftNameTxt_.text = var_166_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_12 = arg_163_1:GetWordFromCfg(115201040)
				local var_166_13 = arg_163_1:FormatText(var_166_12.content)

				arg_163_1.text_.text = var_166_13

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_14 = 25
				local var_166_15 = utf8.len(var_166_13)
				local var_166_16 = var_166_14 <= 0 and var_166_10 or var_166_10 * (var_166_15 / var_166_14)

				if var_166_16 > 0 and var_166_10 < var_166_16 then
					arg_163_1.talkMaxDuration = var_166_16

					if var_166_16 + var_166_9 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_9
					end
				end

				arg_163_1.text_.text = var_166_13
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201040", "story_v_out_115201.awb") ~= 0 then
					local var_166_17 = manager.audio:GetVoiceLength("story_v_out_115201", "115201040", "story_v_out_115201.awb") / 1000

					if var_166_17 + var_166_9 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_9
					end

					if var_166_12.prefab_name ~= "" and arg_163_1.actors_[var_166_12.prefab_name] ~= nil then
						local var_166_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_12.prefab_name].transform, "story_v_out_115201", "115201040", "story_v_out_115201.awb")

						arg_163_1:RecordAudio("115201040", var_166_18)
						arg_163_1:RecordAudio("115201040", var_166_18)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115201", "115201040", "story_v_out_115201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115201", "115201040", "story_v_out_115201.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_19 = math.max(var_166_10, arg_163_1.talkMaxDuration)

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_19 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_9) / var_166_19

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_9 + var_166_19 and arg_163_1.time_ < var_166_9 + var_166_19 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play115201041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115201041
		arg_167_1.duration_ = 4.7

		local var_167_0 = {
			ja = 4.7,
			ko = 3.3,
			zh = 3.766,
			en = 4.166
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
				arg_167_0:Play115201042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.35

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[262].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(115201041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201041", "story_v_out_115201.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201041", "story_v_out_115201.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_115201", "115201041", "story_v_out_115201.awb")

						arg_167_1:RecordAudio("115201041", var_170_9)
						arg_167_1:RecordAudio("115201041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115201", "115201041", "story_v_out_115201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115201", "115201041", "story_v_out_115201.awb")
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
	Play115201042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115201042
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			ja = 4.9,
			ko = 6.433,
			zh = 5.1,
			en = 7.9
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
				arg_171_0:Play115201043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1035ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1035ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -1.05, -5.6)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1035ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_174_10 = arg_171_1.actors_["1035ui_story"]
			local var_174_11 = 0

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 and not isNil(var_174_10) and arg_171_1.var_.characterEffect1035ui_story == nil then
				arg_171_1.var_.characterEffect1035ui_story = var_174_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_12 = 0.2

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_12 and not isNil(var_174_10) then
				local var_174_13 = (arg_171_1.time_ - var_174_11) / var_174_12

				if arg_171_1.var_.characterEffect1035ui_story and not isNil(var_174_10) then
					arg_171_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_11 + var_174_12 and arg_171_1.time_ < var_174_11 + var_174_12 + arg_174_0 and not isNil(var_174_10) and arg_171_1.var_.characterEffect1035ui_story then
				arg_171_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_174_14 = 0
			local var_174_15 = 0.575

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_16 = arg_171_1:FormatText(StoryNameCfg[21].name)

				arg_171_1.leftNameTxt_.text = var_174_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_17 = arg_171_1:GetWordFromCfg(115201042)
				local var_174_18 = arg_171_1:FormatText(var_174_17.content)

				arg_171_1.text_.text = var_174_18

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_19 = 23
				local var_174_20 = utf8.len(var_174_18)
				local var_174_21 = var_174_19 <= 0 and var_174_15 or var_174_15 * (var_174_20 / var_174_19)

				if var_174_21 > 0 and var_174_15 < var_174_21 then
					arg_171_1.talkMaxDuration = var_174_21

					if var_174_21 + var_174_14 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_21 + var_174_14
					end
				end

				arg_171_1.text_.text = var_174_18
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201042", "story_v_out_115201.awb") ~= 0 then
					local var_174_22 = manager.audio:GetVoiceLength("story_v_out_115201", "115201042", "story_v_out_115201.awb") / 1000

					if var_174_22 + var_174_14 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_14
					end

					if var_174_17.prefab_name ~= "" and arg_171_1.actors_[var_174_17.prefab_name] ~= nil then
						local var_174_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_17.prefab_name].transform, "story_v_out_115201", "115201042", "story_v_out_115201.awb")

						arg_171_1:RecordAudio("115201042", var_174_23)
						arg_171_1:RecordAudio("115201042", var_174_23)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115201", "115201042", "story_v_out_115201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115201", "115201042", "story_v_out_115201.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_24 = math.max(var_174_15, arg_171_1.talkMaxDuration)

			if var_174_14 <= arg_171_1.time_ and arg_171_1.time_ < var_174_14 + var_174_24 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_14) / var_174_24

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_14 + var_174_24 and arg_171_1.time_ < var_174_14 + var_174_24 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play115201043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115201043
		arg_175_1.duration_ = 1.6

		local var_175_0 = {
			ja = 1.6,
			ko = 1.2,
			zh = 1.433,
			en = 1.4
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
				arg_175_0:Play115201044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1035ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1035ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1035ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = 0
			local var_178_10 = 0.125

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_11 = arg_175_1:FormatText(StoryNameCfg[263].name)

				arg_175_1.leftNameTxt_.text = var_178_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_12 = arg_175_1:GetWordFromCfg(115201043)
				local var_178_13 = arg_175_1:FormatText(var_178_12.content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_14 = 5
				local var_178_15 = utf8.len(var_178_13)
				local var_178_16 = var_178_14 <= 0 and var_178_10 or var_178_10 * (var_178_15 / var_178_14)

				if var_178_16 > 0 and var_178_10 < var_178_16 then
					arg_175_1.talkMaxDuration = var_178_16

					if var_178_16 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_16 + var_178_9
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201043", "story_v_out_115201.awb") ~= 0 then
					local var_178_17 = manager.audio:GetVoiceLength("story_v_out_115201", "115201043", "story_v_out_115201.awb") / 1000

					if var_178_17 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_9
					end

					if var_178_12.prefab_name ~= "" and arg_175_1.actors_[var_178_12.prefab_name] ~= nil then
						local var_178_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_12.prefab_name].transform, "story_v_out_115201", "115201043", "story_v_out_115201.awb")

						arg_175_1:RecordAudio("115201043", var_178_18)
						arg_175_1:RecordAudio("115201043", var_178_18)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115201", "115201043", "story_v_out_115201.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115201", "115201043", "story_v_out_115201.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_19 = math.max(var_178_10, arg_175_1.talkMaxDuration)

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_19 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_9) / var_178_19

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_9 + var_178_19 and arg_175_1.time_ < var_178_9 + var_178_19 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play115201044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115201044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play115201045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.85

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(115201044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 34
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115201045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115201045
		arg_183_1.duration_ = 15.33

		local var_183_0 = {
			ja = 15.333,
			ko = 9.433,
			zh = 7.566,
			en = 8.366
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
				arg_183_0:Play115201046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_1 = 2

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_1 then
				local var_186_2 = (arg_183_1.time_ - var_186_0) / var_186_1
				local var_186_3 = Color.New(0, 0, 0)

				var_186_3.a = Mathf.Lerp(0, 1, var_186_2)
				arg_183_1.mask_.color = var_186_3
			end

			if arg_183_1.time_ >= var_186_0 + var_186_1 and arg_183_1.time_ < var_186_0 + var_186_1 + arg_186_0 then
				local var_186_4 = Color.New(0, 0, 0)

				var_186_4.a = 1
				arg_183_1.mask_.color = var_186_4
			end

			local var_186_5 = 2

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_6 = 2

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 then
				local var_186_7 = (arg_183_1.time_ - var_186_5) / var_186_6
				local var_186_8 = Color.New(0, 0, 0)

				var_186_8.a = Mathf.Lerp(1, 0, var_186_7)
				arg_183_1.mask_.color = var_186_8
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 then
				local var_186_9 = Color.New(0, 0, 0)
				local var_186_10 = 0

				arg_183_1.mask_.enabled = false
				var_186_9.a = var_186_10
				arg_183_1.mask_.color = var_186_9
			end

			local var_186_11 = "RO0206"

			if arg_183_1.bgs_[var_186_11] == nil then
				local var_186_12 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_11)
				var_186_12.name = var_186_11
				var_186_12.transform.parent = arg_183_1.stage_.transform
				var_186_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_11] = var_186_12
			end

			local var_186_13 = 2

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				local var_186_14 = manager.ui.mainCamera.transform.localPosition
				local var_186_15 = Vector3.New(0, 0, 10) + Vector3.New(var_186_14.x, var_186_14.y, 0)
				local var_186_16 = arg_183_1.bgs_.RO0206

				var_186_16.transform.localPosition = var_186_15
				var_186_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_17 = var_186_16:GetComponent("SpriteRenderer")

				if var_186_17 and var_186_17.sprite then
					local var_186_18 = (var_186_16.transform.localPosition - var_186_14).z
					local var_186_19 = manager.ui.mainCameraCom_
					local var_186_20 = 2 * var_186_18 * Mathf.Tan(var_186_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_21 = var_186_20 * var_186_19.aspect
					local var_186_22 = var_186_17.sprite.bounds.size.x
					local var_186_23 = var_186_17.sprite.bounds.size.y
					local var_186_24 = var_186_21 / var_186_22
					local var_186_25 = var_186_20 / var_186_23
					local var_186_26 = var_186_25 < var_186_24 and var_186_24 or var_186_25

					var_186_16.transform.localScale = Vector3.New(var_186_26, var_186_26, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "RO0206" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_27 = arg_183_1.bgs_.RO0206.transform
			local var_186_28 = 2

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 then
				arg_183_1.var_.moveOldPosRO0206 = var_186_27.localPosition
			end

			local var_186_29 = 0.001

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_29 then
				local var_186_30 = (arg_183_1.time_ - var_186_28) / var_186_29
				local var_186_31 = Vector3.New(3, 1.65, 4.9)

				var_186_27.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosRO0206, var_186_31, var_186_30)
			end

			if arg_183_1.time_ >= var_186_28 + var_186_29 and arg_183_1.time_ < var_186_28 + var_186_29 + arg_186_0 then
				var_186_27.localPosition = Vector3.New(3, 1.65, 4.9)
			end

			local var_186_32 = arg_183_1.bgs_.RO0206.transform
			local var_186_33 = 2.01666666666667

			if var_186_33 < arg_183_1.time_ and arg_183_1.time_ <= var_186_33 + arg_186_0 then
				arg_183_1.var_.moveOldPosRO0206 = var_186_32.localPosition
			end

			local var_186_34 = 5

			if var_186_33 <= arg_183_1.time_ and arg_183_1.time_ < var_186_33 + var_186_34 then
				local var_186_35 = (arg_183_1.time_ - var_186_33) / var_186_34
				local var_186_36 = Vector3.New(2.5, 1.65, 4.9)

				var_186_32.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosRO0206, var_186_36, var_186_35)
			end

			if arg_183_1.time_ >= var_186_33 + var_186_34 and arg_183_1.time_ < var_186_33 + var_186_34 + arg_186_0 then
				var_186_32.localPosition = Vector3.New(2.5, 1.65, 4.9)
			end

			local var_186_37 = 4

			if var_186_37 < arg_183_1.time_ and arg_183_1.time_ <= var_186_37 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_38 = 3.01666666666667

			if arg_183_1.time_ >= var_186_37 + var_186_38 and arg_183_1.time_ < var_186_37 + var_186_38 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_39 = 4
			local var_186_40 = 0.425

			if var_186_39 < arg_183_1.time_ and arg_183_1.time_ <= var_186_39 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_41 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_41:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_42 = arg_183_1:FormatText(StoryNameCfg[260].name)

				arg_183_1.leftNameTxt_.text = var_186_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_43 = arg_183_1:GetWordFromCfg(115201045)
				local var_186_44 = arg_183_1:FormatText(var_186_43.content)

				arg_183_1.text_.text = var_186_44

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_45 = 17
				local var_186_46 = utf8.len(var_186_44)
				local var_186_47 = var_186_45 <= 0 and var_186_40 or var_186_40 * (var_186_46 / var_186_45)

				if var_186_47 > 0 and var_186_40 < var_186_47 then
					arg_183_1.talkMaxDuration = var_186_47
					var_186_39 = var_186_39 + 0.3

					if var_186_47 + var_186_39 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_47 + var_186_39
					end
				end

				arg_183_1.text_.text = var_186_44
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201045", "story_v_out_115201.awb") ~= 0 then
					local var_186_48 = manager.audio:GetVoiceLength("story_v_out_115201", "115201045", "story_v_out_115201.awb") / 1000

					if var_186_48 + var_186_39 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_48 + var_186_39
					end

					if var_186_43.prefab_name ~= "" and arg_183_1.actors_[var_186_43.prefab_name] ~= nil then
						local var_186_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_43.prefab_name].transform, "story_v_out_115201", "115201045", "story_v_out_115201.awb")

						arg_183_1:RecordAudio("115201045", var_186_49)
						arg_183_1:RecordAudio("115201045", var_186_49)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115201", "115201045", "story_v_out_115201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115201", "115201045", "story_v_out_115201.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_50 = var_186_39 + 0.3
			local var_186_51 = math.max(var_186_40, arg_183_1.talkMaxDuration)

			if var_186_50 <= arg_183_1.time_ and arg_183_1.time_ < var_186_50 + var_186_51 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_50) / var_186_51

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_50 + var_186_51 and arg_183_1.time_ < var_186_50 + var_186_51 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play115201046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 115201046
		arg_189_1.duration_ = 1.47

		local var_189_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.466,
			en = 1.233
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
				arg_189_0:Play115201047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[263].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(115201046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201046", "story_v_out_115201.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201046", "story_v_out_115201.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_115201", "115201046", "story_v_out_115201.awb")

						arg_189_1:RecordAudio("115201046", var_192_9)
						arg_189_1:RecordAudio("115201046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_115201", "115201046", "story_v_out_115201.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_115201", "115201046", "story_v_out_115201.awb")
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
	Play115201047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 115201047
		arg_193_1.duration_ = 11.37

		local var_193_0 = {
			ja = 11.366,
			ko = 8.3,
			zh = 9.233,
			en = 7.433
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
				arg_193_0:Play115201048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.025

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[260].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(115201047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201047", "story_v_out_115201.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201047", "story_v_out_115201.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_115201", "115201047", "story_v_out_115201.awb")

						arg_193_1:RecordAudio("115201047", var_196_9)
						arg_193_1:RecordAudio("115201047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_115201", "115201047", "story_v_out_115201.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_115201", "115201047", "story_v_out_115201.awb")
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
	Play115201048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 115201048
		arg_197_1.duration_ = 2.8

		local var_197_0 = {
			ja = 2.8,
			ko = 2.466,
			zh = 2.6,
			en = 1.2
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
				arg_197_0:Play115201049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.3

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[263].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(115201048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201048", "story_v_out_115201.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201048", "story_v_out_115201.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_115201", "115201048", "story_v_out_115201.awb")

						arg_197_1:RecordAudio("115201048", var_200_9)
						arg_197_1:RecordAudio("115201048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_115201", "115201048", "story_v_out_115201.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_115201", "115201048", "story_v_out_115201.awb")
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
	Play115201049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 115201049
		arg_201_1.duration_ = 1.5

		local var_201_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.5,
			en = 1.033
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
				arg_201_0:Play115201050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.075

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[260].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(115201049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201049", "story_v_out_115201.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201049", "story_v_out_115201.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_115201", "115201049", "story_v_out_115201.awb")

						arg_201_1:RecordAudio("115201049", var_204_9)
						arg_201_1:RecordAudio("115201049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_115201", "115201049", "story_v_out_115201.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_115201", "115201049", "story_v_out_115201.awb")
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
	Play115201050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 115201050
		arg_205_1.duration_ = 5.67

		local var_205_0 = {
			ja = 5.4,
			ko = 3.866,
			zh = 5.666,
			en = 3.133
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
				arg_205_0:Play115201051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.7

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[260].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(115201050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 28
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201050", "story_v_out_115201.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201050", "story_v_out_115201.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_115201", "115201050", "story_v_out_115201.awb")

						arg_205_1:RecordAudio("115201050", var_208_9)
						arg_205_1:RecordAudio("115201050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_115201", "115201050", "story_v_out_115201.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_115201", "115201050", "story_v_out_115201.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play115201051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 115201051
		arg_209_1.duration_ = 15.07

		local var_209_0 = {
			ja = 10.666,
			ko = 12.033,
			zh = 15.066,
			en = 13.466
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
				arg_209_0:Play115201052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.6

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[260].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(115201051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 64
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201051", "story_v_out_115201.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201051", "story_v_out_115201.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_115201", "115201051", "story_v_out_115201.awb")

						arg_209_1:RecordAudio("115201051", var_212_9)
						arg_209_1:RecordAudio("115201051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_115201", "115201051", "story_v_out_115201.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_115201", "115201051", "story_v_out_115201.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play115201052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 115201052
		arg_213_1.duration_ = 13.73

		local var_213_0 = {
			ja = 13.733,
			ko = 11.2,
			zh = 10.533,
			en = 11.3
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
				arg_213_0:Play115201053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.1

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[260].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(115201052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201052", "story_v_out_115201.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201052", "story_v_out_115201.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_115201", "115201052", "story_v_out_115201.awb")

						arg_213_1:RecordAudio("115201052", var_216_9)
						arg_213_1:RecordAudio("115201052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_115201", "115201052", "story_v_out_115201.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_115201", "115201052", "story_v_out_115201.awb")
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
	Play115201053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 115201053
		arg_217_1.duration_ = 11.63

		local var_217_0 = {
			ja = 11.633,
			ko = 3.533,
			zh = 4.933,
			en = 4.733
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
				arg_217_0:Play115201054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.575

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[260].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(115201053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 23
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201053", "story_v_out_115201.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201053", "story_v_out_115201.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_115201", "115201053", "story_v_out_115201.awb")

						arg_217_1:RecordAudio("115201053", var_220_9)
						arg_217_1:RecordAudio("115201053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_115201", "115201053", "story_v_out_115201.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_115201", "115201053", "story_v_out_115201.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play115201054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 115201054
		arg_221_1.duration_ = 13.7

		local var_221_0 = {
			ja = 13.7,
			ko = 7.433,
			zh = 7.266,
			en = 7.8
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
				arg_221_0:Play115201055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.85

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[260].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(115201054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 34
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201054", "story_v_out_115201.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201054", "story_v_out_115201.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_115201", "115201054", "story_v_out_115201.awb")

						arg_221_1:RecordAudio("115201054", var_224_9)
						arg_221_1:RecordAudio("115201054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_115201", "115201054", "story_v_out_115201.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_115201", "115201054", "story_v_out_115201.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play115201055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 115201055
		arg_225_1.duration_ = 4.1

		local var_225_0 = {
			ja = 4.1,
			ko = 1.833,
			zh = 1.3,
			en = 1.533
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
				arg_225_0:Play115201056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.1

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[42].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(115201055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 4
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201055", "story_v_out_115201.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201055", "story_v_out_115201.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_115201", "115201055", "story_v_out_115201.awb")

						arg_225_1:RecordAudio("115201055", var_228_9)
						arg_225_1:RecordAudio("115201055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_115201", "115201055", "story_v_out_115201.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_115201", "115201055", "story_v_out_115201.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play115201056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 115201056
		arg_229_1.duration_ = 1.73

		local var_229_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 1.4,
			en = 1.733
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
				arg_229_0:Play115201057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.05

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[263].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(115201056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 2
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201056", "story_v_out_115201.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201056", "story_v_out_115201.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_115201", "115201056", "story_v_out_115201.awb")

						arg_229_1:RecordAudio("115201056", var_232_9)
						arg_229_1:RecordAudio("115201056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_115201", "115201056", "story_v_out_115201.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_115201", "115201056", "story_v_out_115201.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play115201057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 115201057
		arg_233_1.duration_ = 7

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play115201058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.bgs_.RO0206
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				local var_236_2 = var_236_0:GetComponent("SpriteRenderer")

				if var_236_2 then
					arg_233_1.var_.alphaOldValueRO0206 = var_236_2.color.a
					arg_233_1.var_.alphaMatValueRO0206 = var_236_2
				end

				arg_233_1.var_.alphaOldValueRO0206 = 1
			end

			local var_236_3 = 2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Mathf.Lerp(arg_233_1.var_.alphaOldValueRO0206, 0, var_236_4)

				if arg_233_1.var_.alphaMatValueRO0206 then
					local var_236_6 = arg_233_1.var_.alphaMatValueRO0206.color

					var_236_6.a = var_236_5
					arg_233_1.var_.alphaMatValueRO0206.color = var_236_6
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 and arg_233_1.var_.alphaMatValueRO0206 then
				local var_236_7 = arg_233_1.var_.alphaMatValueRO0206
				local var_236_8 = var_236_7.color

				var_236_8.a = 0
				var_236_7.color = var_236_8
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_9 = 2
			local var_236_10 = 1.2

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_11 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_11:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_12 = arg_233_1:GetWordFromCfg(115201057)
				local var_236_13 = arg_233_1:FormatText(var_236_12.content)

				arg_233_1.text_.text = var_236_13

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_14 = 48
				local var_236_15 = utf8.len(var_236_13)
				local var_236_16 = var_236_14 <= 0 and var_236_10 or var_236_10 * (var_236_15 / var_236_14)

				if var_236_16 > 0 and var_236_10 < var_236_16 then
					arg_233_1.talkMaxDuration = var_236_16
					var_236_9 = var_236_9 + 0.3

					if var_236_16 + var_236_9 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_9
					end
				end

				arg_233_1.text_.text = var_236_13
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = var_236_9 + 0.3
			local var_236_18 = math.max(var_236_10, arg_233_1.talkMaxDuration)

			if var_236_17 <= arg_233_1.time_ and arg_233_1.time_ < var_236_17 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_17) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_17 + var_236_18 and arg_233_1.time_ < var_236_17 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play115201058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115201058
		arg_239_1.duration_ = 6.1

		local var_239_0 = {
			ja = 5.8,
			ko = 6.1,
			zh = 5.4,
			en = 4.6
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
				arg_239_0:Play115201059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.bgs_.RO0206
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				local var_242_2 = var_242_0:GetComponent("SpriteRenderer")

				if var_242_2 then
					arg_239_1.var_.alphaOldValueRO0206 = var_242_2.color.a
					arg_239_1.var_.alphaMatValueRO0206 = var_242_2
				end

				arg_239_1.var_.alphaOldValueRO0206 = 0
			end

			local var_242_3 = 2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_3 then
				local var_242_4 = (arg_239_1.time_ - var_242_1) / var_242_3
				local var_242_5 = Mathf.Lerp(arg_239_1.var_.alphaOldValueRO0206, 1, var_242_4)

				if arg_239_1.var_.alphaMatValueRO0206 then
					local var_242_6 = arg_239_1.var_.alphaMatValueRO0206.color

					var_242_6.a = var_242_5
					arg_239_1.var_.alphaMatValueRO0206.color = var_242_6
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_3 and arg_239_1.time_ < var_242_1 + var_242_3 + arg_242_0 and arg_239_1.var_.alphaMatValueRO0206 then
				local var_242_7 = arg_239_1.var_.alphaMatValueRO0206
				local var_242_8 = var_242_7.color

				var_242_8.a = 1
				var_242_7.color = var_242_8
			end

			local var_242_9 = 2
			local var_242_10 = 0.225

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_11 = arg_239_1:FormatText(StoryNameCfg[263].name)

				arg_239_1.leftNameTxt_.text = var_242_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_12 = arg_239_1:GetWordFromCfg(115201058)
				local var_242_13 = arg_239_1:FormatText(var_242_12.content)

				arg_239_1.text_.text = var_242_13

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_14 = 9
				local var_242_15 = utf8.len(var_242_13)
				local var_242_16 = var_242_14 <= 0 and var_242_10 or var_242_10 * (var_242_15 / var_242_14)

				if var_242_16 > 0 and var_242_10 < var_242_16 then
					arg_239_1.talkMaxDuration = var_242_16

					if var_242_16 + var_242_9 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_16 + var_242_9
					end
				end

				arg_239_1.text_.text = var_242_13
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201058", "story_v_out_115201.awb") ~= 0 then
					local var_242_17 = manager.audio:GetVoiceLength("story_v_out_115201", "115201058", "story_v_out_115201.awb") / 1000

					if var_242_17 + var_242_9 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_17 + var_242_9
					end

					if var_242_12.prefab_name ~= "" and arg_239_1.actors_[var_242_12.prefab_name] ~= nil then
						local var_242_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_12.prefab_name].transform, "story_v_out_115201", "115201058", "story_v_out_115201.awb")

						arg_239_1:RecordAudio("115201058", var_242_18)
						arg_239_1:RecordAudio("115201058", var_242_18)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115201", "115201058", "story_v_out_115201.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115201", "115201058", "story_v_out_115201.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_19 = math.max(var_242_10, arg_239_1.talkMaxDuration)

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_19 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_9) / var_242_19

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_9 + var_242_19 and arg_239_1.time_ < var_242_9 + var_242_19 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play115201059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115201059
		arg_243_1.duration_ = 3.87

		local var_243_0 = {
			ja = 1.4,
			ko = 2.9,
			zh = 3.866,
			en = 2.8
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
				arg_243_0:Play115201060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.2

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[260].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:GetWordFromCfg(115201059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 8
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201059", "story_v_out_115201.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201059", "story_v_out_115201.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_115201", "115201059", "story_v_out_115201.awb")

						arg_243_1:RecordAudio("115201059", var_246_9)
						arg_243_1:RecordAudio("115201059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115201", "115201059", "story_v_out_115201.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115201", "115201059", "story_v_out_115201.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115201060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115201060
		arg_247_1.duration_ = 18.37

		local var_247_0 = {
			ja = 13.933,
			ko = 18.366,
			zh = 15.566,
			en = 15.5
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
				arg_247_0:Play115201061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.35

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[263].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(115201060)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 54
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201060", "story_v_out_115201.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201060", "story_v_out_115201.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_115201", "115201060", "story_v_out_115201.awb")

						arg_247_1:RecordAudio("115201060", var_250_9)
						arg_247_1:RecordAudio("115201060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115201", "115201060", "story_v_out_115201.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115201", "115201060", "story_v_out_115201.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play115201061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115201061
		arg_251_1.duration_ = 2.4

		local var_251_0 = {
			ja = 1.133,
			ko = 2.333,
			zh = 2.4,
			en = 2.266
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
				arg_251_0:Play115201062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.2

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[260].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(115201061)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201061", "story_v_out_115201.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201061", "story_v_out_115201.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_115201", "115201061", "story_v_out_115201.awb")

						arg_251_1:RecordAudio("115201061", var_254_9)
						arg_251_1:RecordAudio("115201061", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_115201", "115201061", "story_v_out_115201.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_115201", "115201061", "story_v_out_115201.awb")
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
	Play115201062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115201062
		arg_255_1.duration_ = 13.17

		local var_255_0 = {
			ja = 13.166,
			ko = 11.466,
			zh = 10,
			en = 11.833
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
				arg_255_0:Play115201063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.925

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[263].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(115201062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201062", "story_v_out_115201.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201062", "story_v_out_115201.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_115201", "115201062", "story_v_out_115201.awb")

						arg_255_1:RecordAudio("115201062", var_258_9)
						arg_255_1:RecordAudio("115201062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_115201", "115201062", "story_v_out_115201.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_115201", "115201062", "story_v_out_115201.awb")
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
	Play115201063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115201063
		arg_259_1.duration_ = 14.3

		local var_259_0 = {
			ja = 14.3,
			ko = 10.8,
			zh = 11.3,
			en = 10.866
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
				arg_259_0:Play115201064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 1.1

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[263].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(115201063)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201063", "story_v_out_115201.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201063", "story_v_out_115201.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_115201", "115201063", "story_v_out_115201.awb")

						arg_259_1:RecordAudio("115201063", var_262_9)
						arg_259_1:RecordAudio("115201063", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115201", "115201063", "story_v_out_115201.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115201", "115201063", "story_v_out_115201.awb")
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
	Play115201064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115201064
		arg_263_1.duration_ = 5.07

		local var_263_0 = {
			ja = 5,
			ko = 4,
			zh = 3.833,
			en = 5.066
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
				arg_263_0:Play115201065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.3

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[263].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(115201064)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201064", "story_v_out_115201.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201064", "story_v_out_115201.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_115201", "115201064", "story_v_out_115201.awb")

						arg_263_1:RecordAudio("115201064", var_266_9)
						arg_263_1:RecordAudio("115201064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_115201", "115201064", "story_v_out_115201.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_115201", "115201064", "story_v_out_115201.awb")
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
	Play115201065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115201065
		arg_267_1.duration_ = 1.5

		local var_267_0 = {
			ja = 1.233,
			ko = 0.999999999999,
			zh = 1.5,
			en = 1.5
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play115201066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.05

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[260].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(115201065)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201065", "story_v_out_115201.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201065", "story_v_out_115201.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_115201", "115201065", "story_v_out_115201.awb")

						arg_267_1:RecordAudio("115201065", var_270_9)
						arg_267_1:RecordAudio("115201065", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_115201", "115201065", "story_v_out_115201.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_115201", "115201065", "story_v_out_115201.awb")
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
	Play115201066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115201066
		arg_271_1.duration_ = 4.6

		local var_271_0 = {
			ja = 4.6,
			ko = 2.433,
			zh = 3.066,
			en = 2.233
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
				arg_271_0:Play115201067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.2

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[260].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:GetWordFromCfg(115201066)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 8
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201066", "story_v_out_115201.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201066", "story_v_out_115201.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_115201", "115201066", "story_v_out_115201.awb")

						arg_271_1:RecordAudio("115201066", var_274_9)
						arg_271_1:RecordAudio("115201066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115201", "115201066", "story_v_out_115201.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115201", "115201066", "story_v_out_115201.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play115201067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115201067
		arg_275_1.duration_ = 9

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115201068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_1 = 2

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_1 then
				local var_278_2 = (arg_275_1.time_ - var_278_0) / var_278_1
				local var_278_3 = Color.New(0, 0, 0)

				var_278_3.a = Mathf.Lerp(0, 1, var_278_2)
				arg_275_1.mask_.color = var_278_3
			end

			if arg_275_1.time_ >= var_278_0 + var_278_1 and arg_275_1.time_ < var_278_0 + var_278_1 + arg_278_0 then
				local var_278_4 = Color.New(0, 0, 0)

				var_278_4.a = 1
				arg_275_1.mask_.color = var_278_4
			end

			local var_278_5 = 2

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_6 = 2

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_6 then
				local var_278_7 = (arg_275_1.time_ - var_278_5) / var_278_6
				local var_278_8 = Color.New(0, 0, 0)

				var_278_8.a = Mathf.Lerp(1, 0, var_278_7)
				arg_275_1.mask_.color = var_278_8
			end

			if arg_275_1.time_ >= var_278_5 + var_278_6 and arg_275_1.time_ < var_278_5 + var_278_6 + arg_278_0 then
				local var_278_9 = Color.New(0, 0, 0)
				local var_278_10 = 0

				arg_275_1.mask_.enabled = false
				var_278_9.a = var_278_10
				arg_275_1.mask_.color = var_278_9
			end

			local var_278_11 = arg_275_1.bgs_.RO0206.transform
			local var_278_12 = 2

			if var_278_12 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 then
				arg_275_1.var_.moveOldPosRO0206 = var_278_11.localPosition
			end

			local var_278_13 = 0.001

			if var_278_12 <= arg_275_1.time_ and arg_275_1.time_ < var_278_12 + var_278_13 then
				local var_278_14 = (arg_275_1.time_ - var_278_12) / var_278_13
				local var_278_15 = Vector3.New(0, 1, 9.5)

				var_278_11.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPosRO0206, var_278_15, var_278_14)
			end

			if arg_275_1.time_ >= var_278_12 + var_278_13 and arg_275_1.time_ < var_278_12 + var_278_13 + arg_278_0 then
				var_278_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_278_16 = arg_275_1.bgs_.RO0206.transform
			local var_278_17 = 2.01666666666667

			if var_278_17 < arg_275_1.time_ and arg_275_1.time_ <= var_278_17 + arg_278_0 then
				arg_275_1.var_.moveOldPosRO0206 = var_278_16.localPosition
			end

			local var_278_18 = 2.5

			if var_278_17 <= arg_275_1.time_ and arg_275_1.time_ < var_278_17 + var_278_18 then
				local var_278_19 = (arg_275_1.time_ - var_278_17) / var_278_18
				local var_278_20 = Vector3.New(0, 1, 10)

				var_278_16.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPosRO0206, var_278_20, var_278_19)
			end

			if arg_275_1.time_ >= var_278_17 + var_278_18 and arg_275_1.time_ < var_278_17 + var_278_18 + arg_278_0 then
				var_278_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_278_21 = 4

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			local var_278_22 = 0.516666666666667

			if arg_275_1.time_ >= var_278_21 + var_278_22 and arg_275_1.time_ < var_278_21 + var_278_22 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_23 = 4
			local var_278_24 = 0.35

			if var_278_23 < arg_275_1.time_ and arg_275_1.time_ <= var_278_23 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_25 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_25:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_26 = arg_275_1:GetWordFromCfg(115201067)
				local var_278_27 = arg_275_1:FormatText(var_278_26.content)

				arg_275_1.text_.text = var_278_27

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_28 = 14
				local var_278_29 = utf8.len(var_278_27)
				local var_278_30 = var_278_28 <= 0 and var_278_24 or var_278_24 * (var_278_29 / var_278_28)

				if var_278_30 > 0 and var_278_24 < var_278_30 then
					arg_275_1.talkMaxDuration = var_278_30
					var_278_23 = var_278_23 + 0.3

					if var_278_30 + var_278_23 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_30 + var_278_23
					end
				end

				arg_275_1.text_.text = var_278_27
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = var_278_23 + 0.3
			local var_278_32 = math.max(var_278_24, arg_275_1.talkMaxDuration)

			if var_278_31 <= arg_275_1.time_ and arg_275_1.time_ < var_278_31 + var_278_32 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_31) / var_278_32

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_31 + var_278_32 and arg_275_1.time_ < var_278_31 + var_278_32 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play115201068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 115201068
		arg_281_1.duration_ = 4.53

		local var_281_0 = {
			ja = 4.533,
			ko = 1.533,
			zh = 1.366,
			en = 1.466
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
				arg_281_0:Play115201069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.1

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[263].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(115201068)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 4
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201068", "story_v_out_115201.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201068", "story_v_out_115201.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_115201", "115201068", "story_v_out_115201.awb")

						arg_281_1:RecordAudio("115201068", var_284_9)
						arg_281_1:RecordAudio("115201068", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_115201", "115201068", "story_v_out_115201.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_115201", "115201068", "story_v_out_115201.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play115201069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 115201069
		arg_285_1.duration_ = 1.63

		local var_285_0 = {
			ja = 1.5,
			ko = 1.633,
			zh = 1.366,
			en = 1.433
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
				arg_285_0:Play115201070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.1

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[261].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(115201069)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 4
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201069", "story_v_out_115201.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201069", "story_v_out_115201.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_115201", "115201069", "story_v_out_115201.awb")

						arg_285_1:RecordAudio("115201069", var_288_9)
						arg_285_1:RecordAudio("115201069", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_115201", "115201069", "story_v_out_115201.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_115201", "115201069", "story_v_out_115201.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play115201070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 115201070
		arg_289_1.duration_ = 2.7

		local var_289_0 = {
			ja = 1.8,
			ko = 1.033,
			zh = 1.766,
			en = 2.7
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
				arg_289_0:Play115201071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.1

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[263].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(115201070)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 4
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201070", "story_v_out_115201.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201070", "story_v_out_115201.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_115201", "115201070", "story_v_out_115201.awb")

						arg_289_1:RecordAudio("115201070", var_292_9)
						arg_289_1:RecordAudio("115201070", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_115201", "115201070", "story_v_out_115201.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_115201", "115201070", "story_v_out_115201.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play115201071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 115201071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play115201072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.4

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(115201071)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 16
				local var_296_5 = utf8.len(var_296_3)
				local var_296_6 = var_296_4 <= 0 and var_296_1 or var_296_1 * (var_296_5 / var_296_4)

				if var_296_6 > 0 and var_296_1 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_7 and arg_293_1.time_ < var_296_0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play115201072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 115201072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play115201073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.2

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(115201072)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 48
				local var_300_5 = utf8.len(var_300_3)
				local var_300_6 = var_300_4 <= 0 and var_300_1 or var_300_1 * (var_300_5 / var_300_4)

				if var_300_6 > 0 and var_300_1 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_7 and arg_297_1.time_ < var_300_0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play115201073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 115201073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play115201074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.8

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(115201073)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 32
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play115201074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 115201074
		arg_305_1.duration_ = 9.27

		local var_305_0 = {
			ja = 7.4,
			ko = 7.566,
			zh = 6.866,
			en = 9.266
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
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play115201075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.675

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[260].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(115201074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 27
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201074", "story_v_out_115201.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201074", "story_v_out_115201.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_115201", "115201074", "story_v_out_115201.awb")

						arg_305_1:RecordAudio("115201074", var_308_9)
						arg_305_1:RecordAudio("115201074", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_115201", "115201074", "story_v_out_115201.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_115201", "115201074", "story_v_out_115201.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play115201075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 115201075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play115201076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.025

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(115201075)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 41
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play115201076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 115201076
		arg_313_1.duration_ = 9

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play115201077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = "G03_1"

			if arg_313_1.bgs_[var_316_0] == nil then
				local var_316_1 = Object.Instantiate(arg_313_1.paintGo_)

				var_316_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_316_0)
				var_316_1.name = var_316_0
				var_316_1.transform.parent = arg_313_1.stage_.transform
				var_316_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.bgs_[var_316_0] = var_316_1
			end

			local var_316_2 = 2

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				local var_316_3 = manager.ui.mainCamera.transform.localPosition
				local var_316_4 = Vector3.New(0, 0, 10) + Vector3.New(var_316_3.x, var_316_3.y, 0)
				local var_316_5 = arg_313_1.bgs_.G03_1

				var_316_5.transform.localPosition = var_316_4
				var_316_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_6 = var_316_5:GetComponent("SpriteRenderer")

				if var_316_6 and var_316_6.sprite then
					local var_316_7 = (var_316_5.transform.localPosition - var_316_3).z
					local var_316_8 = manager.ui.mainCameraCom_
					local var_316_9 = 2 * var_316_7 * Mathf.Tan(var_316_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_316_10 = var_316_9 * var_316_8.aspect
					local var_316_11 = var_316_6.sprite.bounds.size.x
					local var_316_12 = var_316_6.sprite.bounds.size.y
					local var_316_13 = var_316_10 / var_316_11
					local var_316_14 = var_316_9 / var_316_12
					local var_316_15 = var_316_14 < var_316_13 and var_316_13 or var_316_14

					var_316_5.transform.localScale = Vector3.New(var_316_15, var_316_15, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "G03_1" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_17 = 2

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Color.New(0, 0, 0)

				var_316_19.a = Mathf.Lerp(0, 1, var_316_18)
				arg_313_1.mask_.color = var_316_19
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				local var_316_20 = Color.New(0, 0, 0)

				var_316_20.a = 1
				arg_313_1.mask_.color = var_316_20
			end

			local var_316_21 = 2

			if var_316_21 < arg_313_1.time_ and arg_313_1.time_ <= var_316_21 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_22 = 2

			if var_316_21 <= arg_313_1.time_ and arg_313_1.time_ < var_316_21 + var_316_22 then
				local var_316_23 = (arg_313_1.time_ - var_316_21) / var_316_22
				local var_316_24 = Color.New(0, 0, 0)

				var_316_24.a = Mathf.Lerp(1, 0, var_316_23)
				arg_313_1.mask_.color = var_316_24
			end

			if arg_313_1.time_ >= var_316_21 + var_316_22 and arg_313_1.time_ < var_316_21 + var_316_22 + arg_316_0 then
				local var_316_25 = Color.New(0, 0, 0)
				local var_316_26 = 0

				arg_313_1.mask_.enabled = false
				var_316_25.a = var_316_26
				arg_313_1.mask_.color = var_316_25
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_27 = 4
			local var_316_28 = 0.7

			if var_316_27 < arg_313_1.time_ and arg_313_1.time_ <= var_316_27 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_29 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_29:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_30 = arg_313_1:GetWordFromCfg(115201076)
				local var_316_31 = arg_313_1:FormatText(var_316_30.content)

				arg_313_1.text_.text = var_316_31

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_32 = 28
				local var_316_33 = utf8.len(var_316_31)
				local var_316_34 = var_316_32 <= 0 and var_316_28 or var_316_28 * (var_316_33 / var_316_32)

				if var_316_34 > 0 and var_316_28 < var_316_34 then
					arg_313_1.talkMaxDuration = var_316_34
					var_316_27 = var_316_27 + 0.3

					if var_316_34 + var_316_27 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_34 + var_316_27
					end
				end

				arg_313_1.text_.text = var_316_31
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_35 = var_316_27 + 0.3
			local var_316_36 = math.max(var_316_28, arg_313_1.talkMaxDuration)

			if var_316_35 <= arg_313_1.time_ and arg_313_1.time_ < var_316_35 + var_316_36 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_35) / var_316_36

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_35 + var_316_36 and arg_313_1.time_ < var_316_35 + var_316_36 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play115201077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115201077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play115201078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.625

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(115201077)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 25
				local var_322_5 = utf8.len(var_322_3)
				local var_322_6 = var_322_4 <= 0 and var_322_1 or var_322_1 * (var_322_5 / var_322_4)

				if var_322_6 > 0 and var_322_1 < var_322_6 then
					arg_319_1.talkMaxDuration = var_322_6

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_7 and arg_319_1.time_ < var_322_0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play115201078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115201078
		arg_323_1.duration_ = 13.8

		local var_323_0 = {
			ja = 13.8,
			ko = 4.933,
			zh = 5.333,
			en = 7.266
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
				arg_323_0:Play115201079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = "1017ui_story"

			if arg_323_1.actors_[var_326_0] == nil then
				local var_326_1 = Asset.Load("Char/" .. "1017ui_story")

				if not isNil(var_326_1) then
					local var_326_2 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_323_1.stage_.transform)

					var_326_2.name = var_326_0
					var_326_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_323_1.actors_[var_326_0] = var_326_2

					local var_326_3 = var_326_2:GetComponentInChildren(typeof(CharacterEffect))

					var_326_3.enabled = true

					local var_326_4 = GameObjectTools.GetOrAddComponent(var_326_2, typeof(DynamicBoneHelper))

					if var_326_4 then
						var_326_4:EnableDynamicBone(false)
					end

					arg_323_1:ShowWeapon(var_326_3.transform, false)

					arg_323_1.var_[var_326_0 .. "Animator"] = var_326_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_323_1.var_[var_326_0 .. "Animator"].applyRootMotion = true
					arg_323_1.var_[var_326_0 .. "LipSync"] = var_326_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_326_5 = arg_323_1.actors_["1017ui_story"].transform
			local var_326_6 = 0

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.var_.moveOldPos1017ui_story = var_326_5.localPosition
			end

			local var_326_7 = 0.001

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_7 then
				local var_326_8 = (arg_323_1.time_ - var_326_6) / var_326_7
				local var_326_9 = Vector3.New(-0.7, -1.01, -6.05)

				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1017ui_story, var_326_9, var_326_8)

				local var_326_10 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_10.x, var_326_10.y, var_326_10.z)

				local var_326_11 = var_326_5.localEulerAngles

				var_326_11.z = 0
				var_326_11.x = 0
				var_326_5.localEulerAngles = var_326_11
			end

			if arg_323_1.time_ >= var_326_6 + var_326_7 and arg_323_1.time_ < var_326_6 + var_326_7 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_326_12 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_12.x, var_326_12.y, var_326_12.z)

				local var_326_13 = var_326_5.localEulerAngles

				var_326_13.z = 0
				var_326_13.x = 0
				var_326_5.localEulerAngles = var_326_13
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			local var_326_15 = 0

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_326_16 = arg_323_1.actors_["1017ui_story"]
			local var_326_17 = 0

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 and not isNil(var_326_16) and arg_323_1.var_.characterEffect1017ui_story == nil then
				arg_323_1.var_.characterEffect1017ui_story = var_326_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_18 = 0.2

			if var_326_17 <= arg_323_1.time_ and arg_323_1.time_ < var_326_17 + var_326_18 and not isNil(var_326_16) then
				local var_326_19 = (arg_323_1.time_ - var_326_17) / var_326_18

				if arg_323_1.var_.characterEffect1017ui_story and not isNil(var_326_16) then
					arg_323_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_17 + var_326_18 and arg_323_1.time_ < var_326_17 + var_326_18 + arg_326_0 and not isNil(var_326_16) and arg_323_1.var_.characterEffect1017ui_story then
				arg_323_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_326_20 = 0
			local var_326_21 = 0.675

			if var_326_20 < arg_323_1.time_ and arg_323_1.time_ <= var_326_20 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_22 = arg_323_1:FormatText(StoryNameCfg[273].name)

				arg_323_1.leftNameTxt_.text = var_326_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_23 = arg_323_1:GetWordFromCfg(115201078)
				local var_326_24 = arg_323_1:FormatText(var_326_23.content)

				arg_323_1.text_.text = var_326_24

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_25 = 27
				local var_326_26 = utf8.len(var_326_24)
				local var_326_27 = var_326_25 <= 0 and var_326_21 or var_326_21 * (var_326_26 / var_326_25)

				if var_326_27 > 0 and var_326_21 < var_326_27 then
					arg_323_1.talkMaxDuration = var_326_27

					if var_326_27 + var_326_20 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_27 + var_326_20
					end
				end

				arg_323_1.text_.text = var_326_24
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201078", "story_v_out_115201.awb") ~= 0 then
					local var_326_28 = manager.audio:GetVoiceLength("story_v_out_115201", "115201078", "story_v_out_115201.awb") / 1000

					if var_326_28 + var_326_20 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_28 + var_326_20
					end

					if var_326_23.prefab_name ~= "" and arg_323_1.actors_[var_326_23.prefab_name] ~= nil then
						local var_326_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_23.prefab_name].transform, "story_v_out_115201", "115201078", "story_v_out_115201.awb")

						arg_323_1:RecordAudio("115201078", var_326_29)
						arg_323_1:RecordAudio("115201078", var_326_29)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_115201", "115201078", "story_v_out_115201.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_115201", "115201078", "story_v_out_115201.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_30 = math.max(var_326_21, arg_323_1.talkMaxDuration)

			if var_326_20 <= arg_323_1.time_ and arg_323_1.time_ < var_326_20 + var_326_30 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_20) / var_326_30

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_20 + var_326_30 and arg_323_1.time_ < var_326_20 + var_326_30 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play115201079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115201079
		arg_327_1.duration_ = 7.33

		local var_327_0 = {
			ja = 7.3,
			ko = 6.266,
			zh = 5.966,
			en = 7.333
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
				arg_327_0:Play115201080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_330_1 = 0
			local var_330_2 = 0.725

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_3 = arg_327_1:FormatText(StoryNameCfg[273].name)

				arg_327_1.leftNameTxt_.text = var_330_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_4 = arg_327_1:GetWordFromCfg(115201079)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 29
				local var_330_7 = utf8.len(var_330_5)
				local var_330_8 = var_330_6 <= 0 and var_330_2 or var_330_2 * (var_330_7 / var_330_6)

				if var_330_8 > 0 and var_330_2 < var_330_8 then
					arg_327_1.talkMaxDuration = var_330_8

					if var_330_8 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201079", "story_v_out_115201.awb") ~= 0 then
					local var_330_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201079", "story_v_out_115201.awb") / 1000

					if var_330_9 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_1
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_out_115201", "115201079", "story_v_out_115201.awb")

						arg_327_1:RecordAudio("115201079", var_330_10)
						arg_327_1:RecordAudio("115201079", var_330_10)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115201", "115201079", "story_v_out_115201.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115201", "115201079", "story_v_out_115201.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_11 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_11 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_11

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_11 and arg_327_1.time_ < var_330_1 + var_330_11 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play115201080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115201080
		arg_331_1.duration_ = 7.47

		local var_331_0 = {
			ja = 6.166,
			ko = 5.933,
			zh = 5.933,
			en = 7.466
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115201081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1052ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1052ui_story = var_334_0.localPosition
			end

			local var_334_2 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2
				local var_334_4 = Vector3.New(0.7, -1.05, -6.2)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1052ui_story, var_334_4, var_334_3)

				local var_334_5 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_5.x, var_334_5.y, var_334_5.z)

				local var_334_6 = var_334_0.localEulerAngles

				var_334_6.z = 0
				var_334_6.x = 0
				var_334_0.localEulerAngles = var_334_6
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_334_7 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_7.x, var_334_7.y, var_334_7.z)

				local var_334_8 = var_334_0.localEulerAngles

				var_334_8.z = 0
				var_334_8.x = 0
				var_334_0.localEulerAngles = var_334_8
			end

			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 then
				arg_331_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_334_11 = arg_331_1.actors_["1052ui_story"]
			local var_334_12 = 0

			if var_334_12 < arg_331_1.time_ and arg_331_1.time_ <= var_334_12 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect1052ui_story == nil then
				arg_331_1.var_.characterEffect1052ui_story = var_334_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_13 = 0.2

			if var_334_12 <= arg_331_1.time_ and arg_331_1.time_ < var_334_12 + var_334_13 and not isNil(var_334_11) then
				local var_334_14 = (arg_331_1.time_ - var_334_12) / var_334_13

				if arg_331_1.var_.characterEffect1052ui_story and not isNil(var_334_11) then
					arg_331_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_12 + var_334_13 and arg_331_1.time_ < var_334_12 + var_334_13 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect1052ui_story then
				arg_331_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_334_15 = arg_331_1.actors_["1017ui_story"]
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.characterEffect1017ui_story == nil then
				arg_331_1.var_.characterEffect1017ui_story = var_334_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_17 = 0.2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 and not isNil(var_334_15) then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17

				if arg_331_1.var_.characterEffect1017ui_story and not isNil(var_334_15) then
					local var_334_19 = Mathf.Lerp(0, 0.5, var_334_18)

					arg_331_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1017ui_story.fillRatio = var_334_19
				end
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.characterEffect1017ui_story then
				local var_334_20 = 0.5

				arg_331_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1017ui_story.fillRatio = var_334_20
			end

			local var_334_21 = 0
			local var_334_22 = 0.65

			if var_334_21 < arg_331_1.time_ and arg_331_1.time_ <= var_334_21 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_23 = arg_331_1:FormatText(StoryNameCfg[263].name)

				arg_331_1.leftNameTxt_.text = var_334_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_24 = arg_331_1:GetWordFromCfg(115201080)
				local var_334_25 = arg_331_1:FormatText(var_334_24.content)

				arg_331_1.text_.text = var_334_25

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_26 = 27
				local var_334_27 = utf8.len(var_334_25)
				local var_334_28 = var_334_26 <= 0 and var_334_22 or var_334_22 * (var_334_27 / var_334_26)

				if var_334_28 > 0 and var_334_22 < var_334_28 then
					arg_331_1.talkMaxDuration = var_334_28

					if var_334_28 + var_334_21 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_28 + var_334_21
					end
				end

				arg_331_1.text_.text = var_334_25
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201080", "story_v_out_115201.awb") ~= 0 then
					local var_334_29 = manager.audio:GetVoiceLength("story_v_out_115201", "115201080", "story_v_out_115201.awb") / 1000

					if var_334_29 + var_334_21 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_29 + var_334_21
					end

					if var_334_24.prefab_name ~= "" and arg_331_1.actors_[var_334_24.prefab_name] ~= nil then
						local var_334_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_24.prefab_name].transform, "story_v_out_115201", "115201080", "story_v_out_115201.awb")

						arg_331_1:RecordAudio("115201080", var_334_30)
						arg_331_1:RecordAudio("115201080", var_334_30)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_115201", "115201080", "story_v_out_115201.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_115201", "115201080", "story_v_out_115201.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_31 = math.max(var_334_22, arg_331_1.talkMaxDuration)

			if var_334_21 <= arg_331_1.time_ and arg_331_1.time_ < var_334_21 + var_334_31 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_21) / var_334_31

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_21 + var_334_31 and arg_331_1.time_ < var_334_21 + var_334_31 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play115201081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115201081
		arg_335_1.duration_ = 2

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play115201082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_2")
			end

			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_338_2 = arg_335_1.actors_["1017ui_story"]
			local var_338_3 = 0

			if var_338_3 < arg_335_1.time_ and arg_335_1.time_ <= var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.characterEffect1017ui_story == nil then
				arg_335_1.var_.characterEffect1017ui_story = var_338_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.2

			if var_338_3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_3 + var_338_4 and not isNil(var_338_2) then
				local var_338_5 = (arg_335_1.time_ - var_338_3) / var_338_4

				if arg_335_1.var_.characterEffect1017ui_story and not isNil(var_338_2) then
					arg_335_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_3 + var_338_4 and arg_335_1.time_ < var_338_3 + var_338_4 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.characterEffect1017ui_story then
				arg_335_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_338_6 = arg_335_1.actors_["1052ui_story"]
			local var_338_7 = 0

			if var_338_7 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect1052ui_story == nil then
				arg_335_1.var_.characterEffect1052ui_story = var_338_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_8 = 0.2

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_8 and not isNil(var_338_6) then
				local var_338_9 = (arg_335_1.time_ - var_338_7) / var_338_8

				if arg_335_1.var_.characterEffect1052ui_story and not isNil(var_338_6) then
					local var_338_10 = Mathf.Lerp(0, 0.5, var_338_9)

					arg_335_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1052ui_story.fillRatio = var_338_10
				end
			end

			if arg_335_1.time_ >= var_338_7 + var_338_8 and arg_335_1.time_ < var_338_7 + var_338_8 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect1052ui_story then
				local var_338_11 = 0.5

				arg_335_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1052ui_story.fillRatio = var_338_11
			end

			local var_338_12 = 0
			local var_338_13 = 0.15

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_14 = arg_335_1:FormatText(StoryNameCfg[273].name)

				arg_335_1.leftNameTxt_.text = var_338_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_15 = arg_335_1:GetWordFromCfg(115201081)
				local var_338_16 = arg_335_1:FormatText(var_338_15.content)

				arg_335_1.text_.text = var_338_16

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_17 = 6
				local var_338_18 = utf8.len(var_338_16)
				local var_338_19 = var_338_17 <= 0 and var_338_13 or var_338_13 * (var_338_18 / var_338_17)

				if var_338_19 > 0 and var_338_13 < var_338_19 then
					arg_335_1.talkMaxDuration = var_338_19

					if var_338_19 + var_338_12 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_19 + var_338_12
					end
				end

				arg_335_1.text_.text = var_338_16
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201081", "story_v_out_115201.awb") ~= 0 then
					local var_338_20 = manager.audio:GetVoiceLength("story_v_out_115201", "115201081", "story_v_out_115201.awb") / 1000

					if var_338_20 + var_338_12 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_20 + var_338_12
					end

					if var_338_15.prefab_name ~= "" and arg_335_1.actors_[var_338_15.prefab_name] ~= nil then
						local var_338_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_15.prefab_name].transform, "story_v_out_115201", "115201081", "story_v_out_115201.awb")

						arg_335_1:RecordAudio("115201081", var_338_21)
						arg_335_1:RecordAudio("115201081", var_338_21)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115201", "115201081", "story_v_out_115201.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115201", "115201081", "story_v_out_115201.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_22 = math.max(var_338_13, arg_335_1.talkMaxDuration)

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_22 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_12) / var_338_22

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_12 + var_338_22 and arg_335_1.time_ < var_338_12 + var_338_22 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play115201082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115201082
		arg_339_1.duration_ = 4.03

		local var_339_0 = {
			ja = 2.566,
			ko = 4.033,
			zh = 2.433,
			en = 2.6
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play115201083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			local var_342_2 = arg_339_1.actors_["1052ui_story"]
			local var_342_3 = 0

			if var_342_3 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.characterEffect1052ui_story == nil then
				arg_339_1.var_.characterEffect1052ui_story = var_342_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_4 = 0.2

			if var_342_3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_3 + var_342_4 and not isNil(var_342_2) then
				local var_342_5 = (arg_339_1.time_ - var_342_3) / var_342_4

				if arg_339_1.var_.characterEffect1052ui_story and not isNil(var_342_2) then
					arg_339_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_3 + var_342_4 and arg_339_1.time_ < var_342_3 + var_342_4 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.characterEffect1052ui_story then
				arg_339_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_342_6 = arg_339_1.actors_["1017ui_story"]
			local var_342_7 = 0

			if var_342_7 < arg_339_1.time_ and arg_339_1.time_ <= var_342_7 + arg_342_0 and not isNil(var_342_6) and arg_339_1.var_.characterEffect1017ui_story == nil then
				arg_339_1.var_.characterEffect1017ui_story = var_342_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_8 = 0.2

			if var_342_7 <= arg_339_1.time_ and arg_339_1.time_ < var_342_7 + var_342_8 and not isNil(var_342_6) then
				local var_342_9 = (arg_339_1.time_ - var_342_7) / var_342_8

				if arg_339_1.var_.characterEffect1017ui_story and not isNil(var_342_6) then
					local var_342_10 = Mathf.Lerp(0, 0.5, var_342_9)

					arg_339_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1017ui_story.fillRatio = var_342_10
				end
			end

			if arg_339_1.time_ >= var_342_7 + var_342_8 and arg_339_1.time_ < var_342_7 + var_342_8 + arg_342_0 and not isNil(var_342_6) and arg_339_1.var_.characterEffect1017ui_story then
				local var_342_11 = 0.5

				arg_339_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1017ui_story.fillRatio = var_342_11
			end

			local var_342_12 = 0
			local var_342_13 = 0.225

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_14 = arg_339_1:FormatText(StoryNameCfg[263].name)

				arg_339_1.leftNameTxt_.text = var_342_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_15 = arg_339_1:GetWordFromCfg(115201082)
				local var_342_16 = arg_339_1:FormatText(var_342_15.content)

				arg_339_1.text_.text = var_342_16

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_17 = 9
				local var_342_18 = utf8.len(var_342_16)
				local var_342_19 = var_342_17 <= 0 and var_342_13 or var_342_13 * (var_342_18 / var_342_17)

				if var_342_19 > 0 and var_342_13 < var_342_19 then
					arg_339_1.talkMaxDuration = var_342_19

					if var_342_19 + var_342_12 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_19 + var_342_12
					end
				end

				arg_339_1.text_.text = var_342_16
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201082", "story_v_out_115201.awb") ~= 0 then
					local var_342_20 = manager.audio:GetVoiceLength("story_v_out_115201", "115201082", "story_v_out_115201.awb") / 1000

					if var_342_20 + var_342_12 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_20 + var_342_12
					end

					if var_342_15.prefab_name ~= "" and arg_339_1.actors_[var_342_15.prefab_name] ~= nil then
						local var_342_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_15.prefab_name].transform, "story_v_out_115201", "115201082", "story_v_out_115201.awb")

						arg_339_1:RecordAudio("115201082", var_342_21)
						arg_339_1:RecordAudio("115201082", var_342_21)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115201", "115201082", "story_v_out_115201.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115201", "115201082", "story_v_out_115201.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_22 = math.max(var_342_13, arg_339_1.talkMaxDuration)

			if var_342_12 <= arg_339_1.time_ and arg_339_1.time_ < var_342_12 + var_342_22 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_12) / var_342_22

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_12 + var_342_22 and arg_339_1.time_ < var_342_12 + var_342_22 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play115201083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 115201083
		arg_343_1.duration_ = 7.73

		local var_343_0 = {
			ja = 7.733,
			ko = 4.2,
			zh = 3.366,
			en = 4.9
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play115201084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1017ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1017ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(0, 100, 0)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1017ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, 100, 0)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = arg_343_1.actors_["1024ui_story"].transform
			local var_346_10 = 0

			if var_346_10 < arg_343_1.time_ and arg_343_1.time_ <= var_346_10 + arg_346_0 then
				arg_343_1.var_.moveOldPos1024ui_story = var_346_9.localPosition

				local var_346_11 = "1024ui_story"

				arg_343_1:ShowWeapon(arg_343_1.var_[var_346_11 .. "Animator"].transform, false)
			end

			local var_346_12 = 0.001

			if var_346_10 <= arg_343_1.time_ and arg_343_1.time_ < var_346_10 + var_346_12 then
				local var_346_13 = (arg_343_1.time_ - var_346_10) / var_346_12
				local var_346_14 = Vector3.New(-0.7, -1, -6.05)

				var_346_9.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1024ui_story, var_346_14, var_346_13)

				local var_346_15 = manager.ui.mainCamera.transform.position - var_346_9.position

				var_346_9.forward = Vector3.New(var_346_15.x, var_346_15.y, var_346_15.z)

				local var_346_16 = var_346_9.localEulerAngles

				var_346_16.z = 0
				var_346_16.x = 0
				var_346_9.localEulerAngles = var_346_16
			end

			if arg_343_1.time_ >= var_346_10 + var_346_12 and arg_343_1.time_ < var_346_10 + var_346_12 + arg_346_0 then
				var_346_9.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_346_17 = manager.ui.mainCamera.transform.position - var_346_9.position

				var_346_9.forward = Vector3.New(var_346_17.x, var_346_17.y, var_346_17.z)

				local var_346_18 = var_346_9.localEulerAngles

				var_346_18.z = 0
				var_346_18.x = 0
				var_346_9.localEulerAngles = var_346_18
			end

			local var_346_19 = 0

			if var_346_19 < arg_343_1.time_ and arg_343_1.time_ <= var_346_19 + arg_346_0 then
				arg_343_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_346_20 = 0

			if var_346_20 < arg_343_1.time_ and arg_343_1.time_ <= var_346_20 + arg_346_0 then
				arg_343_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_346_21 = arg_343_1.actors_["1024ui_story"]
			local var_346_22 = 0

			if var_346_22 < arg_343_1.time_ and arg_343_1.time_ <= var_346_22 + arg_346_0 and not isNil(var_346_21) and arg_343_1.var_.characterEffect1024ui_story == nil then
				arg_343_1.var_.characterEffect1024ui_story = var_346_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_23 = 0.2

			if var_346_22 <= arg_343_1.time_ and arg_343_1.time_ < var_346_22 + var_346_23 and not isNil(var_346_21) then
				local var_346_24 = (arg_343_1.time_ - var_346_22) / var_346_23

				if arg_343_1.var_.characterEffect1024ui_story and not isNil(var_346_21) then
					arg_343_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_22 + var_346_23 and arg_343_1.time_ < var_346_22 + var_346_23 + arg_346_0 and not isNil(var_346_21) and arg_343_1.var_.characterEffect1024ui_story then
				arg_343_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_346_25 = arg_343_1.actors_["1052ui_story"]
			local var_346_26 = 0

			if var_346_26 < arg_343_1.time_ and arg_343_1.time_ <= var_346_26 + arg_346_0 and not isNil(var_346_25) and arg_343_1.var_.characterEffect1052ui_story == nil then
				arg_343_1.var_.characterEffect1052ui_story = var_346_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_27 = 0.2

			if var_346_26 <= arg_343_1.time_ and arg_343_1.time_ < var_346_26 + var_346_27 and not isNil(var_346_25) then
				local var_346_28 = (arg_343_1.time_ - var_346_26) / var_346_27

				if arg_343_1.var_.characterEffect1052ui_story and not isNil(var_346_25) then
					local var_346_29 = Mathf.Lerp(0, 0.5, var_346_28)

					arg_343_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1052ui_story.fillRatio = var_346_29
				end
			end

			if arg_343_1.time_ >= var_346_26 + var_346_27 and arg_343_1.time_ < var_346_26 + var_346_27 + arg_346_0 and not isNil(var_346_25) and arg_343_1.var_.characterEffect1052ui_story then
				local var_346_30 = 0.5

				arg_343_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1052ui_story.fillRatio = var_346_30
			end

			local var_346_31 = 0
			local var_346_32 = 0.45

			if var_346_31 < arg_343_1.time_ and arg_343_1.time_ <= var_346_31 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_33 = arg_343_1:FormatText(StoryNameCfg[265].name)

				arg_343_1.leftNameTxt_.text = var_346_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_34 = arg_343_1:GetWordFromCfg(115201083)
				local var_346_35 = arg_343_1:FormatText(var_346_34.content)

				arg_343_1.text_.text = var_346_35

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_36 = 18
				local var_346_37 = utf8.len(var_346_35)
				local var_346_38 = var_346_36 <= 0 and var_346_32 or var_346_32 * (var_346_37 / var_346_36)

				if var_346_38 > 0 and var_346_32 < var_346_38 then
					arg_343_1.talkMaxDuration = var_346_38

					if var_346_38 + var_346_31 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_38 + var_346_31
					end
				end

				arg_343_1.text_.text = var_346_35
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201083", "story_v_out_115201.awb") ~= 0 then
					local var_346_39 = manager.audio:GetVoiceLength("story_v_out_115201", "115201083", "story_v_out_115201.awb") / 1000

					if var_346_39 + var_346_31 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_39 + var_346_31
					end

					if var_346_34.prefab_name ~= "" and arg_343_1.actors_[var_346_34.prefab_name] ~= nil then
						local var_346_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_34.prefab_name].transform, "story_v_out_115201", "115201083", "story_v_out_115201.awb")

						arg_343_1:RecordAudio("115201083", var_346_40)
						arg_343_1:RecordAudio("115201083", var_346_40)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_115201", "115201083", "story_v_out_115201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_115201", "115201083", "story_v_out_115201.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_41 = math.max(var_346_32, arg_343_1.talkMaxDuration)

			if var_346_31 <= arg_343_1.time_ and arg_343_1.time_ < var_346_31 + var_346_41 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_31) / var_346_41

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_31 + var_346_41 and arg_343_1.time_ < var_346_31 + var_346_41 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play115201084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 115201084
		arg_347_1.duration_ = 5.07

		local var_347_0 = {
			ja = 4.733,
			ko = 4.6,
			zh = 2.933,
			en = 5.066
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play115201085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1024ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1024ui_story == nil then
				arg_347_1.var_.characterEffect1024ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1024ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1024ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1024ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1024ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_350_7 = 0
			local var_350_8 = 0.4

			if var_350_7 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_9 = arg_347_1:FormatText(StoryNameCfg[273].name)

				arg_347_1.leftNameTxt_.text = var_350_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_10 = arg_347_1:GetWordFromCfg(115201084)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 16
				local var_350_13 = utf8.len(var_350_11)
				local var_350_14 = var_350_12 <= 0 and var_350_8 or var_350_8 * (var_350_13 / var_350_12)

				if var_350_14 > 0 and var_350_8 < var_350_14 then
					arg_347_1.talkMaxDuration = var_350_14

					if var_350_14 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201084", "story_v_out_115201.awb") ~= 0 then
					local var_350_15 = manager.audio:GetVoiceLength("story_v_out_115201", "115201084", "story_v_out_115201.awb") / 1000

					if var_350_15 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_7
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_115201", "115201084", "story_v_out_115201.awb")

						arg_347_1:RecordAudio("115201084", var_350_16)
						arg_347_1:RecordAudio("115201084", var_350_16)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_115201", "115201084", "story_v_out_115201.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_115201", "115201084", "story_v_out_115201.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_17 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_17 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_17

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_17 and arg_347_1.time_ < var_350_7 + var_350_17 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play115201085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 115201085
		arg_351_1.duration_ = 8.53

		local var_351_0 = {
			ja = 8.533,
			ko = 5.2,
			zh = 6.333,
			en = 3.933
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play115201086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_354_1 = arg_351_1.actors_["1052ui_story"]
			local var_354_2 = 0

			if var_354_2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1052ui_story == nil then
				arg_351_1.var_.characterEffect1052ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_3 = 0.2

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_3 and not isNil(var_354_1) then
				local var_354_4 = (arg_351_1.time_ - var_354_2) / var_354_3

				if arg_351_1.var_.characterEffect1052ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_2 + var_354_3 and arg_351_1.time_ < var_354_2 + var_354_3 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1052ui_story then
				arg_351_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_354_5 = 0
			local var_354_6 = 0.525

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_7 = arg_351_1:FormatText(StoryNameCfg[263].name)

				arg_351_1.leftNameTxt_.text = var_354_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_8 = arg_351_1:GetWordFromCfg(115201085)
				local var_354_9 = arg_351_1:FormatText(var_354_8.content)

				arg_351_1.text_.text = var_354_9

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 21
				local var_354_11 = utf8.len(var_354_9)
				local var_354_12 = var_354_10 <= 0 and var_354_6 or var_354_6 * (var_354_11 / var_354_10)

				if var_354_12 > 0 and var_354_6 < var_354_12 then
					arg_351_1.talkMaxDuration = var_354_12

					if var_354_12 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_9
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201085", "story_v_out_115201.awb") ~= 0 then
					local var_354_13 = manager.audio:GetVoiceLength("story_v_out_115201", "115201085", "story_v_out_115201.awb") / 1000

					if var_354_13 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_5
					end

					if var_354_8.prefab_name ~= "" and arg_351_1.actors_[var_354_8.prefab_name] ~= nil then
						local var_354_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_8.prefab_name].transform, "story_v_out_115201", "115201085", "story_v_out_115201.awb")

						arg_351_1:RecordAudio("115201085", var_354_14)
						arg_351_1:RecordAudio("115201085", var_354_14)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_115201", "115201085", "story_v_out_115201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_115201", "115201085", "story_v_out_115201.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_15 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_15 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_15

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_15 and arg_351_1.time_ < var_354_5 + var_354_15 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play115201086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 115201086
		arg_355_1.duration_ = 10.33

		local var_355_0 = {
			ja = 10.333,
			ko = 8.033,
			zh = 8.233,
			en = 8.766
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play115201087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_358_1 = 0
			local var_358_2 = 0.8

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_3 = arg_355_1:FormatText(StoryNameCfg[263].name)

				arg_355_1.leftNameTxt_.text = var_358_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_4 = arg_355_1:GetWordFromCfg(115201086)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 32
				local var_358_7 = utf8.len(var_358_5)
				local var_358_8 = var_358_6 <= 0 and var_358_2 or var_358_2 * (var_358_7 / var_358_6)

				if var_358_8 > 0 and var_358_2 < var_358_8 then
					arg_355_1.talkMaxDuration = var_358_8

					if var_358_8 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201086", "story_v_out_115201.awb") ~= 0 then
					local var_358_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201086", "story_v_out_115201.awb") / 1000

					if var_358_9 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_1
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_out_115201", "115201086", "story_v_out_115201.awb")

						arg_355_1:RecordAudio("115201086", var_358_10)
						arg_355_1:RecordAudio("115201086", var_358_10)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_115201", "115201086", "story_v_out_115201.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_115201", "115201086", "story_v_out_115201.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_11 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_11 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_11

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_11 and arg_355_1.time_ < var_358_1 + var_358_11 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play115201087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 115201087
		arg_359_1.duration_ = 3.73

		local var_359_0 = {
			ja = 3.733,
			ko = 2.7,
			zh = 2.833,
			en = 2.833
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play115201088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1024ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1024ui_story == nil then
				arg_359_1.var_.characterEffect1024ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1024ui_story and not isNil(var_362_0) then
					arg_359_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1024ui_story then
				arg_359_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_362_4 = 0

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_362_5 = arg_359_1.actors_["1052ui_story"]
			local var_362_6 = 0

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1052ui_story == nil then
				arg_359_1.var_.characterEffect1052ui_story = var_362_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_7 = 0.2

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_7 and not isNil(var_362_5) then
				local var_362_8 = (arg_359_1.time_ - var_362_6) / var_362_7

				if arg_359_1.var_.characterEffect1052ui_story and not isNil(var_362_5) then
					local var_362_9 = Mathf.Lerp(0, 0.5, var_362_8)

					arg_359_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1052ui_story.fillRatio = var_362_9
				end
			end

			if arg_359_1.time_ >= var_362_6 + var_362_7 and arg_359_1.time_ < var_362_6 + var_362_7 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1052ui_story then
				local var_362_10 = 0.5

				arg_359_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1052ui_story.fillRatio = var_362_10
			end

			local var_362_11 = 0
			local var_362_12 = 0.325

			if var_362_11 < arg_359_1.time_ and arg_359_1.time_ <= var_362_11 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_13 = arg_359_1:FormatText(StoryNameCfg[265].name)

				arg_359_1.leftNameTxt_.text = var_362_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_14 = arg_359_1:GetWordFromCfg(115201087)
				local var_362_15 = arg_359_1:FormatText(var_362_14.content)

				arg_359_1.text_.text = var_362_15

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_16 = 13
				local var_362_17 = utf8.len(var_362_15)
				local var_362_18 = var_362_16 <= 0 and var_362_12 or var_362_12 * (var_362_17 / var_362_16)

				if var_362_18 > 0 and var_362_12 < var_362_18 then
					arg_359_1.talkMaxDuration = var_362_18

					if var_362_18 + var_362_11 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_18 + var_362_11
					end
				end

				arg_359_1.text_.text = var_362_15
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201087", "story_v_out_115201.awb") ~= 0 then
					local var_362_19 = manager.audio:GetVoiceLength("story_v_out_115201", "115201087", "story_v_out_115201.awb") / 1000

					if var_362_19 + var_362_11 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_19 + var_362_11
					end

					if var_362_14.prefab_name ~= "" and arg_359_1.actors_[var_362_14.prefab_name] ~= nil then
						local var_362_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_14.prefab_name].transform, "story_v_out_115201", "115201087", "story_v_out_115201.awb")

						arg_359_1:RecordAudio("115201087", var_362_20)
						arg_359_1:RecordAudio("115201087", var_362_20)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_115201", "115201087", "story_v_out_115201.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_115201", "115201087", "story_v_out_115201.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_21 = math.max(var_362_12, arg_359_1.talkMaxDuration)

			if var_362_11 <= arg_359_1.time_ and arg_359_1.time_ < var_362_11 + var_362_21 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_11) / var_362_21

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_11 + var_362_21 and arg_359_1.time_ < var_362_11 + var_362_21 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play115201088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 115201088
		arg_363_1.duration_ = 4.7

		local var_363_0 = {
			ja = 2.8,
			ko = 3.533,
			zh = 4.7,
			en = 2.6
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play115201089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_366_1 = arg_363_1.actors_["1052ui_story"]
			local var_366_2 = 0

			if var_366_2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1052ui_story == nil then
				arg_363_1.var_.characterEffect1052ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_3 = 0.2

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_3 and not isNil(var_366_1) then
				local var_366_4 = (arg_363_1.time_ - var_366_2) / var_366_3

				if arg_363_1.var_.characterEffect1052ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_2 + var_366_3 and arg_363_1.time_ < var_366_2 + var_366_3 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1052ui_story then
				arg_363_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_366_5 = 0
			local var_366_6 = 0.275

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_7 = arg_363_1:FormatText(StoryNameCfg[263].name)

				arg_363_1.leftNameTxt_.text = var_366_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_8 = arg_363_1:GetWordFromCfg(115201088)
				local var_366_9 = arg_363_1:FormatText(var_366_8.content)

				arg_363_1.text_.text = var_366_9

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_10 = 11
				local var_366_11 = utf8.len(var_366_9)
				local var_366_12 = var_366_10 <= 0 and var_366_6 or var_366_6 * (var_366_11 / var_366_10)

				if var_366_12 > 0 and var_366_6 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_5
					end
				end

				arg_363_1.text_.text = var_366_9
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201088", "story_v_out_115201.awb") ~= 0 then
					local var_366_13 = manager.audio:GetVoiceLength("story_v_out_115201", "115201088", "story_v_out_115201.awb") / 1000

					if var_366_13 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_5
					end

					if var_366_8.prefab_name ~= "" and arg_363_1.actors_[var_366_8.prefab_name] ~= nil then
						local var_366_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_8.prefab_name].transform, "story_v_out_115201", "115201088", "story_v_out_115201.awb")

						arg_363_1:RecordAudio("115201088", var_366_14)
						arg_363_1:RecordAudio("115201088", var_366_14)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_115201", "115201088", "story_v_out_115201.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_115201", "115201088", "story_v_out_115201.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_15 = math.max(var_366_6, arg_363_1.talkMaxDuration)

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_15 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_5) / var_366_15

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_5 + var_366_15 and arg_363_1.time_ < var_366_5 + var_366_15 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play115201089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 115201089
		arg_367_1.duration_ = 3.87

		local var_367_0 = {
			ja = 3.866,
			ko = 3.566,
			zh = 2.633,
			en = 2.066
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
				arg_367_0:Play115201090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1052ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1052ui_story == nil then
				arg_367_1.var_.characterEffect1052ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1052ui_story and not isNil(var_370_0) then
					local var_370_4 = Mathf.Lerp(0, 0.5, var_370_3)

					arg_367_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1052ui_story.fillRatio = var_370_4
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1052ui_story then
				local var_370_5 = 0.5

				arg_367_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1052ui_story.fillRatio = var_370_5
			end

			local var_370_6 = 0
			local var_370_7 = 0.275

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_8 = arg_367_1:FormatText(StoryNameCfg[273].name)

				arg_367_1.leftNameTxt_.text = var_370_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_9 = arg_367_1:GetWordFromCfg(115201089)
				local var_370_10 = arg_367_1:FormatText(var_370_9.content)

				arg_367_1.text_.text = var_370_10

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 11
				local var_370_12 = utf8.len(var_370_10)
				local var_370_13 = var_370_11 <= 0 and var_370_7 or var_370_7 * (var_370_12 / var_370_11)

				if var_370_13 > 0 and var_370_7 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_10
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201089", "story_v_out_115201.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201089", "story_v_out_115201.awb") / 1000

					if var_370_14 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_6
					end

					if var_370_9.prefab_name ~= "" and arg_367_1.actors_[var_370_9.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_9.prefab_name].transform, "story_v_out_115201", "115201089", "story_v_out_115201.awb")

						arg_367_1:RecordAudio("115201089", var_370_15)
						arg_367_1:RecordAudio("115201089", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_115201", "115201089", "story_v_out_115201.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_115201", "115201089", "story_v_out_115201.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_6) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_6 + var_370_16 and arg_367_1.time_ < var_370_6 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play115201090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 115201090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play115201091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1052ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1052ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, 100, 0)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1052ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, 100, 0)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1024ui_story"].transform
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 then
				arg_371_1.var_.moveOldPos1024ui_story = var_374_9.localPosition
			end

			local var_374_11 = 0.001

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11
				local var_374_13 = Vector3.New(0, 100, 0)

				var_374_9.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1024ui_story, var_374_13, var_374_12)

				local var_374_14 = manager.ui.mainCamera.transform.position - var_374_9.position

				var_374_9.forward = Vector3.New(var_374_14.x, var_374_14.y, var_374_14.z)

				local var_374_15 = var_374_9.localEulerAngles

				var_374_15.z = 0
				var_374_15.x = 0
				var_374_9.localEulerAngles = var_374_15
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 then
				var_374_9.localPosition = Vector3.New(0, 100, 0)

				local var_374_16 = manager.ui.mainCamera.transform.position - var_374_9.position

				var_374_9.forward = Vector3.New(var_374_16.x, var_374_16.y, var_374_16.z)

				local var_374_17 = var_374_9.localEulerAngles

				var_374_17.z = 0
				var_374_17.x = 0
				var_374_9.localEulerAngles = var_374_17
			end

			local var_374_18 = 0
			local var_374_19 = 0.6

			if var_374_18 < arg_371_1.time_ and arg_371_1.time_ <= var_374_18 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_20 = arg_371_1:GetWordFromCfg(115201090)
				local var_374_21 = arg_371_1:FormatText(var_374_20.content)

				arg_371_1.text_.text = var_374_21

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_22 = 24
				local var_374_23 = utf8.len(var_374_21)
				local var_374_24 = var_374_22 <= 0 and var_374_19 or var_374_19 * (var_374_23 / var_374_22)

				if var_374_24 > 0 and var_374_19 < var_374_24 then
					arg_371_1.talkMaxDuration = var_374_24

					if var_374_24 + var_374_18 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_24 + var_374_18
					end
				end

				arg_371_1.text_.text = var_374_21
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_19, arg_371_1.talkMaxDuration)

			if var_374_18 <= arg_371_1.time_ and arg_371_1.time_ < var_374_18 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_18) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_18 + var_374_25 and arg_371_1.time_ < var_374_18 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play115201091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 115201091
		arg_375_1.duration_ = 4.7

		local var_375_0 = {
			ja = 4.7,
			ko = 2.8,
			zh = 3.8,
			en = 2.433
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play115201092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1052ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1052ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0, -1.05, -6.2)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1052ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 then
				arg_375_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_378_11 = arg_375_1.actors_["1052ui_story"]
			local var_378_12 = 0

			if var_378_12 < arg_375_1.time_ and arg_375_1.time_ <= var_378_12 + arg_378_0 and not isNil(var_378_11) and arg_375_1.var_.characterEffect1052ui_story == nil then
				arg_375_1.var_.characterEffect1052ui_story = var_378_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_13 = 0.2

			if var_378_12 <= arg_375_1.time_ and arg_375_1.time_ < var_378_12 + var_378_13 and not isNil(var_378_11) then
				local var_378_14 = (arg_375_1.time_ - var_378_12) / var_378_13

				if arg_375_1.var_.characterEffect1052ui_story and not isNil(var_378_11) then
					arg_375_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_12 + var_378_13 and arg_375_1.time_ < var_378_12 + var_378_13 + arg_378_0 and not isNil(var_378_11) and arg_375_1.var_.characterEffect1052ui_story then
				arg_375_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_378_15 = 0
			local var_378_16 = 0.275

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[263].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(115201091)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 11
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201091", "story_v_out_115201.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_115201", "115201091", "story_v_out_115201.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_115201", "115201091", "story_v_out_115201.awb")

						arg_375_1:RecordAudio("115201091", var_378_24)
						arg_375_1:RecordAudio("115201091", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_115201", "115201091", "story_v_out_115201.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_115201", "115201091", "story_v_out_115201.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play115201092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 115201092
		arg_379_1.duration_ = 6.4

		local var_379_0 = {
			ja = 4.4,
			ko = 5.166,
			zh = 5.033,
			en = 6.4
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play115201093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1052ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1052ui_story == nil then
				arg_379_1.var_.characterEffect1052ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1052ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1052ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1052ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1052ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 0.575

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[261].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_9 = arg_379_1:GetWordFromCfg(115201092)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 23
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201092", "story_v_out_115201.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201092", "story_v_out_115201.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_out_115201", "115201092", "story_v_out_115201.awb")

						arg_379_1:RecordAudio("115201092", var_382_15)
						arg_379_1:RecordAudio("115201092", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_115201", "115201092", "story_v_out_115201.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_115201", "115201092", "story_v_out_115201.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play115201093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 115201093
		arg_383_1.duration_ = 3.2

		local var_383_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 3.2,
			en = 2.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play115201094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1052ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1052ui_story == nil then
				arg_383_1.var_.characterEffect1052ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1052ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1052ui_story then
				arg_383_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_386_4 = 0

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_386_5 = 0
			local var_386_6 = 0.125

			if var_386_5 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_7 = arg_383_1:FormatText(StoryNameCfg[263].name)

				arg_383_1.leftNameTxt_.text = var_386_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_8 = arg_383_1:GetWordFromCfg(115201093)
				local var_386_9 = arg_383_1:FormatText(var_386_8.content)

				arg_383_1.text_.text = var_386_9

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_10 = 5
				local var_386_11 = utf8.len(var_386_9)
				local var_386_12 = var_386_10 <= 0 and var_386_6 or var_386_6 * (var_386_11 / var_386_10)

				if var_386_12 > 0 and var_386_6 < var_386_12 then
					arg_383_1.talkMaxDuration = var_386_12

					if var_386_12 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_12 + var_386_5
					end
				end

				arg_383_1.text_.text = var_386_9
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201093", "story_v_out_115201.awb") ~= 0 then
					local var_386_13 = manager.audio:GetVoiceLength("story_v_out_115201", "115201093", "story_v_out_115201.awb") / 1000

					if var_386_13 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_5
					end

					if var_386_8.prefab_name ~= "" and arg_383_1.actors_[var_386_8.prefab_name] ~= nil then
						local var_386_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_8.prefab_name].transform, "story_v_out_115201", "115201093", "story_v_out_115201.awb")

						arg_383_1:RecordAudio("115201093", var_386_14)
						arg_383_1:RecordAudio("115201093", var_386_14)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_115201", "115201093", "story_v_out_115201.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_115201", "115201093", "story_v_out_115201.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_15 = math.max(var_386_6, arg_383_1.talkMaxDuration)

			if var_386_5 <= arg_383_1.time_ and arg_383_1.time_ < var_386_5 + var_386_15 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_5) / var_386_15

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_5 + var_386_15 and arg_383_1.time_ < var_386_5 + var_386_15 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play115201094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 115201094
		arg_387_1.duration_ = 2.53

		local var_387_0 = {
			ja = 2.3,
			ko = 2.533,
			zh = 1.866,
			en = 1.7
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play115201095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1052ui_story"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1052ui_story == nil then
				arg_387_1.var_.characterEffect1052ui_story = var_390_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.2

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.characterEffect1052ui_story and not isNil(var_390_0) then
					local var_390_4 = Mathf.Lerp(0, 0.5, var_390_3)

					arg_387_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1052ui_story.fillRatio = var_390_4
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1052ui_story then
				local var_390_5 = 0.5

				arg_387_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1052ui_story.fillRatio = var_390_5
			end

			local var_390_6 = 0
			local var_390_7 = 0.225

			if var_390_6 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_8 = arg_387_1:FormatText(StoryNameCfg[261].name)

				arg_387_1.leftNameTxt_.text = var_390_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_9 = arg_387_1:GetWordFromCfg(115201094)
				local var_390_10 = arg_387_1:FormatText(var_390_9.content)

				arg_387_1.text_.text = var_390_10

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_11 = 9
				local var_390_12 = utf8.len(var_390_10)
				local var_390_13 = var_390_11 <= 0 and var_390_7 or var_390_7 * (var_390_12 / var_390_11)

				if var_390_13 > 0 and var_390_7 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_6
					end
				end

				arg_387_1.text_.text = var_390_10
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201094", "story_v_out_115201.awb") ~= 0 then
					local var_390_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201094", "story_v_out_115201.awb") / 1000

					if var_390_14 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_14 + var_390_6
					end

					if var_390_9.prefab_name ~= "" and arg_387_1.actors_[var_390_9.prefab_name] ~= nil then
						local var_390_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_9.prefab_name].transform, "story_v_out_115201", "115201094", "story_v_out_115201.awb")

						arg_387_1:RecordAudio("115201094", var_390_15)
						arg_387_1:RecordAudio("115201094", var_390_15)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_115201", "115201094", "story_v_out_115201.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_115201", "115201094", "story_v_out_115201.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_16 = math.max(var_390_7, arg_387_1.talkMaxDuration)

			if var_390_6 <= arg_387_1.time_ and arg_387_1.time_ < var_390_6 + var_390_16 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_6) / var_390_16

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_6 + var_390_16 and arg_387_1.time_ < var_390_6 + var_390_16 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play115201095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 115201095
		arg_391_1.duration_ = 6.4

		local var_391_0 = {
			ja = 6.4,
			ko = 5.266,
			zh = 5.9,
			en = 5.933
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play115201096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_394_1 = arg_391_1.actors_["1052ui_story"]
			local var_394_2 = 0

			if var_394_2 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1052ui_story == nil then
				arg_391_1.var_.characterEffect1052ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_3 = 0.2

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_3 and not isNil(var_394_1) then
				local var_394_4 = (arg_391_1.time_ - var_394_2) / var_394_3

				if arg_391_1.var_.characterEffect1052ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_2 + var_394_3 and arg_391_1.time_ < var_394_2 + var_394_3 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1052ui_story then
				arg_391_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_394_5 = 0

			if var_394_5 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_394_6 = 0
			local var_394_7 = 0.55

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[263].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_9 = arg_391_1:GetWordFromCfg(115201095)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 22
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201095", "story_v_out_115201.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201095", "story_v_out_115201.awb") / 1000

					if var_394_14 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_6
					end

					if var_394_9.prefab_name ~= "" and arg_391_1.actors_[var_394_9.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_9.prefab_name].transform, "story_v_out_115201", "115201095", "story_v_out_115201.awb")

						arg_391_1:RecordAudio("115201095", var_394_15)
						arg_391_1:RecordAudio("115201095", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_115201", "115201095", "story_v_out_115201.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_115201", "115201095", "story_v_out_115201.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_16 and arg_391_1.time_ < var_394_6 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play115201096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 115201096
		arg_395_1.duration_ = 3.63

		local var_395_0 = {
			ja = 3.333,
			ko = 3.2,
			zh = 3.633,
			en = 3.566
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play115201097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1052ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1052ui_story == nil then
				arg_395_1.var_.characterEffect1052ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1052ui_story and not isNil(var_398_0) then
					local var_398_4 = Mathf.Lerp(0, 0.5, var_398_3)

					arg_395_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1052ui_story.fillRatio = var_398_4
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1052ui_story then
				local var_398_5 = 0.5

				arg_395_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1052ui_story.fillRatio = var_398_5
			end

			local var_398_6 = 0
			local var_398_7 = 0.225

			if var_398_6 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_8 = arg_395_1:FormatText(StoryNameCfg[261].name)

				arg_395_1.leftNameTxt_.text = var_398_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_9 = arg_395_1:GetWordFromCfg(115201096)
				local var_398_10 = arg_395_1:FormatText(var_398_9.content)

				arg_395_1.text_.text = var_398_10

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 9
				local var_398_12 = utf8.len(var_398_10)
				local var_398_13 = var_398_11 <= 0 and var_398_7 or var_398_7 * (var_398_12 / var_398_11)

				if var_398_13 > 0 and var_398_7 < var_398_13 then
					arg_395_1.talkMaxDuration = var_398_13

					if var_398_13 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_13 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_10
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201096", "story_v_out_115201.awb") ~= 0 then
					local var_398_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201096", "story_v_out_115201.awb") / 1000

					if var_398_14 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_14 + var_398_6
					end

					if var_398_9.prefab_name ~= "" and arg_395_1.actors_[var_398_9.prefab_name] ~= nil then
						local var_398_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_9.prefab_name].transform, "story_v_out_115201", "115201096", "story_v_out_115201.awb")

						arg_395_1:RecordAudio("115201096", var_398_15)
						arg_395_1:RecordAudio("115201096", var_398_15)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_115201", "115201096", "story_v_out_115201.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_115201", "115201096", "story_v_out_115201.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_16 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_16 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_16

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_16 and arg_395_1.time_ < var_398_6 + var_398_16 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play115201097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 115201097
		arg_399_1.duration_ = 8.5

		local var_399_0 = {
			ja = 5.866,
			ko = 8.3,
			zh = 7.033,
			en = 8.5
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play115201098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.8

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[262].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(115201097)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 31
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201097", "story_v_out_115201.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201097", "story_v_out_115201.awb") / 1000

					if var_402_8 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_0
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_115201", "115201097", "story_v_out_115201.awb")

						arg_399_1:RecordAudio("115201097", var_402_9)
						arg_399_1:RecordAudio("115201097", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_115201", "115201097", "story_v_out_115201.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_115201", "115201097", "story_v_out_115201.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_10 and arg_399_1.time_ < var_402_0 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play115201098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 115201098
		arg_403_1.duration_ = 14.9

		local var_403_0 = {
			ja = 12.666,
			ko = 8.366,
			zh = 8.8,
			en = 14.9
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
				arg_403_0:Play115201099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.225

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[291].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(115201098)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 49
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201098", "story_v_out_115201.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201098", "story_v_out_115201.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_115201", "115201098", "story_v_out_115201.awb")

						arg_403_1:RecordAudio("115201098", var_406_9)
						arg_403_1:RecordAudio("115201098", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_115201", "115201098", "story_v_out_115201.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_115201", "115201098", "story_v_out_115201.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play115201099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 115201099
		arg_407_1.duration_ = 10.13

		local var_407_0 = {
			ja = 8.233,
			ko = 5.633,
			zh = 5.2,
			en = 10.133
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play115201100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_410_1 = arg_407_1.actors_["1052ui_story"]
			local var_410_2 = 0

			if var_410_2 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1052ui_story == nil then
				arg_407_1.var_.characterEffect1052ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_3 = 0.2

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_3 and not isNil(var_410_1) then
				local var_410_4 = (arg_407_1.time_ - var_410_2) / var_410_3

				if arg_407_1.var_.characterEffect1052ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_2 + var_410_3 and arg_407_1.time_ < var_410_2 + var_410_3 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1052ui_story then
				arg_407_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_410_5 = 0

			if var_410_5 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			local var_410_6 = 0
			local var_410_7 = 0.4

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[263].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_9 = arg_407_1:GetWordFromCfg(115201099)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 16
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201099", "story_v_out_115201.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201099", "story_v_out_115201.awb") / 1000

					if var_410_14 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_6
					end

					if var_410_9.prefab_name ~= "" and arg_407_1.actors_[var_410_9.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_9.prefab_name].transform, "story_v_out_115201", "115201099", "story_v_out_115201.awb")

						arg_407_1:RecordAudio("115201099", var_410_15)
						arg_407_1:RecordAudio("115201099", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_115201", "115201099", "story_v_out_115201.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_115201", "115201099", "story_v_out_115201.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_16 and arg_407_1.time_ < var_410_6 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play115201100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 115201100
		arg_411_1.duration_ = 12.7

		local var_411_0 = {
			ja = 12.633,
			ko = 10.433,
			zh = 9.6,
			en = 12.7
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play115201101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_414_1 = 0
			local var_414_2 = 1.2

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_3 = arg_411_1:FormatText(StoryNameCfg[263].name)

				arg_411_1.leftNameTxt_.text = var_414_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_4 = arg_411_1:GetWordFromCfg(115201100)
				local var_414_5 = arg_411_1:FormatText(var_414_4.content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_6 = 48
				local var_414_7 = utf8.len(var_414_5)
				local var_414_8 = var_414_6 <= 0 and var_414_2 or var_414_2 * (var_414_7 / var_414_6)

				if var_414_8 > 0 and var_414_2 < var_414_8 then
					arg_411_1.talkMaxDuration = var_414_8

					if var_414_8 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201100", "story_v_out_115201.awb") ~= 0 then
					local var_414_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201100", "story_v_out_115201.awb") / 1000

					if var_414_9 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_1
					end

					if var_414_4.prefab_name ~= "" and arg_411_1.actors_[var_414_4.prefab_name] ~= nil then
						local var_414_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_4.prefab_name].transform, "story_v_out_115201", "115201100", "story_v_out_115201.awb")

						arg_411_1:RecordAudio("115201100", var_414_10)
						arg_411_1:RecordAudio("115201100", var_414_10)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_115201", "115201100", "story_v_out_115201.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_115201", "115201100", "story_v_out_115201.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_11 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_11 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_11

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_11 and arg_411_1.time_ < var_414_1 + var_414_11 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play115201101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 115201101
		arg_415_1.duration_ = 4.97

		local var_415_0 = {
			ja = 4.5,
			ko = 4.966,
			zh = 4.2,
			en = 3.366
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
				arg_415_0:Play115201102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_418_1 = 0
			local var_418_2 = 0.4

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_3 = arg_415_1:FormatText(StoryNameCfg[263].name)

				arg_415_1.leftNameTxt_.text = var_418_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(115201101)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 16
				local var_418_7 = utf8.len(var_418_5)
				local var_418_8 = var_418_6 <= 0 and var_418_2 or var_418_2 * (var_418_7 / var_418_6)

				if var_418_8 > 0 and var_418_2 < var_418_8 then
					arg_415_1.talkMaxDuration = var_418_8

					if var_418_8 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201101", "story_v_out_115201.awb") ~= 0 then
					local var_418_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201101", "story_v_out_115201.awb") / 1000

					if var_418_9 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_1
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_out_115201", "115201101", "story_v_out_115201.awb")

						arg_415_1:RecordAudio("115201101", var_418_10)
						arg_415_1:RecordAudio("115201101", var_418_10)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_115201", "115201101", "story_v_out_115201.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_115201", "115201101", "story_v_out_115201.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_11 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_11 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_11

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_11 and arg_415_1.time_ < var_418_1 + var_418_11 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play115201102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 115201102
		arg_419_1.duration_ = 11

		local var_419_0 = {
			ja = 11,
			ko = 6.266,
			zh = 5.533,
			en = 7.766
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
				arg_419_0:Play115201103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1052ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1052ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, 100, 0)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1052ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, 100, 0)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1024ui_story"].transform
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 then
				arg_419_1.var_.moveOldPos1024ui_story = var_422_9.localPosition
			end

			local var_422_11 = 0.001

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11
				local var_422_13 = Vector3.New(0, -1, -6.05)

				var_422_9.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1024ui_story, var_422_13, var_422_12)

				local var_422_14 = manager.ui.mainCamera.transform.position - var_422_9.position

				var_422_9.forward = Vector3.New(var_422_14.x, var_422_14.y, var_422_14.z)

				local var_422_15 = var_422_9.localEulerAngles

				var_422_15.z = 0
				var_422_15.x = 0
				var_422_9.localEulerAngles = var_422_15
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 then
				var_422_9.localPosition = Vector3.New(0, -1, -6.05)

				local var_422_16 = manager.ui.mainCamera.transform.position - var_422_9.position

				var_422_9.forward = Vector3.New(var_422_16.x, var_422_16.y, var_422_16.z)

				local var_422_17 = var_422_9.localEulerAngles

				var_422_17.z = 0
				var_422_17.x = 0
				var_422_9.localEulerAngles = var_422_17
			end

			local var_422_18 = 0

			if var_422_18 < arg_419_1.time_ and arg_419_1.time_ <= var_422_18 + arg_422_0 then
				arg_419_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_422_19 = 0

			if var_422_19 < arg_419_1.time_ and arg_419_1.time_ <= var_422_19 + arg_422_0 then
				arg_419_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_422_20 = arg_419_1.actors_["1024ui_story"]
			local var_422_21 = 0

			if var_422_21 < arg_419_1.time_ and arg_419_1.time_ <= var_422_21 + arg_422_0 and not isNil(var_422_20) and arg_419_1.var_.characterEffect1024ui_story == nil then
				arg_419_1.var_.characterEffect1024ui_story = var_422_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_22 = 0.2

			if var_422_21 <= arg_419_1.time_ and arg_419_1.time_ < var_422_21 + var_422_22 and not isNil(var_422_20) then
				local var_422_23 = (arg_419_1.time_ - var_422_21) / var_422_22

				if arg_419_1.var_.characterEffect1024ui_story and not isNil(var_422_20) then
					arg_419_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_21 + var_422_22 and arg_419_1.time_ < var_422_21 + var_422_22 + arg_422_0 and not isNil(var_422_20) and arg_419_1.var_.characterEffect1024ui_story then
				arg_419_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_422_24 = 0
			local var_422_25 = 0.825

			if var_422_24 < arg_419_1.time_ and arg_419_1.time_ <= var_422_24 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_26 = arg_419_1:FormatText(StoryNameCfg[265].name)

				arg_419_1.leftNameTxt_.text = var_422_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_27 = arg_419_1:GetWordFromCfg(115201102)
				local var_422_28 = arg_419_1:FormatText(var_422_27.content)

				arg_419_1.text_.text = var_422_28

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_29 = 33
				local var_422_30 = utf8.len(var_422_28)
				local var_422_31 = var_422_29 <= 0 and var_422_25 or var_422_25 * (var_422_30 / var_422_29)

				if var_422_31 > 0 and var_422_25 < var_422_31 then
					arg_419_1.talkMaxDuration = var_422_31

					if var_422_31 + var_422_24 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_31 + var_422_24
					end
				end

				arg_419_1.text_.text = var_422_28
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201102", "story_v_out_115201.awb") ~= 0 then
					local var_422_32 = manager.audio:GetVoiceLength("story_v_out_115201", "115201102", "story_v_out_115201.awb") / 1000

					if var_422_32 + var_422_24 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_32 + var_422_24
					end

					if var_422_27.prefab_name ~= "" and arg_419_1.actors_[var_422_27.prefab_name] ~= nil then
						local var_422_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_27.prefab_name].transform, "story_v_out_115201", "115201102", "story_v_out_115201.awb")

						arg_419_1:RecordAudio("115201102", var_422_33)
						arg_419_1:RecordAudio("115201102", var_422_33)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_115201", "115201102", "story_v_out_115201.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_115201", "115201102", "story_v_out_115201.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_34 = math.max(var_422_25, arg_419_1.talkMaxDuration)

			if var_422_24 <= arg_419_1.time_ and arg_419_1.time_ < var_422_24 + var_422_34 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_24) / var_422_34

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_24 + var_422_34 and arg_419_1.time_ < var_422_24 + var_422_34 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play115201103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 115201103
		arg_423_1.duration_ = 6.67

		local var_423_0 = {
			ja = 6.666,
			ko = 5.6,
			zh = 4.033,
			en = 4.2
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
				arg_423_0:Play115201104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1024ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1024ui_story == nil then
				arg_423_1.var_.characterEffect1024ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1024ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1024ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1024ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1024ui_story.fillRatio = var_426_5
			end

			local var_426_6 = 0
			local var_426_7 = 0.525

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_8 = arg_423_1:FormatText(StoryNameCfg[261].name)

				arg_423_1.leftNameTxt_.text = var_426_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_9 = arg_423_1:GetWordFromCfg(115201103)
				local var_426_10 = arg_423_1:FormatText(var_426_9.content)

				arg_423_1.text_.text = var_426_10

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_11 = 21
				local var_426_12 = utf8.len(var_426_10)
				local var_426_13 = var_426_11 <= 0 and var_426_7 or var_426_7 * (var_426_12 / var_426_11)

				if var_426_13 > 0 and var_426_7 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_10
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201103", "story_v_out_115201.awb") ~= 0 then
					local var_426_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201103", "story_v_out_115201.awb") / 1000

					if var_426_14 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_14 + var_426_6
					end

					if var_426_9.prefab_name ~= "" and arg_423_1.actors_[var_426_9.prefab_name] ~= nil then
						local var_426_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_9.prefab_name].transform, "story_v_out_115201", "115201103", "story_v_out_115201.awb")

						arg_423_1:RecordAudio("115201103", var_426_15)
						arg_423_1:RecordAudio("115201103", var_426_15)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_115201", "115201103", "story_v_out_115201.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_115201", "115201103", "story_v_out_115201.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_16 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_16 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_16

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_16 and arg_423_1.time_ < var_426_6 + var_426_16 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play115201104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 115201104
		arg_427_1.duration_ = 5.27

		local var_427_0 = {
			ja = 5.266,
			ko = 4.533,
			zh = 4.033,
			en = 3.133
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play115201105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_430_1 = arg_427_1.actors_["1024ui_story"]
			local var_430_2 = 0

			if var_430_2 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1024ui_story == nil then
				arg_427_1.var_.characterEffect1024ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_3 = 0.2

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_3 and not isNil(var_430_1) then
				local var_430_4 = (arg_427_1.time_ - var_430_2) / var_430_3

				if arg_427_1.var_.characterEffect1024ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_2 + var_430_3 and arg_427_1.time_ < var_430_2 + var_430_3 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1024ui_story then
				arg_427_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_430_5 = 0

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_430_6 = 0
			local var_430_7 = 0.475

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[265].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_9 = arg_427_1:GetWordFromCfg(115201104)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 19
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201104", "story_v_out_115201.awb") ~= 0 then
					local var_430_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201104", "story_v_out_115201.awb") / 1000

					if var_430_14 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_6
					end

					if var_430_9.prefab_name ~= "" and arg_427_1.actors_[var_430_9.prefab_name] ~= nil then
						local var_430_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_9.prefab_name].transform, "story_v_out_115201", "115201104", "story_v_out_115201.awb")

						arg_427_1:RecordAudio("115201104", var_430_15)
						arg_427_1:RecordAudio("115201104", var_430_15)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_115201", "115201104", "story_v_out_115201.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_115201", "115201104", "story_v_out_115201.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_16 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_16

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_16 and arg_427_1.time_ < var_430_6 + var_430_16 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play115201105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 115201105
		arg_431_1.duration_ = 9.6

		local var_431_0 = {
			ja = 8.033,
			ko = 8.466,
			zh = 9.6,
			en = 6.833
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
				arg_431_0:Play115201106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1024ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos1024ui_story = var_434_0.localPosition
			end

			local var_434_2 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2
				local var_434_4 = Vector3.New(0, 100, 0)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1024ui_story, var_434_4, var_434_3)

				local var_434_5 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_5.x, var_434_5.y, var_434_5.z)

				local var_434_6 = var_434_0.localEulerAngles

				var_434_6.z = 0
				var_434_6.x = 0
				var_434_0.localEulerAngles = var_434_6
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0, 100, 0)

				local var_434_7 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_7.x, var_434_7.y, var_434_7.z)

				local var_434_8 = var_434_0.localEulerAngles

				var_434_8.z = 0
				var_434_8.x = 0
				var_434_0.localEulerAngles = var_434_8
			end

			local var_434_9 = arg_431_1.actors_["1017ui_story"].transform
			local var_434_10 = 0

			if var_434_10 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 then
				arg_431_1.var_.moveOldPos1017ui_story = var_434_9.localPosition
			end

			local var_434_11 = 0.001

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_11 then
				local var_434_12 = (arg_431_1.time_ - var_434_10) / var_434_11
				local var_434_13 = Vector3.New(-0.7, -1.01, -6.05)

				var_434_9.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1017ui_story, var_434_13, var_434_12)

				local var_434_14 = manager.ui.mainCamera.transform.position - var_434_9.position

				var_434_9.forward = Vector3.New(var_434_14.x, var_434_14.y, var_434_14.z)

				local var_434_15 = var_434_9.localEulerAngles

				var_434_15.z = 0
				var_434_15.x = 0
				var_434_9.localEulerAngles = var_434_15
			end

			if arg_431_1.time_ >= var_434_10 + var_434_11 and arg_431_1.time_ < var_434_10 + var_434_11 + arg_434_0 then
				var_434_9.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_434_16 = manager.ui.mainCamera.transform.position - var_434_9.position

				var_434_9.forward = Vector3.New(var_434_16.x, var_434_16.y, var_434_16.z)

				local var_434_17 = var_434_9.localEulerAngles

				var_434_17.z = 0
				var_434_17.x = 0
				var_434_9.localEulerAngles = var_434_17
			end

			local var_434_18 = 0

			if var_434_18 < arg_431_1.time_ and arg_431_1.time_ <= var_434_18 + arg_434_0 then
				arg_431_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			local var_434_19 = 0

			if var_434_19 < arg_431_1.time_ and arg_431_1.time_ <= var_434_19 + arg_434_0 then
				arg_431_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_434_20 = arg_431_1.actors_["1017ui_story"]
			local var_434_21 = 0

			if var_434_21 < arg_431_1.time_ and arg_431_1.time_ <= var_434_21 + arg_434_0 and not isNil(var_434_20) and arg_431_1.var_.characterEffect1017ui_story == nil then
				arg_431_1.var_.characterEffect1017ui_story = var_434_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_22 = 0.2

			if var_434_21 <= arg_431_1.time_ and arg_431_1.time_ < var_434_21 + var_434_22 and not isNil(var_434_20) then
				local var_434_23 = (arg_431_1.time_ - var_434_21) / var_434_22

				if arg_431_1.var_.characterEffect1017ui_story and not isNil(var_434_20) then
					arg_431_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_21 + var_434_22 and arg_431_1.time_ < var_434_21 + var_434_22 + arg_434_0 and not isNil(var_434_20) and arg_431_1.var_.characterEffect1017ui_story then
				arg_431_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_434_24 = 0
			local var_434_25 = 1.05

			if var_434_24 < arg_431_1.time_ and arg_431_1.time_ <= var_434_24 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_26 = arg_431_1:FormatText(StoryNameCfg[273].name)

				arg_431_1.leftNameTxt_.text = var_434_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_27 = arg_431_1:GetWordFromCfg(115201105)
				local var_434_28 = arg_431_1:FormatText(var_434_27.content)

				arg_431_1.text_.text = var_434_28

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_29 = 42
				local var_434_30 = utf8.len(var_434_28)
				local var_434_31 = var_434_29 <= 0 and var_434_25 or var_434_25 * (var_434_30 / var_434_29)

				if var_434_31 > 0 and var_434_25 < var_434_31 then
					arg_431_1.talkMaxDuration = var_434_31

					if var_434_31 + var_434_24 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_31 + var_434_24
					end
				end

				arg_431_1.text_.text = var_434_28
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201105", "story_v_out_115201.awb") ~= 0 then
					local var_434_32 = manager.audio:GetVoiceLength("story_v_out_115201", "115201105", "story_v_out_115201.awb") / 1000

					if var_434_32 + var_434_24 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_32 + var_434_24
					end

					if var_434_27.prefab_name ~= "" and arg_431_1.actors_[var_434_27.prefab_name] ~= nil then
						local var_434_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_27.prefab_name].transform, "story_v_out_115201", "115201105", "story_v_out_115201.awb")

						arg_431_1:RecordAudio("115201105", var_434_33)
						arg_431_1:RecordAudio("115201105", var_434_33)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_115201", "115201105", "story_v_out_115201.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_115201", "115201105", "story_v_out_115201.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_34 = math.max(var_434_25, arg_431_1.talkMaxDuration)

			if var_434_24 <= arg_431_1.time_ and arg_431_1.time_ < var_434_24 + var_434_34 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_24) / var_434_34

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_24 + var_434_34 and arg_431_1.time_ < var_434_24 + var_434_34 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play115201106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 115201106
		arg_435_1.duration_ = 4.87

		local var_435_0 = {
			ja = 4.866,
			ko = 2.7,
			zh = 4.133,
			en = 4.3
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
			arg_435_1.auto_ = false
		end

		function arg_435_1.playNext_(arg_437_0)
			arg_435_1.onStoryFinished_()
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1017ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1017ui_story == nil then
				arg_435_1.var_.characterEffect1017ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1017ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1017ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1017ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1017ui_story.fillRatio = var_438_5
			end

			local var_438_6 = arg_435_1.actors_["1052ui_story"].transform
			local var_438_7 = 0

			if var_438_7 < arg_435_1.time_ and arg_435_1.time_ <= var_438_7 + arg_438_0 then
				arg_435_1.var_.moveOldPos1052ui_story = var_438_6.localPosition
			end

			local var_438_8 = 0.001

			if var_438_7 <= arg_435_1.time_ and arg_435_1.time_ < var_438_7 + var_438_8 then
				local var_438_9 = (arg_435_1.time_ - var_438_7) / var_438_8
				local var_438_10 = Vector3.New(0.7, -1.05, -6.2)

				var_438_6.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1052ui_story, var_438_10, var_438_9)

				local var_438_11 = manager.ui.mainCamera.transform.position - var_438_6.position

				var_438_6.forward = Vector3.New(var_438_11.x, var_438_11.y, var_438_11.z)

				local var_438_12 = var_438_6.localEulerAngles

				var_438_12.z = 0
				var_438_12.x = 0
				var_438_6.localEulerAngles = var_438_12
			end

			if arg_435_1.time_ >= var_438_7 + var_438_8 and arg_435_1.time_ < var_438_7 + var_438_8 + arg_438_0 then
				var_438_6.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_438_13 = manager.ui.mainCamera.transform.position - var_438_6.position

				var_438_6.forward = Vector3.New(var_438_13.x, var_438_13.y, var_438_13.z)

				local var_438_14 = var_438_6.localEulerAngles

				var_438_14.z = 0
				var_438_14.x = 0
				var_438_6.localEulerAngles = var_438_14
			end

			local var_438_15 = 0

			if var_438_15 < arg_435_1.time_ and arg_435_1.time_ <= var_438_15 + arg_438_0 then
				arg_435_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_438_16 = 0

			if var_438_16 < arg_435_1.time_ and arg_435_1.time_ <= var_438_16 + arg_438_0 then
				arg_435_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_438_17 = arg_435_1.actors_["1052ui_story"]
			local var_438_18 = 0

			if var_438_18 < arg_435_1.time_ and arg_435_1.time_ <= var_438_18 + arg_438_0 and not isNil(var_438_17) and arg_435_1.var_.characterEffect1052ui_story == nil then
				arg_435_1.var_.characterEffect1052ui_story = var_438_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_19 = 0.2

			if var_438_18 <= arg_435_1.time_ and arg_435_1.time_ < var_438_18 + var_438_19 and not isNil(var_438_17) then
				local var_438_20 = (arg_435_1.time_ - var_438_18) / var_438_19

				if arg_435_1.var_.characterEffect1052ui_story and not isNil(var_438_17) then
					arg_435_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_18 + var_438_19 and arg_435_1.time_ < var_438_18 + var_438_19 + arg_438_0 and not isNil(var_438_17) and arg_435_1.var_.characterEffect1052ui_story then
				arg_435_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_438_21 = 0
			local var_438_22 = 0.25

			if var_438_21 < arg_435_1.time_ and arg_435_1.time_ <= var_438_21 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_23 = arg_435_1:FormatText(StoryNameCfg[263].name)

				arg_435_1.leftNameTxt_.text = var_438_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_24 = arg_435_1:GetWordFromCfg(115201106)
				local var_438_25 = arg_435_1:FormatText(var_438_24.content)

				arg_435_1.text_.text = var_438_25

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_26 = 10
				local var_438_27 = utf8.len(var_438_25)
				local var_438_28 = var_438_26 <= 0 and var_438_22 or var_438_22 * (var_438_27 / var_438_26)

				if var_438_28 > 0 and var_438_22 < var_438_28 then
					arg_435_1.talkMaxDuration = var_438_28

					if var_438_28 + var_438_21 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_28 + var_438_21
					end
				end

				arg_435_1.text_.text = var_438_25
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201106", "story_v_out_115201.awb") ~= 0 then
					local var_438_29 = manager.audio:GetVoiceLength("story_v_out_115201", "115201106", "story_v_out_115201.awb") / 1000

					if var_438_29 + var_438_21 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_29 + var_438_21
					end

					if var_438_24.prefab_name ~= "" and arg_435_1.actors_[var_438_24.prefab_name] ~= nil then
						local var_438_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_24.prefab_name].transform, "story_v_out_115201", "115201106", "story_v_out_115201.awb")

						arg_435_1:RecordAudio("115201106", var_438_30)
						arg_435_1:RecordAudio("115201106", var_438_30)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_115201", "115201106", "story_v_out_115201.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_115201", "115201106", "story_v_out_115201.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_31 = math.max(var_438_22, arg_435_1.talkMaxDuration)

			if var_438_21 <= arg_435_1.time_ and arg_435_1.time_ < var_438_21 + var_438_31 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_21) / var_438_31

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_21 + var_438_31 and arg_435_1.time_ < var_438_21 + var_438_31 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/RO0205",
		"TextureConfig/Background/G02j",
		"TextureConfig/Background/RO0206",
		"TextureConfig/Background/G03_1"
	},
	voices = {
		"story_v_out_115201.awb"
	}
}
