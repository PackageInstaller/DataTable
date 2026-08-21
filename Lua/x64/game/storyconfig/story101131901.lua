return {
	Play113191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113191001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "OM0106"

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
				local var_4_5 = arg_1_1.bgs_.OM0106

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
					if iter_4_0 ~= "OM0106" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.OM0106.transform
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0106 = var_4_16.localPosition
			end

			local var_4_18 = 0.001

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / var_4_18
				local var_4_20 = Vector3.New(-1.5, -1, -0.5)

				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0106, var_4_20, var_4_19)
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(-1.5, -1, -0.5)
			end

			local var_4_21 = arg_1_1.bgs_.OM0106.transform
			local var_4_22 = 0.034

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0106 = var_4_21.localPosition
			end

			local var_4_23 = 3

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Vector3.New(-1.2, -1, -0.5)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0106, var_4_25, var_4_24)
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(-1.2, -1, -0.5)
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_27 = 2

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Color.New(0, 0, 0)

				var_4_29.a = Mathf.Lerp(1, 0, var_4_28)
				arg_1_1.mask_.color = var_4_29
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				local var_4_30 = Color.New(0, 0, 0)
				local var_4_31 = 0

				arg_1_1.mask_.enabled = false
				var_4_30.a = var_4_31
				arg_1_1.mask_.color = var_4_30
			end

			local var_4_32 = 0

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_33 = 3.034

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 2
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 2
			local var_4_47 = 0.05

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_49 = arg_1_1:GetWordFromCfg(113191001)
				local var_4_50 = arg_1_1:FormatText(var_4_49.content)

				arg_1_1.text_.text = var_4_50

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_51 = 2
				local var_4_52 = utf8.len(var_4_50)
				local var_4_53 = var_4_51 <= 0 and var_4_47 or var_4_47 * (var_4_52 / var_4_51)

				if var_4_53 > 0 and var_4_47 < var_4_53 then
					arg_1_1.talkMaxDuration = var_4_53
					var_4_46 = var_4_46 + 0.3

					if var_4_53 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_50
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_54 = var_4_46 + 0.3
			local var_4_55 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_55

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113191002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			ja = 1.3,
			ko = 2.2,
			zh = 3.2,
			en = 2.3
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
				arg_9_0:Play113191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.05

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[208].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(113191002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 2
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191002", "story_v_out_113191.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191002", "story_v_out_113191.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_113191", "113191002", "story_v_out_113191.awb")

						arg_9_1:RecordAudio("113191002", var_12_9)
						arg_9_1:RecordAudio("113191002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113191", "113191002", "story_v_out_113191.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113191", "113191002", "story_v_out_113191.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play113191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_2 = "play"
				local var_16_3 = "music"

				arg_13_1:AudioAction(var_16_2, var_16_3, "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed.awb")

				local var_16_4 = ""
				local var_16_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed")

				if var_16_5 ~= "" then
					if arg_13_1.bgmTxt_.text ~= var_16_5 and arg_13_1.bgmTxt_.text ~= "" then
						if arg_13_1.bgmTxt2_.text ~= "" then
							arg_13_1.bgmTxt_.text = arg_13_1.bgmTxt2_.text
						end

						arg_13_1.bgmTxt2_.text = var_16_5

						arg_13_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_13_1.bgmTxt_.text = var_16_5
						arg_13_1.bgmTxt2_.text = var_16_5
					end

					if arg_13_1.bgmTimer then
						arg_13_1.bgmTimer:Stop()

						arg_13_1.bgmTimer = nil
					end

					if arg_13_1.settingData.show_music_name == 1 then
						arg_13_1.musicController:SetSelectedState("show")
						arg_13_1.musicAnimator_:Play("open", 0, 0)

						if arg_13_1.settingData.music_time ~= 0 then
							arg_13_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_13_1.settingData.music_time), function()
								if arg_13_1 == nil or isNil(arg_13_1.bgmTxt_) then
									return
								end

								arg_13_1.musicController:SetSelectedState("hide")
								arg_13_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_16_6 = 0
			local var_16_7 = 0.8

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(113191003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 32
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113191004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 113191004
		arg_18_1.duration_ = 8.17

		local var_18_0 = {
			ja = 5.533,
			ko = 5.366,
			zh = 8.166,
			en = 7.5
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play113191005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.35

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[208].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(113191004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 14
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191004", "story_v_out_113191.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191004", "story_v_out_113191.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_113191", "113191004", "story_v_out_113191.awb")

						arg_18_1:RecordAudio("113191004", var_21_9)
						arg_18_1:RecordAudio("113191004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_113191", "113191004", "story_v_out_113191.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_113191", "113191004", "story_v_out_113191.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play113191005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 113191005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play113191006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "OM0103"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 0

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.OM0103

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "OM0103" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 0

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_17 = 2

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_17 then
				local var_25_18 = (arg_22_1.time_ - var_25_16) / var_25_17
				local var_25_19 = Color.New(1, 1, 1)

				var_25_19.a = Mathf.Lerp(1, 0, var_25_18)
				arg_22_1.mask_.color = var_25_19
			end

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				local var_25_20 = Color.New(1, 1, 1)
				local var_25_21 = 0

				arg_22_1.mask_.enabled = false
				var_25_20.a = var_25_21
				arg_22_1.mask_.color = var_25_20
			end

			local var_25_22 = 0

			arg_22_1.isInRecall_ = false

			if var_25_22 < arg_22_1.time_ and arg_22_1.time_ <= var_25_22 + arg_25_0 then
				arg_22_1.screenFilterGo_:SetActive(true)

				arg_22_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_25_2, iter_25_3 in pairs(arg_22_1.actors_) do
					local var_25_23 = iter_25_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_25_4, iter_25_5 in ipairs(var_25_23) do
						if iter_25_5.color.r > 0.51 then
							iter_25_5.color = Color.New(1, 1, 1)
						else
							iter_25_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_25_24 = 2

			if var_25_22 <= arg_22_1.time_ and arg_22_1.time_ < var_25_22 + var_25_24 then
				local var_25_25 = (arg_22_1.time_ - var_25_22) / var_25_24

				arg_22_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_25_25)
			end

			if arg_22_1.time_ >= var_25_22 + var_25_24 and arg_22_1.time_ < var_25_22 + var_25_24 + arg_25_0 then
				arg_22_1.screenFilterEffect_.weight = 1
			end

			local var_25_26 = 0
			local var_25_27 = 0.05

			if var_25_26 < arg_22_1.time_ and arg_22_1.time_ <= var_25_26 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_28 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_28:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_29 = arg_22_1:GetWordFromCfg(113191001)
				local var_25_30 = arg_22_1:FormatText(var_25_29.content)

				arg_22_1.text_.text = var_25_30

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_31 = 2
				local var_25_32 = utf8.len(var_25_30)
				local var_25_33 = var_25_31 <= 0 and var_25_27 or var_25_27 * (var_25_32 / var_25_31)

				if var_25_33 > 0 and var_25_27 < var_25_33 then
					arg_22_1.talkMaxDuration = var_25_33
					var_25_26 = var_25_26 + 0.3

					if var_25_33 + var_25_26 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_33 + var_25_26
					end
				end

				arg_22_1.text_.text = var_25_30
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_34 = var_25_26 + 0.3
			local var_25_35 = math.max(var_25_27, arg_22_1.talkMaxDuration)

			if var_25_34 <= arg_22_1.time_ and arg_22_1.time_ < var_25_34 + var_25_35 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_34) / var_25_35

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_34 + var_25_35 and arg_22_1.time_ < var_25_34 + var_25_35 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play113191006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113191006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play113191007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "OM0105"

			if arg_28_1.bgs_[var_31_0] == nil then
				local var_31_1 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_0)
				var_31_1.name = var_31_0
				var_31_1.transform.parent = arg_28_1.stage_.transform
				var_31_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_0] = var_31_1
			end

			local var_31_2 = 0

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				local var_31_3 = manager.ui.mainCamera.transform.localPosition
				local var_31_4 = Vector3.New(0, 0, 10) + Vector3.New(var_31_3.x, var_31_3.y, 0)
				local var_31_5 = arg_28_1.bgs_.OM0105

				var_31_5.transform.localPosition = var_31_4
				var_31_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_6 = var_31_5:GetComponent("SpriteRenderer")

				if var_31_6 and var_31_6.sprite then
					local var_31_7 = (var_31_5.transform.localPosition - var_31_3).z
					local var_31_8 = manager.ui.mainCameraCom_
					local var_31_9 = 2 * var_31_7 * Mathf.Tan(var_31_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_10 = var_31_9 * var_31_8.aspect
					local var_31_11 = var_31_6.sprite.bounds.size.x
					local var_31_12 = var_31_6.sprite.bounds.size.y
					local var_31_13 = var_31_10 / var_31_11
					local var_31_14 = var_31_9 / var_31_12
					local var_31_15 = var_31_14 < var_31_13 and var_31_13 or var_31_14

					var_31_5.transform.localScale = Vector3.New(var_31_15, var_31_15, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "OM0105" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_17 = 2

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Color.New(1, 1, 1)

				var_31_19.a = Mathf.Lerp(1, 0, var_31_18)
				arg_28_1.mask_.color = var_31_19
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				local var_31_20 = Color.New(1, 1, 1)
				local var_31_21 = 0

				arg_28_1.mask_.enabled = false
				var_31_20.a = var_31_21
				arg_28_1.mask_.color = var_31_20
			end

			local var_31_22 = 0
			local var_31_23 = 0.05

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_24 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_24:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(113191001)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 2
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29
					var_31_22 = var_31_22 + 0.3

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = var_31_22 + 0.3
			local var_31_31 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_30 <= arg_28_1.time_ and arg_28_1.time_ < var_31_30 + var_31_31 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_30) / var_31_31

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_30 + var_31_31 and arg_28_1.time_ < var_31_30 + var_31_31 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play113191007 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 113191007
		arg_34_1.duration_ = 9.7

		local var_34_0 = {
			ja = 8.466,
			ko = 7.633,
			zh = 9.7,
			en = 7.466
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play113191008(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 2

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				local var_37_1 = manager.ui.mainCamera.transform.localPosition
				local var_37_2 = Vector3.New(0, 0, 10) + Vector3.New(var_37_1.x, var_37_1.y, 0)
				local var_37_3 = arg_34_1.bgs_.OM0106

				var_37_3.transform.localPosition = var_37_2
				var_37_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_4 = var_37_3:GetComponent("SpriteRenderer")

				if var_37_4 and var_37_4.sprite then
					local var_37_5 = (var_37_3.transform.localPosition - var_37_1).z
					local var_37_6 = manager.ui.mainCameraCom_
					local var_37_7 = 2 * var_37_5 * Mathf.Tan(var_37_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_37_8 = var_37_7 * var_37_6.aspect
					local var_37_9 = var_37_4.sprite.bounds.size.x
					local var_37_10 = var_37_4.sprite.bounds.size.y
					local var_37_11 = var_37_8 / var_37_9
					local var_37_12 = var_37_7 / var_37_10
					local var_37_13 = var_37_12 < var_37_11 and var_37_11 or var_37_12

					var_37_3.transform.localScale = Vector3.New(var_37_13, var_37_13, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "OM0106" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_14 = 0

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_15 = 2

			if var_37_14 <= arg_34_1.time_ and arg_34_1.time_ < var_37_14 + var_37_15 then
				local var_37_16 = (arg_34_1.time_ - var_37_14) / var_37_15
				local var_37_17 = Color.New(0, 0, 0)

				var_37_17.a = Mathf.Lerp(0, 1, var_37_16)
				arg_34_1.mask_.color = var_37_17
			end

			if arg_34_1.time_ >= var_37_14 + var_37_15 and arg_34_1.time_ < var_37_14 + var_37_15 + arg_37_0 then
				local var_37_18 = Color.New(0, 0, 0)

				var_37_18.a = 1
				arg_34_1.mask_.color = var_37_18
			end

			local var_37_19 = 2

			if var_37_19 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_20 = 2

			if var_37_19 <= arg_34_1.time_ and arg_34_1.time_ < var_37_19 + var_37_20 then
				local var_37_21 = (arg_34_1.time_ - var_37_19) / var_37_20
				local var_37_22 = Color.New(0, 0, 0)

				var_37_22.a = Mathf.Lerp(1, 0, var_37_21)
				arg_34_1.mask_.color = var_37_22
			end

			if arg_34_1.time_ >= var_37_19 + var_37_20 and arg_34_1.time_ < var_37_19 + var_37_20 + arg_37_0 then
				local var_37_23 = Color.New(0, 0, 0)
				local var_37_24 = 0

				arg_34_1.mask_.enabled = false
				var_37_23.a = var_37_24
				arg_34_1.mask_.color = var_37_23
			end

			local var_37_25 = 2

			arg_34_1.isInRecall_ = false

			if var_37_25 < arg_34_1.time_ and arg_34_1.time_ <= var_37_25 + arg_37_0 then
				arg_34_1.screenFilterGo_:SetActive(false)

				for iter_37_2, iter_37_3 in pairs(arg_34_1.actors_) do
					local var_37_26 = iter_37_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_37_4, iter_37_5 in ipairs(var_37_26) do
						if iter_37_5.color.r > 0.51 then
							iter_37_5.color = Color.New(1, 1, 1)
						else
							iter_37_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_37_27 = 0.0166666666666667

			if var_37_25 <= arg_34_1.time_ and arg_34_1.time_ < var_37_25 + var_37_27 then
				local var_37_28 = (arg_34_1.time_ - var_37_25) / var_37_27

				arg_34_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_37_28)
			end

			if arg_34_1.time_ >= var_37_25 + var_37_27 and arg_34_1.time_ < var_37_25 + var_37_27 + arg_37_0 then
				arg_34_1.screenFilterEffect_.weight = 0
			end

			local var_37_29 = arg_34_1.bgs_.OM0106.transform
			local var_37_30 = 2

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1.var_.moveOldPosOM0106 = var_37_29.localPosition
			end

			local var_37_31 = 0.001

			if var_37_30 <= arg_34_1.time_ and arg_34_1.time_ < var_37_30 + var_37_31 then
				local var_37_32 = (arg_34_1.time_ - var_37_30) / var_37_31
				local var_37_33 = Vector3.New(0, 1, 9.6)

				var_37_29.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosOM0106, var_37_33, var_37_32)
			end

			if arg_34_1.time_ >= var_37_30 + var_37_31 and arg_34_1.time_ < var_37_30 + var_37_31 + arg_37_0 then
				var_37_29.localPosition = Vector3.New(0, 1, 9.6)
			end

			local var_37_34 = arg_34_1.bgs_.OM0106.transform
			local var_37_35 = 2.034

			if var_37_35 < arg_34_1.time_ and arg_34_1.time_ <= var_37_35 + arg_37_0 then
				arg_34_1.var_.moveOldPosOM0106 = var_37_34.localPosition
			end

			local var_37_36 = 3

			if var_37_35 <= arg_34_1.time_ and arg_34_1.time_ < var_37_35 + var_37_36 then
				local var_37_37 = (arg_34_1.time_ - var_37_35) / var_37_36
				local var_37_38 = Vector3.New(0, 1, 10)

				var_37_34.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosOM0106, var_37_38, var_37_37)
			end

			if arg_34_1.time_ >= var_37_35 + var_37_36 and arg_34_1.time_ < var_37_35 + var_37_36 + arg_37_0 then
				var_37_34.localPosition = Vector3.New(0, 1, 10)
			end

			local var_37_39 = 4

			if var_37_39 < arg_34_1.time_ and arg_34_1.time_ <= var_37_39 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			local var_37_40 = 1.034

			if arg_34_1.time_ >= var_37_39 + var_37_40 and arg_34_1.time_ < var_37_39 + var_37_40 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_41 = 4
			local var_37_42 = 0.2

			if var_37_41 < arg_34_1.time_ and arg_34_1.time_ <= var_37_41 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_43 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_43:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_44 = arg_34_1:FormatText(StoryNameCfg[208].name)

				arg_34_1.leftNameTxt_.text = var_37_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_45 = arg_34_1:GetWordFromCfg(113191007)
				local var_37_46 = arg_34_1:FormatText(var_37_45.content)

				arg_34_1.text_.text = var_37_46

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_47 = 8
				local var_37_48 = utf8.len(var_37_46)
				local var_37_49 = var_37_47 <= 0 and var_37_42 or var_37_42 * (var_37_48 / var_37_47)

				if var_37_49 > 0 and var_37_42 < var_37_49 then
					arg_34_1.talkMaxDuration = var_37_49
					var_37_41 = var_37_41 + 0.3

					if var_37_49 + var_37_41 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_49 + var_37_41
					end
				end

				arg_34_1.text_.text = var_37_46
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191007", "story_v_out_113191.awb") ~= 0 then
					local var_37_50 = manager.audio:GetVoiceLength("story_v_out_113191", "113191007", "story_v_out_113191.awb") / 1000

					if var_37_50 + var_37_41 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_50 + var_37_41
					end

					if var_37_45.prefab_name ~= "" and arg_34_1.actors_[var_37_45.prefab_name] ~= nil then
						local var_37_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_45.prefab_name].transform, "story_v_out_113191", "113191007", "story_v_out_113191.awb")

						arg_34_1:RecordAudio("113191007", var_37_51)
						arg_34_1:RecordAudio("113191007", var_37_51)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_113191", "113191007", "story_v_out_113191.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_113191", "113191007", "story_v_out_113191.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_52 = var_37_41 + 0.3
			local var_37_53 = math.max(var_37_42, arg_34_1.talkMaxDuration)

			if var_37_52 <= arg_34_1.time_ and arg_34_1.time_ < var_37_52 + var_37_53 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_52) / var_37_53

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_52 + var_37_53 and arg_34_1.time_ < var_37_52 + var_37_53 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play113191008 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113191008
		arg_40_1.duration_ = 7.27

		local var_40_0 = {
			ja = 7.266,
			ko = 2.8,
			zh = 4.233,
			en = 5.466
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113191009(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.25

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[208].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(113191008)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 10
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191008", "story_v_out_113191.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191008", "story_v_out_113191.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_113191", "113191008", "story_v_out_113191.awb")

						arg_40_1:RecordAudio("113191008", var_43_9)
						arg_40_1:RecordAudio("113191008", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113191", "113191008", "story_v_out_113191.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113191", "113191008", "story_v_out_113191.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113191009 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113191009
		arg_44_1.duration_ = 1.23

		local var_44_0 = {
			ja = 1.066,
			ko = 1.233,
			zh = 1.133,
			en = 1.2
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play113191010(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.1

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[94].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(113191009)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 4
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191009", "story_v_out_113191.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191009", "story_v_out_113191.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_113191", "113191009", "story_v_out_113191.awb")

						arg_44_1:RecordAudio("113191009", var_47_9)
						arg_44_1:RecordAudio("113191009", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113191", "113191009", "story_v_out_113191.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113191", "113191009", "story_v_out_113191.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play113191010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113191010
		arg_48_1.duration_ = 2.43

		local var_48_0 = {
			ja = 1.7,
			ko = 2.1,
			zh = 2.433,
			en = 1.333
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play113191011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.125

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[208].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(113191010)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 5
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191010", "story_v_out_113191.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191010", "story_v_out_113191.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_113191", "113191010", "story_v_out_113191.awb")

						arg_48_1:RecordAudio("113191010", var_51_9)
						arg_48_1:RecordAudio("113191010", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113191", "113191010", "story_v_out_113191.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113191", "113191010", "story_v_out_113191.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play113191011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113191011
		arg_52_1.duration_ = 10.37

		local var_52_0 = {
			ja = 6.1,
			ko = 10.366,
			zh = 8.933,
			en = 9.5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play113191012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_1 = 2

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_1 then
				local var_55_2 = (arg_52_1.time_ - var_55_0) / var_55_1
				local var_55_3 = Color.New(0, 0, 0)

				var_55_3.a = Mathf.Lerp(0, 1, var_55_2)
				arg_52_1.mask_.color = var_55_3
			end

			if arg_52_1.time_ >= var_55_0 + var_55_1 and arg_52_1.time_ < var_55_0 + var_55_1 + arg_55_0 then
				local var_55_4 = Color.New(0, 0, 0)

				var_55_4.a = 1
				arg_52_1.mask_.color = var_55_4
			end

			local var_55_5 = 2

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_6 = 2

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6
				local var_55_8 = Color.New(0, 0, 0)

				var_55_8.a = Mathf.Lerp(1, 0, var_55_7)
				arg_52_1.mask_.color = var_55_8
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				local var_55_9 = Color.New(0, 0, 0)
				local var_55_10 = 0

				arg_52_1.mask_.enabled = false
				var_55_9.a = var_55_10
				arg_52_1.mask_.color = var_55_9
			end

			local var_55_11 = "F03b"

			if arg_52_1.bgs_[var_55_11] == nil then
				local var_55_12 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_11)
				var_55_12.name = var_55_11
				var_55_12.transform.parent = arg_52_1.stage_.transform
				var_55_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_11] = var_55_12
			end

			local var_55_13 = 2

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				local var_55_14 = manager.ui.mainCamera.transform.localPosition
				local var_55_15 = Vector3.New(0, 0, 10) + Vector3.New(var_55_14.x, var_55_14.y, 0)
				local var_55_16 = arg_52_1.bgs_.F03b

				var_55_16.transform.localPosition = var_55_15
				var_55_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_17 = var_55_16:GetComponent("SpriteRenderer")

				if var_55_17 and var_55_17.sprite then
					local var_55_18 = (var_55_16.transform.localPosition - var_55_14).z
					local var_55_19 = manager.ui.mainCameraCom_
					local var_55_20 = 2 * var_55_18 * Mathf.Tan(var_55_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_21 = var_55_20 * var_55_19.aspect
					local var_55_22 = var_55_17.sprite.bounds.size.x
					local var_55_23 = var_55_17.sprite.bounds.size.y
					local var_55_24 = var_55_21 / var_55_22
					local var_55_25 = var_55_20 / var_55_23
					local var_55_26 = var_55_25 < var_55_24 and var_55_24 or var_55_25

					var_55_16.transform.localScale = Vector3.New(var_55_26, var_55_26, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "F03b" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_27 = "1084ui_story"

			if arg_52_1.actors_[var_55_27] == nil then
				local var_55_28 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_55_28) then
					local var_55_29 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_52_1.stage_.transform)

					var_55_29.name = var_55_27
					var_55_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_27] = var_55_29

					local var_55_30 = var_55_29:GetComponentInChildren(typeof(CharacterEffect))

					var_55_30.enabled = true

					local var_55_31 = GameObjectTools.GetOrAddComponent(var_55_29, typeof(DynamicBoneHelper))

					if var_55_31 then
						var_55_31:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_30.transform, false)

					arg_52_1.var_[var_55_27 .. "Animator"] = var_55_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_27 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_27 .. "LipSync"] = var_55_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_32 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_33 = 3.8

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_32.localPosition
			end

			local var_55_34 = 0.001

			if var_55_33 <= arg_52_1.time_ and arg_52_1.time_ < var_55_33 + var_55_34 then
				local var_55_35 = (arg_52_1.time_ - var_55_33) / var_55_34
				local var_55_36 = Vector3.New(-0.7, -0.97, -6)

				var_55_32.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_36, var_55_35)

				local var_55_37 = manager.ui.mainCamera.transform.position - var_55_32.position

				var_55_32.forward = Vector3.New(var_55_37.x, var_55_37.y, var_55_37.z)

				local var_55_38 = var_55_32.localEulerAngles

				var_55_38.z = 0
				var_55_38.x = 0
				var_55_32.localEulerAngles = var_55_38
			end

			if arg_52_1.time_ >= var_55_33 + var_55_34 and arg_52_1.time_ < var_55_33 + var_55_34 + arg_55_0 then
				var_55_32.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_55_39 = manager.ui.mainCamera.transform.position - var_55_32.position

				var_55_32.forward = Vector3.New(var_55_39.x, var_55_39.y, var_55_39.z)

				local var_55_40 = var_55_32.localEulerAngles

				var_55_40.z = 0
				var_55_40.x = 0
				var_55_32.localEulerAngles = var_55_40
			end

			local var_55_41 = 3.8

			if var_55_41 < arg_52_1.time_ and arg_52_1.time_ <= var_55_41 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_55_42 = 3.8

			if var_55_42 < arg_52_1.time_ and arg_52_1.time_ <= var_55_42 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_55_43 = arg_52_1.actors_["1084ui_story"]
			local var_55_44 = 3.8

			if var_55_44 < arg_52_1.time_ and arg_52_1.time_ <= var_55_44 + arg_55_0 and not isNil(var_55_43) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_45 = 0.2

			if var_55_44 <= arg_52_1.time_ and arg_52_1.time_ < var_55_44 + var_55_45 and not isNil(var_55_43) then
				local var_55_46 = (arg_52_1.time_ - var_55_44) / var_55_45

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_43) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_44 + var_55_45 and arg_52_1.time_ < var_55_44 + var_55_45 + arg_55_0 and not isNil(var_55_43) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_47 = 4
			local var_55_48 = 0.525

			if var_55_47 < arg_52_1.time_ and arg_52_1.time_ <= var_55_47 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_49 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_49:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_50 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_51 = arg_52_1:GetWordFromCfg(113191011)
				local var_55_52 = arg_52_1:FormatText(var_55_51.content)

				arg_52_1.text_.text = var_55_52

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_53 = 21
				local var_55_54 = utf8.len(var_55_52)
				local var_55_55 = var_55_53 <= 0 and var_55_48 or var_55_48 * (var_55_54 / var_55_53)

				if var_55_55 > 0 and var_55_48 < var_55_55 then
					arg_52_1.talkMaxDuration = var_55_55
					var_55_47 = var_55_47 + 0.3

					if var_55_55 + var_55_47 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_55 + var_55_47
					end
				end

				arg_52_1.text_.text = var_55_52
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191011", "story_v_out_113191.awb") ~= 0 then
					local var_55_56 = manager.audio:GetVoiceLength("story_v_out_113191", "113191011", "story_v_out_113191.awb") / 1000

					if var_55_56 + var_55_47 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_56 + var_55_47
					end

					if var_55_51.prefab_name ~= "" and arg_52_1.actors_[var_55_51.prefab_name] ~= nil then
						local var_55_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_51.prefab_name].transform, "story_v_out_113191", "113191011", "story_v_out_113191.awb")

						arg_52_1:RecordAudio("113191011", var_55_57)
						arg_52_1:RecordAudio("113191011", var_55_57)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113191", "113191011", "story_v_out_113191.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113191", "113191011", "story_v_out_113191.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_58 = var_55_47 + 0.3
			local var_55_59 = math.max(var_55_48, arg_52_1.talkMaxDuration)

			if var_55_58 <= arg_52_1.time_ and arg_52_1.time_ < var_55_58 + var_55_59 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_58) / var_55_59

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_58 + var_55_59 and arg_52_1.time_ < var_55_58 + var_55_59 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play113191012 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113191012
		arg_58_1.duration_ = 9.1

		local var_58_0 = {
			ja = 9.1,
			ko = 5.866,
			zh = 4.633,
			en = 6.533
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play113191013(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1084ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1084ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1084ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.55

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[10].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(113191012)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 22
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191012", "story_v_out_113191.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191012", "story_v_out_113191.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_113191", "113191012", "story_v_out_113191.awb")

						arg_58_1:RecordAudio("113191012", var_61_15)
						arg_58_1:RecordAudio("113191012", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113191", "113191012", "story_v_out_113191.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113191", "113191012", "story_v_out_113191.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play113191013 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 113191013
		arg_62_1.duration_ = 4.5

		local var_62_0 = {
			ja = 4.5,
			ko = 3,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play113191014(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "1038ui_story"

			if arg_62_1.actors_[var_65_0] == nil then
				local var_65_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_65_1) then
					local var_65_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_62_1.stage_.transform)

					var_65_2.name = var_65_0
					var_65_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_0] = var_65_2

					local var_65_3 = var_65_2:GetComponentInChildren(typeof(CharacterEffect))

					var_65_3.enabled = true

					local var_65_4 = GameObjectTools.GetOrAddComponent(var_65_2, typeof(DynamicBoneHelper))

					if var_65_4 then
						var_65_4:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_3.transform, false)

					arg_62_1.var_[var_65_0 .. "Animator"] = var_65_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_0 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_0 .. "LipSync"] = var_65_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_5 = arg_62_1.actors_["1038ui_story"].transform
			local var_65_6 = 0

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.var_.moveOldPos1038ui_story = var_65_5.localPosition
			end

			local var_65_7 = 0.001

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_7 then
				local var_65_8 = (arg_62_1.time_ - var_65_6) / var_65_7
				local var_65_9 = Vector3.New(0.7, -1.11, -5.9)

				var_65_5.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1038ui_story, var_65_9, var_65_8)

				local var_65_10 = manager.ui.mainCamera.transform.position - var_65_5.position

				var_65_5.forward = Vector3.New(var_65_10.x, var_65_10.y, var_65_10.z)

				local var_65_11 = var_65_5.localEulerAngles

				var_65_11.z = 0
				var_65_11.x = 0
				var_65_5.localEulerAngles = var_65_11
			end

			if arg_62_1.time_ >= var_65_6 + var_65_7 and arg_62_1.time_ < var_65_6 + var_65_7 + arg_65_0 then
				var_65_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_65_12 = manager.ui.mainCamera.transform.position - var_65_5.position

				var_65_5.forward = Vector3.New(var_65_12.x, var_65_12.y, var_65_12.z)

				local var_65_13 = var_65_5.localEulerAngles

				var_65_13.z = 0
				var_65_13.x = 0
				var_65_5.localEulerAngles = var_65_13
			end

			local var_65_14 = 0

			if var_65_14 < arg_62_1.time_ and arg_62_1.time_ <= var_65_14 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_65_15 = 0

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_65_16 = arg_62_1.actors_["1038ui_story"]
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 and not isNil(var_65_16) and arg_62_1.var_.characterEffect1038ui_story == nil then
				arg_62_1.var_.characterEffect1038ui_story = var_65_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_18 = 0.2

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_18 and not isNil(var_65_16) then
				local var_65_19 = (arg_62_1.time_ - var_65_17) / var_65_18

				if arg_62_1.var_.characterEffect1038ui_story and not isNil(var_65_16) then
					arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_17 + var_65_18 and arg_62_1.time_ < var_65_17 + var_65_18 + arg_65_0 and not isNil(var_65_16) and arg_62_1.var_.characterEffect1038ui_story then
				arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_65_20 = 0
			local var_65_21 = 0.25

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_22 = arg_62_1:FormatText(StoryNameCfg[94].name)

				arg_62_1.leftNameTxt_.text = var_65_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_23 = arg_62_1:GetWordFromCfg(113191013)
				local var_65_24 = arg_62_1:FormatText(var_65_23.content)

				arg_62_1.text_.text = var_65_24

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_25 = 10
				local var_65_26 = utf8.len(var_65_24)
				local var_65_27 = var_65_25 <= 0 and var_65_21 or var_65_21 * (var_65_26 / var_65_25)

				if var_65_27 > 0 and var_65_21 < var_65_27 then
					arg_62_1.talkMaxDuration = var_65_27

					if var_65_27 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_27 + var_65_20
					end
				end

				arg_62_1.text_.text = var_65_24
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191013", "story_v_out_113191.awb") ~= 0 then
					local var_65_28 = manager.audio:GetVoiceLength("story_v_out_113191", "113191013", "story_v_out_113191.awb") / 1000

					if var_65_28 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_20
					end

					if var_65_23.prefab_name ~= "" and arg_62_1.actors_[var_65_23.prefab_name] ~= nil then
						local var_65_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_23.prefab_name].transform, "story_v_out_113191", "113191013", "story_v_out_113191.awb")

						arg_62_1:RecordAudio("113191013", var_65_29)
						arg_62_1:RecordAudio("113191013", var_65_29)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_113191", "113191013", "story_v_out_113191.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_113191", "113191013", "story_v_out_113191.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_30 = math.max(var_65_21, arg_62_1.talkMaxDuration)

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_30 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_20) / var_65_30

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_20 + var_65_30 and arg_62_1.time_ < var_65_20 + var_65_30 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play113191014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 113191014
		arg_66_1.duration_ = 4.83

		local var_66_0 = {
			ja = 0.999999999999,
			ko = 1.6,
			zh = 4.833,
			en = 1.3
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play113191015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1038ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1038ui_story == nil then
				arg_66_1.var_.characterEffect1038ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1038ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1038ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1038ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1038ui_story.fillRatio = var_69_5
			end

			local var_69_6 = 0
			local var_69_7 = 0.05

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[208].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_9 = arg_66_1:GetWordFromCfg(113191014)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 2
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191014", "story_v_out_113191.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191014", "story_v_out_113191.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_113191", "113191014", "story_v_out_113191.awb")

						arg_66_1:RecordAudio("113191014", var_69_15)
						arg_66_1:RecordAudio("113191014", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_113191", "113191014", "story_v_out_113191.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_113191", "113191014", "story_v_out_113191.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play113191015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 113191015
		arg_70_1.duration_ = 7.43

		local var_70_0 = {
			ja = 7.433,
			ko = 3.433,
			zh = 4.7,
			en = 5.733
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play113191016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.275

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[208].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(113191015)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 11
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191015", "story_v_out_113191.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191015", "story_v_out_113191.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_113191", "113191015", "story_v_out_113191.awb")

						arg_70_1:RecordAudio("113191015", var_73_9)
						arg_70_1:RecordAudio("113191015", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_113191", "113191015", "story_v_out_113191.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_113191", "113191015", "story_v_out_113191.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play113191016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 113191016
		arg_74_1.duration_ = 3.4

		local var_74_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3.4
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play113191017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_77_1 = arg_74_1.actors_["1038ui_story"]
			local var_77_2 = 0

			if var_77_2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1038ui_story == nil then
				arg_74_1.var_.characterEffect1038ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.2

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_3 and not isNil(var_77_1) then
				local var_77_4 = (arg_74_1.time_ - var_77_2) / var_77_3

				if arg_74_1.var_.characterEffect1038ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_2 + var_77_3 and arg_74_1.time_ < var_77_2 + var_77_3 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1038ui_story then
				arg_74_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_77_5 = 0
			local var_77_6 = 0.125

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_7 = arg_74_1:FormatText(StoryNameCfg[94].name)

				arg_74_1.leftNameTxt_.text = var_77_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_8 = arg_74_1:GetWordFromCfg(113191016)
				local var_77_9 = arg_74_1:FormatText(var_77_8.content)

				arg_74_1.text_.text = var_77_9

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 5
				local var_77_11 = utf8.len(var_77_9)
				local var_77_12 = var_77_10 <= 0 and var_77_6 or var_77_6 * (var_77_11 / var_77_10)

				if var_77_12 > 0 and var_77_6 < var_77_12 then
					arg_74_1.talkMaxDuration = var_77_12

					if var_77_12 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_9
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191016", "story_v_out_113191.awb") ~= 0 then
					local var_77_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191016", "story_v_out_113191.awb") / 1000

					if var_77_13 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_5
					end

					if var_77_8.prefab_name ~= "" and arg_74_1.actors_[var_77_8.prefab_name] ~= nil then
						local var_77_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_8.prefab_name].transform, "story_v_out_113191", "113191016", "story_v_out_113191.awb")

						arg_74_1:RecordAudio("113191016", var_77_14)
						arg_74_1:RecordAudio("113191016", var_77_14)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_113191", "113191016", "story_v_out_113191.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_113191", "113191016", "story_v_out_113191.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_15 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_15 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_15

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_15 and arg_74_1.time_ < var_77_5 + var_77_15 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play113191017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 113191017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play113191018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1084ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1084ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1038ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos1038ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(0, 100, 0)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1038ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, 100, 0)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = 0
			local var_81_19 = 0.6

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_20 = arg_78_1:GetWordFromCfg(113191017)
				local var_81_21 = arg_78_1:FormatText(var_81_20.content)

				arg_78_1.text_.text = var_81_21

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_22 = 24
				local var_81_23 = utf8.len(var_81_21)
				local var_81_24 = var_81_22 <= 0 and var_81_19 or var_81_19 * (var_81_23 / var_81_22)

				if var_81_24 > 0 and var_81_19 < var_81_24 then
					arg_78_1.talkMaxDuration = var_81_24

					if var_81_24 + var_81_18 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_18
					end
				end

				arg_78_1.text_.text = var_81_21
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_19, arg_78_1.talkMaxDuration)

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_18) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_18 + var_81_25 and arg_78_1.time_ < var_81_18 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play113191018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 113191018
		arg_82_1.duration_ = 8.1

		local var_82_0 = {
			ja = 3.8,
			ko = 6.9,
			zh = 8.1,
			en = 5.1
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play113191019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1084ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, -0.97, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1084ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_85_11 = arg_82_1.actors_["1084ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.2

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1084ui_story then
				arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_85_15 = 0
			local var_85_16 = 0.675

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(113191018)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 27
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191018", "story_v_out_113191.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191018", "story_v_out_113191.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_113191", "113191018", "story_v_out_113191.awb")

						arg_82_1:RecordAudio("113191018", var_85_24)
						arg_82_1:RecordAudio("113191018", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_113191", "113191018", "story_v_out_113191.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_113191", "113191018", "story_v_out_113191.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play113191019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 113191019
		arg_86_1.duration_ = 10.73

		local var_86_0 = {
			ja = 8.233,
			ko = 6.1,
			zh = 7.533,
			en = 10.733
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play113191020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1084ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_5
			end

			local var_89_6 = arg_86_1.actors_["1084ui_story"].transform
			local var_89_7 = 0

			if var_89_7 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_6.localPosition
			end

			local var_89_8 = 0.001

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_8 then
				local var_89_9 = (arg_86_1.time_ - var_89_7) / var_89_8
				local var_89_10 = Vector3.New(0, 100, 0)

				var_89_6.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, var_89_10, var_89_9)

				local var_89_11 = manager.ui.mainCamera.transform.position - var_89_6.position

				var_89_6.forward = Vector3.New(var_89_11.x, var_89_11.y, var_89_11.z)

				local var_89_12 = var_89_6.localEulerAngles

				var_89_12.z = 0
				var_89_12.x = 0
				var_89_6.localEulerAngles = var_89_12
			end

			if arg_86_1.time_ >= var_89_7 + var_89_8 and arg_86_1.time_ < var_89_7 + var_89_8 + arg_89_0 then
				var_89_6.localPosition = Vector3.New(0, 100, 0)

				local var_89_13 = manager.ui.mainCamera.transform.position - var_89_6.position

				var_89_6.forward = Vector3.New(var_89_13.x, var_89_13.y, var_89_13.z)

				local var_89_14 = var_89_6.localEulerAngles

				var_89_14.z = 0
				var_89_14.x = 0
				var_89_6.localEulerAngles = var_89_14
			end

			local var_89_15 = 0
			local var_89_16 = 0.8

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[10].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_18 = arg_86_1:GetWordFromCfg(113191019)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 32
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191019", "story_v_out_113191.awb") ~= 0 then
					local var_89_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191019", "story_v_out_113191.awb") / 1000

					if var_89_23 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_23 + var_89_15
					end

					if var_89_18.prefab_name ~= "" and arg_86_1.actors_[var_89_18.prefab_name] ~= nil then
						local var_89_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_18.prefab_name].transform, "story_v_out_113191", "113191019", "story_v_out_113191.awb")

						arg_86_1:RecordAudio("113191019", var_89_24)
						arg_86_1:RecordAudio("113191019", var_89_24)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_113191", "113191019", "story_v_out_113191.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_113191", "113191019", "story_v_out_113191.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_25 and arg_86_1.time_ < var_89_15 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play113191020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 113191020
		arg_90_1.duration_ = 0.02

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"

			SetActive(arg_90_1.choicesGo_, true)

			for iter_91_0, iter_91_1 in ipairs(arg_90_1.choices_) do
				local var_91_0 = iter_91_0 <= 1

				SetActive(iter_91_1.go, var_91_0)
			end

			arg_90_1.choices_[1].txt.text = arg_90_1:FormatText(StoryChoiceCfg[201].name)
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play113191021(arg_90_1)
			end

			arg_90_1:RecordChoiceLog(113191020, 201)
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			return
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play113191021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 113191021
		arg_94_1.duration_ = 12.47

		local var_94_0 = {
			ja = 10.566,
			ko = 8.633,
			zh = 7.8,
			en = 12.466
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play113191022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[10].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(113191021)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 40
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191021", "story_v_out_113191.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191021", "story_v_out_113191.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_113191", "113191021", "story_v_out_113191.awb")

						arg_94_1:RecordAudio("113191021", var_97_9)
						arg_94_1:RecordAudio("113191021", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_113191", "113191021", "story_v_out_113191.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_113191", "113191021", "story_v_out_113191.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play113191022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 113191022
		arg_98_1.duration_ = 12.03

		local var_98_0 = {
			ja = 12.033,
			ko = 9,
			zh = 9.666,
			en = 9.333
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play113191023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "1041ui_story"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_98_1.stage_.transform)

					var_101_2.name = var_101_0
					var_101_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_98_1.actors_[var_101_0] = var_101_2

					local var_101_3 = var_101_2:GetComponentInChildren(typeof(CharacterEffect))

					var_101_3.enabled = true

					local var_101_4 = GameObjectTools.GetOrAddComponent(var_101_2, typeof(DynamicBoneHelper))

					if var_101_4 then
						var_101_4:EnableDynamicBone(false)
					end

					arg_98_1:ShowWeapon(var_101_3.transform, false)

					arg_98_1.var_[var_101_0 .. "Animator"] = var_101_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_98_1.var_[var_101_0 .. "Animator"].applyRootMotion = true
					arg_98_1.var_[var_101_0 .. "LipSync"] = var_101_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_101_5 = arg_98_1.actors_["1041ui_story"].transform
			local var_101_6 = 0

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.var_.moveOldPos1041ui_story = var_101_5.localPosition
			end

			local var_101_7 = 0.001

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_7 then
				local var_101_8 = (arg_98_1.time_ - var_101_6) / var_101_7
				local var_101_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1041ui_story, var_101_9, var_101_8)

				local var_101_10 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_10.x, var_101_10.y, var_101_10.z)

				local var_101_11 = var_101_5.localEulerAngles

				var_101_11.z = 0
				var_101_11.x = 0
				var_101_5.localEulerAngles = var_101_11
			end

			if arg_98_1.time_ >= var_101_6 + var_101_7 and arg_98_1.time_ < var_101_6 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_5.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_5.localEulerAngles = var_101_13
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action9_2")
			end

			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_101_16 = arg_98_1.actors_["1041ui_story"]
			local var_101_17 = 0

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1041ui_story == nil then
				arg_98_1.var_.characterEffect1041ui_story = var_101_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_18 = 0.2

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_18 and not isNil(var_101_16) then
				local var_101_19 = (arg_98_1.time_ - var_101_17) / var_101_18

				if arg_98_1.var_.characterEffect1041ui_story and not isNil(var_101_16) then
					arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_17 + var_101_18 and arg_98_1.time_ < var_101_17 + var_101_18 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1041ui_story then
				arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_101_20 = 0
			local var_101_21 = 0.9

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_22 = arg_98_1:FormatText(StoryNameCfg[208].name)

				arg_98_1.leftNameTxt_.text = var_101_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_23 = arg_98_1:GetWordFromCfg(113191022)
				local var_101_24 = arg_98_1:FormatText(var_101_23.content)

				arg_98_1.text_.text = var_101_24

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_25 = 36
				local var_101_26 = utf8.len(var_101_24)
				local var_101_27 = var_101_25 <= 0 and var_101_21 or var_101_21 * (var_101_26 / var_101_25)

				if var_101_27 > 0 and var_101_21 < var_101_27 then
					arg_98_1.talkMaxDuration = var_101_27

					if var_101_27 + var_101_20 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_27 + var_101_20
					end
				end

				arg_98_1.text_.text = var_101_24
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191022", "story_v_out_113191.awb") ~= 0 then
					local var_101_28 = manager.audio:GetVoiceLength("story_v_out_113191", "113191022", "story_v_out_113191.awb") / 1000

					if var_101_28 + var_101_20 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_28 + var_101_20
					end

					if var_101_23.prefab_name ~= "" and arg_98_1.actors_[var_101_23.prefab_name] ~= nil then
						local var_101_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_23.prefab_name].transform, "story_v_out_113191", "113191022", "story_v_out_113191.awb")

						arg_98_1:RecordAudio("113191022", var_101_29)
						arg_98_1:RecordAudio("113191022", var_101_29)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_113191", "113191022", "story_v_out_113191.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_113191", "113191022", "story_v_out_113191.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_30 = math.max(var_101_21, arg_98_1.talkMaxDuration)

			if var_101_20 <= arg_98_1.time_ and arg_98_1.time_ < var_101_20 + var_101_30 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_20) / var_101_30

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_20 + var_101_30 and arg_98_1.time_ < var_101_20 + var_101_30 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play113191023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 113191023
		arg_102_1.duration_ = 5.93

		local var_102_0 = {
			ja = 5.933,
			ko = 3.133,
			zh = 4,
			en = 3.3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play113191024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1041ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1041ui_story == nil then
				arg_102_1.var_.characterEffect1041ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1041ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1041ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1041ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1041ui_story.fillRatio = var_105_5
			end

			local var_105_6 = arg_102_1.actors_["1038ui_story"].transform
			local var_105_7 = 0

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1.var_.moveOldPos1038ui_story = var_105_6.localPosition
			end

			local var_105_8 = 0.001

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_8 then
				local var_105_9 = (arg_102_1.time_ - var_105_7) / var_105_8
				local var_105_10 = Vector3.New(0.7, -1.11, -5.9)

				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1038ui_story, var_105_10, var_105_9)

				local var_105_11 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_11.x, var_105_11.y, var_105_11.z)

				local var_105_12 = var_105_6.localEulerAngles

				var_105_12.z = 0
				var_105_12.x = 0
				var_105_6.localEulerAngles = var_105_12
			end

			if arg_102_1.time_ >= var_105_7 + var_105_8 and arg_102_1.time_ < var_105_7 + var_105_8 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_105_13 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_13.x, var_105_13.y, var_105_13.z)

				local var_105_14 = var_105_6.localEulerAngles

				var_105_14.z = 0
				var_105_14.x = 0
				var_105_6.localEulerAngles = var_105_14
			end

			local var_105_15 = 0

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_105_17 = arg_102_1.actors_["1038ui_story"]
			local var_105_18 = 0

			if var_105_18 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 and not isNil(var_105_17) and arg_102_1.var_.characterEffect1038ui_story == nil then
				arg_102_1.var_.characterEffect1038ui_story = var_105_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_19 = 0.2

			if var_105_18 <= arg_102_1.time_ and arg_102_1.time_ < var_105_18 + var_105_19 and not isNil(var_105_17) then
				local var_105_20 = (arg_102_1.time_ - var_105_18) / var_105_19

				if arg_102_1.var_.characterEffect1038ui_story and not isNil(var_105_17) then
					arg_102_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_18 + var_105_19 and arg_102_1.time_ < var_105_18 + var_105_19 + arg_105_0 and not isNil(var_105_17) and arg_102_1.var_.characterEffect1038ui_story then
				arg_102_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_105_21 = 0
			local var_105_22 = 0.4

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_23 = arg_102_1:FormatText(StoryNameCfg[94].name)

				arg_102_1.leftNameTxt_.text = var_105_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_24 = arg_102_1:GetWordFromCfg(113191023)
				local var_105_25 = arg_102_1:FormatText(var_105_24.content)

				arg_102_1.text_.text = var_105_25

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_26 = 16
				local var_105_27 = utf8.len(var_105_25)
				local var_105_28 = var_105_26 <= 0 and var_105_22 or var_105_22 * (var_105_27 / var_105_26)

				if var_105_28 > 0 and var_105_22 < var_105_28 then
					arg_102_1.talkMaxDuration = var_105_28

					if var_105_28 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_28 + var_105_21
					end
				end

				arg_102_1.text_.text = var_105_25
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191023", "story_v_out_113191.awb") ~= 0 then
					local var_105_29 = manager.audio:GetVoiceLength("story_v_out_113191", "113191023", "story_v_out_113191.awb") / 1000

					if var_105_29 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_29 + var_105_21
					end

					if var_105_24.prefab_name ~= "" and arg_102_1.actors_[var_105_24.prefab_name] ~= nil then
						local var_105_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_24.prefab_name].transform, "story_v_out_113191", "113191023", "story_v_out_113191.awb")

						arg_102_1:RecordAudio("113191023", var_105_30)
						arg_102_1:RecordAudio("113191023", var_105_30)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_113191", "113191023", "story_v_out_113191.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_113191", "113191023", "story_v_out_113191.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_22, arg_102_1.talkMaxDuration)

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_21) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_21 + var_105_31 and arg_102_1.time_ < var_105_21 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play113191024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 113191024
		arg_106_1.duration_ = 7.47

		local var_106_0 = {
			ja = 6.233,
			ko = 4.7,
			zh = 7.466,
			en = 3.7
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play113191025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1038ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1038ui_story == nil then
				arg_106_1.var_.characterEffect1038ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1038ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1038ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1038ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1038ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_109_7 = arg_106_1.actors_["1041ui_story"]
			local var_109_8 = 0

			if var_109_8 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 and not isNil(var_109_7) and arg_106_1.var_.characterEffect1041ui_story == nil then
				arg_106_1.var_.characterEffect1041ui_story = var_109_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_9 = 0.2

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_9 and not isNil(var_109_7) then
				local var_109_10 = (arg_106_1.time_ - var_109_8) / var_109_9

				if arg_106_1.var_.characterEffect1041ui_story and not isNil(var_109_7) then
					arg_106_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_8 + var_109_9 and arg_106_1.time_ < var_109_8 + var_109_9 + arg_109_0 and not isNil(var_109_7) and arg_106_1.var_.characterEffect1041ui_story then
				arg_106_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_109_11 = 0
			local var_109_12 = 0.525

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_13 = arg_106_1:FormatText(StoryNameCfg[208].name)

				arg_106_1.leftNameTxt_.text = var_109_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_14 = arg_106_1:GetWordFromCfg(113191024)
				local var_109_15 = arg_106_1:FormatText(var_109_14.content)

				arg_106_1.text_.text = var_109_15

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_16 = 21
				local var_109_17 = utf8.len(var_109_15)
				local var_109_18 = var_109_16 <= 0 and var_109_12 or var_109_12 * (var_109_17 / var_109_16)

				if var_109_18 > 0 and var_109_12 < var_109_18 then
					arg_106_1.talkMaxDuration = var_109_18

					if var_109_18 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_18 + var_109_11
					end
				end

				arg_106_1.text_.text = var_109_15
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191024", "story_v_out_113191.awb") ~= 0 then
					local var_109_19 = manager.audio:GetVoiceLength("story_v_out_113191", "113191024", "story_v_out_113191.awb") / 1000

					if var_109_19 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_11
					end

					if var_109_14.prefab_name ~= "" and arg_106_1.actors_[var_109_14.prefab_name] ~= nil then
						local var_109_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_14.prefab_name].transform, "story_v_out_113191", "113191024", "story_v_out_113191.awb")

						arg_106_1:RecordAudio("113191024", var_109_20)
						arg_106_1:RecordAudio("113191024", var_109_20)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_113191", "113191024", "story_v_out_113191.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_113191", "113191024", "story_v_out_113191.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_21 = math.max(var_109_12, arg_106_1.talkMaxDuration)

			if var_109_11 <= arg_106_1.time_ and arg_106_1.time_ < var_109_11 + var_109_21 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_11) / var_109_21

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_11 + var_109_21 and arg_106_1.time_ < var_109_11 + var_109_21 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play113191025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 113191025
		arg_110_1.duration_ = 12.47

		local var_110_0 = {
			ja = 10.966,
			ko = 7.966,
			zh = 7.333,
			en = 12.466
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play113191026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1041ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1041ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1041ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1038ui_story"].transform
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.var_.moveOldPos1038ui_story = var_113_9.localPosition
			end

			local var_113_11 = 0.001

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11
				local var_113_13 = Vector3.New(0, 100, 0)

				var_113_9.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1038ui_story, var_113_13, var_113_12)

				local var_113_14 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_14.x, var_113_14.y, var_113_14.z)

				local var_113_15 = var_113_9.localEulerAngles

				var_113_15.z = 0
				var_113_15.x = 0
				var_113_9.localEulerAngles = var_113_15
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 then
				var_113_9.localPosition = Vector3.New(0, 100, 0)

				local var_113_16 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_16.x, var_113_16.y, var_113_16.z)

				local var_113_17 = var_113_9.localEulerAngles

				var_113_17.z = 0
				var_113_17.x = 0
				var_113_9.localEulerAngles = var_113_17
			end

			local var_113_18 = 0
			local var_113_19 = 0.925

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_20 = arg_110_1:FormatText(StoryNameCfg[10].name)

				arg_110_1.leftNameTxt_.text = var_113_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_21 = arg_110_1:GetWordFromCfg(113191025)
				local var_113_22 = arg_110_1:FormatText(var_113_21.content)

				arg_110_1.text_.text = var_113_22

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_23 = 37
				local var_113_24 = utf8.len(var_113_22)
				local var_113_25 = var_113_23 <= 0 and var_113_19 or var_113_19 * (var_113_24 / var_113_23)

				if var_113_25 > 0 and var_113_19 < var_113_25 then
					arg_110_1.talkMaxDuration = var_113_25

					if var_113_25 + var_113_18 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_25 + var_113_18
					end
				end

				arg_110_1.text_.text = var_113_22
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191025", "story_v_out_113191.awb") ~= 0 then
					local var_113_26 = manager.audio:GetVoiceLength("story_v_out_113191", "113191025", "story_v_out_113191.awb") / 1000

					if var_113_26 + var_113_18 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_26 + var_113_18
					end

					if var_113_21.prefab_name ~= "" and arg_110_1.actors_[var_113_21.prefab_name] ~= nil then
						local var_113_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_21.prefab_name].transform, "story_v_out_113191", "113191025", "story_v_out_113191.awb")

						arg_110_1:RecordAudio("113191025", var_113_27)
						arg_110_1:RecordAudio("113191025", var_113_27)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_113191", "113191025", "story_v_out_113191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_113191", "113191025", "story_v_out_113191.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_28 = math.max(var_113_19, arg_110_1.talkMaxDuration)

			if var_113_18 <= arg_110_1.time_ and arg_110_1.time_ < var_113_18 + var_113_28 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_18) / var_113_28

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_18 + var_113_28 and arg_110_1.time_ < var_113_18 + var_113_28 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play113191026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 113191026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play113191027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.25

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(113191026)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 50
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play113191027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 113191027
		arg_118_1.duration_ = 3.83

		local var_118_0 = {
			ja = 2.933,
			ko = 3.7,
			zh = 2.533,
			en = 3.833
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play113191028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_0.localPosition

				local var_121_2 = "1084ui_story"

				arg_118_1:ShowWeapon(arg_118_1.var_[var_121_2 .. "Animator"].transform, true)
			end

			local var_121_3 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_3 then
				local var_121_4 = (arg_118_1.time_ - var_121_1) / var_121_3
				local var_121_5 = Vector3.New(0, -0.97, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_5, var_121_4)

				local var_121_6 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_6.x, var_121_6.y, var_121_6.z)

				local var_121_7 = var_121_0.localEulerAngles

				var_121_7.z = 0
				var_121_7.x = 0
				var_121_0.localEulerAngles = var_121_7
			end

			if arg_118_1.time_ >= var_121_1 + var_121_3 and arg_118_1.time_ < var_121_1 + var_121_3 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_121_8 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_8.x, var_121_8.y, var_121_8.z)

				local var_121_9 = var_121_0.localEulerAngles

				var_121_9.z = 0
				var_121_9.x = 0
				var_121_0.localEulerAngles = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_121_12 = arg_118_1.actors_["1084ui_story"]
			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 and not isNil(var_121_12) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_14 = 0.2

			if var_121_13 <= arg_118_1.time_ and arg_118_1.time_ < var_121_13 + var_121_14 and not isNil(var_121_12) then
				local var_121_15 = (arg_118_1.time_ - var_121_13) / var_121_14

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_12) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_13 + var_121_14 and arg_118_1.time_ < var_121_13 + var_121_14 + arg_121_0 and not isNil(var_121_12) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_16 = 0
			local var_121_17 = 0.325

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_18 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_19 = arg_118_1:GetWordFromCfg(113191027)
				local var_121_20 = arg_118_1:FormatText(var_121_19.content)

				arg_118_1.text_.text = var_121_20

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_21 = 13
				local var_121_22 = utf8.len(var_121_20)
				local var_121_23 = var_121_21 <= 0 and var_121_17 or var_121_17 * (var_121_22 / var_121_21)

				if var_121_23 > 0 and var_121_17 < var_121_23 then
					arg_118_1.talkMaxDuration = var_121_23

					if var_121_23 + var_121_16 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_16
					end
				end

				arg_118_1.text_.text = var_121_20
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191027", "story_v_out_113191.awb") ~= 0 then
					local var_121_24 = manager.audio:GetVoiceLength("story_v_out_113191", "113191027", "story_v_out_113191.awb") / 1000

					if var_121_24 + var_121_16 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_24 + var_121_16
					end

					if var_121_19.prefab_name ~= "" and arg_118_1.actors_[var_121_19.prefab_name] ~= nil then
						local var_121_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_19.prefab_name].transform, "story_v_out_113191", "113191027", "story_v_out_113191.awb")

						arg_118_1:RecordAudio("113191027", var_121_25)
						arg_118_1:RecordAudio("113191027", var_121_25)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_113191", "113191027", "story_v_out_113191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_113191", "113191027", "story_v_out_113191.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_26 = math.max(var_121_17, arg_118_1.talkMaxDuration)

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_26 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_16) / var_121_26

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_16 + var_121_26 and arg_118_1.time_ < var_121_16 + var_121_26 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play113191028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 113191028
		arg_122_1.duration_ = 14.9

		local var_122_0 = {
			ja = 14.9,
			ko = 7.333,
			zh = 5.933,
			en = 9.333
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play113191029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.775

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[10].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(113191028)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 31
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191028", "story_v_out_113191.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191028", "story_v_out_113191.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_113191", "113191028", "story_v_out_113191.awb")

						arg_122_1:RecordAudio("113191028", var_125_15)
						arg_122_1:RecordAudio("113191028", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_113191", "113191028", "story_v_out_113191.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_113191", "113191028", "story_v_out_113191.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play113191029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 113191029
		arg_126_1.duration_ = 3.6

		local var_126_0 = {
			ja = 3.3,
			ko = 3.2,
			zh = 2.833,
			en = 3.6
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play113191030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_129_1 = arg_126_1.actors_["1084ui_story"]
			local var_129_2 = 0

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.2

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_3 and not isNil(var_129_1) then
				local var_129_4 = (arg_126_1.time_ - var_129_2) / var_129_3

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_2 + var_129_3 and arg_126_1.time_ < var_129_2 + var_129_3 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_5 = 0
			local var_129_6 = 0.275

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_7 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_8 = arg_126_1:GetWordFromCfg(113191029)
				local var_129_9 = arg_126_1:FormatText(var_129_8.content)

				arg_126_1.text_.text = var_129_9

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 11
				local var_129_11 = utf8.len(var_129_9)
				local var_129_12 = var_129_10 <= 0 and var_129_6 or var_129_6 * (var_129_11 / var_129_10)

				if var_129_12 > 0 and var_129_6 < var_129_12 then
					arg_126_1.talkMaxDuration = var_129_12

					if var_129_12 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_12 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_9
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191029", "story_v_out_113191.awb") ~= 0 then
					local var_129_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191029", "story_v_out_113191.awb") / 1000

					if var_129_13 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_5
					end

					if var_129_8.prefab_name ~= "" and arg_126_1.actors_[var_129_8.prefab_name] ~= nil then
						local var_129_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_8.prefab_name].transform, "story_v_out_113191", "113191029", "story_v_out_113191.awb")

						arg_126_1:RecordAudio("113191029", var_129_14)
						arg_126_1:RecordAudio("113191029", var_129_14)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_113191", "113191029", "story_v_out_113191.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_113191", "113191029", "story_v_out_113191.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_15 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_15 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_15

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_15 and arg_126_1.time_ < var_129_5 + var_129_15 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play113191030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 113191030
		arg_130_1.duration_ = 7.87

		local var_130_0 = {
			ja = 5.633,
			ko = 7.866,
			zh = 4.533,
			en = 5.3
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play113191031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1084ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1084ui_story = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1084ui_story, var_133_4, var_133_3)

				local var_133_5 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_5.x, var_133_5.y, var_133_5.z)

				local var_133_6 = var_133_0.localEulerAngles

				var_133_6.z = 0
				var_133_6.x = 0
				var_133_0.localEulerAngles = var_133_6
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_7 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_7.x, var_133_7.y, var_133_7.z)

				local var_133_8 = var_133_0.localEulerAngles

				var_133_8.z = 0
				var_133_8.x = 0
				var_133_0.localEulerAngles = var_133_8
			end

			local var_133_9 = 0
			local var_133_10 = 0.425

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_11 = arg_130_1:FormatText(StoryNameCfg[216].name)

				arg_130_1.leftNameTxt_.text = var_133_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_12 = arg_130_1:GetWordFromCfg(113191030)
				local var_133_13 = arg_130_1:FormatText(var_133_12.content)

				arg_130_1.text_.text = var_133_13

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_14 = 17
				local var_133_15 = utf8.len(var_133_13)
				local var_133_16 = var_133_14 <= 0 and var_133_10 or var_133_10 * (var_133_15 / var_133_14)

				if var_133_16 > 0 and var_133_10 < var_133_16 then
					arg_130_1.talkMaxDuration = var_133_16

					if var_133_16 + var_133_9 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_16 + var_133_9
					end
				end

				arg_130_1.text_.text = var_133_13
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191030", "story_v_out_113191.awb") ~= 0 then
					local var_133_17 = manager.audio:GetVoiceLength("story_v_out_113191", "113191030", "story_v_out_113191.awb") / 1000

					if var_133_17 + var_133_9 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_17 + var_133_9
					end

					if var_133_12.prefab_name ~= "" and arg_130_1.actors_[var_133_12.prefab_name] ~= nil then
						local var_133_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_12.prefab_name].transform, "story_v_out_113191", "113191030", "story_v_out_113191.awb")

						arg_130_1:RecordAudio("113191030", var_133_18)
						arg_130_1:RecordAudio("113191030", var_133_18)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_113191", "113191030", "story_v_out_113191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_113191", "113191030", "story_v_out_113191.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_19 = math.max(var_133_10, arg_130_1.talkMaxDuration)

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_19 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_9) / var_133_19

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_9 + var_133_19 and arg_130_1.time_ < var_133_9 + var_133_19 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play113191031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 113191031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play113191032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.475

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(113191031)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 19
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play113191032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 113191032
		arg_138_1.duration_ = 5.67

		local var_138_0 = {
			ja = 5.666,
			ko = 3.033,
			zh = 3.7,
			en = 5.4
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play113191033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = "1097ui_story"

			if arg_138_1.actors_[var_141_0] == nil then
				local var_141_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_141_1) then
					local var_141_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_138_1.stage_.transform)

					var_141_2.name = var_141_0
					var_141_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_138_1.actors_[var_141_0] = var_141_2

					local var_141_3 = var_141_2:GetComponentInChildren(typeof(CharacterEffect))

					var_141_3.enabled = true

					local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_2, typeof(DynamicBoneHelper))

					if var_141_4 then
						var_141_4:EnableDynamicBone(false)
					end

					arg_138_1:ShowWeapon(var_141_3.transform, false)

					arg_138_1.var_[var_141_0 .. "Animator"] = var_141_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_138_1.var_[var_141_0 .. "Animator"].applyRootMotion = true
					arg_138_1.var_[var_141_0 .. "LipSync"] = var_141_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_141_5 = arg_138_1.actors_["1097ui_story"].transform
			local var_141_6 = 0

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.var_.moveOldPos1097ui_story = var_141_5.localPosition
			end

			local var_141_7 = 0.001

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_7 then
				local var_141_8 = (arg_138_1.time_ - var_141_6) / var_141_7
				local var_141_9 = Vector3.New(0, -0.54, -6.3)

				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1097ui_story, var_141_9, var_141_8)

				local var_141_10 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_10.x, var_141_10.y, var_141_10.z)

				local var_141_11 = var_141_5.localEulerAngles

				var_141_11.z = 0
				var_141_11.x = 0
				var_141_5.localEulerAngles = var_141_11
			end

			if arg_138_1.time_ >= var_141_6 + var_141_7 and arg_138_1.time_ < var_141_6 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_141_12 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_12.x, var_141_12.y, var_141_12.z)

				local var_141_13 = var_141_5.localEulerAngles

				var_141_13.z = 0
				var_141_13.x = 0
				var_141_5.localEulerAngles = var_141_13
			end

			local var_141_14 = 0

			if var_141_14 < arg_138_1.time_ and arg_138_1.time_ <= var_141_14 + arg_141_0 then
				arg_138_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_141_15 = 0

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_141_16 = arg_138_1.actors_["1097ui_story"]
			local var_141_17 = 0

			if var_141_17 < arg_138_1.time_ and arg_138_1.time_ <= var_141_17 + arg_141_0 and not isNil(var_141_16) and arg_138_1.var_.characterEffect1097ui_story == nil then
				arg_138_1.var_.characterEffect1097ui_story = var_141_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_18 = 0.2

			if var_141_17 <= arg_138_1.time_ and arg_138_1.time_ < var_141_17 + var_141_18 and not isNil(var_141_16) then
				local var_141_19 = (arg_138_1.time_ - var_141_17) / var_141_18

				if arg_138_1.var_.characterEffect1097ui_story and not isNil(var_141_16) then
					arg_138_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_17 + var_141_18 and arg_138_1.time_ < var_141_17 + var_141_18 + arg_141_0 and not isNil(var_141_16) and arg_138_1.var_.characterEffect1097ui_story then
				arg_138_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_141_20 = 0
			local var_141_21 = 0.3

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_22 = arg_138_1:FormatText(StoryNameCfg[216].name)

				arg_138_1.leftNameTxt_.text = var_141_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_23 = arg_138_1:GetWordFromCfg(113191032)
				local var_141_24 = arg_138_1:FormatText(var_141_23.content)

				arg_138_1.text_.text = var_141_24

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_25 = 12
				local var_141_26 = utf8.len(var_141_24)
				local var_141_27 = var_141_25 <= 0 and var_141_21 or var_141_21 * (var_141_26 / var_141_25)

				if var_141_27 > 0 and var_141_21 < var_141_27 then
					arg_138_1.talkMaxDuration = var_141_27

					if var_141_27 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_27 + var_141_20
					end
				end

				arg_138_1.text_.text = var_141_24
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191032", "story_v_out_113191.awb") ~= 0 then
					local var_141_28 = manager.audio:GetVoiceLength("story_v_out_113191", "113191032", "story_v_out_113191.awb") / 1000

					if var_141_28 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_20
					end

					if var_141_23.prefab_name ~= "" and arg_138_1.actors_[var_141_23.prefab_name] ~= nil then
						local var_141_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_23.prefab_name].transform, "story_v_out_113191", "113191032", "story_v_out_113191.awb")

						arg_138_1:RecordAudio("113191032", var_141_29)
						arg_138_1:RecordAudio("113191032", var_141_29)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_113191", "113191032", "story_v_out_113191.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_113191", "113191032", "story_v_out_113191.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_30 = math.max(var_141_21, arg_138_1.talkMaxDuration)

			if var_141_20 <= arg_138_1.time_ and arg_138_1.time_ < var_141_20 + var_141_30 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_20) / var_141_30

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_20 + var_141_30 and arg_138_1.time_ < var_141_20 + var_141_30 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play113191033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 113191033
		arg_142_1.duration_ = 14.67

		local var_142_0 = {
			ja = 12.2,
			ko = 10.933,
			zh = 10.066,
			en = 14.666
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play113191034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_145_1 = 0
			local var_145_2 = 0.975

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_3 = arg_142_1:FormatText(StoryNameCfg[216].name)

				arg_142_1.leftNameTxt_.text = var_145_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(113191033)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 39
				local var_145_7 = utf8.len(var_145_5)
				local var_145_8 = var_145_6 <= 0 and var_145_2 or var_145_2 * (var_145_7 / var_145_6)

				if var_145_8 > 0 and var_145_2 < var_145_8 then
					arg_142_1.talkMaxDuration = var_145_8

					if var_145_8 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191033", "story_v_out_113191.awb") ~= 0 then
					local var_145_9 = manager.audio:GetVoiceLength("story_v_out_113191", "113191033", "story_v_out_113191.awb") / 1000

					if var_145_9 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_1
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_113191", "113191033", "story_v_out_113191.awb")

						arg_142_1:RecordAudio("113191033", var_145_10)
						arg_142_1:RecordAudio("113191033", var_145_10)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_113191", "113191033", "story_v_out_113191.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_113191", "113191033", "story_v_out_113191.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_11 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_11 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_11

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_11 and arg_142_1.time_ < var_145_1 + var_145_11 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play113191034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 113191034
		arg_146_1.duration_ = 3.23

		local var_146_0 = {
			ja = 2.4,
			ko = 3.233,
			zh = 2.4,
			en = 2.266
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play113191035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_0.localPosition

				local var_149_2 = "1084ui_story"

				arg_146_1:ShowWeapon(arg_146_1.var_[var_149_2 .. "Animator"].transform, false)
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0.7, -0.97, -6)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9
			end

			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_149_11 = arg_146_1.actors_["1084ui_story"]
			local var_149_12 = 0

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_13 = 0.2

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 and not isNil(var_149_11) then
				local var_149_14 = (arg_146_1.time_ - var_149_12) / var_149_13

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_11) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_15 = 0

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_149_16 = arg_146_1.actors_["1097ui_story"].transform
			local var_149_17 = 0

			if var_149_17 < arg_146_1.time_ and arg_146_1.time_ <= var_149_17 + arg_149_0 then
				arg_146_1.var_.moveOldPos1097ui_story = var_149_16.localPosition
			end

			local var_149_18 = 0.5

			if var_149_17 <= arg_146_1.time_ and arg_146_1.time_ < var_149_17 + var_149_18 then
				local var_149_19 = (arg_146_1.time_ - var_149_17) / var_149_18
				local var_149_20 = Vector3.New(-0.7, -0.54, -6.3)

				var_149_16.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1097ui_story, var_149_20, var_149_19)

				local var_149_21 = manager.ui.mainCamera.transform.position - var_149_16.position

				var_149_16.forward = Vector3.New(var_149_21.x, var_149_21.y, var_149_21.z)

				local var_149_22 = var_149_16.localEulerAngles

				var_149_22.z = 0
				var_149_22.x = 0
				var_149_16.localEulerAngles = var_149_22
			end

			if arg_146_1.time_ >= var_149_17 + var_149_18 and arg_146_1.time_ < var_149_17 + var_149_18 + arg_149_0 then
				var_149_16.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_149_23 = manager.ui.mainCamera.transform.position - var_149_16.position

				var_149_16.forward = Vector3.New(var_149_23.x, var_149_23.y, var_149_23.z)

				local var_149_24 = var_149_16.localEulerAngles

				var_149_24.z = 0
				var_149_24.x = 0
				var_149_16.localEulerAngles = var_149_24
			end

			local var_149_25 = arg_146_1.actors_["1097ui_story"]
			local var_149_26 = 0

			if var_149_26 < arg_146_1.time_ and arg_146_1.time_ <= var_149_26 + arg_149_0 and not isNil(var_149_25) and arg_146_1.var_.characterEffect1097ui_story == nil then
				arg_146_1.var_.characterEffect1097ui_story = var_149_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_27 = 0.2

			if var_149_26 <= arg_146_1.time_ and arg_146_1.time_ < var_149_26 + var_149_27 and not isNil(var_149_25) then
				local var_149_28 = (arg_146_1.time_ - var_149_26) / var_149_27

				if arg_146_1.var_.characterEffect1097ui_story and not isNil(var_149_25) then
					local var_149_29 = Mathf.Lerp(0, 0.5, var_149_28)

					arg_146_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1097ui_story.fillRatio = var_149_29
				end
			end

			if arg_146_1.time_ >= var_149_26 + var_149_27 and arg_146_1.time_ < var_149_26 + var_149_27 + arg_149_0 and not isNil(var_149_25) and arg_146_1.var_.characterEffect1097ui_story then
				local var_149_30 = 0.5

				arg_146_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1097ui_story.fillRatio = var_149_30
			end

			local var_149_31 = 0
			local var_149_32 = 0.3

			if var_149_31 < arg_146_1.time_ and arg_146_1.time_ <= var_149_31 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_33 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_34 = arg_146_1:GetWordFromCfg(113191034)
				local var_149_35 = arg_146_1:FormatText(var_149_34.content)

				arg_146_1.text_.text = var_149_35

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_36 = 12
				local var_149_37 = utf8.len(var_149_35)
				local var_149_38 = var_149_36 <= 0 and var_149_32 or var_149_32 * (var_149_37 / var_149_36)

				if var_149_38 > 0 and var_149_32 < var_149_38 then
					arg_146_1.talkMaxDuration = var_149_38

					if var_149_38 + var_149_31 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_38 + var_149_31
					end
				end

				arg_146_1.text_.text = var_149_35
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191034", "story_v_out_113191.awb") ~= 0 then
					local var_149_39 = manager.audio:GetVoiceLength("story_v_out_113191", "113191034", "story_v_out_113191.awb") / 1000

					if var_149_39 + var_149_31 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_39 + var_149_31
					end

					if var_149_34.prefab_name ~= "" and arg_146_1.actors_[var_149_34.prefab_name] ~= nil then
						local var_149_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_34.prefab_name].transform, "story_v_out_113191", "113191034", "story_v_out_113191.awb")

						arg_146_1:RecordAudio("113191034", var_149_40)
						arg_146_1:RecordAudio("113191034", var_149_40)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_113191", "113191034", "story_v_out_113191.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_113191", "113191034", "story_v_out_113191.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_41 = math.max(var_149_32, arg_146_1.talkMaxDuration)

			if var_149_31 <= arg_146_1.time_ and arg_146_1.time_ < var_149_31 + var_149_41 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_31) / var_149_41

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_31 + var_149_41 and arg_146_1.time_ < var_149_31 + var_149_41 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play113191035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 113191035
		arg_150_1.duration_ = 4.3

		local var_150_0 = {
			ja = 1.999999999999,
			ko = 4.3,
			zh = 3.7,
			en = 4.233
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play113191036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_153_1 = arg_150_1.actors_["1097ui_story"]
			local var_153_2 = 0

			if var_153_2 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1097ui_story == nil then
				arg_150_1.var_.characterEffect1097ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.2

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_3 and not isNil(var_153_1) then
				local var_153_4 = (arg_150_1.time_ - var_153_2) / var_153_3

				if arg_150_1.var_.characterEffect1097ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_2 + var_153_3 and arg_150_1.time_ < var_153_2 + var_153_3 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1097ui_story then
				arg_150_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_153_5 = arg_150_1.actors_["1084ui_story"]
			local var_153_6 = 0

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_7 = 0.2

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_7 and not isNil(var_153_5) then
				local var_153_8 = (arg_150_1.time_ - var_153_6) / var_153_7

				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_5) then
					local var_153_9 = Mathf.Lerp(0, 0.5, var_153_8)

					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_9
				end
			end

			if arg_150_1.time_ >= var_153_6 + var_153_7 and arg_150_1.time_ < var_153_6 + var_153_7 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1084ui_story then
				local var_153_10 = 0.5

				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_10
			end

			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_153_12 = 0
			local var_153_13 = 0.3

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_14 = arg_150_1:FormatText(StoryNameCfg[216].name)

				arg_150_1.leftNameTxt_.text = var_153_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_15 = arg_150_1:GetWordFromCfg(113191035)
				local var_153_16 = arg_150_1:FormatText(var_153_15.content)

				arg_150_1.text_.text = var_153_16

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_17 = 12
				local var_153_18 = utf8.len(var_153_16)
				local var_153_19 = var_153_17 <= 0 and var_153_13 or var_153_13 * (var_153_18 / var_153_17)

				if var_153_19 > 0 and var_153_13 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_16
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191035", "story_v_out_113191.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_out_113191", "113191035", "story_v_out_113191.awb") / 1000

					if var_153_20 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_12
					end

					if var_153_15.prefab_name ~= "" and arg_150_1.actors_[var_153_15.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_15.prefab_name].transform, "story_v_out_113191", "113191035", "story_v_out_113191.awb")

						arg_150_1:RecordAudio("113191035", var_153_21)
						arg_150_1:RecordAudio("113191035", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_113191", "113191035", "story_v_out_113191.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_113191", "113191035", "story_v_out_113191.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_22 and arg_150_1.time_ < var_153_12 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play113191036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 113191036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play113191037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1097ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1097ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, 100, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1097ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, 100, 0)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1084ui_story"].transform
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.var_.moveOldPos1084ui_story = var_157_9.localPosition
			end

			local var_157_11 = 0.001

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11
				local var_157_13 = Vector3.New(0, 100, 0)

				var_157_9.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1084ui_story, var_157_13, var_157_12)

				local var_157_14 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_14.x, var_157_14.y, var_157_14.z)

				local var_157_15 = var_157_9.localEulerAngles

				var_157_15.z = 0
				var_157_15.x = 0
				var_157_9.localEulerAngles = var_157_15
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 then
				var_157_9.localPosition = Vector3.New(0, 100, 0)

				local var_157_16 = manager.ui.mainCamera.transform.position - var_157_9.position

				var_157_9.forward = Vector3.New(var_157_16.x, var_157_16.y, var_157_16.z)

				local var_157_17 = var_157_9.localEulerAngles

				var_157_17.z = 0
				var_157_17.x = 0
				var_157_9.localEulerAngles = var_157_17
			end

			local var_157_18 = 0
			local var_157_19 = 0.75

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 then
				local var_157_20 = "play"
				local var_157_21 = "effect"

				arg_154_1:AudioAction(var_157_20, var_157_21, "se_story_10", "se_story_10_light", "")
			end

			local var_157_22 = 0
			local var_157_23 = 0.75

			if var_157_22 < arg_154_1.time_ and arg_154_1.time_ <= var_157_22 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_24 = arg_154_1:GetWordFromCfg(113191036)
				local var_157_25 = arg_154_1:FormatText(var_157_24.content)

				arg_154_1.text_.text = var_157_25

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_26 = 30
				local var_157_27 = utf8.len(var_157_25)
				local var_157_28 = var_157_26 <= 0 and var_157_23 or var_157_23 * (var_157_27 / var_157_26)

				if var_157_28 > 0 and var_157_23 < var_157_28 then
					arg_154_1.talkMaxDuration = var_157_28

					if var_157_28 + var_157_22 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_28 + var_157_22
					end
				end

				arg_154_1.text_.text = var_157_25
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_29 = math.max(var_157_23, arg_154_1.talkMaxDuration)

			if var_157_22 <= arg_154_1.time_ and arg_154_1.time_ < var_157_22 + var_157_29 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_22) / var_157_29

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_22 + var_157_29 and arg_154_1.time_ < var_157_22 + var_157_29 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play113191037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 113191037
		arg_158_1.duration_ = 5.53

		local var_158_0 = {
			ja = 5.533,
			ko = 4.066,
			zh = 2.7,
			en = 2.066
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play113191038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1097ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos1097ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1097ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_161_11 = arg_158_1.actors_["1097ui_story"]
			local var_161_12 = 0

			if var_161_12 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 and not isNil(var_161_11) and arg_158_1.var_.characterEffect1097ui_story == nil then
				arg_158_1.var_.characterEffect1097ui_story = var_161_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_13 = 0.2

			if var_161_12 <= arg_158_1.time_ and arg_158_1.time_ < var_161_12 + var_161_13 and not isNil(var_161_11) then
				local var_161_14 = (arg_158_1.time_ - var_161_12) / var_161_13

				if arg_158_1.var_.characterEffect1097ui_story and not isNil(var_161_11) then
					arg_158_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_12 + var_161_13 and arg_158_1.time_ < var_161_12 + var_161_13 + arg_161_0 and not isNil(var_161_11) and arg_158_1.var_.characterEffect1097ui_story then
				arg_158_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_161_15 = 0
			local var_161_16 = 0.25

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_17 = arg_158_1:FormatText(StoryNameCfg[216].name)

				arg_158_1.leftNameTxt_.text = var_161_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_18 = arg_158_1:GetWordFromCfg(113191037)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_20 = 10
				local var_161_21 = utf8.len(var_161_19)
				local var_161_22 = var_161_20 <= 0 and var_161_16 or var_161_16 * (var_161_21 / var_161_20)

				if var_161_22 > 0 and var_161_16 < var_161_22 then
					arg_158_1.talkMaxDuration = var_161_22

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191037", "story_v_out_113191.awb") ~= 0 then
					local var_161_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191037", "story_v_out_113191.awb") / 1000

					if var_161_23 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_23 + var_161_15
					end

					if var_161_18.prefab_name ~= "" and arg_158_1.actors_[var_161_18.prefab_name] ~= nil then
						local var_161_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_18.prefab_name].transform, "story_v_out_113191", "113191037", "story_v_out_113191.awb")

						arg_158_1:RecordAudio("113191037", var_161_24)
						arg_158_1:RecordAudio("113191037", var_161_24)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_113191", "113191037", "story_v_out_113191.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_113191", "113191037", "story_v_out_113191.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_25 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_15) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_15 + var_161_25 and arg_158_1.time_ < var_161_15 + var_161_25 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play113191038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 113191038
		arg_162_1.duration_ = 2.57

		local var_162_0 = {
			ja = 2.566,
			ko = 1.999999999999,
			zh = 2.4,
			en = 1.999999999999
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play113191039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1097ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1097ui_story == nil then
				arg_162_1.var_.characterEffect1097ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1097ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1097ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1097ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1097ui_story.fillRatio = var_165_5
			end

			local var_165_6 = arg_162_1.actors_["1084ui_story"].transform
			local var_165_7 = 0

			if var_165_7 < arg_162_1.time_ and arg_162_1.time_ <= var_165_7 + arg_165_0 then
				arg_162_1.var_.moveOldPos1084ui_story = var_165_6.localPosition
			end

			local var_165_8 = 0.001

			if var_165_7 <= arg_162_1.time_ and arg_162_1.time_ < var_165_7 + var_165_8 then
				local var_165_9 = (arg_162_1.time_ - var_165_7) / var_165_8
				local var_165_10 = Vector3.New(0.7, -0.97, -6)

				var_165_6.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1084ui_story, var_165_10, var_165_9)

				local var_165_11 = manager.ui.mainCamera.transform.position - var_165_6.position

				var_165_6.forward = Vector3.New(var_165_11.x, var_165_11.y, var_165_11.z)

				local var_165_12 = var_165_6.localEulerAngles

				var_165_12.z = 0
				var_165_12.x = 0
				var_165_6.localEulerAngles = var_165_12
			end

			if arg_162_1.time_ >= var_165_7 + var_165_8 and arg_162_1.time_ < var_165_7 + var_165_8 + arg_165_0 then
				var_165_6.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_165_13 = manager.ui.mainCamera.transform.position - var_165_6.position

				var_165_6.forward = Vector3.New(var_165_13.x, var_165_13.y, var_165_13.z)

				local var_165_14 = var_165_6.localEulerAngles

				var_165_14.z = 0
				var_165_14.x = 0
				var_165_6.localEulerAngles = var_165_14
			end

			local var_165_15 = 0

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_165_16 = 0

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_165_17 = arg_162_1.actors_["1084ui_story"]
			local var_165_18 = 0

			if var_165_18 < arg_162_1.time_ and arg_162_1.time_ <= var_165_18 + arg_165_0 and not isNil(var_165_17) and arg_162_1.var_.characterEffect1084ui_story == nil then
				arg_162_1.var_.characterEffect1084ui_story = var_165_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_19 = 0.2

			if var_165_18 <= arg_162_1.time_ and arg_162_1.time_ < var_165_18 + var_165_19 and not isNil(var_165_17) then
				local var_165_20 = (arg_162_1.time_ - var_165_18) / var_165_19

				if arg_162_1.var_.characterEffect1084ui_story and not isNil(var_165_17) then
					arg_162_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_18 + var_165_19 and arg_162_1.time_ < var_165_18 + var_165_19 + arg_165_0 and not isNil(var_165_17) and arg_162_1.var_.characterEffect1084ui_story then
				arg_162_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_165_21 = 0
			local var_165_22 = 0.225

			if var_165_21 < arg_162_1.time_ and arg_162_1.time_ <= var_165_21 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_23 = arg_162_1:FormatText(StoryNameCfg[6].name)

				arg_162_1.leftNameTxt_.text = var_165_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_24 = arg_162_1:GetWordFromCfg(113191038)
				local var_165_25 = arg_162_1:FormatText(var_165_24.content)

				arg_162_1.text_.text = var_165_25

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_26 = 9
				local var_165_27 = utf8.len(var_165_25)
				local var_165_28 = var_165_26 <= 0 and var_165_22 or var_165_22 * (var_165_27 / var_165_26)

				if var_165_28 > 0 and var_165_22 < var_165_28 then
					arg_162_1.talkMaxDuration = var_165_28

					if var_165_28 + var_165_21 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_28 + var_165_21
					end
				end

				arg_162_1.text_.text = var_165_25
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191038", "story_v_out_113191.awb") ~= 0 then
					local var_165_29 = manager.audio:GetVoiceLength("story_v_out_113191", "113191038", "story_v_out_113191.awb") / 1000

					if var_165_29 + var_165_21 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_29 + var_165_21
					end

					if var_165_24.prefab_name ~= "" and arg_162_1.actors_[var_165_24.prefab_name] ~= nil then
						local var_165_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_24.prefab_name].transform, "story_v_out_113191", "113191038", "story_v_out_113191.awb")

						arg_162_1:RecordAudio("113191038", var_165_30)
						arg_162_1:RecordAudio("113191038", var_165_30)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_113191", "113191038", "story_v_out_113191.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_113191", "113191038", "story_v_out_113191.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_31 = math.max(var_165_22, arg_162_1.talkMaxDuration)

			if var_165_21 <= arg_162_1.time_ and arg_162_1.time_ < var_165_21 + var_165_31 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_21) / var_165_31

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_21 + var_165_31 and arg_162_1.time_ < var_165_21 + var_165_31 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play113191039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 113191039
		arg_166_1.duration_ = 2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play113191040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1038ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1038ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, -1.11, -5.9)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1038ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["1097ui_story"].transform
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.var_.moveOldPos1097ui_story = var_169_9.localPosition
			end

			local var_169_11 = 0.001

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11
				local var_169_13 = Vector3.New(0, 100, 0)

				var_169_9.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1097ui_story, var_169_13, var_169_12)

				local var_169_14 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_14.x, var_169_14.y, var_169_14.z)

				local var_169_15 = var_169_9.localEulerAngles

				var_169_15.z = 0
				var_169_15.x = 0
				var_169_9.localEulerAngles = var_169_15
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 then
				var_169_9.localPosition = Vector3.New(0, 100, 0)

				local var_169_16 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_16.x, var_169_16.y, var_169_16.z)

				local var_169_17 = var_169_9.localEulerAngles

				var_169_17.z = 0
				var_169_17.x = 0
				var_169_9.localEulerAngles = var_169_17
			end

			local var_169_18 = arg_166_1.actors_["1084ui_story"].transform
			local var_169_19 = 0

			if var_169_19 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1.var_.moveOldPos1084ui_story = var_169_18.localPosition
			end

			local var_169_20 = 0.001

			if var_169_19 <= arg_166_1.time_ and arg_166_1.time_ < var_169_19 + var_169_20 then
				local var_169_21 = (arg_166_1.time_ - var_169_19) / var_169_20
				local var_169_22 = Vector3.New(0, 100, 0)

				var_169_18.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1084ui_story, var_169_22, var_169_21)

				local var_169_23 = manager.ui.mainCamera.transform.position - var_169_18.position

				var_169_18.forward = Vector3.New(var_169_23.x, var_169_23.y, var_169_23.z)

				local var_169_24 = var_169_18.localEulerAngles

				var_169_24.z = 0
				var_169_24.x = 0
				var_169_18.localEulerAngles = var_169_24
			end

			if arg_166_1.time_ >= var_169_19 + var_169_20 and arg_166_1.time_ < var_169_19 + var_169_20 + arg_169_0 then
				var_169_18.localPosition = Vector3.New(0, 100, 0)

				local var_169_25 = manager.ui.mainCamera.transform.position - var_169_18.position

				var_169_18.forward = Vector3.New(var_169_25.x, var_169_25.y, var_169_25.z)

				local var_169_26 = var_169_18.localEulerAngles

				var_169_26.z = 0
				var_169_26.x = 0
				var_169_18.localEulerAngles = var_169_26
			end

			local var_169_27 = 0

			if var_169_27 < arg_166_1.time_ and arg_166_1.time_ <= var_169_27 + arg_169_0 then
				arg_166_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_169_28 = 0

			if var_169_28 < arg_166_1.time_ and arg_166_1.time_ <= var_169_28 + arg_169_0 then
				arg_166_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_169_29 = arg_166_1.actors_["1038ui_story"]
			local var_169_30 = 0

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 and not isNil(var_169_29) and arg_166_1.var_.characterEffect1038ui_story == nil then
				arg_166_1.var_.characterEffect1038ui_story = var_169_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_31 = 0.2

			if var_169_30 <= arg_166_1.time_ and arg_166_1.time_ < var_169_30 + var_169_31 and not isNil(var_169_29) then
				local var_169_32 = (arg_166_1.time_ - var_169_30) / var_169_31

				if arg_166_1.var_.characterEffect1038ui_story and not isNil(var_169_29) then
					arg_166_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_30 + var_169_31 and arg_166_1.time_ < var_169_30 + var_169_31 + arg_169_0 and not isNil(var_169_29) and arg_166_1.var_.characterEffect1038ui_story then
				arg_166_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_169_33 = 0
			local var_169_34 = 0.05

			if var_169_33 < arg_166_1.time_ and arg_166_1.time_ <= var_169_33 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_35 = arg_166_1:FormatText(StoryNameCfg[94].name)

				arg_166_1.leftNameTxt_.text = var_169_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_36 = arg_166_1:GetWordFromCfg(113191039)
				local var_169_37 = arg_166_1:FormatText(var_169_36.content)

				arg_166_1.text_.text = var_169_37

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_38 = 2
				local var_169_39 = utf8.len(var_169_37)
				local var_169_40 = var_169_38 <= 0 and var_169_34 or var_169_34 * (var_169_39 / var_169_38)

				if var_169_40 > 0 and var_169_34 < var_169_40 then
					arg_166_1.talkMaxDuration = var_169_40

					if var_169_40 + var_169_33 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_40 + var_169_33
					end
				end

				arg_166_1.text_.text = var_169_37
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191039", "story_v_out_113191.awb") ~= 0 then
					local var_169_41 = manager.audio:GetVoiceLength("story_v_out_113191", "113191039", "story_v_out_113191.awb") / 1000

					if var_169_41 + var_169_33 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_41 + var_169_33
					end

					if var_169_36.prefab_name ~= "" and arg_166_1.actors_[var_169_36.prefab_name] ~= nil then
						local var_169_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_36.prefab_name].transform, "story_v_out_113191", "113191039", "story_v_out_113191.awb")

						arg_166_1:RecordAudio("113191039", var_169_42)
						arg_166_1:RecordAudio("113191039", var_169_42)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_113191", "113191039", "story_v_out_113191.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_113191", "113191039", "story_v_out_113191.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_43 = math.max(var_169_34, arg_166_1.talkMaxDuration)

			if var_169_33 <= arg_166_1.time_ and arg_166_1.time_ < var_169_33 + var_169_43 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_33) / var_169_43

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_33 + var_169_43 and arg_166_1.time_ < var_169_33 + var_169_43 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play113191040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 113191040
		arg_170_1.duration_ = 2

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play113191041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_173_1 = 0
			local var_173_2 = 0.1

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_3 = arg_170_1:FormatText(StoryNameCfg[94].name)

				arg_170_1.leftNameTxt_.text = var_173_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:GetWordFromCfg(113191040)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 4
				local var_173_7 = utf8.len(var_173_5)
				local var_173_8 = var_173_6 <= 0 and var_173_2 or var_173_2 * (var_173_7 / var_173_6)

				if var_173_8 > 0 and var_173_2 < var_173_8 then
					arg_170_1.talkMaxDuration = var_173_8

					if var_173_8 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191040", "story_v_out_113191.awb") ~= 0 then
					local var_173_9 = manager.audio:GetVoiceLength("story_v_out_113191", "113191040", "story_v_out_113191.awb") / 1000

					if var_173_9 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_1
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_113191", "113191040", "story_v_out_113191.awb")

						arg_170_1:RecordAudio("113191040", var_173_10)
						arg_170_1:RecordAudio("113191040", var_173_10)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_113191", "113191040", "story_v_out_113191.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_113191", "113191040", "story_v_out_113191.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_11 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_11 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_11

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_11 and arg_170_1.time_ < var_173_1 + var_173_11 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play113191041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 113191041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play113191042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1038ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1038ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1038ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = 0
			local var_177_10 = 0.425

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_11 = arg_174_1:GetWordFromCfg(113191041)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 17
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_10 or var_177_10 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_10 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_9 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_9
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_10, arg_174_1.talkMaxDuration)

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_9) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_9 + var_177_16 and arg_174_1.time_ < var_177_9 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play113191042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113191042
		arg_178_1.duration_ = 2.87

		local var_178_0 = {
			ja = 2.266,
			ko = 2.866,
			zh = 2.1,
			en = 2.366
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play113191043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1038ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1038ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1.11, -5.9)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1038ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_11 = arg_178_1.actors_["1038ui_story"]
			local var_181_12 = 0

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect1038ui_story == nil then
				arg_178_1.var_.characterEffect1038ui_story = var_181_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_13 = 0.2

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_13 and not isNil(var_181_11) then
				local var_181_14 = (arg_178_1.time_ - var_181_12) / var_181_13

				if arg_178_1.var_.characterEffect1038ui_story and not isNil(var_181_11) then
					arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_12 + var_181_13 and arg_178_1.time_ < var_181_12 + var_181_13 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect1038ui_story then
				arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_181_15 = 0
			local var_181_16 = 0.25

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[94].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(113191042)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 10
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191042", "story_v_out_113191.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191042", "story_v_out_113191.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_113191", "113191042", "story_v_out_113191.awb")

						arg_178_1:RecordAudio("113191042", var_181_24)
						arg_178_1:RecordAudio("113191042", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_113191", "113191042", "story_v_out_113191.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_113191", "113191042", "story_v_out_113191.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play113191043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113191043
		arg_182_1.duration_ = 4.83

		local var_182_0 = {
			ja = 1.033,
			ko = 1.766,
			zh = 4.833,
			en = 1
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play113191044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1038ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1038ui_story == nil then
				arg_182_1.var_.characterEffect1038ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1038ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1038ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1038ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1038ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0
			local var_185_7 = 0.05

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[208].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_9 = arg_182_1:GetWordFromCfg(113191043)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 2
				local var_185_12 = utf8.len(var_185_10)
				local var_185_13 = var_185_11 <= 0 and var_185_7 or var_185_7 * (var_185_12 / var_185_11)

				if var_185_13 > 0 and var_185_7 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191043", "story_v_out_113191.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191043", "story_v_out_113191.awb") / 1000

					if var_185_14 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_6
					end

					if var_185_9.prefab_name ~= "" and arg_182_1.actors_[var_185_9.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_9.prefab_name].transform, "story_v_out_113191", "113191043", "story_v_out_113191.awb")

						arg_182_1:RecordAudio("113191043", var_185_15)
						arg_182_1:RecordAudio("113191043", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_113191", "113191043", "story_v_out_113191.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_113191", "113191043", "story_v_out_113191.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_16 and arg_182_1.time_ < var_185_6 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play113191044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113191044
		arg_186_1.duration_ = 9.37

		local var_186_0 = {
			ja = 9.366,
			ko = 6.9,
			zh = 5.166,
			en = 6.133
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
				arg_186_0:Play113191045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_1 = arg_186_1.actors_["1038ui_story"]
			local var_189_2 = 0

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1038ui_story == nil then
				arg_186_1.var_.characterEffect1038ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.2

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_3 and not isNil(var_189_1) then
				local var_189_4 = (arg_186_1.time_ - var_189_2) / var_189_3

				if arg_186_1.var_.characterEffect1038ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_2 + var_189_3 and arg_186_1.time_ < var_189_2 + var_189_3 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1038ui_story then
				arg_186_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_189_5 = 0
			local var_189_6 = 0.675

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_7 = arg_186_1:FormatText(StoryNameCfg[94].name)

				arg_186_1.leftNameTxt_.text = var_189_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(113191044)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 27
				local var_189_11 = utf8.len(var_189_9)
				local var_189_12 = var_189_10 <= 0 and var_189_6 or var_189_6 * (var_189_11 / var_189_10)

				if var_189_12 > 0 and var_189_6 < var_189_12 then
					arg_186_1.talkMaxDuration = var_189_12

					if var_189_12 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191044", "story_v_out_113191.awb") ~= 0 then
					local var_189_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191044", "story_v_out_113191.awb") / 1000

					if var_189_13 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_5
					end

					if var_189_8.prefab_name ~= "" and arg_186_1.actors_[var_189_8.prefab_name] ~= nil then
						local var_189_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_8.prefab_name].transform, "story_v_out_113191", "113191044", "story_v_out_113191.awb")

						arg_186_1:RecordAudio("113191044", var_189_14)
						arg_186_1:RecordAudio("113191044", var_189_14)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_113191", "113191044", "story_v_out_113191.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_113191", "113191044", "story_v_out_113191.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_15 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_15 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_15

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_15 and arg_186_1.time_ < var_189_5 + var_189_15 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play113191045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 113191045
		arg_190_1.duration_ = 5.47

		local var_190_0 = {
			ja = 5.366,
			ko = 4.6,
			zh = 5.466,
			en = 3.633
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
				arg_190_0:Play113191046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1038ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1038ui_story == nil then
				arg_190_1.var_.characterEffect1038ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1038ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1038ui_story then
				arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_193_4 = 0
			local var_193_5 = 0.425

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_6 = arg_190_1:FormatText(StoryNameCfg[208].name)

				arg_190_1.leftNameTxt_.text = var_193_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_7 = arg_190_1:GetWordFromCfg(113191045)
				local var_193_8 = arg_190_1:FormatText(var_193_7.content)

				arg_190_1.text_.text = var_193_8

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 17
				local var_193_10 = utf8.len(var_193_8)
				local var_193_11 = var_193_9 <= 0 and var_193_5 or var_193_5 * (var_193_10 / var_193_9)

				if var_193_11 > 0 and var_193_5 < var_193_11 then
					arg_190_1.talkMaxDuration = var_193_11

					if var_193_11 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_8
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191045", "story_v_out_113191.awb") ~= 0 then
					local var_193_12 = manager.audio:GetVoiceLength("story_v_out_113191", "113191045", "story_v_out_113191.awb") / 1000

					if var_193_12 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_4
					end

					if var_193_7.prefab_name ~= "" and arg_190_1.actors_[var_193_7.prefab_name] ~= nil then
						local var_193_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_7.prefab_name].transform, "story_v_out_113191", "113191045", "story_v_out_113191.awb")

						arg_190_1:RecordAudio("113191045", var_193_13)
						arg_190_1:RecordAudio("113191045", var_193_13)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_113191", "113191045", "story_v_out_113191.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_113191", "113191045", "story_v_out_113191.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_14 and arg_190_1.time_ < var_193_4 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play113191046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 113191046
		arg_194_1.duration_ = 2

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play113191047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_197_1 = arg_194_1.actors_["1038ui_story"]
			local var_197_2 = 0

			if var_197_2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1038ui_story == nil then
				arg_194_1.var_.characterEffect1038ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.2

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_3 and not isNil(var_197_1) then
				local var_197_4 = (arg_194_1.time_ - var_197_2) / var_197_3

				if arg_194_1.var_.characterEffect1038ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_2 + var_197_3 and arg_194_1.time_ < var_197_2 + var_197_3 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1038ui_story then
				arg_194_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_197_5 = 0
			local var_197_6 = 0.125

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_7 = arg_194_1:FormatText(StoryNameCfg[94].name)

				arg_194_1.leftNameTxt_.text = var_197_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:GetWordFromCfg(113191046)
				local var_197_9 = arg_194_1:FormatText(var_197_8.content)

				arg_194_1.text_.text = var_197_9

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 5
				local var_197_11 = utf8.len(var_197_9)
				local var_197_12 = var_197_10 <= 0 and var_197_6 or var_197_6 * (var_197_11 / var_197_10)

				if var_197_12 > 0 and var_197_6 < var_197_12 then
					arg_194_1.talkMaxDuration = var_197_12

					if var_197_12 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_9
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191046", "story_v_out_113191.awb") ~= 0 then
					local var_197_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191046", "story_v_out_113191.awb") / 1000

					if var_197_13 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_5
					end

					if var_197_8.prefab_name ~= "" and arg_194_1.actors_[var_197_8.prefab_name] ~= nil then
						local var_197_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_8.prefab_name].transform, "story_v_out_113191", "113191046", "story_v_out_113191.awb")

						arg_194_1:RecordAudio("113191046", var_197_14)
						arg_194_1:RecordAudio("113191046", var_197_14)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_113191", "113191046", "story_v_out_113191.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_113191", "113191046", "story_v_out_113191.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_15 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_15 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_15

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_15 and arg_194_1.time_ < var_197_5 + var_197_15 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play113191047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 113191047
		arg_198_1.duration_ = 12.1

		local var_198_0 = {
			ja = 8.966,
			ko = 10.2,
			zh = 12,
			en = 12.1
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play113191048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1038ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1038ui_story == nil then
				arg_198_1.var_.characterEffect1038ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1038ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1038ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1038ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1038ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 1.2

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[208].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(113191047)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 48
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191047", "story_v_out_113191.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191047", "story_v_out_113191.awb") / 1000

					if var_201_14 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_6
					end

					if var_201_9.prefab_name ~= "" and arg_198_1.actors_[var_201_9.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_9.prefab_name].transform, "story_v_out_113191", "113191047", "story_v_out_113191.awb")

						arg_198_1:RecordAudio("113191047", var_201_15)
						arg_198_1:RecordAudio("113191047", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_113191", "113191047", "story_v_out_113191.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_113191", "113191047", "story_v_out_113191.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_16 and arg_198_1.time_ < var_201_6 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play113191048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 113191048
		arg_202_1.duration_ = 7.13

		local var_202_0 = {
			ja = 5.8,
			ko = 7.133,
			zh = 4.7,
			en = 4.966
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play113191049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_205_1 = arg_202_1.actors_["1038ui_story"]
			local var_205_2 = 0

			if var_205_2 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1038ui_story == nil then
				arg_202_1.var_.characterEffect1038ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_3 = 0.2

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_3 and not isNil(var_205_1) then
				local var_205_4 = (arg_202_1.time_ - var_205_2) / var_205_3

				if arg_202_1.var_.characterEffect1038ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_2 + var_205_3 and arg_202_1.time_ < var_205_2 + var_205_3 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1038ui_story then
				arg_202_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			local var_205_6 = 0
			local var_205_7 = 0.55

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[94].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_9 = arg_202_1:GetWordFromCfg(113191048)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 22
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191048", "story_v_out_113191.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191048", "story_v_out_113191.awb") / 1000

					if var_205_14 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_6
					end

					if var_205_9.prefab_name ~= "" and arg_202_1.actors_[var_205_9.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_9.prefab_name].transform, "story_v_out_113191", "113191048", "story_v_out_113191.awb")

						arg_202_1:RecordAudio("113191048", var_205_15)
						arg_202_1:RecordAudio("113191048", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_113191", "113191048", "story_v_out_113191.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_113191", "113191048", "story_v_out_113191.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_16 and arg_202_1.time_ < var_205_6 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play113191049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 113191049
		arg_206_1.duration_ = 14.93

		local var_206_0 = {
			ja = 14.366,
			ko = 12.733,
			zh = 12.966,
			en = 14.933
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play113191050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1038ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1038ui_story == nil then
				arg_206_1.var_.characterEffect1038ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1038ui_story and not isNil(var_209_0) then
					local var_209_4 = Mathf.Lerp(0, 0.5, var_209_3)

					arg_206_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1038ui_story.fillRatio = var_209_4
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1038ui_story then
				local var_209_5 = 0.5

				arg_206_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1038ui_story.fillRatio = var_209_5
			end

			local var_209_6 = 0
			local var_209_7 = 1.2

			if var_209_6 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_8 = arg_206_1:FormatText(StoryNameCfg[208].name)

				arg_206_1.leftNameTxt_.text = var_209_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_9 = arg_206_1:GetWordFromCfg(113191049)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 48
				local var_209_12 = utf8.len(var_209_10)
				local var_209_13 = var_209_11 <= 0 and var_209_7 or var_209_7 * (var_209_12 / var_209_11)

				if var_209_13 > 0 and var_209_7 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_10
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191049", "story_v_out_113191.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191049", "story_v_out_113191.awb") / 1000

					if var_209_14 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_6
					end

					if var_209_9.prefab_name ~= "" and arg_206_1.actors_[var_209_9.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_9.prefab_name].transform, "story_v_out_113191", "113191049", "story_v_out_113191.awb")

						arg_206_1:RecordAudio("113191049", var_209_15)
						arg_206_1:RecordAudio("113191049", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_113191", "113191049", "story_v_out_113191.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_113191", "113191049", "story_v_out_113191.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_16 and arg_206_1.time_ < var_209_6 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play113191050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 113191050
		arg_210_1.duration_ = 8.83

		local var_210_0 = {
			ja = 5.166,
			ko = 6.433,
			zh = 5.1,
			en = 8.833
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play113191051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.525

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[208].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:GetWordFromCfg(113191050)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 21
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191050", "story_v_out_113191.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191050", "story_v_out_113191.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_113191", "113191050", "story_v_out_113191.awb")

						arg_210_1:RecordAudio("113191050", var_213_9)
						arg_210_1:RecordAudio("113191050", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_113191", "113191050", "story_v_out_113191.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_113191", "113191050", "story_v_out_113191.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play113191051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 113191051
		arg_214_1.duration_ = 2.13

		local var_214_0 = {
			ja = 2.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_214_0:Play113191052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_217_1 = arg_214_1.actors_["1038ui_story"]
			local var_217_2 = 0

			if var_217_2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1038ui_story == nil then
				arg_214_1.var_.characterEffect1038ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.2

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_3 and not isNil(var_217_1) then
				local var_217_4 = (arg_214_1.time_ - var_217_2) / var_217_3

				if arg_214_1.var_.characterEffect1038ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_2 + var_217_3 and arg_214_1.time_ < var_217_2 + var_217_3 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1038ui_story then
				arg_214_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_217_5 = 0
			local var_217_6 = 0.075

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_7 = arg_214_1:FormatText(StoryNameCfg[94].name)

				arg_214_1.leftNameTxt_.text = var_217_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_8 = arg_214_1:GetWordFromCfg(113191051)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 3
				local var_217_11 = utf8.len(var_217_9)
				local var_217_12 = var_217_10 <= 0 and var_217_6 or var_217_6 * (var_217_11 / var_217_10)

				if var_217_12 > 0 and var_217_6 < var_217_12 then
					arg_214_1.talkMaxDuration = var_217_12

					if var_217_12 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191051", "story_v_out_113191.awb") ~= 0 then
					local var_217_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191051", "story_v_out_113191.awb") / 1000

					if var_217_13 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_5
					end

					if var_217_8.prefab_name ~= "" and arg_214_1.actors_[var_217_8.prefab_name] ~= nil then
						local var_217_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_8.prefab_name].transform, "story_v_out_113191", "113191051", "story_v_out_113191.awb")

						arg_214_1:RecordAudio("113191051", var_217_14)
						arg_214_1:RecordAudio("113191051", var_217_14)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_113191", "113191051", "story_v_out_113191.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_113191", "113191051", "story_v_out_113191.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_15 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_15 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_15

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_15 and arg_214_1.time_ < var_217_5 + var_217_15 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play113191052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 113191052
		arg_218_1.duration_ = 13.7

		local var_218_0 = {
			ja = 9.9,
			ko = 13.7,
			zh = 9.3,
			en = 12.5
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
				arg_218_0:Play113191053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_221_1 = arg_218_1.actors_["1038ui_story"]
			local var_221_2 = 0

			if var_221_2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1038ui_story == nil then
				arg_218_1.var_.characterEffect1038ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.2

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_3 and not isNil(var_221_1) then
				local var_221_4 = (arg_218_1.time_ - var_221_2) / var_221_3

				if arg_218_1.var_.characterEffect1038ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_2 + var_221_3 and arg_218_1.time_ < var_221_2 + var_221_3 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1038ui_story then
				arg_218_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_221_5 = 0

			if var_221_5 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_221_6 = 0
			local var_221_7 = 1.325

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_8 = arg_218_1:FormatText(StoryNameCfg[94].name)

				arg_218_1.leftNameTxt_.text = var_221_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_9 = arg_218_1:GetWordFromCfg(113191052)
				local var_221_10 = arg_218_1:FormatText(var_221_9.content)

				arg_218_1.text_.text = var_221_10

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 53
				local var_221_12 = utf8.len(var_221_10)
				local var_221_13 = var_221_11 <= 0 and var_221_7 or var_221_7 * (var_221_12 / var_221_11)

				if var_221_13 > 0 and var_221_7 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_10
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191052", "story_v_out_113191.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191052", "story_v_out_113191.awb") / 1000

					if var_221_14 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_6
					end

					if var_221_9.prefab_name ~= "" and arg_218_1.actors_[var_221_9.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_9.prefab_name].transform, "story_v_out_113191", "113191052", "story_v_out_113191.awb")

						arg_218_1:RecordAudio("113191052", var_221_15)
						arg_218_1:RecordAudio("113191052", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_113191", "113191052", "story_v_out_113191.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_113191", "113191052", "story_v_out_113191.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_16 and arg_218_1.time_ < var_221_6 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play113191053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 113191053
		arg_222_1.duration_ = 2.07

		local var_222_0 = {
			ja = 2.066,
			ko = 1.566,
			zh = 1.8,
			en = 1.366
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
				arg_222_0:Play113191054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1038ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1038ui_story == nil then
				arg_222_1.var_.characterEffect1038ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1038ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1038ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1038ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1038ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.1

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_8 = arg_222_1:FormatText(StoryNameCfg[208].name)

				arg_222_1.leftNameTxt_.text = var_225_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_9 = arg_222_1:GetWordFromCfg(113191053)
				local var_225_10 = arg_222_1:FormatText(var_225_9.content)

				arg_222_1.text_.text = var_225_10

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 4
				local var_225_12 = utf8.len(var_225_10)
				local var_225_13 = var_225_11 <= 0 and var_225_7 or var_225_7 * (var_225_12 / var_225_11)

				if var_225_13 > 0 and var_225_7 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_10
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191053", "story_v_out_113191.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191053", "story_v_out_113191.awb") / 1000

					if var_225_14 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_6
					end

					if var_225_9.prefab_name ~= "" and arg_222_1.actors_[var_225_9.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_9.prefab_name].transform, "story_v_out_113191", "113191053", "story_v_out_113191.awb")

						arg_222_1:RecordAudio("113191053", var_225_15)
						arg_222_1:RecordAudio("113191053", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_113191", "113191053", "story_v_out_113191.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_113191", "113191053", "story_v_out_113191.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_16 and arg_222_1.time_ < var_225_6 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play113191054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 113191054
		arg_226_1.duration_ = 10.1

		local var_226_0 = {
			ja = 8.633,
			ko = 10.1,
			zh = 8.066,
			en = 9.4
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play113191055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_229_1 = arg_226_1.actors_["1038ui_story"]
			local var_229_2 = 0

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1038ui_story == nil then
				arg_226_1.var_.characterEffect1038ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_3 = 0.2

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_3 and not isNil(var_229_1) then
				local var_229_4 = (arg_226_1.time_ - var_229_2) / var_229_3

				if arg_226_1.var_.characterEffect1038ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_2 + var_229_3 and arg_226_1.time_ < var_229_2 + var_229_3 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1038ui_story then
				arg_226_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_229_5 = 0
			local var_229_6 = 1.125

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_7 = arg_226_1:FormatText(StoryNameCfg[94].name)

				arg_226_1.leftNameTxt_.text = var_229_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(113191054)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 45
				local var_229_11 = utf8.len(var_229_9)
				local var_229_12 = var_229_10 <= 0 and var_229_6 or var_229_6 * (var_229_11 / var_229_10)

				if var_229_12 > 0 and var_229_6 < var_229_12 then
					arg_226_1.talkMaxDuration = var_229_12

					if var_229_12 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191054", "story_v_out_113191.awb") ~= 0 then
					local var_229_13 = manager.audio:GetVoiceLength("story_v_out_113191", "113191054", "story_v_out_113191.awb") / 1000

					if var_229_13 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_5
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_113191", "113191054", "story_v_out_113191.awb")

						arg_226_1:RecordAudio("113191054", var_229_14)
						arg_226_1:RecordAudio("113191054", var_229_14)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_113191", "113191054", "story_v_out_113191.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_113191", "113191054", "story_v_out_113191.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_15 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_15 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_15

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_15 and arg_226_1.time_ < var_229_5 + var_229_15 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play113191055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 113191055
		arg_230_1.duration_ = 9.33

		local var_230_0 = {
			ja = 9.333,
			ko = 6.8,
			zh = 7.7,
			en = 6.833
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play113191056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_233_1 = arg_230_1.actors_["1038ui_story"]
			local var_233_2 = 0

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1038ui_story == nil then
				arg_230_1.var_.characterEffect1038ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_3 = 0.2

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_3 and not isNil(var_233_1) then
				local var_233_4 = (arg_230_1.time_ - var_233_2) / var_233_3

				if arg_230_1.var_.characterEffect1038ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_2 + var_233_3 and arg_230_1.time_ < var_233_2 + var_233_3 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1038ui_story then
				arg_230_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			local var_233_6 = 0
			local var_233_7 = 0.625

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[94].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:GetWordFromCfg(113191055)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 25
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191055", "story_v_out_113191.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191055", "story_v_out_113191.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_out_113191", "113191055", "story_v_out_113191.awb")

						arg_230_1:RecordAudio("113191055", var_233_15)
						arg_230_1:RecordAudio("113191055", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_113191", "113191055", "story_v_out_113191.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_113191", "113191055", "story_v_out_113191.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_16 and arg_230_1.time_ < var_233_6 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play113191056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 113191056
		arg_234_1.duration_ = 1.63

		local var_234_0 = {
			ja = 1.3,
			ko = 1.6,
			zh = 1.633,
			en = 1.166
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play113191057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1038ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1038ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, 100, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1038ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, 100, 0)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = 0
			local var_237_10 = 0.05

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_11 = arg_234_1:FormatText(StoryNameCfg[208].name)

				arg_234_1.leftNameTxt_.text = var_237_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_12 = arg_234_1:GetWordFromCfg(113191056)
				local var_237_13 = arg_234_1:FormatText(var_237_12.content)

				arg_234_1.text_.text = var_237_13

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_14 = 2
				local var_237_15 = utf8.len(var_237_13)
				local var_237_16 = var_237_14 <= 0 and var_237_10 or var_237_10 * (var_237_15 / var_237_14)

				if var_237_16 > 0 and var_237_10 < var_237_16 then
					arg_234_1.talkMaxDuration = var_237_16

					if var_237_16 + var_237_9 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_16 + var_237_9
					end
				end

				arg_234_1.text_.text = var_237_13
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191056", "story_v_out_113191.awb") ~= 0 then
					local var_237_17 = manager.audio:GetVoiceLength("story_v_out_113191", "113191056", "story_v_out_113191.awb") / 1000

					if var_237_17 + var_237_9 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_17 + var_237_9
					end

					if var_237_12.prefab_name ~= "" and arg_234_1.actors_[var_237_12.prefab_name] ~= nil then
						local var_237_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_12.prefab_name].transform, "story_v_out_113191", "113191056", "story_v_out_113191.awb")

						arg_234_1:RecordAudio("113191056", var_237_18)
						arg_234_1:RecordAudio("113191056", var_237_18)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_113191", "113191056", "story_v_out_113191.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_113191", "113191056", "story_v_out_113191.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_19 = math.max(var_237_10, arg_234_1.talkMaxDuration)

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_19 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_9) / var_237_19

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_9 + var_237_19 and arg_234_1.time_ < var_237_9 + var_237_19 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play113191057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 113191057
		arg_238_1.duration_ = 4

		local var_238_0 = {
			ja = 3.333,
			ko = 4,
			zh = 2.433,
			en = 3.333
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play113191058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1084ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_0.localPosition

				local var_241_2 = "1084ui_story"

				arg_238_1:ShowWeapon(arg_238_1.var_[var_241_2 .. "Animator"].transform, false)
			end

			local var_241_3 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_3 then
				local var_241_4 = (arg_238_1.time_ - var_241_1) / var_241_3
				local var_241_5 = Vector3.New(-0.7, -0.97, -6)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, var_241_5, var_241_4)

				local var_241_6 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_6.x, var_241_6.y, var_241_6.z)

				local var_241_7 = var_241_0.localEulerAngles

				var_241_7.z = 0
				var_241_7.x = 0
				var_241_0.localEulerAngles = var_241_7
			end

			if arg_238_1.time_ >= var_241_1 + var_241_3 and arg_238_1.time_ < var_241_1 + var_241_3 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_241_8 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_8.x, var_241_8.y, var_241_8.z)

				local var_241_9 = var_241_0.localEulerAngles

				var_241_9.z = 0
				var_241_9.x = 0
				var_241_0.localEulerAngles = var_241_9
			end

			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_241_11 = arg_238_1.actors_["1084ui_story"]
			local var_241_12 = 0

			if var_241_12 < arg_238_1.time_ and arg_238_1.time_ <= var_241_12 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_13 = 0.2

			if var_241_12 <= arg_238_1.time_ and arg_238_1.time_ < var_241_12 + var_241_13 and not isNil(var_241_11) then
				local var_241_14 = (arg_238_1.time_ - var_241_12) / var_241_13

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_11) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_12 + var_241_13 and arg_238_1.time_ < var_241_12 + var_241_13 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_15 = 0

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_241_16 = 0
			local var_241_17 = 0.275

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_18 = arg_238_1:FormatText(StoryNameCfg[6].name)

				arg_238_1.leftNameTxt_.text = var_241_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_19 = arg_238_1:GetWordFromCfg(113191057)
				local var_241_20 = arg_238_1:FormatText(var_241_19.content)

				arg_238_1.text_.text = var_241_20

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_21 = 11
				local var_241_22 = utf8.len(var_241_20)
				local var_241_23 = var_241_21 <= 0 and var_241_17 or var_241_17 * (var_241_22 / var_241_21)

				if var_241_23 > 0 and var_241_17 < var_241_23 then
					arg_238_1.talkMaxDuration = var_241_23

					if var_241_23 + var_241_16 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_16
					end
				end

				arg_238_1.text_.text = var_241_20
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191057", "story_v_out_113191.awb") ~= 0 then
					local var_241_24 = manager.audio:GetVoiceLength("story_v_out_113191", "113191057", "story_v_out_113191.awb") / 1000

					if var_241_24 + var_241_16 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_24 + var_241_16
					end

					if var_241_19.prefab_name ~= "" and arg_238_1.actors_[var_241_19.prefab_name] ~= nil then
						local var_241_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_19.prefab_name].transform, "story_v_out_113191", "113191057", "story_v_out_113191.awb")

						arg_238_1:RecordAudio("113191057", var_241_25)
						arg_238_1:RecordAudio("113191057", var_241_25)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_113191", "113191057", "story_v_out_113191.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_113191", "113191057", "story_v_out_113191.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_26 = math.max(var_241_17, arg_238_1.talkMaxDuration)

			if var_241_16 <= arg_238_1.time_ and arg_238_1.time_ < var_241_16 + var_241_26 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_16) / var_241_26

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_16 + var_241_26 and arg_238_1.time_ < var_241_16 + var_241_26 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play113191058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 113191058
		arg_242_1.duration_ = 4.83

		local var_242_0 = {
			ja = 4.833,
			ko = 4.733,
			zh = 3.4,
			en = 4.533
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play113191059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1084ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_5
			end

			local var_245_6 = arg_242_1.actors_["1038ui_story"].transform
			local var_245_7 = 0

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				arg_242_1.var_.moveOldPos1038ui_story = var_245_6.localPosition
			end

			local var_245_8 = 0.001

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 then
				local var_245_9 = (arg_242_1.time_ - var_245_7) / var_245_8
				local var_245_10 = Vector3.New(0.7, -1.11, -5.9)

				var_245_6.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1038ui_story, var_245_10, var_245_9)

				local var_245_11 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_11.x, var_245_11.y, var_245_11.z)

				local var_245_12 = var_245_6.localEulerAngles

				var_245_12.z = 0
				var_245_12.x = 0
				var_245_6.localEulerAngles = var_245_12
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 then
				var_245_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_245_13 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_13.x, var_245_13.y, var_245_13.z)

				local var_245_14 = var_245_6.localEulerAngles

				var_245_14.z = 0
				var_245_14.x = 0
				var_245_6.localEulerAngles = var_245_14
			end

			local var_245_15 = 0

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_245_17 = arg_242_1.actors_["1038ui_story"]
			local var_245_18 = 0

			if var_245_18 < arg_242_1.time_ and arg_242_1.time_ <= var_245_18 + arg_245_0 and not isNil(var_245_17) and arg_242_1.var_.characterEffect1038ui_story == nil then
				arg_242_1.var_.characterEffect1038ui_story = var_245_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_19 = 0.2

			if var_245_18 <= arg_242_1.time_ and arg_242_1.time_ < var_245_18 + var_245_19 and not isNil(var_245_17) then
				local var_245_20 = (arg_242_1.time_ - var_245_18) / var_245_19

				if arg_242_1.var_.characterEffect1038ui_story and not isNil(var_245_17) then
					arg_242_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_18 + var_245_19 and arg_242_1.time_ < var_245_18 + var_245_19 + arg_245_0 and not isNil(var_245_17) and arg_242_1.var_.characterEffect1038ui_story then
				arg_242_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_245_21 = 0
			local var_245_22 = 0.425

			if var_245_21 < arg_242_1.time_ and arg_242_1.time_ <= var_245_21 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_23 = arg_242_1:FormatText(StoryNameCfg[94].name)

				arg_242_1.leftNameTxt_.text = var_245_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_24 = arg_242_1:GetWordFromCfg(113191058)
				local var_245_25 = arg_242_1:FormatText(var_245_24.content)

				arg_242_1.text_.text = var_245_25

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_26 = 17
				local var_245_27 = utf8.len(var_245_25)
				local var_245_28 = var_245_26 <= 0 and var_245_22 or var_245_22 * (var_245_27 / var_245_26)

				if var_245_28 > 0 and var_245_22 < var_245_28 then
					arg_242_1.talkMaxDuration = var_245_28

					if var_245_28 + var_245_21 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_28 + var_245_21
					end
				end

				arg_242_1.text_.text = var_245_25
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191058", "story_v_out_113191.awb") ~= 0 then
					local var_245_29 = manager.audio:GetVoiceLength("story_v_out_113191", "113191058", "story_v_out_113191.awb") / 1000

					if var_245_29 + var_245_21 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_29 + var_245_21
					end

					if var_245_24.prefab_name ~= "" and arg_242_1.actors_[var_245_24.prefab_name] ~= nil then
						local var_245_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_24.prefab_name].transform, "story_v_out_113191", "113191058", "story_v_out_113191.awb")

						arg_242_1:RecordAudio("113191058", var_245_30)
						arg_242_1:RecordAudio("113191058", var_245_30)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_113191", "113191058", "story_v_out_113191.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_113191", "113191058", "story_v_out_113191.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_31 = math.max(var_245_22, arg_242_1.talkMaxDuration)

			if var_245_21 <= arg_242_1.time_ and arg_242_1.time_ < var_245_21 + var_245_31 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_21) / var_245_31

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_21 + var_245_31 and arg_242_1.time_ < var_245_21 + var_245_31 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play113191059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 113191059
		arg_246_1.duration_ = 2.13

		local var_246_0 = {
			ja = 2.133,
			ko = 1.333,
			zh = 1.333,
			en = 1.4
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play113191060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1038ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1038ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, 100, 0)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1038ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, 100, 0)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1084ui_story"].transform
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = var_249_9.localPosition
			end

			local var_249_11 = 0.001

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11
				local var_249_13 = Vector3.New(0, 100, 0)

				var_249_9.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, var_249_13, var_249_12)

				local var_249_14 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_14.x, var_249_14.y, var_249_14.z)

				local var_249_15 = var_249_9.localEulerAngles

				var_249_15.z = 0
				var_249_15.x = 0
				var_249_9.localEulerAngles = var_249_15
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 then
				var_249_9.localPosition = Vector3.New(0, 100, 0)

				local var_249_16 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_16.x, var_249_16.y, var_249_16.z)

				local var_249_17 = var_249_9.localEulerAngles

				var_249_17.z = 0
				var_249_17.x = 0
				var_249_9.localEulerAngles = var_249_17
			end

			local var_249_18 = 0
			local var_249_19 = 0.05

			if var_249_18 < arg_246_1.time_ and arg_246_1.time_ <= var_249_18 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_20 = arg_246_1:FormatText(StoryNameCfg[208].name)

				arg_246_1.leftNameTxt_.text = var_249_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_21 = arg_246_1:GetWordFromCfg(113191059)
				local var_249_22 = arg_246_1:FormatText(var_249_21.content)

				arg_246_1.text_.text = var_249_22

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_23 = 2
				local var_249_24 = utf8.len(var_249_22)
				local var_249_25 = var_249_23 <= 0 and var_249_19 or var_249_19 * (var_249_24 / var_249_23)

				if var_249_25 > 0 and var_249_19 < var_249_25 then
					arg_246_1.talkMaxDuration = var_249_25

					if var_249_25 + var_249_18 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_25 + var_249_18
					end
				end

				arg_246_1.text_.text = var_249_22
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191059", "story_v_out_113191.awb") ~= 0 then
					local var_249_26 = manager.audio:GetVoiceLength("story_v_out_113191", "113191059", "story_v_out_113191.awb") / 1000

					if var_249_26 + var_249_18 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_26 + var_249_18
					end

					if var_249_21.prefab_name ~= "" and arg_246_1.actors_[var_249_21.prefab_name] ~= nil then
						local var_249_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_21.prefab_name].transform, "story_v_out_113191", "113191059", "story_v_out_113191.awb")

						arg_246_1:RecordAudio("113191059", var_249_27)
						arg_246_1:RecordAudio("113191059", var_249_27)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_113191", "113191059", "story_v_out_113191.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_113191", "113191059", "story_v_out_113191.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_28 = math.max(var_249_19, arg_246_1.talkMaxDuration)

			if var_249_18 <= arg_246_1.time_ and arg_246_1.time_ < var_249_18 + var_249_28 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_18) / var_249_28

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_18 + var_249_28 and arg_246_1.time_ < var_249_18 + var_249_28 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play113191060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 113191060
		arg_250_1.duration_ = 9.03

		local var_250_0 = {
			ja = 9.033,
			ko = 8.1,
			zh = 7.4,
			en = 7.833
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play113191061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_1 = 2

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_1 then
				local var_253_2 = (arg_250_1.time_ - var_253_0) / var_253_1
				local var_253_3 = Color.New(0, 0, 0)

				var_253_3.a = Mathf.Lerp(0, 1, var_253_2)
				arg_250_1.mask_.color = var_253_3
			end

			if arg_250_1.time_ >= var_253_0 + var_253_1 and arg_250_1.time_ < var_253_0 + var_253_1 + arg_253_0 then
				local var_253_4 = Color.New(0, 0, 0)

				var_253_4.a = 1
				arg_250_1.mask_.color = var_253_4
			end

			local var_253_5 = 2

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_6 = 2

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_6 then
				local var_253_7 = (arg_250_1.time_ - var_253_5) / var_253_6
				local var_253_8 = Color.New(0, 0, 0)

				var_253_8.a = Mathf.Lerp(1, 0, var_253_7)
				arg_250_1.mask_.color = var_253_8
			end

			if arg_250_1.time_ >= var_253_5 + var_253_6 and arg_250_1.time_ < var_253_5 + var_253_6 + arg_253_0 then
				local var_253_9 = Color.New(0, 0, 0)
				local var_253_10 = 0

				arg_250_1.mask_.enabled = false
				var_253_9.a = var_253_10
				arg_250_1.mask_.color = var_253_9
			end

			local var_253_11 = "OM0107"

			if arg_250_1.bgs_[var_253_11] == nil then
				local var_253_12 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_253_11)
				var_253_12.name = var_253_11
				var_253_12.transform.parent = arg_250_1.stage_.transform
				var_253_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_[var_253_11] = var_253_12
			end

			local var_253_13 = 2

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				local var_253_14 = manager.ui.mainCamera.transform.localPosition
				local var_253_15 = Vector3.New(0, 0, 10) + Vector3.New(var_253_14.x, var_253_14.y, 0)
				local var_253_16 = arg_250_1.bgs_.OM0107

				var_253_16.transform.localPosition = var_253_15
				var_253_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_17 = var_253_16:GetComponent("SpriteRenderer")

				if var_253_17 and var_253_17.sprite then
					local var_253_18 = (var_253_16.transform.localPosition - var_253_14).z
					local var_253_19 = manager.ui.mainCameraCom_
					local var_253_20 = 2 * var_253_18 * Mathf.Tan(var_253_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_253_21 = var_253_20 * var_253_19.aspect
					local var_253_22 = var_253_17.sprite.bounds.size.x
					local var_253_23 = var_253_17.sprite.bounds.size.y
					local var_253_24 = var_253_21 / var_253_22
					local var_253_25 = var_253_20 / var_253_23
					local var_253_26 = var_253_25 < var_253_24 and var_253_24 or var_253_25

					var_253_16.transform.localScale = Vector3.New(var_253_26, var_253_26, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "OM0107" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_27 = arg_250_1.bgs_.OM0107.transform
			local var_253_28 = 2

			if var_253_28 < arg_250_1.time_ and arg_250_1.time_ <= var_253_28 + arg_253_0 then
				arg_250_1.var_.moveOldPosOM0107 = var_253_27.localPosition
			end

			local var_253_29 = 0.001

			if var_253_28 <= arg_250_1.time_ and arg_250_1.time_ < var_253_28 + var_253_29 then
				local var_253_30 = (arg_250_1.time_ - var_253_28) / var_253_29
				local var_253_31 = Vector3.New(-3.8, 2.5, 0)

				var_253_27.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPosOM0107, var_253_31, var_253_30)
			end

			if arg_250_1.time_ >= var_253_28 + var_253_29 and arg_250_1.time_ < var_253_28 + var_253_29 + arg_253_0 then
				var_253_27.localPosition = Vector3.New(-3.8, 2.5, 0)
			end

			local var_253_32 = arg_250_1.bgs_.OM0107.transform
			local var_253_33 = 2.034

			if var_253_33 < arg_250_1.time_ and arg_250_1.time_ <= var_253_33 + arg_253_0 then
				arg_250_1.var_.moveOldPosOM0107 = var_253_32.localPosition
			end

			local var_253_34 = 5

			if var_253_33 <= arg_250_1.time_ and arg_250_1.time_ < var_253_33 + var_253_34 then
				local var_253_35 = (arg_250_1.time_ - var_253_33) / var_253_34
				local var_253_36 = Vector3.New(-3.8, 2.25, 0)

				var_253_32.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPosOM0107, var_253_36, var_253_35)
			end

			if arg_250_1.time_ >= var_253_33 + var_253_34 and arg_250_1.time_ < var_253_33 + var_253_34 + arg_253_0 then
				var_253_32.localPosition = Vector3.New(-3.8, 2.25, 0)
			end

			local var_253_37 = 2

			if var_253_37 < arg_250_1.time_ and arg_250_1.time_ <= var_253_37 + arg_253_0 then
				arg_250_1.allBtn_.enabled = false
			end

			local var_253_38 = 5.034

			if arg_250_1.time_ >= var_253_37 + var_253_38 and arg_250_1.time_ < var_253_37 + var_253_38 + arg_253_0 then
				arg_250_1.allBtn_.enabled = true
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_39 = 4
			local var_253_40 = 0.4

			if var_253_39 < arg_250_1.time_ and arg_250_1.time_ <= var_253_39 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_41 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_41:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_42 = arg_250_1:FormatText(StoryNameCfg[208].name)

				arg_250_1.leftNameTxt_.text = var_253_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_43 = arg_250_1:GetWordFromCfg(113191060)
				local var_253_44 = arg_250_1:FormatText(var_253_43.content)

				arg_250_1.text_.text = var_253_44

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_45 = 16
				local var_253_46 = utf8.len(var_253_44)
				local var_253_47 = var_253_45 <= 0 and var_253_40 or var_253_40 * (var_253_46 / var_253_45)

				if var_253_47 > 0 and var_253_40 < var_253_47 then
					arg_250_1.talkMaxDuration = var_253_47
					var_253_39 = var_253_39 + 0.3

					if var_253_47 + var_253_39 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_47 + var_253_39
					end
				end

				arg_250_1.text_.text = var_253_44
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191060", "story_v_out_113191.awb") ~= 0 then
					local var_253_48 = manager.audio:GetVoiceLength("story_v_out_113191", "113191060", "story_v_out_113191.awb") / 1000

					if var_253_48 + var_253_39 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_48 + var_253_39
					end

					if var_253_43.prefab_name ~= "" and arg_250_1.actors_[var_253_43.prefab_name] ~= nil then
						local var_253_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_43.prefab_name].transform, "story_v_out_113191", "113191060", "story_v_out_113191.awb")

						arg_250_1:RecordAudio("113191060", var_253_49)
						arg_250_1:RecordAudio("113191060", var_253_49)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_113191", "113191060", "story_v_out_113191.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_113191", "113191060", "story_v_out_113191.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_50 = var_253_39 + 0.3
			local var_253_51 = math.max(var_253_40, arg_250_1.talkMaxDuration)

			if var_253_50 <= arg_250_1.time_ and arg_250_1.time_ < var_253_50 + var_253_51 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_50) / var_253_51

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_50 + var_253_51 and arg_250_1.time_ < var_253_50 + var_253_51 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play113191061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 113191061
		arg_256_1.duration_ = 10.43

		local var_256_0 = {
			ja = 9.966,
			ko = 8.533,
			zh = 10.433,
			en = 9.7
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play113191062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_1 = 2

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_1 then
				local var_259_2 = (arg_256_1.time_ - var_259_0) / var_259_1
				local var_259_3 = Color.New(0, 0, 0)

				var_259_3.a = Mathf.Lerp(0, 1, var_259_2)
				arg_256_1.mask_.color = var_259_3
			end

			if arg_256_1.time_ >= var_259_0 + var_259_1 and arg_256_1.time_ < var_259_0 + var_259_1 + arg_259_0 then
				local var_259_4 = Color.New(0, 0, 0)

				var_259_4.a = 1
				arg_256_1.mask_.color = var_259_4
			end

			local var_259_5 = 2

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_6 = 2

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6
				local var_259_8 = Color.New(0, 0, 0)

				var_259_8.a = Mathf.Lerp(1, 0, var_259_7)
				arg_256_1.mask_.color = var_259_8
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 then
				local var_259_9 = Color.New(0, 0, 0)
				local var_259_10 = 0

				arg_256_1.mask_.enabled = false
				var_259_9.a = var_259_10
				arg_256_1.mask_.color = var_259_9
			end

			local var_259_11 = arg_256_1.bgs_.OM0107.transform
			local var_259_12 = 1.966

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 then
				arg_256_1.var_.moveOldPosOM0107 = var_259_11.localPosition
			end

			local var_259_13 = 0.001

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_13 then
				local var_259_14 = (arg_256_1.time_ - var_259_12) / var_259_13
				local var_259_15 = Vector3.New(3.15, -0.7, 0)

				var_259_11.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPosOM0107, var_259_15, var_259_14)
			end

			if arg_256_1.time_ >= var_259_12 + var_259_13 and arg_256_1.time_ < var_259_12 + var_259_13 + arg_259_0 then
				var_259_11.localPosition = Vector3.New(3.15, -0.7, 0)
			end

			local var_259_16 = arg_256_1.bgs_.OM0107.transform
			local var_259_17 = 2

			if var_259_17 < arg_256_1.time_ and arg_256_1.time_ <= var_259_17 + arg_259_0 then
				arg_256_1.var_.moveOldPosOM0107 = var_259_16.localPosition
			end

			local var_259_18 = 5

			if var_259_17 <= arg_256_1.time_ and arg_256_1.time_ < var_259_17 + var_259_18 then
				local var_259_19 = (arg_256_1.time_ - var_259_17) / var_259_18
				local var_259_20 = Vector3.New(3.15, -1, 0)

				var_259_16.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPosOM0107, var_259_20, var_259_19)
			end

			if arg_256_1.time_ >= var_259_17 + var_259_18 and arg_256_1.time_ < var_259_17 + var_259_18 + arg_259_0 then
				var_259_16.localPosition = Vector3.New(3.15, -1, 0)
			end

			local var_259_21 = 2

			if var_259_21 < arg_256_1.time_ and arg_256_1.time_ <= var_259_21 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			local var_259_22 = 5

			if arg_256_1.time_ >= var_259_21 + var_259_22 and arg_256_1.time_ < var_259_21 + var_259_22 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_23 = 4
			local var_259_24 = 0.475

			if var_259_23 < arg_256_1.time_ and arg_256_1.time_ <= var_259_23 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_25 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_25:setOnUpdate(LuaHelper.FloatAction(function(arg_260_0)
					arg_256_1.dialogCg_.alpha = arg_260_0
				end))
				var_259_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_26 = arg_256_1:FormatText(StoryNameCfg[226].name)

				arg_256_1.leftNameTxt_.text = var_259_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_27 = arg_256_1:GetWordFromCfg(113191061)
				local var_259_28 = arg_256_1:FormatText(var_259_27.content)

				arg_256_1.text_.text = var_259_28

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_29 = 19
				local var_259_30 = utf8.len(var_259_28)
				local var_259_31 = var_259_29 <= 0 and var_259_24 or var_259_24 * (var_259_30 / var_259_29)

				if var_259_31 > 0 and var_259_24 < var_259_31 then
					arg_256_1.talkMaxDuration = var_259_31
					var_259_23 = var_259_23 + 0.3

					if var_259_31 + var_259_23 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_31 + var_259_23
					end
				end

				arg_256_1.text_.text = var_259_28
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191061", "story_v_out_113191.awb") ~= 0 then
					local var_259_32 = manager.audio:GetVoiceLength("story_v_out_113191", "113191061", "story_v_out_113191.awb") / 1000

					if var_259_32 + var_259_23 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_32 + var_259_23
					end

					if var_259_27.prefab_name ~= "" and arg_256_1.actors_[var_259_27.prefab_name] ~= nil then
						local var_259_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_27.prefab_name].transform, "story_v_out_113191", "113191061", "story_v_out_113191.awb")

						arg_256_1:RecordAudio("113191061", var_259_33)
						arg_256_1:RecordAudio("113191061", var_259_33)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_113191", "113191061", "story_v_out_113191.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_113191", "113191061", "story_v_out_113191.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_34 = var_259_23 + 0.3
			local var_259_35 = math.max(var_259_24, arg_256_1.talkMaxDuration)

			if var_259_34 <= arg_256_1.time_ and arg_256_1.time_ < var_259_34 + var_259_35 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_34) / var_259_35

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_34 + var_259_35 and arg_256_1.time_ < var_259_34 + var_259_35 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play113191062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 113191062
		arg_262_1.duration_ = 6.57

		local var_262_0 = {
			ja = 4.333,
			ko = 4.433,
			zh = 5.133,
			en = 6.566
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
				arg_262_0:Play113191063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.425

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[226].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:GetWordFromCfg(113191062)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191062", "story_v_out_113191.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191062", "story_v_out_113191.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_out_113191", "113191062", "story_v_out_113191.awb")

						arg_262_1:RecordAudio("113191062", var_265_9)
						arg_262_1:RecordAudio("113191062", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_113191", "113191062", "story_v_out_113191.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_113191", "113191062", "story_v_out_113191.awb")
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
	Play113191063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 113191063
		arg_266_1.duration_ = 7.63

		local var_266_0 = {
			ja = 7.633,
			ko = 7.533,
			zh = 7.433,
			en = 6.7
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
				arg_266_0:Play113191064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_1 = 2

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_1 then
				local var_269_2 = (arg_266_1.time_ - var_269_0) / var_269_1
				local var_269_3 = Color.New(0, 0, 0)

				var_269_3.a = Mathf.Lerp(0, 1, var_269_2)
				arg_266_1.mask_.color = var_269_3
			end

			if arg_266_1.time_ >= var_269_0 + var_269_1 and arg_266_1.time_ < var_269_0 + var_269_1 + arg_269_0 then
				local var_269_4 = Color.New(0, 0, 0)

				var_269_4.a = 1
				arg_266_1.mask_.color = var_269_4
			end

			local var_269_5 = 2

			if var_269_5 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_6 = 2

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_6 then
				local var_269_7 = (arg_266_1.time_ - var_269_5) / var_269_6
				local var_269_8 = Color.New(0, 0, 0)

				var_269_8.a = Mathf.Lerp(1, 0, var_269_7)
				arg_266_1.mask_.color = var_269_8
			end

			if arg_266_1.time_ >= var_269_5 + var_269_6 and arg_266_1.time_ < var_269_5 + var_269_6 + arg_269_0 then
				local var_269_9 = Color.New(0, 0, 0)
				local var_269_10 = 0

				arg_266_1.mask_.enabled = false
				var_269_9.a = var_269_10
				arg_266_1.mask_.color = var_269_9
			end

			local var_269_11 = arg_266_1.bgs_.OM0107.transform
			local var_269_12 = 2

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 then
				arg_266_1.var_.moveOldPosOM0107 = var_269_11.localPosition
			end

			local var_269_13 = 0.001

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_13 then
				local var_269_14 = (arg_266_1.time_ - var_269_12) / var_269_13
				local var_269_15 = Vector3.New(0, 1, 10)

				var_269_11.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPosOM0107, var_269_15, var_269_14)
			end

			if arg_266_1.time_ >= var_269_12 + var_269_13 and arg_266_1.time_ < var_269_12 + var_269_13 + arg_269_0 then
				var_269_11.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_266_1.frameCnt_ <= 1 then
				arg_266_1.dialog_:SetActive(false)
			end

			local var_269_16 = 4
			local var_269_17 = 0.375

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0

				arg_266_1.dialog_:SetActive(true)

				arg_266_1.dialogCg_.alpha = 0

				local var_269_18 = LeanTween.value(arg_266_1.dialog_, 0, 1, 0.3)

				var_269_18:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_266_1.dialogCg_.alpha = arg_270_0
				end))
				var_269_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_266_1.dialog_)
					var_269_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_266_1.duration_ = arg_266_1.duration_ + 0.3

				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_19 = arg_266_1:FormatText(StoryNameCfg[208].name)

				arg_266_1.leftNameTxt_.text = var_269_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_20 = arg_266_1:GetWordFromCfg(113191063)
				local var_269_21 = arg_266_1:FormatText(var_269_20.content)

				arg_266_1.text_.text = var_269_21

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_22 = 15
				local var_269_23 = utf8.len(var_269_21)
				local var_269_24 = var_269_22 <= 0 and var_269_17 or var_269_17 * (var_269_23 / var_269_22)

				if var_269_24 > 0 and var_269_17 < var_269_24 then
					arg_266_1.talkMaxDuration = var_269_24
					var_269_16 = var_269_16 + 0.3

					if var_269_24 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_16
					end
				end

				arg_266_1.text_.text = var_269_21
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191063", "story_v_out_113191.awb") ~= 0 then
					local var_269_25 = manager.audio:GetVoiceLength("story_v_out_113191", "113191063", "story_v_out_113191.awb") / 1000

					if var_269_25 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_25 + var_269_16
					end

					if var_269_20.prefab_name ~= "" and arg_266_1.actors_[var_269_20.prefab_name] ~= nil then
						local var_269_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_20.prefab_name].transform, "story_v_out_113191", "113191063", "story_v_out_113191.awb")

						arg_266_1:RecordAudio("113191063", var_269_26)
						arg_266_1:RecordAudio("113191063", var_269_26)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_113191", "113191063", "story_v_out_113191.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_113191", "113191063", "story_v_out_113191.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_27 = var_269_16 + 0.3
			local var_269_28 = math.max(var_269_17, arg_266_1.talkMaxDuration)

			if var_269_27 <= arg_266_1.time_ and arg_266_1.time_ < var_269_27 + var_269_28 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_27) / var_269_28

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_27 + var_269_28 and arg_266_1.time_ < var_269_27 + var_269_28 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play113191064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 113191064
		arg_272_1.duration_ = 2.53

		local var_272_0 = {
			ja = 2.1,
			ko = 0.999999999999,
			zh = 2.533,
			en = 2.466
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play113191065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.1

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[226].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(113191064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 4
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191064", "story_v_out_113191.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191064", "story_v_out_113191.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_113191", "113191064", "story_v_out_113191.awb")

						arg_272_1:RecordAudio("113191064", var_275_9)
						arg_272_1:RecordAudio("113191064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_113191", "113191064", "story_v_out_113191.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_113191", "113191064", "story_v_out_113191.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play113191065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 113191065
		arg_276_1.duration_ = 1.5

		local var_276_0 = {
			ja = 1.4,
			ko = 1.466,
			zh = 1.133,
			en = 1.5
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play113191066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.075

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[208].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:GetWordFromCfg(113191065)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 3
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191065", "story_v_out_113191.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191065", "story_v_out_113191.awb") / 1000

					if var_279_8 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_0
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_113191", "113191065", "story_v_out_113191.awb")

						arg_276_1:RecordAudio("113191065", var_279_9)
						arg_276_1:RecordAudio("113191065", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_113191", "113191065", "story_v_out_113191.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_113191", "113191065", "story_v_out_113191.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_10 and arg_276_1.time_ < var_279_0 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play113191066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 113191066
		arg_280_1.duration_ = 10.6

		local var_280_0 = {
			ja = 8.9,
			ko = 5.733,
			zh = 10.6,
			en = 7.7
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play113191067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.75

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[226].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(113191066)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 30
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191066", "story_v_out_113191.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191066", "story_v_out_113191.awb") / 1000

					if var_283_8 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_0
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_113191", "113191066", "story_v_out_113191.awb")

						arg_280_1:RecordAudio("113191066", var_283_9)
						arg_280_1:RecordAudio("113191066", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_113191", "113191066", "story_v_out_113191.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_113191", "113191066", "story_v_out_113191.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_10 and arg_280_1.time_ < var_283_0 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play113191067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 113191067
		arg_284_1.duration_ = 7.2

		local var_284_0 = {
			ja = 7.2,
			ko = 5.4,
			zh = 4.333,
			en = 4.6
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play113191068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.325

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[226].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_3 = arg_284_1:GetWordFromCfg(113191067)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 13
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191067", "story_v_out_113191.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191067", "story_v_out_113191.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_113191", "113191067", "story_v_out_113191.awb")

						arg_284_1:RecordAudio("113191067", var_287_9)
						arg_284_1:RecordAudio("113191067", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_113191", "113191067", "story_v_out_113191.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_113191", "113191067", "story_v_out_113191.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play113191068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 113191068
		arg_288_1.duration_ = 2.33

		local var_288_0 = {
			ja = 1.3,
			ko = 1.533,
			zh = 2.333,
			en = 1.533
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play113191069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.05

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[208].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:GetWordFromCfg(113191068)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 2
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191068", "story_v_out_113191.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191068", "story_v_out_113191.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_113191", "113191068", "story_v_out_113191.awb")

						arg_288_1:RecordAudio("113191068", var_291_9)
						arg_288_1:RecordAudio("113191068", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_113191", "113191068", "story_v_out_113191.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_113191", "113191068", "story_v_out_113191.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play113191069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 113191069
		arg_292_1.duration_ = 9.63

		local var_292_0 = {
			ja = 9.633,
			ko = 7,
			zh = 6.433,
			en = 4.2
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play113191070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.525

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[226].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:GetWordFromCfg(113191069)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 21
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191069", "story_v_out_113191.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191069", "story_v_out_113191.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_113191", "113191069", "story_v_out_113191.awb")

						arg_292_1:RecordAudio("113191069", var_295_9)
						arg_292_1:RecordAudio("113191069", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_113191", "113191069", "story_v_out_113191.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_113191", "113191069", "story_v_out_113191.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play113191070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 113191070
		arg_296_1.duration_ = 18.5

		local var_296_0 = {
			ja = 18.5,
			ko = 11.566,
			zh = 12.3,
			en = 14.233
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play113191071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.925

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[226].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:GetWordFromCfg(113191070)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 37
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191070", "story_v_out_113191.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191070", "story_v_out_113191.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_out_113191", "113191070", "story_v_out_113191.awb")

						arg_296_1:RecordAudio("113191070", var_299_9)
						arg_296_1:RecordAudio("113191070", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_113191", "113191070", "story_v_out_113191.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_113191", "113191070", "story_v_out_113191.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play113191071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 113191071
		arg_300_1.duration_ = 27.3

		local var_300_0 = {
			ja = 27.3,
			ko = 21.933,
			zh = 26.366,
			en = 23.466
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play113191072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 1.95

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[226].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_3 = arg_300_1:GetWordFromCfg(113191071)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 78
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191071", "story_v_out_113191.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191071", "story_v_out_113191.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_113191", "113191071", "story_v_out_113191.awb")

						arg_300_1:RecordAudio("113191071", var_303_9)
						arg_300_1:RecordAudio("113191071", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_113191", "113191071", "story_v_out_113191.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_113191", "113191071", "story_v_out_113191.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play113191072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 113191072
		arg_304_1.duration_ = 20

		local var_304_0 = {
			ja = 20,
			ko = 11.4,
			zh = 15.3,
			en = 14.866
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play113191073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.05

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[226].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(113191072)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 42
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191072", "story_v_out_113191.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191072", "story_v_out_113191.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_113191", "113191072", "story_v_out_113191.awb")

						arg_304_1:RecordAudio("113191072", var_307_9)
						arg_304_1:RecordAudio("113191072", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_113191", "113191072", "story_v_out_113191.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_113191", "113191072", "story_v_out_113191.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play113191073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 113191073
		arg_308_1.duration_ = 11.4

		local var_308_0 = {
			ja = 11.4,
			ko = 9.366,
			zh = 6.2,
			en = 10.266
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play113191074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.8

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[208].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:GetWordFromCfg(113191073)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 32
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191073", "story_v_out_113191.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191073", "story_v_out_113191.awb") / 1000

					if var_311_8 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_0
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_113191", "113191073", "story_v_out_113191.awb")

						arg_308_1:RecordAudio("113191073", var_311_9)
						arg_308_1:RecordAudio("113191073", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_113191", "113191073", "story_v_out_113191.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_113191", "113191073", "story_v_out_113191.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_10 and arg_308_1.time_ < var_311_0 + var_311_10 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play113191074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 113191074
		arg_312_1.duration_ = 9.13

		local var_312_0 = {
			ja = 9.133,
			ko = 3.766,
			zh = 4.266,
			en = 8.1
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play113191075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.375

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[226].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_3 = arg_312_1:GetWordFromCfg(113191074)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 15
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191074", "story_v_out_113191.awb") ~= 0 then
					local var_315_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191074", "story_v_out_113191.awb") / 1000

					if var_315_8 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_0
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_out_113191", "113191074", "story_v_out_113191.awb")

						arg_312_1:RecordAudio("113191074", var_315_9)
						arg_312_1:RecordAudio("113191074", var_315_9)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_113191", "113191074", "story_v_out_113191.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_113191", "113191074", "story_v_out_113191.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_10 and arg_312_1.time_ < var_315_0 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play113191075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 113191075
		arg_316_1.duration_ = 16.33

		local var_316_0 = {
			ja = 8.533,
			ko = 12.233,
			zh = 14.633,
			en = 16.333
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play113191076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 1

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[226].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:GetWordFromCfg(113191075)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 40
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191075", "story_v_out_113191.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191075", "story_v_out_113191.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_113191", "113191075", "story_v_out_113191.awb")

						arg_316_1:RecordAudio("113191075", var_319_9)
						arg_316_1:RecordAudio("113191075", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_113191", "113191075", "story_v_out_113191.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_113191", "113191075", "story_v_out_113191.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play113191076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 113191076
		arg_320_1.duration_ = 15.7

		local var_320_0 = {
			ja = 12.566,
			ko = 10.133,
			zh = 15.7,
			en = 15.7
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play113191077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 1

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[226].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_3 = arg_320_1:GetWordFromCfg(113191076)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 40
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191076", "story_v_out_113191.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191076", "story_v_out_113191.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_113191", "113191076", "story_v_out_113191.awb")

						arg_320_1:RecordAudio("113191076", var_323_9)
						arg_320_1:RecordAudio("113191076", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_113191", "113191076", "story_v_out_113191.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_113191", "113191076", "story_v_out_113191.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play113191077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 113191077
		arg_324_1.duration_ = 15.03

		local var_324_0 = {
			ja = 11.766,
			ko = 8.966,
			zh = 13.5,
			en = 15.033
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play113191078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.75

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[226].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_3 = arg_324_1:GetWordFromCfg(113191077)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 30
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191077", "story_v_out_113191.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191077", "story_v_out_113191.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_113191", "113191077", "story_v_out_113191.awb")

						arg_324_1:RecordAudio("113191077", var_327_9)
						arg_324_1:RecordAudio("113191077", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_113191", "113191077", "story_v_out_113191.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_113191", "113191077", "story_v_out_113191.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play113191078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 113191078
		arg_328_1.duration_ = 2.53

		local var_328_0 = {
			ja = 2.533,
			ko = 1.433,
			zh = 1.566,
			en = 1.433
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play113191079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.075

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[208].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:GetWordFromCfg(113191078)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 3
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191078", "story_v_out_113191.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191078", "story_v_out_113191.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_113191", "113191078", "story_v_out_113191.awb")

						arg_328_1:RecordAudio("113191078", var_331_9)
						arg_328_1:RecordAudio("113191078", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_113191", "113191078", "story_v_out_113191.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_113191", "113191078", "story_v_out_113191.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play113191079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 113191079
		arg_332_1.duration_ = 20.1

		local var_332_0 = {
			ja = 16.4,
			ko = 11.966,
			zh = 13.633,
			en = 20.1
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play113191080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.9

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[226].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:GetWordFromCfg(113191079)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 36
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191079", "story_v_out_113191.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191079", "story_v_out_113191.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_113191", "113191079", "story_v_out_113191.awb")

						arg_332_1:RecordAudio("113191079", var_335_9)
						arg_332_1:RecordAudio("113191079", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_113191", "113191079", "story_v_out_113191.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_113191", "113191079", "story_v_out_113191.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play113191080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 113191080
		arg_336_1.duration_ = 23.9

		local var_336_0 = {
			ja = 20.566,
			ko = 16,
			zh = 23.9,
			en = 22.4
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play113191081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 1.225

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[226].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_3 = arg_336_1:GetWordFromCfg(113191080)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 49
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191080", "story_v_out_113191.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191080", "story_v_out_113191.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_113191", "113191080", "story_v_out_113191.awb")

						arg_336_1:RecordAudio("113191080", var_339_9)
						arg_336_1:RecordAudio("113191080", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_113191", "113191080", "story_v_out_113191.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_113191", "113191080", "story_v_out_113191.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play113191081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 113191081
		arg_340_1.duration_ = 25.87

		local var_340_0 = {
			ja = 17.466,
			ko = 13.133,
			zh = 22.666,
			en = 25.866
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play113191082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.125

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[226].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(113191081)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 45
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191081", "story_v_out_113191.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191081", "story_v_out_113191.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_113191", "113191081", "story_v_out_113191.awb")

						arg_340_1:RecordAudio("113191081", var_343_9)
						arg_340_1:RecordAudio("113191081", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_113191", "113191081", "story_v_out_113191.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_113191", "113191081", "story_v_out_113191.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_10 and arg_340_1.time_ < var_343_0 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play113191082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 113191082
		arg_344_1.duration_ = 11.47

		local var_344_0 = {
			ja = 8.3,
			ko = 9.666,
			zh = 11.466,
			en = 10.6
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play113191083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.775

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[226].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(113191082)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 31
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191082", "story_v_out_113191.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191082", "story_v_out_113191.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_113191", "113191082", "story_v_out_113191.awb")

						arg_344_1:RecordAudio("113191082", var_347_9)
						arg_344_1:RecordAudio("113191082", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_113191", "113191082", "story_v_out_113191.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_113191", "113191082", "story_v_out_113191.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play113191083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 113191083
		arg_348_1.duration_ = 17.5

		local var_348_0 = {
			ja = 5.333,
			ko = 9.5,
			zh = 9.2,
			en = 17.5
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play113191084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.8

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[226].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(113191083)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 32
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191083", "story_v_out_113191.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191083", "story_v_out_113191.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_113191", "113191083", "story_v_out_113191.awb")

						arg_348_1:RecordAudio("113191083", var_351_9)
						arg_348_1:RecordAudio("113191083", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_113191", "113191083", "story_v_out_113191.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_113191", "113191083", "story_v_out_113191.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play113191084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 113191084
		arg_352_1.duration_ = 17.13

		local var_352_0 = {
			ja = 13.9,
			ko = 11.5,
			zh = 13.833,
			en = 17.133
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play113191085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 1.05

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[226].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:GetWordFromCfg(113191084)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 42
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191084", "story_v_out_113191.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191084", "story_v_out_113191.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_113191", "113191084", "story_v_out_113191.awb")

						arg_352_1:RecordAudio("113191084", var_355_9)
						arg_352_1:RecordAudio("113191084", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_113191", "113191084", "story_v_out_113191.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_113191", "113191084", "story_v_out_113191.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play113191085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 113191085
		arg_356_1.duration_ = 20.63

		local var_356_0 = {
			ja = 16.833,
			ko = 11.1,
			zh = 16.5,
			en = 20.633
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play113191086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 1.275

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[226].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(113191085)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 51
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191085", "story_v_out_113191.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191085", "story_v_out_113191.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_113191", "113191085", "story_v_out_113191.awb")

						arg_356_1:RecordAudio("113191085", var_359_9)
						arg_356_1:RecordAudio("113191085", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_113191", "113191085", "story_v_out_113191.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_113191", "113191085", "story_v_out_113191.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play113191086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 113191086
		arg_360_1.duration_ = 19.33

		local var_360_0 = {
			ja = 19.333,
			ko = 10.3,
			zh = 16.066,
			en = 18.5
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play113191087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.9

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[226].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(113191086)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 36
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191086", "story_v_out_113191.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191086", "story_v_out_113191.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_113191", "113191086", "story_v_out_113191.awb")

						arg_360_1:RecordAudio("113191086", var_363_9)
						arg_360_1:RecordAudio("113191086", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_113191", "113191086", "story_v_out_113191.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_113191", "113191086", "story_v_out_113191.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play113191087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 113191087
		arg_364_1.duration_ = 4

		local var_364_0 = {
			ja = 4,
			ko = 3.433,
			zh = 3.266,
			en = 3.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play113191088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.175

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[208].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:GetWordFromCfg(113191087)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 7
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191087", "story_v_out_113191.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191087", "story_v_out_113191.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_113191", "113191087", "story_v_out_113191.awb")

						arg_364_1:RecordAudio("113191087", var_367_9)
						arg_364_1:RecordAudio("113191087", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_113191", "113191087", "story_v_out_113191.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_113191", "113191087", "story_v_out_113191.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play113191088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 113191088
		arg_368_1.duration_ = 13.5

		local var_368_0 = {
			ja = 9.566,
			ko = 5.533,
			zh = 13.5,
			en = 8.5
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play113191089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.425

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[226].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(113191088)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 17
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191088", "story_v_out_113191.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_113191", "113191088", "story_v_out_113191.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_113191", "113191088", "story_v_out_113191.awb")

						arg_368_1:RecordAudio("113191088", var_371_9)
						arg_368_1:RecordAudio("113191088", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_113191", "113191088", "story_v_out_113191.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_113191", "113191088", "story_v_out_113191.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play113191089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 113191089
		arg_372_1.duration_ = 1.87

		local var_372_0 = {
			ja = 1.566,
			ko = 1.866,
			zh = 1.8,
			en = 1.6
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
				arg_372_0:Play113191090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 1

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				local var_375_2 = "play"
				local var_375_3 = "music"

				arg_372_1:AudioAction(var_375_2, var_375_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_375_4 = ""
				local var_375_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_375_5 ~= "" then
					if arg_372_1.bgmTxt_.text ~= var_375_5 and arg_372_1.bgmTxt_.text ~= "" then
						if arg_372_1.bgmTxt2_.text ~= "" then
							arg_372_1.bgmTxt_.text = arg_372_1.bgmTxt2_.text
						end

						arg_372_1.bgmTxt2_.text = var_375_5

						arg_372_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_372_1.bgmTxt_.text = var_375_5
						arg_372_1.bgmTxt2_.text = var_375_5
					end

					if arg_372_1.bgmTimer then
						arg_372_1.bgmTimer:Stop()

						arg_372_1.bgmTimer = nil
					end

					if arg_372_1.settingData.show_music_name == 1 then
						arg_372_1.musicController:SetSelectedState("show")
						arg_372_1.musicAnimator_:Play("open", 0, 0)

						if arg_372_1.settingData.music_time ~= 0 then
							arg_372_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_372_1.settingData.music_time), function()
								if arg_372_1 == nil or isNil(arg_372_1.bgmTxt_) then
									return
								end

								arg_372_1.musicController:SetSelectedState("hide")
								arg_372_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_375_6 = 0
			local var_375_7 = 0.1

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[208].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_9 = arg_372_1:GetWordFromCfg(113191089)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 4
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191089", "story_v_out_113191.awb") ~= 0 then
					local var_375_14 = manager.audio:GetVoiceLength("story_v_out_113191", "113191089", "story_v_out_113191.awb") / 1000

					if var_375_14 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_14 + var_375_6
					end

					if var_375_9.prefab_name ~= "" and arg_372_1.actors_[var_375_9.prefab_name] ~= nil then
						local var_375_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_9.prefab_name].transform, "story_v_out_113191", "113191089", "story_v_out_113191.awb")

						arg_372_1:RecordAudio("113191089", var_375_15)
						arg_372_1:RecordAudio("113191089", var_375_15)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_113191", "113191089", "story_v_out_113191.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_113191", "113191089", "story_v_out_113191.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_16 and arg_372_1.time_ < var_375_6 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play113191090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 113191090
		arg_377_1.duration_ = 7.9

		local var_377_0 = {
			ja = 7.1,
			ko = 6.533,
			zh = 7.9,
			en = 7.866
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play113191091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_1 = 2

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_1 then
				local var_380_2 = (arg_377_1.time_ - var_380_0) / var_380_1
				local var_380_3 = Color.New(0, 0, 0)

				var_380_3.a = Mathf.Lerp(0, 1, var_380_2)
				arg_377_1.mask_.color = var_380_3
			end

			if arg_377_1.time_ >= var_380_0 + var_380_1 and arg_377_1.time_ < var_380_0 + var_380_1 + arg_380_0 then
				local var_380_4 = Color.New(0, 0, 0)

				var_380_4.a = 1
				arg_377_1.mask_.color = var_380_4
			end

			local var_380_5 = 2

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_6 = 2

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_6 then
				local var_380_7 = (arg_377_1.time_ - var_380_5) / var_380_6
				local var_380_8 = Color.New(0, 0, 0)

				var_380_8.a = Mathf.Lerp(1, 0, var_380_7)
				arg_377_1.mask_.color = var_380_8
			end

			if arg_377_1.time_ >= var_380_5 + var_380_6 and arg_377_1.time_ < var_380_5 + var_380_6 + arg_380_0 then
				local var_380_9 = Color.New(0, 0, 0)
				local var_380_10 = 0

				arg_377_1.mask_.enabled = false
				var_380_9.a = var_380_10
				arg_377_1.mask_.color = var_380_9
			end

			local var_380_11 = 2

			if var_380_11 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				local var_380_12 = manager.ui.mainCamera.transform.localPosition
				local var_380_13 = Vector3.New(0, 0, 10) + Vector3.New(var_380_12.x, var_380_12.y, 0)
				local var_380_14 = arg_377_1.bgs_.F03b

				var_380_14.transform.localPosition = var_380_13
				var_380_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_15 = var_380_14:GetComponent("SpriteRenderer")

				if var_380_15 and var_380_15.sprite then
					local var_380_16 = (var_380_14.transform.localPosition - var_380_12).z
					local var_380_17 = manager.ui.mainCameraCom_
					local var_380_18 = 2 * var_380_16 * Mathf.Tan(var_380_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_19 = var_380_18 * var_380_17.aspect
					local var_380_20 = var_380_15.sprite.bounds.size.x
					local var_380_21 = var_380_15.sprite.bounds.size.y
					local var_380_22 = var_380_19 / var_380_20
					local var_380_23 = var_380_18 / var_380_21
					local var_380_24 = var_380_23 < var_380_22 and var_380_22 or var_380_23

					var_380_14.transform.localScale = Vector3.New(var_380_24, var_380_24, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "F03b" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_25 = arg_377_1.actors_["1041ui_story"].transform
			local var_380_26 = 3.8

			if var_380_26 < arg_377_1.time_ and arg_377_1.time_ <= var_380_26 + arg_380_0 then
				arg_377_1.var_.moveOldPos1041ui_story = var_380_25.localPosition
			end

			local var_380_27 = 0.001

			if var_380_26 <= arg_377_1.time_ and arg_377_1.time_ < var_380_26 + var_380_27 then
				local var_380_28 = (arg_377_1.time_ - var_380_26) / var_380_27
				local var_380_29 = Vector3.New(0, -1.11, -5.9)

				var_380_25.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1041ui_story, var_380_29, var_380_28)

				local var_380_30 = manager.ui.mainCamera.transform.position - var_380_25.position

				var_380_25.forward = Vector3.New(var_380_30.x, var_380_30.y, var_380_30.z)

				local var_380_31 = var_380_25.localEulerAngles

				var_380_31.z = 0
				var_380_31.x = 0
				var_380_25.localEulerAngles = var_380_31
			end

			if arg_377_1.time_ >= var_380_26 + var_380_27 and arg_377_1.time_ < var_380_26 + var_380_27 + arg_380_0 then
				var_380_25.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_380_32 = manager.ui.mainCamera.transform.position - var_380_25.position

				var_380_25.forward = Vector3.New(var_380_32.x, var_380_32.y, var_380_32.z)

				local var_380_33 = var_380_25.localEulerAngles

				var_380_33.z = 0
				var_380_33.x = 0
				var_380_25.localEulerAngles = var_380_33
			end

			local var_380_34 = 3.8

			if var_380_34 < arg_377_1.time_ and arg_377_1.time_ <= var_380_34 + arg_380_0 then
				arg_377_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_380_35 = 3.8

			if var_380_35 < arg_377_1.time_ and arg_377_1.time_ <= var_380_35 + arg_380_0 then
				arg_377_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_380_36 = arg_377_1.actors_["1041ui_story"]
			local var_380_37 = 3.8

			if var_380_37 < arg_377_1.time_ and arg_377_1.time_ <= var_380_37 + arg_380_0 and not isNil(var_380_36) and arg_377_1.var_.characterEffect1041ui_story == nil then
				arg_377_1.var_.characterEffect1041ui_story = var_380_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_38 = 0.2

			if var_380_37 <= arg_377_1.time_ and arg_377_1.time_ < var_380_37 + var_380_38 and not isNil(var_380_36) then
				local var_380_39 = (arg_377_1.time_ - var_380_37) / var_380_38

				if arg_377_1.var_.characterEffect1041ui_story and not isNil(var_380_36) then
					arg_377_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_37 + var_380_38 and arg_377_1.time_ < var_380_37 + var_380_38 + arg_380_0 and not isNil(var_380_36) and arg_377_1.var_.characterEffect1041ui_story then
				arg_377_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_40 = 4
			local var_380_41 = 0.2

			if var_380_40 < arg_377_1.time_ and arg_377_1.time_ <= var_380_40 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_42 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_42:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_43 = arg_377_1:FormatText(StoryNameCfg[208].name)

				arg_377_1.leftNameTxt_.text = var_380_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_44 = arg_377_1:GetWordFromCfg(113191090)
				local var_380_45 = arg_377_1:FormatText(var_380_44.content)

				arg_377_1.text_.text = var_380_45

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_46 = 8
				local var_380_47 = utf8.len(var_380_45)
				local var_380_48 = var_380_46 <= 0 and var_380_41 or var_380_41 * (var_380_47 / var_380_46)

				if var_380_48 > 0 and var_380_41 < var_380_48 then
					arg_377_1.talkMaxDuration = var_380_48
					var_380_40 = var_380_40 + 0.3

					if var_380_48 + var_380_40 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_48 + var_380_40
					end
				end

				arg_377_1.text_.text = var_380_45
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191090", "story_v_out_113191.awb") ~= 0 then
					local var_380_49 = manager.audio:GetVoiceLength("story_v_out_113191", "113191090", "story_v_out_113191.awb") / 1000

					if var_380_49 + var_380_40 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_49 + var_380_40
					end

					if var_380_44.prefab_name ~= "" and arg_377_1.actors_[var_380_44.prefab_name] ~= nil then
						local var_380_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_44.prefab_name].transform, "story_v_out_113191", "113191090", "story_v_out_113191.awb")

						arg_377_1:RecordAudio("113191090", var_380_50)
						arg_377_1:RecordAudio("113191090", var_380_50)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_113191", "113191090", "story_v_out_113191.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_113191", "113191090", "story_v_out_113191.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_51 = var_380_40 + 0.3
			local var_380_52 = math.max(var_380_41, arg_377_1.talkMaxDuration)

			if var_380_51 <= arg_377_1.time_ and arg_377_1.time_ < var_380_51 + var_380_52 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_51) / var_380_52

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_51 + var_380_52 and arg_377_1.time_ < var_380_51 + var_380_52 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play113191091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 113191091
		arg_383_1.duration_ = 13.53

		local var_383_0 = {
			ja = 13.2,
			ko = 10.3,
			zh = 13.533,
			en = 12.1
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
				arg_383_0:Play113191092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_386_1 = 0
			local var_386_2 = 1

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_3 = arg_383_1:FormatText(StoryNameCfg[208].name)

				arg_383_1.leftNameTxt_.text = var_386_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(113191091)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_6 = 40
				local var_386_7 = utf8.len(var_386_5)
				local var_386_8 = var_386_6 <= 0 and var_386_2 or var_386_2 * (var_386_7 / var_386_6)

				if var_386_8 > 0 and var_386_2 < var_386_8 then
					arg_383_1.talkMaxDuration = var_386_8

					if var_386_8 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191091", "story_v_out_113191.awb") ~= 0 then
					local var_386_9 = manager.audio:GetVoiceLength("story_v_out_113191", "113191091", "story_v_out_113191.awb") / 1000

					if var_386_9 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_1
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_out_113191", "113191091", "story_v_out_113191.awb")

						arg_383_1:RecordAudio("113191091", var_386_10)
						arg_383_1:RecordAudio("113191091", var_386_10)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_113191", "113191091", "story_v_out_113191.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_113191", "113191091", "story_v_out_113191.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_11 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_11 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_11

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_11 and arg_383_1.time_ < var_386_1 + var_386_11 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play113191092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 113191092
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play113191093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1041ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1041ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(0, 100, 0)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1041ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, 100, 0)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = 0
			local var_390_10 = 0.575

			if var_390_9 < arg_387_1.time_ and arg_387_1.time_ <= var_390_9 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_11 = arg_387_1:GetWordFromCfg(113191092)
				local var_390_12 = arg_387_1:FormatText(var_390_11.content)

				arg_387_1.text_.text = var_390_12

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_13 = 23
				local var_390_14 = utf8.len(var_390_12)
				local var_390_15 = var_390_13 <= 0 and var_390_10 or var_390_10 * (var_390_14 / var_390_13)

				if var_390_15 > 0 and var_390_10 < var_390_15 then
					arg_387_1.talkMaxDuration = var_390_15

					if var_390_15 + var_390_9 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_15 + var_390_9
					end
				end

				arg_387_1.text_.text = var_390_12
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_16 = math.max(var_390_10, arg_387_1.talkMaxDuration)

			if var_390_9 <= arg_387_1.time_ and arg_387_1.time_ < var_390_9 + var_390_16 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_9) / var_390_16

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_9 + var_390_16 and arg_387_1.time_ < var_390_9 + var_390_16 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play113191093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 113191093
		arg_391_1.duration_ = 3.1

		local var_391_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.966
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
				arg_391_0:Play113191094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1038ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1038ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1038ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = 0

			if var_394_9 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 then
				arg_391_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_394_10 = arg_391_1.actors_["1038ui_story"]
			local var_394_11 = 0

			if var_394_11 < arg_391_1.time_ and arg_391_1.time_ <= var_394_11 + arg_394_0 and not isNil(var_394_10) and arg_391_1.var_.characterEffect1038ui_story == nil then
				arg_391_1.var_.characterEffect1038ui_story = var_394_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_12 = 0.2

			if var_394_11 <= arg_391_1.time_ and arg_391_1.time_ < var_394_11 + var_394_12 and not isNil(var_394_10) then
				local var_394_13 = (arg_391_1.time_ - var_394_11) / var_394_12

				if arg_391_1.var_.characterEffect1038ui_story and not isNil(var_394_10) then
					arg_391_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_11 + var_394_12 and arg_391_1.time_ < var_394_11 + var_394_12 + arg_394_0 and not isNil(var_394_10) and arg_391_1.var_.characterEffect1038ui_story then
				arg_391_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_394_15 = 0
			local var_394_16 = 0.1

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_17 = arg_391_1:FormatText(StoryNameCfg[94].name)

				arg_391_1.leftNameTxt_.text = var_394_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(113191093)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 4
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_16 or var_394_16 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_16 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22

					if var_394_22 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191093", "story_v_out_113191.awb") ~= 0 then
					local var_394_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191093", "story_v_out_113191.awb") / 1000

					if var_394_23 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_15
					end

					if var_394_18.prefab_name ~= "" and arg_391_1.actors_[var_394_18.prefab_name] ~= nil then
						local var_394_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_18.prefab_name].transform, "story_v_out_113191", "113191093", "story_v_out_113191.awb")

						arg_391_1:RecordAudio("113191093", var_394_24)
						arg_391_1:RecordAudio("113191093", var_394_24)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_113191", "113191093", "story_v_out_113191.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_113191", "113191093", "story_v_out_113191.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_25 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_15 <= arg_391_1.time_ and arg_391_1.time_ < var_394_15 + var_394_25 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_15) / var_394_25

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_15 + var_394_25 and arg_391_1.time_ < var_394_15 + var_394_25 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play113191094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 113191094
		arg_395_1.duration_ = 4

		local var_395_0 = {
			ja = 4,
			ko = 3.4,
			zh = 3.666,
			en = 2.833
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
				arg_395_0:Play113191095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1038ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1038ui_story == nil then
				arg_395_1.var_.characterEffect1038ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1038ui_story and not isNil(var_398_0) then
					local var_398_4 = Mathf.Lerp(0, 0.5, var_398_3)

					arg_395_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1038ui_story.fillRatio = var_398_4
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1038ui_story then
				local var_398_5 = 0.5

				arg_395_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1038ui_story.fillRatio = var_398_5
			end

			local var_398_6 = arg_395_1.actors_["1041ui_story"].transform
			local var_398_7 = 0

			if var_398_7 < arg_395_1.time_ and arg_395_1.time_ <= var_398_7 + arg_398_0 then
				arg_395_1.var_.moveOldPos1041ui_story = var_398_6.localPosition
			end

			local var_398_8 = 0.001

			if var_398_7 <= arg_395_1.time_ and arg_395_1.time_ < var_398_7 + var_398_8 then
				local var_398_9 = (arg_395_1.time_ - var_398_7) / var_398_8
				local var_398_10 = Vector3.New(0.7, -1.11, -5.9)

				var_398_6.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1041ui_story, var_398_10, var_398_9)

				local var_398_11 = manager.ui.mainCamera.transform.position - var_398_6.position

				var_398_6.forward = Vector3.New(var_398_11.x, var_398_11.y, var_398_11.z)

				local var_398_12 = var_398_6.localEulerAngles

				var_398_12.z = 0
				var_398_12.x = 0
				var_398_6.localEulerAngles = var_398_12
			end

			if arg_395_1.time_ >= var_398_7 + var_398_8 and arg_395_1.time_ < var_398_7 + var_398_8 + arg_398_0 then
				var_398_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_398_13 = manager.ui.mainCamera.transform.position - var_398_6.position

				var_398_6.forward = Vector3.New(var_398_13.x, var_398_13.y, var_398_13.z)

				local var_398_14 = var_398_6.localEulerAngles

				var_398_14.z = 0
				var_398_14.x = 0
				var_398_6.localEulerAngles = var_398_14
			end

			local var_398_15 = 0

			if var_398_15 < arg_395_1.time_ and arg_395_1.time_ <= var_398_15 + arg_398_0 then
				arg_395_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				arg_395_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_398_17 = arg_395_1.actors_["1041ui_story"]
			local var_398_18 = 0

			if var_398_18 < arg_395_1.time_ and arg_395_1.time_ <= var_398_18 + arg_398_0 and not isNil(var_398_17) and arg_395_1.var_.characterEffect1041ui_story == nil then
				arg_395_1.var_.characterEffect1041ui_story = var_398_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_19 = 0.2

			if var_398_18 <= arg_395_1.time_ and arg_395_1.time_ < var_398_18 + var_398_19 and not isNil(var_398_17) then
				local var_398_20 = (arg_395_1.time_ - var_398_18) / var_398_19

				if arg_395_1.var_.characterEffect1041ui_story and not isNil(var_398_17) then
					arg_395_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_18 + var_398_19 and arg_395_1.time_ < var_398_18 + var_398_19 + arg_398_0 and not isNil(var_398_17) and arg_395_1.var_.characterEffect1041ui_story then
				arg_395_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_398_21 = 0
			local var_398_22 = 0.25

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_23 = arg_395_1:FormatText(StoryNameCfg[208].name)

				arg_395_1.leftNameTxt_.text = var_398_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_24 = arg_395_1:GetWordFromCfg(113191094)
				local var_398_25 = arg_395_1:FormatText(var_398_24.content)

				arg_395_1.text_.text = var_398_25

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_26 = 10
				local var_398_27 = utf8.len(var_398_25)
				local var_398_28 = var_398_26 <= 0 and var_398_22 or var_398_22 * (var_398_27 / var_398_26)

				if var_398_28 > 0 and var_398_22 < var_398_28 then
					arg_395_1.talkMaxDuration = var_398_28

					if var_398_28 + var_398_21 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_28 + var_398_21
					end
				end

				arg_395_1.text_.text = var_398_25
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191094", "story_v_out_113191.awb") ~= 0 then
					local var_398_29 = manager.audio:GetVoiceLength("story_v_out_113191", "113191094", "story_v_out_113191.awb") / 1000

					if var_398_29 + var_398_21 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_29 + var_398_21
					end

					if var_398_24.prefab_name ~= "" and arg_395_1.actors_[var_398_24.prefab_name] ~= nil then
						local var_398_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_24.prefab_name].transform, "story_v_out_113191", "113191094", "story_v_out_113191.awb")

						arg_395_1:RecordAudio("113191094", var_398_30)
						arg_395_1:RecordAudio("113191094", var_398_30)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_113191", "113191094", "story_v_out_113191.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_113191", "113191094", "story_v_out_113191.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_31 = math.max(var_398_22, arg_395_1.talkMaxDuration)

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_31 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_21) / var_398_31

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_21 + var_398_31 and arg_395_1.time_ < var_398_21 + var_398_31 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play113191095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 113191095
		arg_399_1.duration_ = 6.37

		local var_399_0 = {
			ja = 5.2,
			ko = 5.6,
			zh = 4.6,
			en = 6.366
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
				arg_399_0:Play113191096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1038ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1038ui_story == nil then
				arg_399_1.var_.characterEffect1038ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1038ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1038ui_story then
				arg_399_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_402_4 = arg_399_1.actors_["1041ui_story"]
			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1041ui_story == nil then
				arg_399_1.var_.characterEffect1041ui_story = var_402_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_6 = 0.2

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_6 and not isNil(var_402_4) then
				local var_402_7 = (arg_399_1.time_ - var_402_5) / var_402_6

				if arg_399_1.var_.characterEffect1041ui_story and not isNil(var_402_4) then
					local var_402_8 = Mathf.Lerp(0, 0.5, var_402_7)

					arg_399_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1041ui_story.fillRatio = var_402_8
				end
			end

			if arg_399_1.time_ >= var_402_5 + var_402_6 and arg_399_1.time_ < var_402_5 + var_402_6 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1041ui_story then
				local var_402_9 = 0.5

				arg_399_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1041ui_story.fillRatio = var_402_9
			end

			local var_402_10 = 0

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 then
				arg_399_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_402_11 = 0

			if var_402_11 < arg_399_1.time_ and arg_399_1.time_ <= var_402_11 + arg_402_0 then
				arg_399_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action456")
			end

			local var_402_12 = 0
			local var_402_13 = 0.525

			if var_402_12 < arg_399_1.time_ and arg_399_1.time_ <= var_402_12 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_14 = arg_399_1:FormatText(StoryNameCfg[94].name)

				arg_399_1.leftNameTxt_.text = var_402_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_15 = arg_399_1:GetWordFromCfg(113191095)
				local var_402_16 = arg_399_1:FormatText(var_402_15.content)

				arg_399_1.text_.text = var_402_16

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_17 = 21
				local var_402_18 = utf8.len(var_402_16)
				local var_402_19 = var_402_17 <= 0 and var_402_13 or var_402_13 * (var_402_18 / var_402_17)

				if var_402_19 > 0 and var_402_13 < var_402_19 then
					arg_399_1.talkMaxDuration = var_402_19

					if var_402_19 + var_402_12 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_19 + var_402_12
					end
				end

				arg_399_1.text_.text = var_402_16
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191095", "story_v_out_113191.awb") ~= 0 then
					local var_402_20 = manager.audio:GetVoiceLength("story_v_out_113191", "113191095", "story_v_out_113191.awb") / 1000

					if var_402_20 + var_402_12 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_20 + var_402_12
					end

					if var_402_15.prefab_name ~= "" and arg_399_1.actors_[var_402_15.prefab_name] ~= nil then
						local var_402_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_15.prefab_name].transform, "story_v_out_113191", "113191095", "story_v_out_113191.awb")

						arg_399_1:RecordAudio("113191095", var_402_21)
						arg_399_1:RecordAudio("113191095", var_402_21)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_113191", "113191095", "story_v_out_113191.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_113191", "113191095", "story_v_out_113191.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_22 = math.max(var_402_13, arg_399_1.talkMaxDuration)

			if var_402_12 <= arg_399_1.time_ and arg_399_1.time_ < var_402_12 + var_402_22 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_12) / var_402_22

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_12 + var_402_22 and arg_399_1.time_ < var_402_12 + var_402_22 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play113191096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 113191096
		arg_403_1.duration_ = 6

		local var_403_0 = {
			ja = 3.9,
			ko = 4,
			zh = 6,
			en = 2.833
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
				arg_403_0:Play113191097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_406_1 = arg_403_1.actors_["1041ui_story"]
			local var_406_2 = 0

			if var_406_2 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1041ui_story == nil then
				arg_403_1.var_.characterEffect1041ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_3 = 0.2

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_3 and not isNil(var_406_1) then
				local var_406_4 = (arg_403_1.time_ - var_406_2) / var_406_3

				if arg_403_1.var_.characterEffect1041ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_2 + var_406_3 and arg_403_1.time_ < var_406_2 + var_406_3 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1041ui_story then
				arg_403_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_406_5 = arg_403_1.actors_["1038ui_story"]
			local var_406_6 = 0

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect1038ui_story == nil then
				arg_403_1.var_.characterEffect1038ui_story = var_406_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_7 = 0.2

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_7 and not isNil(var_406_5) then
				local var_406_8 = (arg_403_1.time_ - var_406_6) / var_406_7

				if arg_403_1.var_.characterEffect1038ui_story and not isNil(var_406_5) then
					local var_406_9 = Mathf.Lerp(0, 0.5, var_406_8)

					arg_403_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1038ui_story.fillRatio = var_406_9
				end
			end

			if arg_403_1.time_ >= var_406_6 + var_406_7 and arg_403_1.time_ < var_406_6 + var_406_7 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect1038ui_story then
				local var_406_10 = 0.5

				arg_403_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1038ui_story.fillRatio = var_406_10
			end

			local var_406_11 = 0
			local var_406_12 = 0.25

			if var_406_11 < arg_403_1.time_ and arg_403_1.time_ <= var_406_11 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_13 = arg_403_1:FormatText(StoryNameCfg[208].name)

				arg_403_1.leftNameTxt_.text = var_406_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_14 = arg_403_1:GetWordFromCfg(113191096)
				local var_406_15 = arg_403_1:FormatText(var_406_14.content)

				arg_403_1.text_.text = var_406_15

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_16 = 10
				local var_406_17 = utf8.len(var_406_15)
				local var_406_18 = var_406_16 <= 0 and var_406_12 or var_406_12 * (var_406_17 / var_406_16)

				if var_406_18 > 0 and var_406_12 < var_406_18 then
					arg_403_1.talkMaxDuration = var_406_18

					if var_406_18 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_18 + var_406_11
					end
				end

				arg_403_1.text_.text = var_406_15
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191096", "story_v_out_113191.awb") ~= 0 then
					local var_406_19 = manager.audio:GetVoiceLength("story_v_out_113191", "113191096", "story_v_out_113191.awb") / 1000

					if var_406_19 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_19 + var_406_11
					end

					if var_406_14.prefab_name ~= "" and arg_403_1.actors_[var_406_14.prefab_name] ~= nil then
						local var_406_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_14.prefab_name].transform, "story_v_out_113191", "113191096", "story_v_out_113191.awb")

						arg_403_1:RecordAudio("113191096", var_406_20)
						arg_403_1:RecordAudio("113191096", var_406_20)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_113191", "113191096", "story_v_out_113191.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_113191", "113191096", "story_v_out_113191.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_21 = math.max(var_406_12, arg_403_1.talkMaxDuration)

			if var_406_11 <= arg_403_1.time_ and arg_403_1.time_ < var_406_11 + var_406_21 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_11) / var_406_21

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_11 + var_406_21 and arg_403_1.time_ < var_406_11 + var_406_21 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play113191097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 113191097
		arg_407_1.duration_ = 8.43

		local var_407_0 = {
			ja = 5.3,
			ko = 8.433,
			zh = 5.933,
			en = 6.233
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
				arg_407_0:Play113191098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1041ui_story"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos1041ui_story = var_410_0.localPosition
			end

			local var_410_2 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2
				local var_410_4 = Vector3.New(0, 100, 0)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1041ui_story, var_410_4, var_410_3)

				local var_410_5 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_5.x, var_410_5.y, var_410_5.z)

				local var_410_6 = var_410_0.localEulerAngles

				var_410_6.z = 0
				var_410_6.x = 0
				var_410_0.localEulerAngles = var_410_6
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, 100, 0)

				local var_410_7 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_7.x, var_410_7.y, var_410_7.z)

				local var_410_8 = var_410_0.localEulerAngles

				var_410_8.z = 0
				var_410_8.x = 0
				var_410_0.localEulerAngles = var_410_8
			end

			local var_410_9 = arg_407_1.actors_["1038ui_story"].transform
			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 then
				arg_407_1.var_.moveOldPos1038ui_story = var_410_9.localPosition
			end

			local var_410_11 = 0.001

			if var_410_10 <= arg_407_1.time_ and arg_407_1.time_ < var_410_10 + var_410_11 then
				local var_410_12 = (arg_407_1.time_ - var_410_10) / var_410_11
				local var_410_13 = Vector3.New(0, 100, 0)

				var_410_9.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1038ui_story, var_410_13, var_410_12)

				local var_410_14 = manager.ui.mainCamera.transform.position - var_410_9.position

				var_410_9.forward = Vector3.New(var_410_14.x, var_410_14.y, var_410_14.z)

				local var_410_15 = var_410_9.localEulerAngles

				var_410_15.z = 0
				var_410_15.x = 0
				var_410_9.localEulerAngles = var_410_15
			end

			if arg_407_1.time_ >= var_410_10 + var_410_11 and arg_407_1.time_ < var_410_10 + var_410_11 + arg_410_0 then
				var_410_9.localPosition = Vector3.New(0, 100, 0)

				local var_410_16 = manager.ui.mainCamera.transform.position - var_410_9.position

				var_410_9.forward = Vector3.New(var_410_16.x, var_410_16.y, var_410_16.z)

				local var_410_17 = var_410_9.localEulerAngles

				var_410_17.z = 0
				var_410_17.x = 0
				var_410_9.localEulerAngles = var_410_17
			end

			local var_410_18 = arg_407_1.actors_["1084ui_story"].transform
			local var_410_19 = 0

			if var_410_19 < arg_407_1.time_ and arg_407_1.time_ <= var_410_19 + arg_410_0 then
				arg_407_1.var_.moveOldPos1084ui_story = var_410_18.localPosition
			end

			local var_410_20 = 0.001

			if var_410_19 <= arg_407_1.time_ and arg_407_1.time_ < var_410_19 + var_410_20 then
				local var_410_21 = (arg_407_1.time_ - var_410_19) / var_410_20
				local var_410_22 = Vector3.New(-0.7, -0.97, -6)

				var_410_18.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1084ui_story, var_410_22, var_410_21)

				local var_410_23 = manager.ui.mainCamera.transform.position - var_410_18.position

				var_410_18.forward = Vector3.New(var_410_23.x, var_410_23.y, var_410_23.z)

				local var_410_24 = var_410_18.localEulerAngles

				var_410_24.z = 0
				var_410_24.x = 0
				var_410_18.localEulerAngles = var_410_24
			end

			if arg_407_1.time_ >= var_410_19 + var_410_20 and arg_407_1.time_ < var_410_19 + var_410_20 + arg_410_0 then
				var_410_18.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_410_25 = manager.ui.mainCamera.transform.position - var_410_18.position

				var_410_18.forward = Vector3.New(var_410_25.x, var_410_25.y, var_410_25.z)

				local var_410_26 = var_410_18.localEulerAngles

				var_410_26.z = 0
				var_410_26.x = 0
				var_410_18.localEulerAngles = var_410_26
			end

			local var_410_27 = 0

			if var_410_27 < arg_407_1.time_ and arg_407_1.time_ <= var_410_27 + arg_410_0 then
				arg_407_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_410_28 = 0

			if var_410_28 < arg_407_1.time_ and arg_407_1.time_ <= var_410_28 + arg_410_0 then
				arg_407_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_410_29 = arg_407_1.actors_["1084ui_story"]
			local var_410_30 = 0

			if var_410_30 < arg_407_1.time_ and arg_407_1.time_ <= var_410_30 + arg_410_0 and not isNil(var_410_29) and arg_407_1.var_.characterEffect1084ui_story == nil then
				arg_407_1.var_.characterEffect1084ui_story = var_410_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_31 = 0.2

			if var_410_30 <= arg_407_1.time_ and arg_407_1.time_ < var_410_30 + var_410_31 and not isNil(var_410_29) then
				local var_410_32 = (arg_407_1.time_ - var_410_30) / var_410_31

				if arg_407_1.var_.characterEffect1084ui_story and not isNil(var_410_29) then
					arg_407_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_30 + var_410_31 and arg_407_1.time_ < var_410_30 + var_410_31 + arg_410_0 and not isNil(var_410_29) and arg_407_1.var_.characterEffect1084ui_story then
				arg_407_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_410_33 = 0
			local var_410_34 = 0.825

			if var_410_33 < arg_407_1.time_ and arg_407_1.time_ <= var_410_33 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_35 = arg_407_1:FormatText(StoryNameCfg[6].name)

				arg_407_1.leftNameTxt_.text = var_410_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_36 = arg_407_1:GetWordFromCfg(113191097)
				local var_410_37 = arg_407_1:FormatText(var_410_36.content)

				arg_407_1.text_.text = var_410_37

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_38 = 33
				local var_410_39 = utf8.len(var_410_37)
				local var_410_40 = var_410_38 <= 0 and var_410_34 or var_410_34 * (var_410_39 / var_410_38)

				if var_410_40 > 0 and var_410_34 < var_410_40 then
					arg_407_1.talkMaxDuration = var_410_40

					if var_410_40 + var_410_33 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_40 + var_410_33
					end
				end

				arg_407_1.text_.text = var_410_37
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191097", "story_v_out_113191.awb") ~= 0 then
					local var_410_41 = manager.audio:GetVoiceLength("story_v_out_113191", "113191097", "story_v_out_113191.awb") / 1000

					if var_410_41 + var_410_33 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_41 + var_410_33
					end

					if var_410_36.prefab_name ~= "" and arg_407_1.actors_[var_410_36.prefab_name] ~= nil then
						local var_410_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_36.prefab_name].transform, "story_v_out_113191", "113191097", "story_v_out_113191.awb")

						arg_407_1:RecordAudio("113191097", var_410_42)
						arg_407_1:RecordAudio("113191097", var_410_42)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_113191", "113191097", "story_v_out_113191.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_113191", "113191097", "story_v_out_113191.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_43 = math.max(var_410_34, arg_407_1.talkMaxDuration)

			if var_410_33 <= arg_407_1.time_ and arg_407_1.time_ < var_410_33 + var_410_43 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_33) / var_410_43

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_33 + var_410_43 and arg_407_1.time_ < var_410_33 + var_410_43 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play113191098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 113191098
		arg_411_1.duration_ = 0.2

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"

			SetActive(arg_411_1.choicesGo_, true)

			for iter_412_0, iter_412_1 in ipairs(arg_411_1.choices_) do
				local var_412_0 = iter_412_0 <= 1

				SetActive(iter_412_1.go, var_412_0)
			end

			arg_411_1.choices_[1].txt.text = arg_411_1:FormatText(StoryChoiceCfg[202].name)
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play113191099(arg_411_1)
			end

			arg_411_1:RecordChoiceLog(113191098, 202)
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1084ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1084ui_story == nil then
				arg_411_1.var_.characterEffect1084ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1084ui_story and not isNil(var_414_0) then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1084ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1084ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1084ui_story.fillRatio = var_414_5
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play113191099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 113191099
		arg_415_1.duration_ = 9.37

		local var_415_0 = {
			ja = 7.766,
			ko = 9.366,
			zh = 5.533,
			en = 8.266
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
			arg_415_1.auto_ = false
		end

		function arg_415_1.playNext_(arg_417_0)
			arg_415_1.onStoryFinished_()
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1097ui_story"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos1097ui_story = var_418_0.localPosition
			end

			local var_418_2 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2
				local var_418_4 = Vector3.New(0.7, -0.54, -6.3)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1097ui_story, var_418_4, var_418_3)

				local var_418_5 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_5.x, var_418_5.y, var_418_5.z)

				local var_418_6 = var_418_0.localEulerAngles

				var_418_6.z = 0
				var_418_6.x = 0
				var_418_0.localEulerAngles = var_418_6
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_418_7 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_7.x, var_418_7.y, var_418_7.z)

				local var_418_8 = var_418_0.localEulerAngles

				var_418_8.z = 0
				var_418_8.x = 0
				var_418_0.localEulerAngles = var_418_8
			end

			local var_418_9 = 0

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 then
				arg_415_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_418_10 = 0

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_418_11 = arg_415_1.actors_["1097ui_story"]
			local var_418_12 = 0

			if var_418_12 < arg_415_1.time_ and arg_415_1.time_ <= var_418_12 + arg_418_0 and not isNil(var_418_11) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_13 = 0.2

			if var_418_12 <= arg_415_1.time_ and arg_415_1.time_ < var_418_12 + var_418_13 and not isNil(var_418_11) then
				local var_418_14 = (arg_415_1.time_ - var_418_12) / var_418_13

				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_11) then
					arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_12 + var_418_13 and arg_415_1.time_ < var_418_12 + var_418_13 + arg_418_0 and not isNil(var_418_11) and arg_415_1.var_.characterEffect1097ui_story then
				arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_418_15 = 0
			local var_418_16 = 0.55

			if var_418_15 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_17 = arg_415_1:FormatText(StoryNameCfg[216].name)

				arg_415_1.leftNameTxt_.text = var_418_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_18 = arg_415_1:GetWordFromCfg(113191099)
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

				if manager.audio:GetVoiceLength("story_v_out_113191", "113191099", "story_v_out_113191.awb") ~= 0 then
					local var_418_23 = manager.audio:GetVoiceLength("story_v_out_113191", "113191099", "story_v_out_113191.awb") / 1000

					if var_418_23 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_15
					end

					if var_418_18.prefab_name ~= "" and arg_415_1.actors_[var_418_18.prefab_name] ~= nil then
						local var_418_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_18.prefab_name].transform, "story_v_out_113191", "113191099", "story_v_out_113191.awb")

						arg_415_1:RecordAudio("113191099", var_418_24)
						arg_415_1:RecordAudio("113191099", var_418_24)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_113191", "113191099", "story_v_out_113191.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_113191", "113191099", "story_v_out_113191.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0106",
		"TextureConfig/Background/OM0103",
		"TextureConfig/Background/OM0105",
		"TextureConfig/Background/F03b",
		"TextureConfig/Background/OM0107"
	},
	voices = {
		"story_v_out_113191.awb"
	}
}
