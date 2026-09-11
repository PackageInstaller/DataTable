return {
	Play425111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425111001
		arg_1_1.duration_ = 9.47

		local var_1_0 = {
			zh = 8.93300033333333,
			ja = 9.46600033333333
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
				arg_1_0:Play425111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2501")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501106).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501107).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= 0 + 1.999999999999 and arg_1_1.time_ < 0 + 1.999999999999 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_0 = 2.00000033333333

			if 2.00000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 1.2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = Color.New(0, 0, 0)

				var_4_2.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_0) / var_4_1)
				arg_1_1.mask_.color = var_4_2
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = 1
				arg_1_1.mask_.color = var_4_3
			end

			local var_4_4 = 3.20000033333333

			if 3.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "SS2501"

			if arg_1_1.bgs_.SS2501 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.SS2501

				arg_1_1.bgs_.SS2501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS2501" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 4.40000033333333

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 0.3 and arg_1_1.time_ < var_4_13 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_14 = arg_1_1.bgs_.SS2501.transform

			if 3.2 < arg_1_1.time_ and arg_1_1.time_ <= 3.2 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS2501 = var_4_14.localPosition
			end

			local var_4_15 = 1.20000033333333

			if 3.2 <= arg_1_1.time_ and arg_1_1.time_ < 3.2 + var_4_15 then
				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS2501, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 3.2) / var_4_15)
			end

			if arg_1_1.time_ >= 3.2 + var_4_15 and arg_1_1.time_ < 3.2 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if 2.93333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.93333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 2.93333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.93333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 4.40000033333333
			local var_4_24 = 0.475

			if 4.40000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(425111001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111001", "story_v_out_425111.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_425111", "425111001", "story_v_out_425111.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_425111", "425111001", "story_v_out_425111.awb")

						arg_1_1:RecordAudio("425111001", var_4_31)
						arg_1_1:RecordAudio("425111001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425111", "425111001", "story_v_out_425111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425111", "425111001", "story_v_out_425111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2501",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.20000033333333,
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.669,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425111002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425111002
		arg_10_1.duration_ = 9.53

		local var_10_0 = {
			zh = 8.833,
			ja = 9.533
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425111003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.025

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:GetWordFromCfg(425111002)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 41 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 41)

				if (41 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 41)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111002", "story_v_out_425111.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111002", "story_v_out_425111.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_425111", "425111002", "story_v_out_425111.awb")

						arg_10_1:RecordAudio("425111002", var_13_6)
						arg_10_1:RecordAudio("425111002", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_425111", "425111002", "story_v_out_425111.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_425111", "425111002", "story_v_out_425111.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play425111003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425111003
		arg_14_1.duration_ = 3.37

		local var_14_0 = {
			zh = 2.833,
			ja = 3.366
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425111004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.25

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:GetWordFromCfg(425111003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 10 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 10)

				if (10 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 10)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111003", "story_v_out_425111.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111003", "story_v_out_425111.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_425111", "425111003", "story_v_out_425111.awb")

						arg_14_1:RecordAudio("425111003", var_17_6)
						arg_14_1:RecordAudio("425111003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_425111", "425111003", "story_v_out_425111.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_425111", "425111003", "story_v_out_425111.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play425111004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425111004
		arg_18_1.duration_ = 6.47

		local var_18_0 = {
			zh = 6.466,
			ja = 4.9
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
				arg_18_0:Play425111005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.8

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(425111004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 32 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 32)

				if (32 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 32)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111004", "story_v_out_425111.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111004", "story_v_out_425111.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_425111", "425111004", "story_v_out_425111.awb")

						arg_18_1:RecordAudio("425111004", var_21_6)
						arg_18_1:RecordAudio("425111004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425111", "425111004", "story_v_out_425111.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425111", "425111004", "story_v_out_425111.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play425111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425111005
		arg_22_1.duration_ = 6.9

		local var_22_0 = {
			zh = 4.3,
			ja = 6.9
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425111006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.55

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(425111005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 22 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 22)

				if (22 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 22)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111005", "story_v_out_425111.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111005", "story_v_out_425111.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_425111", "425111005", "story_v_out_425111.awb")

						arg_22_1:RecordAudio("425111005", var_25_6)
						arg_22_1:RecordAudio("425111005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_425111", "425111005", "story_v_out_425111.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_425111", "425111005", "story_v_out_425111.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425111006
		arg_26_1.duration_ = 8.57

		local var_26_0 = {
			zh = 8.566,
			ja = 8.333
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play425111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1.1

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(425111006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 44 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 44)

				if (44 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 44)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111006", "story_v_out_425111.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111006", "story_v_out_425111.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_425111", "425111006", "story_v_out_425111.awb")

						arg_26_1:RecordAudio("425111006", var_29_6)
						arg_26_1:RecordAudio("425111006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425111", "425111006", "story_v_out_425111.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425111", "425111006", "story_v_out_425111.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play425111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425111007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play425111008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.25

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(425111007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 10 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 10)

				if (10 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 10)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play425111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425111008
		arg_34_1.duration_ = 11.13

		local var_34_0 = {
			zh = 6.766,
			ja = 11.133
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
				arg_34_0:Play425111009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.85

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(425111008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 34 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 34)

				if (34 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 34)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111008", "story_v_out_425111.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111008", "story_v_out_425111.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_425111", "425111008", "story_v_out_425111.awb")

						arg_34_1:RecordAudio("425111008", var_37_6)
						arg_34_1:RecordAudio("425111008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425111", "425111008", "story_v_out_425111.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425111", "425111008", "story_v_out_425111.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play425111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425111009
		arg_38_1.duration_ = 8.23

		local var_38_0 = {
			zh = 8.233,
			ja = 5.4
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play425111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.025

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(425111009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 41 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 41)

				if (41 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 41)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111009", "story_v_out_425111.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111009", "story_v_out_425111.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_425111", "425111009", "story_v_out_425111.awb")

						arg_38_1:RecordAudio("425111009", var_41_6)
						arg_38_1:RecordAudio("425111009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_425111", "425111009", "story_v_out_425111.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_425111", "425111009", "story_v_out_425111.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425111010
		arg_42_1.duration_ = 10.47

		local var_42_0 = {
			zh = 9.2,
			ja = 10.466
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play425111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.1

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:GetWordFromCfg(425111010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 44 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 44)

				if (44 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 44)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111010", "story_v_out_425111.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111010", "story_v_out_425111.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_425111", "425111010", "story_v_out_425111.awb")

						arg_42_1:RecordAudio("425111010", var_45_6)
						arg_42_1:RecordAudio("425111010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_425111", "425111010", "story_v_out_425111.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_425111", "425111010", "story_v_out_425111.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play425111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425111011
		arg_46_1.duration_ = 8.7

		local var_46_0 = {
			zh = 8.4,
			ja = 8.7
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play425111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.925

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(425111011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 37 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 37)

				if (37 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 37)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111011", "story_v_out_425111.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111011", "story_v_out_425111.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_425111", "425111011", "story_v_out_425111.awb")

						arg_46_1:RecordAudio("425111011", var_49_6)
						arg_46_1:RecordAudio("425111011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425111", "425111011", "story_v_out_425111.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425111", "425111011", "story_v_out_425111.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play425111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425111012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play425111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.225

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(425111012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 49 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 49)

				if (49 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 49)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play425111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425111013
		arg_54_1.duration_ = 10.17

		local var_54_0 = {
			zh = 9.733,
			ja = 10.166
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play425111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.bgs_.STblack == nil then
				local var_57_0 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_57_0.name = "STblack"
				var_57_0.transform.parent = arg_54_1.stage_.transform
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_.STblack = var_57_0
			end

			if 1.2 < arg_54_1.time_ and arg_54_1.time_ <= 1.2 + arg_57_0 then
				local var_57_1 = arg_54_1.bgs_.STblack

				arg_54_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_2 = var_57_1:GetComponent("SpriteRenderer")

				if var_57_2 and var_57_2.sprite then
					local var_57_3 = 2 * (var_57_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_1.transform.localScale = Vector3.New(var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "STblack" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_4 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_5 = 1.2

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_5 then
				local var_57_6 = Color.New(0, 0, 0)

				var_57_6.a = Mathf.Lerp(0, 1, (arg_54_1.time_ - var_57_4) / var_57_5)
				arg_54_1.mask_.color = var_57_6
			end

			if arg_54_1.time_ >= var_57_4 + var_57_5 and arg_54_1.time_ < var_57_4 + var_57_5 + arg_57_0 then
				local var_57_7 = Color.New(0, 0, 0)

				var_57_7.a = 1
				arg_54_1.mask_.color = var_57_7
			end

			local var_57_8 = 1.2

			if 1.2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_9 = 1.2

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_9 then
				local var_57_10 = Color.New(0, 0, 0)

				var_57_10.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_8) / var_57_9)
				arg_54_1.mask_.color = var_57_10
			end

			if arg_54_1.time_ >= var_57_8 + var_57_9 and arg_54_1.time_ < var_57_8 + var_57_9 + arg_57_0 then
				local var_57_11 = Color.New(0, 0, 0)

				arg_54_1.mask_.enabled = false
				var_57_11.a = 0
				arg_54_1.mask_.color = var_57_11
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_12 = 2.4
			local var_57_13 = 1

			if 2.4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_14 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_14:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10156_split_1")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_15 = arg_54_1:GetWordFromCfg(425111013)
				local var_57_16 = arg_54_1:FormatText(var_57_15.content)

				arg_54_1.text_.text = var_57_16

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_18 = 40 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_16) / 40)

				if (40 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_16) / 40)) > 0 and var_57_13 < var_57_18 then
					arg_54_1.talkMaxDuration = var_57_18
					var_57_12 = var_57_12 + 0.3

					if var_57_18 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_12
					end
				end

				arg_54_1.text_.text = var_57_16
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111013", "story_v_out_425111.awb") ~= 0 then
					local var_57_19 = manager.audio:GetVoiceLength("story_v_out_425111", "425111013", "story_v_out_425111.awb") / 1000

					if var_57_19 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_19 + var_57_12
					end

					if var_57_15.prefab_name ~= "" and arg_54_1.actors_[var_57_15.prefab_name] ~= nil then
						local var_57_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_15.prefab_name].transform, "story_v_out_425111", "425111013", "story_v_out_425111.awb")

						arg_54_1:RecordAudio("425111013", var_57_20)
						arg_54_1:RecordAudio("425111013", var_57_20)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425111", "425111013", "story_v_out_425111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425111", "425111013", "story_v_out_425111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_21 = var_57_12 + 0.3
			local var_57_22 = math.max(var_57_13, arg_54_1.talkMaxDuration)

			if var_57_12 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_21) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419172,
				charCount = 4,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "1013",
				startTime = 1.2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play425111014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 425111014
		arg_60_1.duration_ = 9.33

		local var_60_0 = {
			zh = 6.466,
			ja = 9.333
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play425111015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.75

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10156_split_1")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(425111014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 30)

				if (30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 30)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111014", "story_v_out_425111.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111014", "story_v_out_425111.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_425111", "425111014", "story_v_out_425111.awb")

						arg_60_1:RecordAudio("425111014", var_63_6)
						arg_60_1:RecordAudio("425111014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_425111", "425111014", "story_v_out_425111.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_425111", "425111014", "story_v_out_425111.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play425111015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 425111015
		arg_64_1.duration_ = 14.27

		local var_64_0 = {
			zh = 11.3,
			ja = 14.266
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play425111016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 1.475

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10156_split_1")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(425111015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 58 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 58)

				if (58 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 58)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111015", "story_v_out_425111.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111015", "story_v_out_425111.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_425111", "425111015", "story_v_out_425111.awb")

						arg_64_1:RecordAudio("425111015", var_67_6)
						arg_64_1:RecordAudio("425111015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_425111", "425111015", "story_v_out_425111.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_425111", "425111015", "story_v_out_425111.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play425111016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 425111016
		arg_68_1.duration_ = 7.4

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play425111017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 1.2 < arg_68_1.time_ and arg_68_1.time_ <= 1.2 + arg_71_0 then
				local var_71_0 = arg_68_1.bgs_.SS2501

				arg_68_1.bgs_.SS2501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_71_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_1 = var_71_0:GetComponent("SpriteRenderer")

				if var_71_1 and var_71_1.sprite then
					local var_71_2 = 2 * (var_71_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_71_0.transform.localScale = Vector3.New(var_71_2 / var_71_1.sprite.bounds.size.y < var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x and var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x or var_71_2 / var_71_1.sprite.bounds.size.y, var_71_2 / var_71_1.sprite.bounds.size.y < var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x and var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x or var_71_2 / var_71_1.sprite.bounds.size.y, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "SS2501" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_3 = 0

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_4 = 1.2

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_4 then
				local var_71_5 = Color.New(0, 0, 0)

				var_71_5.a = Mathf.Lerp(0, 1, (arg_68_1.time_ - var_71_3) / var_71_4)
				arg_68_1.mask_.color = var_71_5
			end

			if arg_68_1.time_ >= var_71_3 + var_71_4 and arg_68_1.time_ < var_71_3 + var_71_4 + arg_71_0 then
				local var_71_6 = Color.New(0, 0, 0)

				var_71_6.a = 1
				arg_68_1.mask_.color = var_71_6
			end

			local var_71_7 = 1.2

			if 1.2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_8 = 1.2

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_8 then
				local var_71_9 = Color.New(0, 0, 0)

				var_71_9.a = Mathf.Lerp(1, 0, (arg_68_1.time_ - var_71_7) / var_71_8)
				arg_68_1.mask_.color = var_71_9
			end

			if arg_68_1.time_ >= var_71_7 + var_71_8 and arg_68_1.time_ < var_71_7 + var_71_8 + arg_71_0 then
				local var_71_10 = Color.New(0, 0, 0)

				arg_68_1.mask_.enabled = false
				var_71_10.a = 0
				arg_68_1.mask_.color = var_71_10
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_11 = 2.4
			local var_71_12 = 0.275

			if 2.4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_13 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_13:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_14 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(425111016).content)

				arg_68_1.text_.text = var_71_14

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 11 <= 0 and var_71_12 or var_71_12 * (utf8.len(var_71_14) / 11)

				if (11 <= 0 and var_71_12 or var_71_12 * (utf8.len(var_71_14) / 11)) > 0 and var_71_12 < var_71_16 then
					arg_68_1.talkMaxDuration = var_71_16
					var_71_11 = var_71_11 + 0.3

					if var_71_16 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_14
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_17 = var_71_11 + 0.3
			local var_71_18 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 + 0.3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_17) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_17 + var_71_18 and arg_68_1.time_ < var_71_17 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				groupID = "1013",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1.2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play425111017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425111017
		arg_74_1.duration_ = 11.5

		local var_74_0 = {
			zh = 11.5,
			ja = 11.3
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
				arg_74_0:Play425111018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 1.375

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(425111017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 55 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 55)

				if (55 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 55)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111017", "story_v_out_425111.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111017", "story_v_out_425111.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_425111", "425111017", "story_v_out_425111.awb")

						arg_74_1:RecordAudio("425111017", var_77_6)
						arg_74_1:RecordAudio("425111017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_425111", "425111017", "story_v_out_425111.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_425111", "425111017", "story_v_out_425111.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play425111018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425111018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play425111019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.65

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(425111018).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 26 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 26)

				if (26 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 26)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play425111019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 425111019
		arg_82_1.duration_ = 4.97

		local var_82_0 = {
			zh = 3,
			ja = 4.966
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
				arg_82_0:Play425111020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(425111019)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)

				if (13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111019", "story_v_out_425111.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111019", "story_v_out_425111.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_425111", "425111019", "story_v_out_425111.awb")

						arg_82_1:RecordAudio("425111019", var_85_6)
						arg_82_1:RecordAudio("425111019", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_425111", "425111019", "story_v_out_425111.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_425111", "425111019", "story_v_out_425111.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play425111020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 425111020
		arg_86_1.duration_ = 9.2

		local var_86_0 = {
			zh = 7.266,
			ja = 9.2
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
				arg_86_0:Play425111021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.bgs_.ST2106 == nil then
				local var_89_0 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2106")
				var_89_0.name = "ST2106"
				var_89_0.transform.parent = arg_86_1.stage_.transform
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_.ST2106 = var_89_0
			end

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= 2 + arg_89_0 then
				local var_89_1 = arg_86_1.bgs_.ST2106

				arg_86_1.bgs_.ST2106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_89_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_2 = var_89_1:GetComponent("SpriteRenderer")

				if var_89_2 and var_89_2.sprite then
					local var_89_3 = 2 * (var_89_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_89_1.transform.localScale = Vector3.New(var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "ST2106" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_4 = 3.3

			if 3.3 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			if arg_86_1.time_ >= var_89_4 + 0.3 and arg_86_1.time_ < var_89_4 + 0.3 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_5 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_6 = 2

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 then
				local var_89_7 = Color.New(0, 0, 0)

				var_89_7.a = Mathf.Lerp(0, 1, (arg_86_1.time_ - var_89_5) / var_89_6)
				arg_86_1.mask_.color = var_89_7
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 then
				local var_89_8 = Color.New(0, 0, 0)

				var_89_8.a = 1
				arg_86_1.mask_.color = var_89_8
			end

			local var_89_9 = 2

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_10 = 1.3

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 then
				local var_89_11 = Color.New(0, 0, 0)

				var_89_11.a = Mathf.Lerp(1, 0, (arg_86_1.time_ - var_89_9) / var_89_10)
				arg_86_1.mask_.color = var_89_11
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 then
				local var_89_12 = Color.New(0, 0, 0)

				arg_86_1.mask_.enabled = false
				var_89_12.a = 0
				arg_86_1.mask_.color = var_89_12
			end

			local var_89_13 = "1037"

			if arg_86_1.actors_["1037"] == nil then
				local var_89_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_89_14) then
					local var_89_15 = Object.Instantiate(var_89_14, arg_86_1.canvasGo_.transform)

					var_89_15.transform:SetSiblingIndex(1)

					var_89_15.name = var_89_13
					var_89_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_86_1.actors_[var_89_13] = var_89_15

					if arg_86_1.isInRecall_ then
						for iter_89_2, iter_89_3 in ipairs((var_89_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_89_16 = arg_86_1.actors_["1037"]

			if 3.1 < arg_86_1.time_ and arg_86_1.time_ <= 3.1 + arg_89_0 and not isNil(var_89_16) and arg_86_1.var_.actorSpriteComps1037 == nil then
				arg_86_1.var_.actorSpriteComps1037 = var_89_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_17 = 0.2

			if 3.1 <= arg_86_1.time_ and arg_86_1.time_ < 3.1 + var_89_17 and not isNil(var_89_16) then
				if arg_86_1.var_.actorSpriteComps1037 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								iter_89_5.color = Color.New(Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor1.r, (arg_86_1.time_ - 3.1) / var_89_17), Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor1.g, (arg_86_1.time_ - 3.1) / var_89_17), (Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor1.b, (arg_86_1.time_ - 3.1) / var_89_17)))
							else
								local var_89_18 = Mathf.Lerp(iter_89_5.color.r, 1, (arg_86_1.time_ - 3.1) / var_89_17)

								iter_89_5.color = Color.New(var_89_18, var_89_18, var_89_18)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 3.1 + var_89_17 and arg_86_1.time_ < 3.1 + var_89_17 + arg_89_0 and not isNil(var_89_16) and arg_86_1.var_.actorSpriteComps1037 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_89_7 then
						iter_89_7.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps1037 = nil
			end

			local var_89_19 = arg_86_1.actors_["1037"].transform

			if 3.1 < arg_86_1.time_ and arg_86_1.time_ <= 3.1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1037 = var_89_19.localPosition
				var_89_19.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1037", 3)

				for iter_89_8 = 0, var_89_19.childCount - 1 do
					local var_89_20 = var_89_19:GetChild(iter_89_8)

					if var_89_20.name == "" or not string.find(var_89_20.name, "split") then
						var_89_20.gameObject:SetActive(true)
					else
						var_89_20.gameObject:SetActive(false)
					end
				end
			end

			local var_89_21 = 0.001

			if 3.1 <= arg_86_1.time_ and arg_86_1.time_ < 3.1 + var_89_21 then
				var_89_19.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_86_1.time_ - 3.1) / var_89_21)
			end

			if arg_86_1.time_ >= 3.1 + var_89_21 and arg_86_1.time_ < 3.1 + var_89_21 + arg_89_0 then
				var_89_19.localPosition = Vector3.New(0, -430, -55)
			end

			if 0.133333333333333 < arg_86_1.time_ and arg_86_1.time_ <= 0.133333333333333 + arg_89_0 then
				arg_86_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.66666666666667 < arg_86_1.time_ and arg_86_1.time_ <= 1.66666666666667 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_24 = 3.3
			local var_89_25 = 0.35

			if 3.3 < arg_86_1.time_ and arg_86_1.time_ <= var_89_24 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_26 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_26:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_27 = arg_86_1:GetWordFromCfg(425111020)
				local var_89_28 = arg_86_1:FormatText(var_89_27.content)

				arg_86_1.text_.text = var_89_28

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_30 = 14 <= 0 and var_89_25 or var_89_25 * (utf8.len(var_89_28) / 14)

				if (14 <= 0 and var_89_25 or var_89_25 * (utf8.len(var_89_28) / 14)) > 0 and var_89_25 < var_89_30 then
					arg_86_1.talkMaxDuration = var_89_30
					var_89_24 = var_89_24 + 0.3

					if var_89_30 + var_89_24 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_30 + var_89_24
					end
				end

				arg_86_1.text_.text = var_89_28
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111020", "story_v_out_425111.awb") ~= 0 then
					local var_89_31 = manager.audio:GetVoiceLength("story_v_out_425111", "425111020", "story_v_out_425111.awb") / 1000

					if var_89_31 + var_89_24 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_31 + var_89_24
					end

					if var_89_27.prefab_name ~= "" and arg_86_1.actors_[var_89_27.prefab_name] ~= nil then
						local var_89_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_27.prefab_name].transform, "story_v_out_425111", "425111020", "story_v_out_425111.awb")

						arg_86_1:RecordAudio("425111020", var_89_32)
						arg_86_1:RecordAudio("425111020", var_89_32)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_425111", "425111020", "story_v_out_425111.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_425111", "425111020", "story_v_out_425111.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = var_89_24 + 0.3
			local var_89_34 = math.max(var_89_25, arg_86_1.talkMaxDuration)

			if var_89_24 + 0.3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_33 + var_89_34 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_33) / var_89_34

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_33 + var_89_34 and arg_86_1.time_ < var_89_33 + var_89_34 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play425111021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 425111021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play425111022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1037 = arg_92_1.actors_["1037"].transform.localPosition
				arg_92_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1037", 7)

				for iter_95_0 = 0, arg_92_1.actors_["1037"].transform.childCount - 1 do
					local var_95_0 = arg_92_1.actors_["1037"].transform:GetChild(iter_95_0)

					if var_95_0.name == "" or not string.find(var_95_0.name, "split") then
						var_95_0.gameObject:SetActive(true)
					else
						var_95_0.gameObject:SetActive(false)
					end
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_92_1.time_ - 0) / var_95_1)
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_95_2 = 0
			local var_95_3 = 1.125

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(425111021).content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 45 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 45)

				if (45 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 45)) > 0 and var_95_3 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_7 and arg_92_1.time_ < var_95_2 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play425111022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 425111022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play425111023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.85

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(425111022).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 34 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 34)

				if (34 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 34)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play425111023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 425111023
		arg_100_1.duration_ = 2.33

		local var_100_0 = {
			zh = 1.866,
			ja = 2.333
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play425111024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.actors_["10156"] == nil then
				local var_103_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10156")

				if not isNil(var_103_0) then
					local var_103_1 = Object.Instantiate(var_103_0, arg_100_1.canvasGo_.transform)

					var_103_1.transform:SetSiblingIndex(1)

					var_103_1.name = "10156"
					var_103_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_100_1.actors_["10156"] = var_103_1

					if arg_100_1.isInRecall_ then
						for iter_103_0, iter_103_1 in ipairs((var_103_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_103_1.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_103_2 = arg_100_1.actors_["10156"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps10156 == nil then
				arg_100_1.var_.actorSpriteComps10156 = var_103_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_3 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.actorSpriteComps10156 then
					for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_103_3 then
							if arg_100_1.isInRecall_ then
								iter_103_3.color = Color.New(Mathf.Lerp(iter_103_3.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_3), Mathf.Lerp(iter_103_3.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_3), (Mathf.Lerp(iter_103_3.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_3)))
							else
								local var_103_4 = Mathf.Lerp(iter_103_3.color.r, 1, (arg_100_1.time_ - 0) / var_103_3)

								iter_103_3.color = Color.New(var_103_4, var_103_4, var_103_4)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps10156 then
				for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_103_5 then
						iter_103_5.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps10156 = nil
			end

			local var_103_5 = arg_100_1.actors_["10156"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10156 = var_103_5.localPosition
				var_103_5.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10156", 3)

				for iter_103_6 = 0, var_103_5.childCount - 1 do
					local var_103_6 = var_103_5:GetChild(iter_103_6)

					if var_103_6.name == "" or not string.find(var_103_6.name, "split") then
						var_103_6.gameObject:SetActive(true)
					else
						var_103_6.gameObject:SetActive(false)
					end
				end
			end

			local var_103_7 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				var_103_5.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_100_1.time_ - 0) / var_103_7)
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				var_103_5.localPosition = Vector3.New(0, -390, -210)
			end

			local var_103_8 = 0
			local var_103_9 = 0.2

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(425111023)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 8 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 8)

				if (8 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 8)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111023", "story_v_out_425111.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111023", "story_v_out_425111.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_425111", "425111023", "story_v_out_425111.awb")

						arg_100_1:RecordAudio("425111023", var_103_15)
						arg_100_1:RecordAudio("425111023", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_425111", "425111023", "story_v_out_425111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_425111", "425111023", "story_v_out_425111.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play425111024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 425111024
		arg_104_1.duration_ = 7.7

		local var_104_0 = {
			zh = 6.2,
			ja = 7.7
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play425111025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10156 = arg_104_1.actors_["10156"].transform.localPosition
				arg_104_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10156", 7)

				for iter_107_0 = 0, arg_104_1.actors_["10156"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["10156"].transform:GetChild(iter_107_0)

					if var_107_0.name == "" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["10156"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_2 = 0
			local var_107_3 = 0.625

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1436].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmrsystem")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_4 = arg_104_1:GetWordFromCfg(425111024)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 25 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 25)

				if (25 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 25)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111024", "story_v_out_425111.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_425111", "425111024", "story_v_out_425111.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_425111", "425111024", "story_v_out_425111.awb")

						arg_104_1:RecordAudio("425111024", var_107_9)
						arg_104_1:RecordAudio("425111024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_425111", "425111024", "story_v_out_425111.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_425111", "425111024", "story_v_out_425111.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play425111025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 425111025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play425111026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0.666666666666667 < arg_108_1.time_ and arg_108_1.time_ <= 0.666666666666667 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_140", "se_story_140_door02", "")
			end

			local var_111_1 = 0
			local var_111_2 = 1.075

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(425111025).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 43 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 43)

				if (43 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 43)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play425111026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 425111026
		arg_112_1.duration_ = 8.17

		local var_112_0 = {
			zh = 6.9,
			ja = 8.166
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play425111027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.85

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1437].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(425111026)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 34 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 34)

				if (34 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 34)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111026", "story_v_out_425111.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111026", "story_v_out_425111.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_425111", "425111026", "story_v_out_425111.awb")

						arg_112_1:RecordAudio("425111026", var_115_6)
						arg_112_1:RecordAudio("425111026", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_425111", "425111026", "story_v_out_425111.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_425111", "425111026", "story_v_out_425111.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play425111027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425111027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play425111028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.125

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(425111027).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 45 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 45)

				if (45 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 45)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425111028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425111028
		arg_120_1.duration_ = 4.2

		local var_120_0 = {
			zh = 4.2,
			ja = 4
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play425111029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.475

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1437].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(425111028)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 19 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 19)

				if (19 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 19)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111028", "story_v_out_425111.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111028", "story_v_out_425111.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_425111", "425111028", "story_v_out_425111.awb")

						arg_120_1:RecordAudio("425111028", var_123_6)
						arg_120_1:RecordAudio("425111028", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_425111", "425111028", "story_v_out_425111.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_425111", "425111028", "story_v_out_425111.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play425111029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425111029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play425111030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(425111029).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 21 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 21)

				if (21 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 21)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play425111030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425111030
		arg_128_1.duration_ = 12.67

		local var_128_0 = {
			zh = 12.133,
			ja = 12.666
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play425111031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10156"]) and arg_128_1.var_.actorSpriteComps10156 == nil then
				arg_128_1.var_.actorSpriteComps10156 = arg_128_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10156"]) then
				if arg_128_1.var_.actorSpriteComps10156 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10156"]) and arg_128_1.var_.actorSpriteComps10156 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps10156 = nil
			end

			local var_131_2 = arg_128_1.actors_["10156"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10156 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10156", 2)

				for iter_131_4 = 0, var_131_2.childCount - 1 do
					local var_131_3 = var_131_2:GetChild(iter_131_4)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(-390, -390, -210)
			end

			local var_131_5 = 0
			local var_131_6 = 1.325

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(425111030)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 53 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 53)

				if (53 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 53)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111030", "story_v_out_425111.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111030", "story_v_out_425111.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_425111", "425111030", "story_v_out_425111.awb")

						arg_128_1:RecordAudio("425111030", var_131_12)
						arg_128_1:RecordAudio("425111030", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425111", "425111030", "story_v_out_425111.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425111", "425111030", "story_v_out_425111.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play425111031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425111031
		arg_132_1.duration_ = 8.13

		local var_132_0 = {
			zh = 5.433,
			ja = 8.133
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play425111032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1037"]) and arg_132_1.var_.actorSpriteComps1037 == nil then
				arg_132_1.var_.actorSpriteComps1037 = arg_132_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1037"]) then
				if arg_132_1.var_.actorSpriteComps1037 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1037"]) and arg_132_1.var_.actorSpriteComps1037 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps1037 = nil
			end

			local var_135_2 = arg_132_1.actors_["10156"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10156 == nil then
				arg_132_1.var_.actorSpriteComps10156 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps10156 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10156 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps10156 = nil
			end

			local var_135_5 = arg_132_1.actors_["1037"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1037 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1037", 4)

				for iter_135_8 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_8)

					if var_135_6.name == "" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_135_8 = 0
			local var_135_9 = 0.7

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(425111031)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 28 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 28)

				if (28 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 28)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111031", "story_v_out_425111.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111031", "story_v_out_425111.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_425111", "425111031", "story_v_out_425111.awb")

						arg_132_1:RecordAudio("425111031", var_135_15)
						arg_132_1:RecordAudio("425111031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_425111", "425111031", "story_v_out_425111.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_425111", "425111031", "story_v_out_425111.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_16 and arg_132_1.time_ < var_135_8 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play425111032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425111032
		arg_136_1.duration_ = 7.63

		local var_136_0 = {
			zh = 7.2,
			ja = 7.633
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play425111033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10156"]) and arg_136_1.var_.actorSpriteComps10156 == nil then
				arg_136_1.var_.actorSpriteComps10156 = arg_136_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10156"]) then
				if arg_136_1.var_.actorSpriteComps10156 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 1, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10156"]) and arg_136_1.var_.actorSpriteComps10156 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps10156 = nil
			end

			local var_139_2 = arg_136_1.actors_["1037"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1037 == nil then
				arg_136_1.var_.actorSpriteComps1037 = var_139_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_3 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.actorSpriteComps1037 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								iter_139_5.color = Color.New(Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_3), Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_3), (Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_3)))
							else
								local var_139_4 = Mathf.Lerp(iter_139_5.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_3)

								iter_139_5.color = Color.New(var_139_4, var_139_4, var_139_4)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1037 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_139_7 then
						iter_139_7.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps1037 = nil
			end

			local var_139_5 = arg_136_1.actors_["10156"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10156 = var_139_5.localPosition
				var_139_5.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("10156", 2)

				for iter_139_8 = 0, var_139_5.childCount - 1 do
					local var_139_6 = var_139_5:GetChild(iter_139_8)

					if var_139_6.name == "" or not string.find(var_139_6.name, "split") then
						var_139_6.gameObject:SetActive(true)
					else
						var_139_6.gameObject:SetActive(false)
					end
				end
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_5.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_136_1.time_ - 0) / var_139_7)
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_5.localPosition = Vector3.New(-390, -390, -210)
			end

			local var_139_8 = 0
			local var_139_9 = 0.675

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(425111032)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 27 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 27)

				if (27 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 27)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111032", "story_v_out_425111.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111032", "story_v_out_425111.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_425111", "425111032", "story_v_out_425111.awb")

						arg_136_1:RecordAudio("425111032", var_139_15)
						arg_136_1:RecordAudio("425111032", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425111", "425111032", "story_v_out_425111.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425111", "425111032", "story_v_out_425111.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play425111033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425111033
		arg_140_1.duration_ = 3.6

		local var_140_0 = {
			zh = 1.833,
			ja = 3.6
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play425111034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1037"]) and arg_140_1.var_.actorSpriteComps1037 == nil then
				arg_140_1.var_.actorSpriteComps1037 = arg_140_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1037"]) then
				if arg_140_1.var_.actorSpriteComps1037 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1037"]) and arg_140_1.var_.actorSpriteComps1037 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1037 = nil
			end

			local var_143_2 = arg_140_1.actors_["10156"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps10156 == nil then
				arg_140_1.var_.actorSpriteComps10156 = var_143_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_3 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.actorSpriteComps10156 then
					for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_143_5 then
							if arg_140_1.isInRecall_ then
								iter_143_5.color = Color.New(Mathf.Lerp(iter_143_5.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_3), Mathf.Lerp(iter_143_5.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_3), (Mathf.Lerp(iter_143_5.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_3)))
							else
								local var_143_4 = Mathf.Lerp(iter_143_5.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_3)

								iter_143_5.color = Color.New(var_143_4, var_143_4, var_143_4)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps10156 then
				for iter_143_6, iter_143_7 in pairs(arg_140_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_143_7 then
						iter_143_7.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps10156 = nil
			end

			local var_143_5 = arg_140_1.actors_["1037"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1037 = var_143_5.localPosition
				var_143_5.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1037", 4)

				for iter_143_8 = 0, var_143_5.childCount - 1 do
					local var_143_6 = var_143_5:GetChild(iter_143_8)

					if var_143_6.name == "split_5" then
						var_143_6:SetAsLastSibling()
						var_143_6.gameObject:SetActive(true)

						arg_140_1.var_.actorSpriteSplit1037 = var_143_6.gameObject:GetComponent(typeof(Image))

						arg_140_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_143_7 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				var_143_5.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_140_1.time_ - 0) / var_143_7)

				if arg_140_1.var_.actorSpriteSplit1037 ~= nil then
					arg_140_1.var_.actorSpriteSplit1037:SetAlpha((arg_140_1.time_ - 0) / var_143_7)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				var_143_5.localPosition = Vector3.New(390, -430, -55)

				if arg_140_1.var_.actorSpriteSplit1037 ~= nil then
					arg_140_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_143_8 = 0
			local var_143_9 = 0.175

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(425111033)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 7 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 7)

				if (7 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 7)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111033", "story_v_out_425111.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111033", "story_v_out_425111.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_425111", "425111033", "story_v_out_425111.awb")

						arg_140_1:RecordAudio("425111033", var_143_15)
						arg_140_1:RecordAudio("425111033", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425111", "425111033", "story_v_out_425111.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425111", "425111033", "story_v_out_425111.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play425111034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425111034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play425111035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1037 = arg_144_1.actors_["1037"].transform.localPosition
				arg_144_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1037", 7)

				for iter_147_0 = 0, arg_144_1.actors_["1037"].transform.childCount - 1 do
					local var_147_0 = arg_144_1.actors_["1037"].transform:GetChild(iter_147_0)

					if var_147_0.name == "" or not string.find(var_147_0.name, "split") then
						var_147_0.gameObject:SetActive(true)
					else
						var_147_0.gameObject:SetActive(false)
					end
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_144_1.time_ - 0) / var_147_1)
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_147_2 = arg_144_1.actors_["10156"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10156 = var_147_2.localPosition
				var_147_2.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10156", 7)

				for iter_147_1 = 0, var_147_2.childCount - 1 do
					local var_147_3 = var_147_2:GetChild(iter_147_1)

					if var_147_3.name == "" or not string.find(var_147_3.name, "split") then
						var_147_3.gameObject:SetActive(true)
					else
						var_147_3.gameObject:SetActive(false)
					end
				end
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_2.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 0) / var_147_4)
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_5 = 0
			local var_147_6 = 0.875

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(425111034).content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 35 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_7) / 35)

				if (35 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_7) / 35)) > 0 and var_147_6 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_5
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_6, arg_144_1.talkMaxDuration)

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_5) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_5 + var_147_10 and arg_144_1.time_ < var_147_5 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play425111035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425111035
		arg_148_1.duration_ = 18.07

		local var_148_0 = {
			zh = 14.933,
			ja = 18.066
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play425111036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 1.2 < arg_148_1.time_ and arg_148_1.time_ <= 1.2 + arg_151_0 then
				local var_151_0 = arg_148_1.bgs_.STblack

				arg_148_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_1 = var_151_0:GetComponent("SpriteRenderer")

				if var_151_1 and var_151_1.sprite then
					local var_151_2 = 2 * (var_151_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_0.transform.localScale = Vector3.New(var_151_2 / var_151_1.sprite.bounds.size.y < var_151_2 * manager.ui.mainCameraCom_.aspect / var_151_1.sprite.bounds.size.x and var_151_2 * manager.ui.mainCameraCom_.aspect / var_151_1.sprite.bounds.size.x or var_151_2 / var_151_1.sprite.bounds.size.y, var_151_2 / var_151_1.sprite.bounds.size.y < var_151_2 * manager.ui.mainCameraCom_.aspect / var_151_1.sprite.bounds.size.x and var_151_2 * manager.ui.mainCameraCom_.aspect / var_151_1.sprite.bounds.size.x or var_151_2 / var_151_1.sprite.bounds.size.y, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "STblack" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_3 = 0

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_4 = 1.2

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_4 then
				local var_151_5 = Color.New(0, 0, 0)

				var_151_5.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_3) / var_151_4)
				arg_148_1.mask_.color = var_151_5
			end

			if arg_148_1.time_ >= var_151_3 + var_151_4 and arg_148_1.time_ < var_151_3 + var_151_4 + arg_151_0 then
				local var_151_6 = Color.New(0, 0, 0)

				var_151_6.a = 1
				arg_148_1.mask_.color = var_151_6
			end

			local var_151_7 = 1.2

			if 1.2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_8 = 1.2

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_8 then
				local var_151_9 = Color.New(0, 0, 0)

				var_151_9.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_7) / var_151_8)
				arg_148_1.mask_.color = var_151_9
			end

			if arg_148_1.time_ >= var_151_7 + var_151_8 and arg_148_1.time_ < var_151_7 + var_151_8 + arg_151_0 then
				local var_151_10 = Color.New(0, 0, 0)

				arg_148_1.mask_.enabled = false
				var_151_10.a = 0
				arg_148_1.mask_.color = var_151_10
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_11 = 2.4
			local var_151_12 = 0.95

			if 2.4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_13 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_13:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10159_split_1")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_14 = arg_148_1:GetWordFromCfg(425111035)
				local var_151_15 = arg_148_1:FormatText(var_151_14.content)

				arg_148_1.text_.text = var_151_15

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 61 <= 0 and var_151_12 or var_151_12 * (utf8.len(var_151_15) / 61)

				if (61 <= 0 and var_151_12 or var_151_12 * (utf8.len(var_151_15) / 61)) > 0 and var_151_12 < var_151_17 then
					arg_148_1.talkMaxDuration = var_151_17
					var_151_11 = var_151_11 + 0.3

					if var_151_17 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_17 + var_151_11
					end
				end

				arg_148_1.text_.text = var_151_15
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111035", "story_v_out_425111.awb") ~= 0 then
					local var_151_18 = manager.audio:GetVoiceLength("story_v_out_425111", "425111035", "story_v_out_425111.awb") / 1000

					if var_151_18 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_11
					end

					if var_151_14.prefab_name ~= "" and arg_148_1.actors_[var_151_14.prefab_name] ~= nil then
						local var_151_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_14.prefab_name].transform, "story_v_out_425111", "425111035", "story_v_out_425111.awb")

						arg_148_1:RecordAudio("425111035", var_151_19)
						arg_148_1:RecordAudio("425111035", var_151_19)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425111", "425111035", "story_v_out_425111.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425111", "425111035", "story_v_out_425111.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_20 = var_151_11 + 0.3
			local var_151_21 = math.max(var_151_12, arg_148_1.talkMaxDuration)

			if var_151_11 + 0.3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_20 + var_151_21 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_20) / var_151_21

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_20 + var_151_21 and arg_148_1.time_ < var_151_20 + var_151_21 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419179,
				charCount = 3,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "1035",
				startTime = 1.2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Assets/ABResources/Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play425111036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 425111036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play425111037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.05

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(425111036).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 42 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 42)

				if (42 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 42)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play425111037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 425111037
		arg_158_1.duration_ = 7.4

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play425111038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 1.2 < arg_158_1.time_ and arg_158_1.time_ <= 1.2 + arg_161_0 then
				local var_161_0 = arg_158_1.bgs_.ST2106

				arg_158_1.bgs_.ST2106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_161_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_161_1 = var_161_0:GetComponent("SpriteRenderer")

				if var_161_1 and var_161_1.sprite then
					local var_161_2 = 2 * (var_161_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_161_0.transform.localScale = Vector3.New(var_161_2 / var_161_1.sprite.bounds.size.y < var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x and var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x or var_161_2 / var_161_1.sprite.bounds.size.y, var_161_2 / var_161_1.sprite.bounds.size.y < var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x and var_161_2 * manager.ui.mainCameraCom_.aspect / var_161_1.sprite.bounds.size.x or var_161_2 / var_161_1.sprite.bounds.size.y, 0)
				end

				for iter_161_0, iter_161_1 in pairs(arg_158_1.bgs_) do
					if iter_161_0 ~= "ST2106" then
						iter_161_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_161_3 = 0

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_3 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_4 = 1.2

			if var_161_3 <= arg_158_1.time_ and arg_158_1.time_ < var_161_3 + var_161_4 then
				local var_161_5 = Color.New(0, 0, 0)

				var_161_5.a = Mathf.Lerp(0, 1, (arg_158_1.time_ - var_161_3) / var_161_4)
				arg_158_1.mask_.color = var_161_5
			end

			if arg_158_1.time_ >= var_161_3 + var_161_4 and arg_158_1.time_ < var_161_3 + var_161_4 + arg_161_0 then
				local var_161_6 = Color.New(0, 0, 0)

				var_161_6.a = 1
				arg_158_1.mask_.color = var_161_6
			end

			local var_161_7 = 1.2

			if 1.2 < arg_158_1.time_ and arg_158_1.time_ <= var_161_7 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_8 = 1.2

			if var_161_7 <= arg_158_1.time_ and arg_158_1.time_ < var_161_7 + var_161_8 then
				local var_161_9 = Color.New(0, 0, 0)

				var_161_9.a = Mathf.Lerp(1, 0, (arg_158_1.time_ - var_161_7) / var_161_8)
				arg_158_1.mask_.color = var_161_9
			end

			if arg_158_1.time_ >= var_161_7 + var_161_8 and arg_158_1.time_ < var_161_7 + var_161_8 + arg_161_0 then
				local var_161_10 = Color.New(0, 0, 0)

				arg_158_1.mask_.enabled = false
				var_161_10.a = 0
				arg_158_1.mask_.color = var_161_10
			end

			if arg_158_1.frameCnt_ <= 1 then
				arg_158_1.dialog_:SetActive(false)
			end

			local var_161_11 = 2.4
			local var_161_12 = 0.05

			if 2.4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0

				arg_158_1.dialog_:SetActive(true)

				arg_158_1.dialogCg_.alpha = 0

				local var_161_13 = LeanTween.value(arg_158_1.dialog_, 0, 1, 0.3)

				var_161_13:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_158_1.dialogCg_.alpha = arg_162_0
				end))
				var_161_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_158_1.dialog_)
					var_161_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_158_1.duration_ = arg_158_1.duration_ + 0.3

				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_14 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(425111037).content)

				arg_158_1.text_.text = var_161_14

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_16 = 2 <= 0 and var_161_12 or var_161_12 * (utf8.len(var_161_14) / 2)

				if (2 <= 0 and var_161_12 or var_161_12 * (utf8.len(var_161_14) / 2)) > 0 and var_161_12 < var_161_16 then
					arg_158_1.talkMaxDuration = var_161_16
					var_161_11 = var_161_11 + 0.3

					if var_161_16 + var_161_11 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_16 + var_161_11
					end
				end

				arg_158_1.text_.text = var_161_14
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_17 = var_161_11 + 0.3
			local var_161_18 = math.max(var_161_12, arg_158_1.talkMaxDuration)

			if var_161_11 + 0.3 <= arg_158_1.time_ and arg_158_1.time_ < var_161_17 + var_161_18 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_17) / var_161_18

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_17 + var_161_18 and arg_158_1.time_ < var_161_17 + var_161_18 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				groupID = "1035",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1.2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play425111038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 425111038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play425111039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.7

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(425111038).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 68 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 68)

				if (68 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 68)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play425111039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 425111039
		arg_168_1.duration_ = 10.33

		local var_168_0 = {
			zh = 7.7,
			ja = 10.333
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play425111040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if arg_168_1.actors_["10159"] == nil then
				local var_171_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10159")

				if not isNil(var_171_0) then
					local var_171_1 = Object.Instantiate(var_171_0, arg_168_1.canvasGo_.transform)

					var_171_1.transform:SetSiblingIndex(1)

					var_171_1.name = "10159"
					var_171_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_168_1.actors_["10159"] = var_171_1

					if arg_168_1.isInRecall_ then
						for iter_171_0, iter_171_1 in ipairs((var_171_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_171_1.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_171_2 = arg_168_1.actors_["10159"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10159 == nil then
				arg_168_1.var_.actorSpriteComps10159 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps10159 then
					for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_171_3 then
							if arg_168_1.isInRecall_ then
								iter_171_3.color = Color.New(Mathf.Lerp(iter_171_3.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_3.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_3.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_3.color.r, 1, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_3.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10159 then
				for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_171_5 then
						iter_171_5.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps10159 = nil
			end

			local var_171_5 = arg_168_1.actors_["10159"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10159 = var_171_5.localPosition
				var_171_5.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10159", 3)

				for iter_171_6 = 0, var_171_5.childCount - 1 do
					local var_171_6 = var_171_5:GetChild(iter_171_6)

					if var_171_6.name == "split_1" or not string.find(var_171_6.name, "split") then
						var_171_6.gameObject:SetActive(true)
					else
						var_171_6.gameObject:SetActive(false)
					end
				end
			end

			local var_171_7 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				var_171_5.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_168_1.time_ - 0) / var_171_7)
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				var_171_5.localPosition = Vector3.New(0, -415, -230)
			end

			local var_171_8 = 0
			local var_171_9 = 0.65

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_10 = arg_168_1:GetWordFromCfg(425111039)
				local var_171_11 = arg_168_1:FormatText(var_171_10.content)

				arg_168_1.text_.text = var_171_11

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 26 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 26)

				if (26 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 26)) > 0 and var_171_9 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_11
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111039", "story_v_out_425111.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111039", "story_v_out_425111.awb") / 1000

					if var_171_14 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_8
					end

					if var_171_10.prefab_name ~= "" and arg_168_1.actors_[var_171_10.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_10.prefab_name].transform, "story_v_out_425111", "425111039", "story_v_out_425111.awb")

						arg_168_1:RecordAudio("425111039", var_171_15)
						arg_168_1:RecordAudio("425111039", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_425111", "425111039", "story_v_out_425111.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_425111", "425111039", "story_v_out_425111.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_16 and arg_168_1.time_ < var_171_8 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play425111040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 425111040
		arg_172_1.duration_ = 4.3

		local var_172_0 = {
			zh = 2.8,
			ja = 4.3
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play425111041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1037"]) and arg_172_1.var_.actorSpriteComps1037 == nil then
				arg_172_1.var_.actorSpriteComps1037 = arg_172_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1037"]) then
				if arg_172_1.var_.actorSpriteComps1037 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 1, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1037"]) and arg_172_1.var_.actorSpriteComps1037 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_172_1.var_.actorSpriteComps1037 = nil
			end

			local var_175_2 = arg_172_1.actors_["10159"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps10159 == nil then
				arg_172_1.var_.actorSpriteComps10159 = var_175_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_3 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.actorSpriteComps10159 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								iter_175_5.color = Color.New(Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_3), Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_3), (Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_3)))
							else
								local var_175_4 = Mathf.Lerp(iter_175_5.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_3)

								iter_175_5.color = Color.New(var_175_4, var_175_4, var_175_4)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps10159 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_175_7 then
						iter_175_7.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps10159 = nil
			end

			local var_175_5 = arg_172_1.actors_["1037"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1037 = var_175_5.localPosition
				var_175_5.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1037", 4)

				for iter_175_8 = 0, var_175_5.childCount - 1 do
					local var_175_6 = var_175_5:GetChild(iter_175_8)

					if var_175_6.name == "split_5" or not string.find(var_175_6.name, "split") then
						var_175_6.gameObject:SetActive(true)
					else
						var_175_6.gameObject:SetActive(false)
					end
				end
			end

			local var_175_7 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				var_175_5.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_172_1.time_ - 0) / var_175_7)
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				var_175_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_175_8 = arg_172_1.actors_["10159"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos10159 = var_175_8.localPosition
				var_175_8.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("10159", 2)

				for iter_175_9 = 0, var_175_8.childCount - 1 do
					local var_175_9 = var_175_8:GetChild(iter_175_9)

					if var_175_9.name == "split_1" or not string.find(var_175_9.name, "split") then
						var_175_9.gameObject:SetActive(true)
					else
						var_175_9.gameObject:SetActive(false)
					end
				end
			end

			local var_175_10 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_10 then
				var_175_8.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_172_1.time_ - 0) / var_175_10)
			end

			if arg_172_1.time_ >= 0 + var_175_10 and arg_172_1.time_ < 0 + var_175_10 + arg_175_0 then
				var_175_8.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_175_11 = 0
			local var_175_12 = 0.3

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_13 = arg_172_1:GetWordFromCfg(425111040)
				local var_175_14 = arg_172_1:FormatText(var_175_13.content)

				arg_172_1.text_.text = var_175_14

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 12 <= 0 and var_175_12 or var_175_12 * (utf8.len(var_175_14) / 12)

				if (12 <= 0 and var_175_12 or var_175_12 * (utf8.len(var_175_14) / 12)) > 0 and var_175_12 < var_175_16 then
					arg_172_1.talkMaxDuration = var_175_16

					if var_175_16 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_16 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_14
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111040", "story_v_out_425111.awb") ~= 0 then
					local var_175_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111040", "story_v_out_425111.awb") / 1000

					if var_175_17 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_17 + var_175_11
					end

					if var_175_13.prefab_name ~= "" and arg_172_1.actors_[var_175_13.prefab_name] ~= nil then
						local var_175_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_13.prefab_name].transform, "story_v_out_425111", "425111040", "story_v_out_425111.awb")

						arg_172_1:RecordAudio("425111040", var_175_18)
						arg_172_1:RecordAudio("425111040", var_175_18)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_425111", "425111040", "story_v_out_425111.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_425111", "425111040", "story_v_out_425111.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_19 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_19 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_19

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_19 and arg_172_1.time_ < var_175_11 + var_175_19 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play425111041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 425111041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play425111042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1037 = arg_176_1.actors_["1037"].transform.localPosition
				arg_176_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1037", 7)

				for iter_179_0 = 0, arg_176_1.actors_["1037"].transform.childCount - 1 do
					local var_179_0 = arg_176_1.actors_["1037"].transform:GetChild(iter_179_0)

					if var_179_0.name == "" or not string.find(var_179_0.name, "split") then
						var_179_0.gameObject:SetActive(true)
					else
						var_179_0.gameObject:SetActive(false)
					end
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_176_1.time_ - 0) / var_179_1)
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_179_2 = arg_176_1.actors_["10159"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10159 = var_179_2.localPosition
				var_179_2.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10159", 7)

				for iter_179_1 = 0, var_179_2.childCount - 1 do
					local var_179_3 = var_179_2:GetChild(iter_179_1)

					if var_179_3.name == "" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_176_1.time_ - 0) / var_179_4)
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_179_5 = 0
			local var_179_6 = 2

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(425111041).content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 80 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 80)

				if (80 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 80)) > 0 and var_179_6 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_10 and arg_176_1.time_ < var_179_5 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play425111042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 425111042
		arg_180_1.duration_ = 5.9

		local var_180_0 = {
			zh = 5.9,
			ja = 4.2
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play425111043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10159"]) and arg_180_1.var_.actorSpriteComps10159 == nil then
				arg_180_1.var_.actorSpriteComps10159 = arg_180_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10159"]) then
				if arg_180_1.var_.actorSpriteComps10159 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10159"]) and arg_180_1.var_.actorSpriteComps10159 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10159 = nil
			end

			local var_183_2 = arg_180_1.actors_["10159"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10159 = var_183_2.localPosition
				var_183_2.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10159", 3)

				for iter_183_4 = 0, var_183_2.childCount - 1 do
					local var_183_3 = var_183_2:GetChild(iter_183_4)

					if var_183_3.name == "split_1" then
						var_183_3:SetAsLastSibling()
						var_183_3.gameObject:SetActive(true)

						arg_180_1.var_.actorSpriteSplit10159 = var_183_3.gameObject:GetComponent(typeof(Image))

						arg_180_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_2.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_180_1.time_ - 0) / var_183_4)

				if arg_180_1.var_.actorSpriteSplit10159 ~= nil then
					arg_180_1.var_.actorSpriteSplit10159:SetAlpha((arg_180_1.time_ - 0) / var_183_4)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_2.localPosition = Vector3.New(0, -415, -230)

				if arg_180_1.var_.actorSpriteSplit10159 ~= nil then
					arg_180_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_183_5 = 0
			local var_183_6 = 0.375

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_7 = arg_180_1:GetWordFromCfg(425111042)
				local var_183_8 = arg_180_1:FormatText(var_183_7.content)

				arg_180_1.text_.text = var_183_8

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 15 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 15)

				if (15 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 15)) > 0 and var_183_6 < var_183_10 then
					arg_180_1.talkMaxDuration = var_183_10

					if var_183_10 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_5
					end
				end

				arg_180_1.text_.text = var_183_8
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111042", "story_v_out_425111.awb") ~= 0 then
					local var_183_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111042", "story_v_out_425111.awb") / 1000

					if var_183_11 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_5
					end

					if var_183_7.prefab_name ~= "" and arg_180_1.actors_[var_183_7.prefab_name] ~= nil then
						local var_183_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_7.prefab_name].transform, "story_v_out_425111", "425111042", "story_v_out_425111.awb")

						arg_180_1:RecordAudio("425111042", var_183_12)
						arg_180_1:RecordAudio("425111042", var_183_12)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_425111", "425111042", "story_v_out_425111.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_425111", "425111042", "story_v_out_425111.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_6, arg_180_1.talkMaxDuration)

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_5) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_5 + var_183_13 and arg_180_1.time_ < var_183_5 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play425111043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 425111043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play425111044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10159 = arg_184_1.actors_["10159"].transform.localPosition
				arg_184_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10159", 7)

				for iter_187_0 = 0, arg_184_1.actors_["10159"].transform.childCount - 1 do
					local var_187_0 = arg_184_1.actors_["10159"].transform:GetChild(iter_187_0)

					if var_187_0.name == "" or not string.find(var_187_0.name, "split") then
						var_187_0.gameObject:SetActive(true)
					else
						var_187_0.gameObject:SetActive(false)
					end
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_184_1.time_ - 0) / var_187_1)
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10159"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_187_2 = 0
			local var_187_3 = 1.175

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(425111043).content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 47 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 47)

				if (47 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 47)) > 0 and var_187_3 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_7 and arg_184_1.time_ < var_187_2 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play425111044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 425111044
		arg_188_1.duration_ = 3.83

		local var_188_0 = {
			zh = 2.3,
			ja = 3.833
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play425111045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1037"]) and arg_188_1.var_.actorSpriteComps1037 == nil then
				arg_188_1.var_.actorSpriteComps1037 = arg_188_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1037"]) then
				if arg_188_1.var_.actorSpriteComps1037 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1037"]) and arg_188_1.var_.actorSpriteComps1037 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1037 = nil
			end

			local var_191_2 = arg_188_1.actors_["1037"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1037 = var_191_2.localPosition
				var_191_2.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1037", 3)

				for iter_191_4 = 0, var_191_2.childCount - 1 do
					local var_191_3 = var_191_2:GetChild(iter_191_4)

					if var_191_3.name == "split_4" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_2.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_188_1.time_ - 0) / var_191_4)
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_191_5 = 0
			local var_191_6 = 0.25

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_7 = arg_188_1:GetWordFromCfg(425111044)
				local var_191_8 = arg_188_1:FormatText(var_191_7.content)

				arg_188_1.text_.text = var_191_8

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 10 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 10)

				if (10 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 10)) > 0 and var_191_6 < var_191_10 then
					arg_188_1.talkMaxDuration = var_191_10

					if var_191_10 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_5
					end
				end

				arg_188_1.text_.text = var_191_8
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111044", "story_v_out_425111.awb") ~= 0 then
					local var_191_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111044", "story_v_out_425111.awb") / 1000

					if var_191_11 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_5
					end

					if var_191_7.prefab_name ~= "" and arg_188_1.actors_[var_191_7.prefab_name] ~= nil then
						local var_191_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_7.prefab_name].transform, "story_v_out_425111", "425111044", "story_v_out_425111.awb")

						arg_188_1:RecordAudio("425111044", var_191_12)
						arg_188_1:RecordAudio("425111044", var_191_12)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_425111", "425111044", "story_v_out_425111.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_425111", "425111044", "story_v_out_425111.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_6, arg_188_1.talkMaxDuration)

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_5) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_5 + var_191_13 and arg_188_1.time_ < var_191_5 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play425111045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 425111045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play425111046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1037"]) and arg_192_1.var_.actorSpriteComps1037 == nil then
				arg_192_1.var_.actorSpriteComps1037 = arg_192_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1037"]) then
				if arg_192_1.var_.actorSpriteComps1037 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1037"]) and arg_192_1.var_.actorSpriteComps1037 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps1037 = nil
			end

			local var_195_2 = 0
			local var_195_3 = 0.8

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_4 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(425111045).content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_6 = 32 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 32)

				if (32 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 32)) > 0 and var_195_3 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_2 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_2
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_3, arg_192_1.talkMaxDuration)

			if var_195_2 <= arg_192_1.time_ and arg_192_1.time_ < var_195_2 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_2) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_2 + var_195_7 and arg_192_1.time_ < var_195_2 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play425111046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 425111046
		arg_196_1.duration_ = 8.53

		local var_196_0 = {
			zh = 5.4,
			ja = 8.533
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play425111047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10159"]) and arg_196_1.var_.actorSpriteComps10159 == nil then
				arg_196_1.var_.actorSpriteComps10159 = arg_196_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10159"]) then
				if arg_196_1.var_.actorSpriteComps10159 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 1, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10159"]) and arg_196_1.var_.actorSpriteComps10159 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10159 = nil
			end

			local var_199_2 = arg_196_1.actors_["10159"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10159 = var_199_2.localPosition
				var_199_2.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10159", 4)

				for iter_199_4 = 0, var_199_2.childCount - 1 do
					local var_199_3 = var_199_2:GetChild(iter_199_4)

					if var_199_3.name == "" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				var_199_2.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10159, Vector3.New(390, -415, -230), (arg_196_1.time_ - 0) / var_199_4)
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				var_199_2.localPosition = Vector3.New(390, -415, -230)
			end

			local var_199_5 = arg_196_1.actors_["1037"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1037 = var_199_5.localPosition
				var_199_5.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1037", 2)

				for iter_199_5 = 0, var_199_5.childCount - 1 do
					local var_199_6 = var_199_5:GetChild(iter_199_5)

					if var_199_6.name == "" or not string.find(var_199_6.name, "split") then
						var_199_6.gameObject:SetActive(true)
					else
						var_199_6.gameObject:SetActive(false)
					end
				end
			end

			local var_199_7 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				var_199_5.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_196_1.time_ - 0) / var_199_7)
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				var_199_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_199_8 = 0
			local var_199_9 = 0.5

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(425111046)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 20 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 20)

				if (20 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 20)) > 0 and var_199_9 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111046", "story_v_out_425111.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111046", "story_v_out_425111.awb") / 1000

					if var_199_14 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_8
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_425111", "425111046", "story_v_out_425111.awb")

						arg_196_1:RecordAudio("425111046", var_199_15)
						arg_196_1:RecordAudio("425111046", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_425111", "425111046", "story_v_out_425111.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_425111", "425111046", "story_v_out_425111.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_16 and arg_196_1.time_ < var_199_8 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play425111047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 425111047
		arg_200_1.duration_ = 2.4

		local var_200_0 = {
			zh = 2.4,
			ja = 1.9
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play425111048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10156"]) and arg_200_1.var_.actorSpriteComps10156 == nil then
				arg_200_1.var_.actorSpriteComps10156 = arg_200_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10156"]) then
				if arg_200_1.var_.actorSpriteComps10156 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10156"]) and arg_200_1.var_.actorSpriteComps10156 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10156 = nil
			end

			local var_203_2 = arg_200_1.actors_["10159"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10159 == nil then
				arg_200_1.var_.actorSpriteComps10159 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10159 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10159 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10159 = nil
			end

			local var_203_5 = arg_200_1.actors_["10156"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10156 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10156", 2)

				for iter_203_8 = 0, var_203_5.childCount - 1 do
					local var_203_6 = var_203_5:GetChild(iter_203_8)

					if var_203_6.name == "" or not string.find(var_203_6.name, "split") then
						var_203_6.gameObject:SetActive(true)
					else
						var_203_6.gameObject:SetActive(false)
					end
				end
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_200_1.time_ - 0) / var_203_7)
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(-390, -390, -210)
			end

			local var_203_8 = arg_200_1.actors_["1037"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1037 = var_203_8.localPosition
				var_203_8.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1037", 7)

				for iter_203_9 = 0, var_203_8.childCount - 1 do
					local var_203_9 = var_203_8:GetChild(iter_203_9)

					if var_203_9.name == "" or not string.find(var_203_9.name, "split") then
						var_203_9.gameObject:SetActive(true)
					else
						var_203_9.gameObject:SetActive(false)
					end
				end
			end

			local var_203_10 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_10 then
				var_203_8.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_200_1.time_ - 0) / var_203_10)
			end

			if arg_200_1.time_ >= 0 + var_203_10 and arg_200_1.time_ < 0 + var_203_10 + arg_203_0 then
				var_203_8.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_203_11 = 0
			local var_203_12 = 0.275

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_13 = arg_200_1:GetWordFromCfg(425111047)
				local var_203_14 = arg_200_1:FormatText(var_203_13.content)

				arg_200_1.text_.text = var_203_14

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_16 = 11 <= 0 and var_203_12 or var_203_12 * (utf8.len(var_203_14) / 11)

				if (11 <= 0 and var_203_12 or var_203_12 * (utf8.len(var_203_14) / 11)) > 0 and var_203_12 < var_203_16 then
					arg_200_1.talkMaxDuration = var_203_16

					if var_203_16 + var_203_11 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_16 + var_203_11
					end
				end

				arg_200_1.text_.text = var_203_14
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111047", "story_v_out_425111.awb") ~= 0 then
					local var_203_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111047", "story_v_out_425111.awb") / 1000

					if var_203_17 + var_203_11 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_17 + var_203_11
					end

					if var_203_13.prefab_name ~= "" and arg_200_1.actors_[var_203_13.prefab_name] ~= nil then
						local var_203_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_13.prefab_name].transform, "story_v_out_425111", "425111047", "story_v_out_425111.awb")

						arg_200_1:RecordAudio("425111047", var_203_18)
						arg_200_1:RecordAudio("425111047", var_203_18)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_425111", "425111047", "story_v_out_425111.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_425111", "425111047", "story_v_out_425111.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_19 = math.max(var_203_12, arg_200_1.talkMaxDuration)

			if var_203_11 <= arg_200_1.time_ and arg_200_1.time_ < var_203_11 + var_203_19 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_11) / var_203_19

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_11 + var_203_19 and arg_200_1.time_ < var_203_11 + var_203_19 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play425111048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 425111048
		arg_204_1.duration_ = 16.1

		local var_204_0 = {
			zh = 11.6,
			ja = 16.1
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play425111049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10159"]) and arg_204_1.var_.actorSpriteComps10159 == nil then
				arg_204_1.var_.actorSpriteComps10159 = arg_204_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10159"]) then
				if arg_204_1.var_.actorSpriteComps10159 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 1, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10159"]) and arg_204_1.var_.actorSpriteComps10159 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10159 = nil
			end

			local var_207_2 = arg_204_1.actors_["10156"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10156 == nil then
				arg_204_1.var_.actorSpriteComps10156 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps10156 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								iter_207_5.color = Color.New(Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_5.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_5.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10156 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_207_7 then
						iter_207_7.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10156 = nil
			end

			local var_207_5 = arg_204_1.actors_["10159"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10159 = var_207_5.localPosition
				var_207_5.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10159", 4)

				for iter_207_8 = 0, var_207_5.childCount - 1 do
					local var_207_6 = var_207_5:GetChild(iter_207_8)

					if var_207_6.name == "" or not string.find(var_207_6.name, "split") then
						var_207_6.gameObject:SetActive(true)
					else
						var_207_6.gameObject:SetActive(false)
					end
				end
			end

			local var_207_7 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10159, Vector3.New(390, -415, -230), (arg_204_1.time_ - 0) / var_207_7)
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(390, -415, -230)
			end

			local var_207_8 = 0
			local var_207_9 = 1.125

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_10 = arg_204_1:GetWordFromCfg(425111048)
				local var_207_11 = arg_204_1:FormatText(var_207_10.content)

				arg_204_1.text_.text = var_207_11

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 45 <= 0 and var_207_9 or var_207_9 * (utf8.len(var_207_11) / 45)

				if (45 <= 0 and var_207_9 or var_207_9 * (utf8.len(var_207_11) / 45)) > 0 and var_207_9 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_8
					end
				end

				arg_204_1.text_.text = var_207_11
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111048", "story_v_out_425111.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111048", "story_v_out_425111.awb") / 1000

					if var_207_14 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_8
					end

					if var_207_10.prefab_name ~= "" and arg_204_1.actors_[var_207_10.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_10.prefab_name].transform, "story_v_out_425111", "425111048", "story_v_out_425111.awb")

						arg_204_1:RecordAudio("425111048", var_207_15)
						arg_204_1:RecordAudio("425111048", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_425111", "425111048", "story_v_out_425111.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_425111", "425111048", "story_v_out_425111.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_9, arg_204_1.talkMaxDuration)

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_8) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_8 + var_207_16 and arg_204_1.time_ < var_207_8 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play425111049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 425111049
		arg_208_1.duration_ = 12.3

		local var_208_0 = {
			zh = 10.666,
			ja = 12.3
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play425111050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.925

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(425111049)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 37 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 37)

				if (37 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 37)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111049", "story_v_out_425111.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111049", "story_v_out_425111.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_425111", "425111049", "story_v_out_425111.awb")

						arg_208_1:RecordAudio("425111049", var_211_6)
						arg_208_1:RecordAudio("425111049", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_425111", "425111049", "story_v_out_425111.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_425111", "425111049", "story_v_out_425111.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play425111050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 425111050
		arg_212_1.duration_ = 1.53

		local var_212_0 = {
			zh = 0.999999999999,
			ja = 1.533
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play425111051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1037"]) and arg_212_1.var_.actorSpriteComps1037 == nil then
				arg_212_1.var_.actorSpriteComps1037 = arg_212_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1037"]) then
				if arg_212_1.var_.actorSpriteComps1037 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 1, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1037"]) and arg_212_1.var_.actorSpriteComps1037 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps1037 = nil
			end

			local var_215_2 = arg_212_1.actors_["10159"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10159 == nil then
				arg_212_1.var_.actorSpriteComps10159 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10159 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								iter_215_5.color = Color.New(Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor2.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor2.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor2.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_5.color.r, 0.5, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_5.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10159 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_215_7 then
						iter_215_7.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps10159 = nil
			end

			local var_215_5 = arg_212_1.actors_["1037"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1037 = var_215_5.localPosition
				var_215_5.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1037", 2)

				for iter_215_8 = 0, var_215_5.childCount - 1 do
					local var_215_6 = var_215_5:GetChild(iter_215_8)

					if var_215_6.name == "split_4" or not string.find(var_215_6.name, "split") then
						var_215_6.gameObject:SetActive(true)
					else
						var_215_6.gameObject:SetActive(false)
					end
				end
			end

			local var_215_7 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_212_1.time_ - 0) / var_215_7)
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_215_8 = 0
			local var_215_9 = 0.1

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(425111050)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 4 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 4)

				if (4 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 4)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111050", "story_v_out_425111.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111050", "story_v_out_425111.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_425111", "425111050", "story_v_out_425111.awb")

						arg_212_1:RecordAudio("425111050", var_215_15)
						arg_212_1:RecordAudio("425111050", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_425111", "425111050", "story_v_out_425111.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_425111", "425111050", "story_v_out_425111.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play425111051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 425111051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play425111052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10159 = arg_216_1.actors_["10159"].transform.localPosition
				arg_216_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10159", 7)

				for iter_219_0 = 0, arg_216_1.actors_["10159"].transform.childCount - 1 do
					local var_219_0 = arg_216_1.actors_["10159"].transform:GetChild(iter_219_0)

					if var_219_0.name == "split_2" or not string.find(var_219_0.name, "split") then
						var_219_0.gameObject:SetActive(true)
					else
						var_219_0.gameObject:SetActive(false)
					end
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_216_1.time_ - 0) / var_219_1)
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10159"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_219_2 = arg_216_1.actors_["1037"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1037 = var_219_2.localPosition
				var_219_2.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1037", 7)

				for iter_219_1 = 0, var_219_2.childCount - 1 do
					local var_219_3 = var_219_2:GetChild(iter_219_1)

					if var_219_3.name == "split_4" or not string.find(var_219_3.name, "split") then
						var_219_3.gameObject:SetActive(true)
					else
						var_219_3.gameObject:SetActive(false)
					end
				end
			end

			local var_219_4 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				var_219_2.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_216_1.time_ - 0) / var_219_4)
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				var_219_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_219_5 = 0
			local var_219_6 = 1.125

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_7 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(425111051).content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 45 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 45)

				if (45 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 45)) > 0 and var_219_6 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_10 and arg_216_1.time_ < var_219_5 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play425111052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 425111052
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play425111053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.6

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(425111052).content)

				arg_220_1.text_.text = var_223_1

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_3 = 24 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 24)

				if (24 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 24)) > 0 and var_223_0 < var_223_3 then
					arg_220_1.talkMaxDuration = var_223_3

					if var_223_3 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_3 + 0
					end
				end

				arg_220_1.text_.text = var_223_1
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_4 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_4

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play425111053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 425111053
		arg_224_1.duration_ = 14.37

		local var_224_0 = {
			zh = 11.033,
			ja = 14.366
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play425111054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10159"]) and arg_224_1.var_.actorSpriteComps10159 == nil then
				arg_224_1.var_.actorSpriteComps10159 = arg_224_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10159"]) then
				if arg_224_1.var_.actorSpriteComps10159 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10159"]) and arg_224_1.var_.actorSpriteComps10159 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10159 = nil
			end

			local var_227_2 = arg_224_1.actors_["10159"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10159 = var_227_2.localPosition
				var_227_2.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10159", 3)

				for iter_227_4 = 0, var_227_2.childCount - 1 do
					local var_227_3 = var_227_2:GetChild(iter_227_4)

					if var_227_3.name == "" or not string.find(var_227_3.name, "split") then
						var_227_3.gameObject:SetActive(true)
					else
						var_227_3.gameObject:SetActive(false)
					end
				end
			end

			local var_227_4 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				var_227_2.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_224_1.time_ - 0) / var_227_4)
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				var_227_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_227_5 = 0
			local var_227_6 = 1.05

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_7 = arg_224_1:GetWordFromCfg(425111053)
				local var_227_8 = arg_224_1:FormatText(var_227_7.content)

				arg_224_1.text_.text = var_227_8

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_10 = 42 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 42)

				if (42 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 42)) > 0 and var_227_6 < var_227_10 then
					arg_224_1.talkMaxDuration = var_227_10

					if var_227_10 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_5
					end
				end

				arg_224_1.text_.text = var_227_8
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111053", "story_v_out_425111.awb") ~= 0 then
					local var_227_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111053", "story_v_out_425111.awb") / 1000

					if var_227_11 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_5
					end

					if var_227_7.prefab_name ~= "" and arg_224_1.actors_[var_227_7.prefab_name] ~= nil then
						local var_227_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_7.prefab_name].transform, "story_v_out_425111", "425111053", "story_v_out_425111.awb")

						arg_224_1:RecordAudio("425111053", var_227_12)
						arg_224_1:RecordAudio("425111053", var_227_12)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_425111", "425111053", "story_v_out_425111.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_425111", "425111053", "story_v_out_425111.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_13 = math.max(var_227_6, arg_224_1.talkMaxDuration)

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_13 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_5) / var_227_13

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_5 + var_227_13 and arg_224_1.time_ < var_227_5 + var_227_13 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play425111054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 425111054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play425111055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10159"]) and arg_228_1.var_.actorSpriteComps10159 == nil then
				arg_228_1.var_.actorSpriteComps10159 = arg_228_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10159"]) then
				if arg_228_1.var_.actorSpriteComps10159 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10159"]) and arg_228_1.var_.actorSpriteComps10159 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10159 = nil
			end

			local var_231_2 = 0
			local var_231_3 = 0.4

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_4 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(425111054).content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_6 = 16 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_4) / 16)

				if (16 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_4) / 16)) > 0 and var_231_3 < var_231_6 then
					arg_228_1.talkMaxDuration = var_231_6

					if var_231_6 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_6 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_7 and arg_228_1.time_ < var_231_2 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play425111055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 425111055
		arg_232_1.duration_ = 1.3

		local var_232_0 = {
			zh = 1.266,
			ja = 1.3
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play425111056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["10159"]) and arg_232_1.var_.actorSpriteComps10159 == nil then
				arg_232_1.var_.actorSpriteComps10159 = arg_232_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_0 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["10159"]) then
				if arg_232_1.var_.actorSpriteComps10159 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								iter_235_1.color = Color.New(Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_0), Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_0), (Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_0)))
							else
								local var_235_1 = Mathf.Lerp(iter_235_1.color.r, 1, (arg_232_1.time_ - 0) / var_235_0)

								iter_235_1.color = Color.New(var_235_1, var_235_1, var_235_1)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["10159"]) and arg_232_1.var_.actorSpriteComps10159 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_235_3 then
						iter_235_3.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10159 = nil
			end

			local var_235_2 = arg_232_1.actors_["10159"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10159 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10159", 3)

				for iter_235_4 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_4)

					if var_235_3.name == "split_5" then
						var_235_3:SetAsLastSibling()
						var_235_3.gameObject:SetActive(true)

						arg_232_1.var_.actorSpriteSplit10159 = var_235_3.gameObject:GetComponent(typeof(Image))

						arg_232_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_235_4 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_232_1.time_ - 0) / var_235_4)

				if arg_232_1.var_.actorSpriteSplit10159 ~= nil then
					arg_232_1.var_.actorSpriteSplit10159:SetAlpha((arg_232_1.time_ - 0) / var_235_4)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(0, -415, -230)

				if arg_232_1.var_.actorSpriteSplit10159 ~= nil then
					arg_232_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_235_5 = 0
			local var_235_6 = 0.05

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:GetWordFromCfg(425111055)
				local var_235_8 = arg_232_1:FormatText(var_235_7.content)

				arg_232_1.text_.text = var_235_8

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 2 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 2)

				if (2 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 2)) > 0 and var_235_6 < var_235_10 then
					arg_232_1.talkMaxDuration = var_235_10

					if var_235_10 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_8
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111055", "story_v_out_425111.awb") ~= 0 then
					local var_235_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111055", "story_v_out_425111.awb") / 1000

					if var_235_11 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_5
					end

					if var_235_7.prefab_name ~= "" and arg_232_1.actors_[var_235_7.prefab_name] ~= nil then
						local var_235_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_7.prefab_name].transform, "story_v_out_425111", "425111055", "story_v_out_425111.awb")

						arg_232_1:RecordAudio("425111055", var_235_12)
						arg_232_1:RecordAudio("425111055", var_235_12)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_425111", "425111055", "story_v_out_425111.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_425111", "425111055", "story_v_out_425111.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_13 and arg_232_1.time_ < var_235_5 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play425111056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 425111056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play425111057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10159"]) and arg_236_1.var_.actorSpriteComps10159 == nil then
				arg_236_1.var_.actorSpriteComps10159 = arg_236_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10159"]) then
				if arg_236_1.var_.actorSpriteComps10159 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10159"]) and arg_236_1.var_.actorSpriteComps10159 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10159 = nil
			end

			local var_239_2 = 0
			local var_239_3 = 0.9

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_4 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(425111056).content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_6 = 36 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 36)

				if (36 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 36)) > 0 and var_239_3 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_7 and arg_236_1.time_ < var_239_2 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play425111057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 425111057
		arg_240_1.duration_ = 6.1

		local var_240_0 = {
			zh = 6.1,
			ja = 4.3
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play425111058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10159"]) and arg_240_1.var_.actorSpriteComps10159 == nil then
				arg_240_1.var_.actorSpriteComps10159 = arg_240_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10159"]) then
				if arg_240_1.var_.actorSpriteComps10159 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								iter_243_1.color = Color.New(Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_0), Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_0), (Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_0)))
							else
								local var_243_1 = Mathf.Lerp(iter_243_1.color.r, 1, (arg_240_1.time_ - 0) / var_243_0)

								iter_243_1.color = Color.New(var_243_1, var_243_1, var_243_1)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10159"]) and arg_240_1.var_.actorSpriteComps10159 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10159 = nil
			end

			local var_243_2 = arg_240_1.actors_["10159"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10159 = var_243_2.localPosition
				var_243_2.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10159", 3)

				for iter_243_4 = 0, var_243_2.childCount - 1 do
					local var_243_3 = var_243_2:GetChild(iter_243_4)

					if var_243_3.name == "split_1" then
						var_243_3:SetAsLastSibling()
						var_243_3.gameObject:SetActive(true)

						arg_240_1.var_.actorSpriteSplit10159 = var_243_3.gameObject:GetComponent(typeof(Image))

						arg_240_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_243_4 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				var_243_2.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_240_1.time_ - 0) / var_243_4)

				if arg_240_1.var_.actorSpriteSplit10159 ~= nil then
					arg_240_1.var_.actorSpriteSplit10159:SetAlpha((arg_240_1.time_ - 0) / var_243_4)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				var_243_2.localPosition = Vector3.New(0, -415, -230)

				if arg_240_1.var_.actorSpriteSplit10159 ~= nil then
					arg_240_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_243_5 = 0
			local var_243_6 = 0.5

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:GetWordFromCfg(425111057)
				local var_243_8 = arg_240_1:FormatText(var_243_7.content)

				arg_240_1.text_.text = var_243_8

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_10 = 20 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_8) / 20)

				if (20 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_8) / 20)) > 0 and var_243_6 < var_243_10 then
					arg_240_1.talkMaxDuration = var_243_10

					if var_243_10 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_5
					end
				end

				arg_240_1.text_.text = var_243_8
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111057", "story_v_out_425111.awb") ~= 0 then
					local var_243_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111057", "story_v_out_425111.awb") / 1000

					if var_243_11 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_5
					end

					if var_243_7.prefab_name ~= "" and arg_240_1.actors_[var_243_7.prefab_name] ~= nil then
						local var_243_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_7.prefab_name].transform, "story_v_out_425111", "425111057", "story_v_out_425111.awb")

						arg_240_1:RecordAudio("425111057", var_243_12)
						arg_240_1:RecordAudio("425111057", var_243_12)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_425111", "425111057", "story_v_out_425111.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_425111", "425111057", "story_v_out_425111.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_13 = math.max(var_243_6, arg_240_1.talkMaxDuration)

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_13 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_5) / var_243_13

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_5 + var_243_13 and arg_240_1.time_ < var_243_5 + var_243_13 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play425111058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 425111058
		arg_244_1.duration_ = 1

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"

			SetActive(arg_244_1.choicesGo_, true)

			for iter_245_0, iter_245_1 in ipairs(arg_244_1.choices_) do
				SetActive(iter_245_1.go, iter_245_0 <= 2)
			end

			arg_244_1.choices_[1].txt.text = arg_244_1:FormatText(StoryChoiceCfg[1537].name)
			arg_244_1.choices_[2].txt.text = arg_244_1:FormatText(StoryChoiceCfg[1538].name)
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play425111059(arg_244_1)
			end

			if arg_246_0 == 2 then
				arg_244_0:Play425111060(arg_244_1)
			end

			arg_244_1:RecordChoiceLog(425111058, 1537, 1538)
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10159"]) and arg_244_1.var_.actorSpriteComps10159 == nil then
				arg_244_1.var_.actorSpriteComps10159 = arg_244_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10159"]) then
				if arg_244_1.var_.actorSpriteComps10159 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_0), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_0), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_0)))
							else
								local var_247_1 = Mathf.Lerp(iter_247_1.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_0)

								iter_247_1.color = Color.New(var_247_1, var_247_1, var_247_1)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10159"]) and arg_244_1.var_.actorSpriteComps10159 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10159 = nil
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play425111059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 425111059
		arg_248_1.duration_ = 7.27

		local var_248_0 = {
			zh = 7.266,
			ja = 5.566
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play425111061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10159"]) and arg_248_1.var_.actorSpriteComps10159 == nil then
				arg_248_1.var_.actorSpriteComps10159 = arg_248_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10159"]) then
				if arg_248_1.var_.actorSpriteComps10159 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								iter_251_1.color = Color.New(Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, (arg_248_1.time_ - 0) / var_251_0), Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, (arg_248_1.time_ - 0) / var_251_0), (Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, (arg_248_1.time_ - 0) / var_251_0)))
							else
								local var_251_1 = Mathf.Lerp(iter_251_1.color.r, 1, (arg_248_1.time_ - 0) / var_251_0)

								iter_251_1.color = Color.New(var_251_1, var_251_1, var_251_1)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10159"]) and arg_248_1.var_.actorSpriteComps10159 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_251_3 then
						iter_251_3.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_248_1.var_.actorSpriteComps10159 = nil
			end

			local var_251_2 = arg_248_1.actors_["10159"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10159 = var_251_2.localPosition
				var_251_2.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10159", 3)

				for iter_251_4 = 0, var_251_2.childCount - 1 do
					local var_251_3 = var_251_2:GetChild(iter_251_4)

					if var_251_3.name == "split_1" or not string.find(var_251_3.name, "split") then
						var_251_3.gameObject:SetActive(true)
					else
						var_251_3.gameObject:SetActive(false)
					end
				end
			end

			local var_251_4 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				var_251_2.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_248_1.time_ - 0) / var_251_4)
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				var_251_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_251_5 = 0
			local var_251_6 = 0.525

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:GetWordFromCfg(425111059)
				local var_251_8 = arg_248_1:FormatText(var_251_7.content)

				arg_248_1.text_.text = var_251_8

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_10 = 21 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_8) / 21)

				if (21 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_8) / 21)) > 0 and var_251_6 < var_251_10 then
					arg_248_1.talkMaxDuration = var_251_10

					if var_251_10 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_5
					end
				end

				arg_248_1.text_.text = var_251_8
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111059", "story_v_out_425111.awb") ~= 0 then
					local var_251_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111059", "story_v_out_425111.awb") / 1000

					if var_251_11 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_5
					end

					if var_251_7.prefab_name ~= "" and arg_248_1.actors_[var_251_7.prefab_name] ~= nil then
						local var_251_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_7.prefab_name].transform, "story_v_out_425111", "425111059", "story_v_out_425111.awb")

						arg_248_1:RecordAudio("425111059", var_251_12)
						arg_248_1:RecordAudio("425111059", var_251_12)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_425111", "425111059", "story_v_out_425111.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_425111", "425111059", "story_v_out_425111.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_13 = math.max(var_251_6, arg_248_1.talkMaxDuration)

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_13 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_5) / var_251_13

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_5 + var_251_13 and arg_248_1.time_ < var_251_5 + var_251_13 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play425111061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 425111061
		arg_252_1.duration_ = 7.83

		local var_252_0 = {
			zh = 6.366,
			ja = 7.833
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play425111062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10156"]) and arg_252_1.var_.actorSpriteComps10156 == nil then
				arg_252_1.var_.actorSpriteComps10156 = arg_252_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10156"]) then
				if arg_252_1.var_.actorSpriteComps10156 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 1, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10156"]) and arg_252_1.var_.actorSpriteComps10156 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps10156 = nil
			end

			local var_255_2 = arg_252_1.actors_["10159"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10159 == nil then
				arg_252_1.var_.actorSpriteComps10159 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps10159 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								iter_255_5.color = Color.New(Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_5.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_5.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10159 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_255_7 then
						iter_255_7.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps10159 = nil
			end

			local var_255_5 = arg_252_1.actors_["10159"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10159 = var_255_5.localPosition
				var_255_5.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10159", 7)

				for iter_255_8 = 0, var_255_5.childCount - 1 do
					local var_255_6 = var_255_5:GetChild(iter_255_8)

					if var_255_6.name == "" or not string.find(var_255_6.name, "split") then
						var_255_6.gameObject:SetActive(true)
					else
						var_255_6.gameObject:SetActive(false)
					end
				end
			end

			local var_255_7 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				var_255_5.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_252_1.time_ - 0) / var_255_7)
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				var_255_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_255_8 = arg_252_1.actors_["10156"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10156 = var_255_8.localPosition
				var_255_8.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10156", 3)

				for iter_255_9 = 0, var_255_8.childCount - 1 do
					local var_255_9 = var_255_8:GetChild(iter_255_9)

					if var_255_9.name == "split_6" or not string.find(var_255_9.name, "split") then
						var_255_9.gameObject:SetActive(true)
					else
						var_255_9.gameObject:SetActive(false)
					end
				end
			end

			local var_255_10 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_10 then
				var_255_8.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_252_1.time_ - 0) / var_255_10)
			end

			if arg_252_1.time_ >= 0 + var_255_10 and arg_252_1.time_ < 0 + var_255_10 + arg_255_0 then
				var_255_8.localPosition = Vector3.New(0, -390, -210)
			end

			local var_255_11 = 0
			local var_255_12 = 0.725

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_11 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_13 = arg_252_1:GetWordFromCfg(425111061)
				local var_255_14 = arg_252_1:FormatText(var_255_13.content)

				arg_252_1.text_.text = var_255_14

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_16 = 29 <= 0 and var_255_12 or var_255_12 * (utf8.len(var_255_14) / 29)

				if (29 <= 0 and var_255_12 or var_255_12 * (utf8.len(var_255_14) / 29)) > 0 and var_255_12 < var_255_16 then
					arg_252_1.talkMaxDuration = var_255_16

					if var_255_16 + var_255_11 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_16 + var_255_11
					end
				end

				arg_252_1.text_.text = var_255_14
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111061", "story_v_out_425111.awb") ~= 0 then
					local var_255_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111061", "story_v_out_425111.awb") / 1000

					if var_255_17 + var_255_11 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_17 + var_255_11
					end

					if var_255_13.prefab_name ~= "" and arg_252_1.actors_[var_255_13.prefab_name] ~= nil then
						local var_255_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_13.prefab_name].transform, "story_v_out_425111", "425111061", "story_v_out_425111.awb")

						arg_252_1:RecordAudio("425111061", var_255_18)
						arg_252_1:RecordAudio("425111061", var_255_18)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_425111", "425111061", "story_v_out_425111.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_425111", "425111061", "story_v_out_425111.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_19 = math.max(var_255_12, arg_252_1.talkMaxDuration)

			if var_255_11 <= arg_252_1.time_ and arg_252_1.time_ < var_255_11 + var_255_19 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_11) / var_255_19

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_11 + var_255_19 and arg_252_1.time_ < var_255_11 + var_255_19 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play425111062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 425111062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play425111063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10156 = arg_256_1.actors_["10156"].transform.localPosition
				arg_256_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10156", 7)

				for iter_259_0 = 0, arg_256_1.actors_["10156"].transform.childCount - 1 do
					local var_259_0 = arg_256_1.actors_["10156"].transform:GetChild(iter_259_0)

					if var_259_0.name == "" or not string.find(var_259_0.name, "split") then
						var_259_0.gameObject:SetActive(true)
					else
						var_259_0.gameObject:SetActive(false)
					end
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_256_1.time_ - 0) / var_259_1)
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["10156"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_259_2 = 0
			local var_259_3 = 0.9

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_4 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(425111062).content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_6 = 36 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_4) / 36)

				if (36 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_4) / 36)) > 0 and var_259_3 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_7 and arg_256_1.time_ < var_259_2 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play425111063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 425111063
		arg_260_1.duration_ = 11.63

		local var_260_0 = {
			zh = 10.066,
			ja = 11.633
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play425111064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["10159"]) and arg_260_1.var_.actorSpriteComps10159 == nil then
				arg_260_1.var_.actorSpriteComps10159 = arg_260_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["10159"]) then
				if arg_260_1.var_.actorSpriteComps10159 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								iter_263_1.color = Color.New(Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, (arg_260_1.time_ - 0) / var_263_0), Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, (arg_260_1.time_ - 0) / var_263_0), (Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, (arg_260_1.time_ - 0) / var_263_0)))
							else
								local var_263_1 = Mathf.Lerp(iter_263_1.color.r, 1, (arg_260_1.time_ - 0) / var_263_0)

								iter_263_1.color = Color.New(var_263_1, var_263_1, var_263_1)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["10159"]) and arg_260_1.var_.actorSpriteComps10159 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_260_1.var_.actorSpriteComps10159 = nil
			end

			local var_263_2 = arg_260_1.actors_["10159"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10159 = var_263_2.localPosition
				var_263_2.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10159", 3)

				for iter_263_4 = 0, var_263_2.childCount - 1 do
					local var_263_3 = var_263_2:GetChild(iter_263_4)

					if var_263_3.name == "" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_2.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_260_1.time_ - 0) / var_263_4)
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_263_5 = 0
			local var_263_6 = 0.7

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:GetWordFromCfg(425111063)
				local var_263_8 = arg_260_1:FormatText(var_263_7.content)

				arg_260_1.text_.text = var_263_8

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 28 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 28)

				if (28 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 28)) > 0 and var_263_6 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_8
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111063", "story_v_out_425111.awb") ~= 0 then
					local var_263_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111063", "story_v_out_425111.awb") / 1000

					if var_263_11 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_5
					end

					if var_263_7.prefab_name ~= "" and arg_260_1.actors_[var_263_7.prefab_name] ~= nil then
						local var_263_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_7.prefab_name].transform, "story_v_out_425111", "425111063", "story_v_out_425111.awb")

						arg_260_1:RecordAudio("425111063", var_263_12)
						arg_260_1:RecordAudio("425111063", var_263_12)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_425111", "425111063", "story_v_out_425111.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_425111", "425111063", "story_v_out_425111.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_13 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_13 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_13

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_13 and arg_260_1.time_ < var_263_5 + var_263_13 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play425111064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 425111064
		arg_264_1.duration_ = 1.27

		local var_264_0 = {
			zh = 0.999999999999,
			ja = 1.266
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play425111065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10159 = arg_264_1.actors_["10159"].transform.localPosition
				arg_264_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10159", 7)

				for iter_267_0 = 0, arg_264_1.actors_["10159"].transform.childCount - 1 do
					local var_267_0 = arg_264_1.actors_["10159"].transform:GetChild(iter_267_0)

					if var_267_0.name == "" or not string.find(var_267_0.name, "split") then
						var_267_0.gameObject:SetActive(true)
					else
						var_267_0.gameObject:SetActive(false)
					end
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_264_1.time_ - 0) / var_267_1)
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["10159"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_267_2 = arg_264_1.actors_["1037"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1037 = var_267_2.localPosition
				var_267_2.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1037", 3)

				for iter_267_1 = 0, var_267_2.childCount - 1 do
					local var_267_3 = var_267_2:GetChild(iter_267_1)

					if var_267_3.name == "split_5" or not string.find(var_267_3.name, "split") then
						var_267_3.gameObject:SetActive(true)
					else
						var_267_3.gameObject:SetActive(false)
					end
				end
			end

			local var_267_4 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				var_267_2.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_264_1.time_ - 0) / var_267_4)
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				var_267_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_267_5 = arg_264_1.actors_["1037"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_5) and arg_264_1.var_.actorSpriteComps1037 == nil then
				arg_264_1.var_.actorSpriteComps1037 = var_267_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_6 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_6 and not isNil(var_267_5) then
				if arg_264_1.var_.actorSpriteComps1037 then
					for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_267_3 then
							if arg_264_1.isInRecall_ then
								iter_267_3.color = Color.New(Mathf.Lerp(iter_267_3.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_6), Mathf.Lerp(iter_267_3.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_6), (Mathf.Lerp(iter_267_3.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_6)))
							else
								local var_267_7 = Mathf.Lerp(iter_267_3.color.r, 1, (arg_264_1.time_ - 0) / var_267_6)

								iter_267_3.color = Color.New(var_267_7, var_267_7, var_267_7)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_6 and arg_264_1.time_ < 0 + var_267_6 + arg_267_0 and not isNil(var_267_5) and arg_264_1.var_.actorSpriteComps1037 then
				for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_267_5 then
						iter_267_5.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps1037 = nil
			end

			local var_267_8 = 0
			local var_267_9 = 0.05

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1435].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_10 = arg_264_1:GetWordFromCfg(425111064)
				local var_267_11 = arg_264_1:FormatText(var_267_10.content)

				arg_264_1.text_.text = var_267_11

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_13 = 2 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 2)

				if (2 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 2)) > 0 and var_267_9 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_11
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111064", "story_v_out_425111.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111064", "story_v_out_425111.awb") / 1000

					if var_267_14 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_8
					end

					if var_267_10.prefab_name ~= "" and arg_264_1.actors_[var_267_10.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_10.prefab_name].transform, "story_v_out_425111", "425111064", "story_v_out_425111.awb")

						arg_264_1:RecordAudio("425111064", var_267_15)
						arg_264_1:RecordAudio("425111064", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_425111", "425111064", "story_v_out_425111.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_425111", "425111064", "story_v_out_425111.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_16 and arg_264_1.time_ < var_267_8 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play425111065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 425111065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play425111066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1037"]) and arg_268_1.var_.actorSpriteComps1037 == nil then
				arg_268_1.var_.actorSpriteComps1037 = arg_268_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1037"]) then
				if arg_268_1.var_.actorSpriteComps1037 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								iter_271_1.color = Color.New(Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_0), Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_0), (Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_0)))
							else
								local var_271_1 = Mathf.Lerp(iter_271_1.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_0)

								iter_271_1.color = Color.New(var_271_1, var_271_1, var_271_1)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1037"]) and arg_268_1.var_.actorSpriteComps1037 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_271_3 then
						iter_271_3.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps1037 = nil
			end

			local var_271_2 = 0
			local var_271_3 = 0.7

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_4 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(425111065).content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 28 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_4) / 28)

				if (28 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_4) / 28)) > 0 and var_271_3 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_7 and arg_268_1.time_ < var_271_2 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play425111066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 425111066
		arg_272_1.duration_ = 10.67

		local var_272_0 = {
			zh = 9.6,
			ja = 10.666
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
				arg_272_0:Play425111067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["10159"]) and arg_272_1.var_.actorSpriteComps10159 == nil then
				arg_272_1.var_.actorSpriteComps10159 = arg_272_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_0 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["10159"]) then
				if arg_272_1.var_.actorSpriteComps10159 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								iter_275_1.color = Color.New(Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor1.r, (arg_272_1.time_ - 0) / var_275_0), Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor1.g, (arg_272_1.time_ - 0) / var_275_0), (Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor1.b, (arg_272_1.time_ - 0) / var_275_0)))
							else
								local var_275_1 = Mathf.Lerp(iter_275_1.color.r, 1, (arg_272_1.time_ - 0) / var_275_0)

								iter_275_1.color = Color.New(var_275_1, var_275_1, var_275_1)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["10159"]) and arg_272_1.var_.actorSpriteComps10159 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_275_3 then
						iter_275_3.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_272_1.var_.actorSpriteComps10159 = nil
			end

			local var_275_2 = arg_272_1.actors_["10159"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10159 = var_275_2.localPosition
				var_275_2.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10159", 4)

				for iter_275_4 = 0, var_275_2.childCount - 1 do
					local var_275_3 = var_275_2:GetChild(iter_275_4)

					if var_275_3.name == "" or not string.find(var_275_3.name, "split") then
						var_275_3.gameObject:SetActive(true)
					else
						var_275_3.gameObject:SetActive(false)
					end
				end
			end

			local var_275_4 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				var_275_2.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10159, Vector3.New(390, -415, -230), (arg_272_1.time_ - 0) / var_275_4)
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				var_275_2.localPosition = Vector3.New(390, -415, -230)
			end

			local var_275_5 = arg_272_1.actors_["1037"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1037 = var_275_5.localPosition
				var_275_5.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("1037", 2)

				for iter_275_5 = 0, var_275_5.childCount - 1 do
					local var_275_6 = var_275_5:GetChild(iter_275_5)

					if var_275_6.name == "" or not string.find(var_275_6.name, "split") then
						var_275_6.gameObject:SetActive(true)
					else
						var_275_6.gameObject:SetActive(false)
					end
				end
			end

			local var_275_7 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				var_275_5.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_272_1.time_ - 0) / var_275_7)
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				var_275_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_275_8 = arg_272_1.actors_["1037"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_8) and arg_272_1.var_.actorSpriteComps1037 == nil then
				arg_272_1.var_.actorSpriteComps1037 = var_275_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_9 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_9 and not isNil(var_275_8) then
				if arg_272_1.var_.actorSpriteComps1037 then
					for iter_275_6, iter_275_7 in pairs(arg_272_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_275_7 then
							if arg_272_1.isInRecall_ then
								iter_275_7.color = Color.New(Mathf.Lerp(iter_275_7.color.r, arg_272_1.hightColor2.r, (arg_272_1.time_ - 0) / var_275_9), Mathf.Lerp(iter_275_7.color.g, arg_272_1.hightColor2.g, (arg_272_1.time_ - 0) / var_275_9), (Mathf.Lerp(iter_275_7.color.b, arg_272_1.hightColor2.b, (arg_272_1.time_ - 0) / var_275_9)))
							else
								local var_275_10 = Mathf.Lerp(iter_275_7.color.r, 0.5, (arg_272_1.time_ - 0) / var_275_9)

								iter_275_7.color = Color.New(var_275_10, var_275_10, var_275_10)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_9 and arg_272_1.time_ < 0 + var_275_9 + arg_275_0 and not isNil(var_275_8) and arg_272_1.var_.actorSpriteComps1037 then
				for iter_275_8, iter_275_9 in pairs(arg_272_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_275_9 then
						iter_275_9.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_272_1.var_.actorSpriteComps1037 = nil
			end

			local var_275_11 = 0
			local var_275_12 = 1.075

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_11 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_13 = arg_272_1:GetWordFromCfg(425111066)
				local var_275_14 = arg_272_1:FormatText(var_275_13.content)

				arg_272_1.text_.text = var_275_14

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_16 = 43 <= 0 and var_275_12 or var_275_12 * (utf8.len(var_275_14) / 43)

				if (43 <= 0 and var_275_12 or var_275_12 * (utf8.len(var_275_14) / 43)) > 0 and var_275_12 < var_275_16 then
					arg_272_1.talkMaxDuration = var_275_16

					if var_275_16 + var_275_11 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_16 + var_275_11
					end
				end

				arg_272_1.text_.text = var_275_14
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111066", "story_v_out_425111.awb") ~= 0 then
					local var_275_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111066", "story_v_out_425111.awb") / 1000

					if var_275_17 + var_275_11 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_17 + var_275_11
					end

					if var_275_13.prefab_name ~= "" and arg_272_1.actors_[var_275_13.prefab_name] ~= nil then
						local var_275_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_13.prefab_name].transform, "story_v_out_425111", "425111066", "story_v_out_425111.awb")

						arg_272_1:RecordAudio("425111066", var_275_18)
						arg_272_1:RecordAudio("425111066", var_275_18)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_425111", "425111066", "story_v_out_425111.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_425111", "425111066", "story_v_out_425111.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_19 = math.max(var_275_12, arg_272_1.talkMaxDuration)

			if var_275_11 <= arg_272_1.time_ and arg_272_1.time_ < var_275_11 + var_275_19 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_11) / var_275_19

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_11 + var_275_19 and arg_272_1.time_ < var_275_11 + var_275_19 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play425111067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 425111067
		arg_276_1.duration_ = 18.23

		local var_276_0 = {
			zh = 9.966,
			ja = 18.233
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
				arg_276_0:Play425111068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1037"]) and arg_276_1.var_.actorSpriteComps1037 == nil then
				arg_276_1.var_.actorSpriteComps1037 = arg_276_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1037"]) then
				if arg_276_1.var_.actorSpriteComps1037 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 1, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1037"]) and arg_276_1.var_.actorSpriteComps1037 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps1037 = nil
			end

			local var_279_2 = arg_276_1.actors_["10159"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps10159 == nil then
				arg_276_1.var_.actorSpriteComps10159 = var_279_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_3 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_3 and not isNil(var_279_2) then
				if arg_276_1.var_.actorSpriteComps10159 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								iter_279_5.color = Color.New(Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_3), Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_3), (Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_3)))
							else
								local var_279_4 = Mathf.Lerp(iter_279_5.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_3)

								iter_279_5.color = Color.New(var_279_4, var_279_4, var_279_4)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_3 and arg_276_1.time_ < 0 + var_279_3 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps10159 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_279_7 then
						iter_279_7.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10159 = nil
			end

			local var_279_5 = arg_276_1.actors_["1037"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1037 = var_279_5.localPosition
				var_279_5.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("1037", 2)

				for iter_279_8 = 0, var_279_5.childCount - 1 do
					local var_279_6 = var_279_5:GetChild(iter_279_8)

					if var_279_6.name == "split_6" then
						var_279_6:SetAsLastSibling()
						var_279_6.gameObject:SetActive(true)

						arg_276_1.var_.actorSpriteSplit1037 = var_279_6.gameObject:GetComponent(typeof(Image))

						arg_276_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_279_7 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				var_279_5.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_276_1.time_ - 0) / var_279_7)

				if arg_276_1.var_.actorSpriteSplit1037 ~= nil then
					arg_276_1.var_.actorSpriteSplit1037:SetAlpha((arg_276_1.time_ - 0) / var_279_7)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				var_279_5.localPosition = Vector3.New(-390, -430, -55)

				if arg_276_1.var_.actorSpriteSplit1037 ~= nil then
					arg_276_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_279_8 = 0
			local var_279_9 = 1.175

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_10 = arg_276_1:GetWordFromCfg(425111067)
				local var_279_11 = arg_276_1:FormatText(var_279_10.content)

				arg_276_1.text_.text = var_279_11

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 47 <= 0 and var_279_9 or var_279_9 * (utf8.len(var_279_11) / 47)

				if (47 <= 0 and var_279_9 or var_279_9 * (utf8.len(var_279_11) / 47)) > 0 and var_279_9 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_8
					end
				end

				arg_276_1.text_.text = var_279_11
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111067", "story_v_out_425111.awb") ~= 0 then
					local var_279_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111067", "story_v_out_425111.awb") / 1000

					if var_279_14 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_14 + var_279_8
					end

					if var_279_10.prefab_name ~= "" and arg_276_1.actors_[var_279_10.prefab_name] ~= nil then
						local var_279_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_10.prefab_name].transform, "story_v_out_425111", "425111067", "story_v_out_425111.awb")

						arg_276_1:RecordAudio("425111067", var_279_15)
						arg_276_1:RecordAudio("425111067", var_279_15)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_425111", "425111067", "story_v_out_425111.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_425111", "425111067", "story_v_out_425111.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_16 = math.max(var_279_9, arg_276_1.talkMaxDuration)

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_16 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_8) / var_279_16

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_8 + var_279_16 and arg_276_1.time_ < var_279_8 + var_279_16 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play425111068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 425111068
		arg_280_1.duration_ = 6.73

		local var_280_0 = {
			zh = 4.533,
			ja = 6.733
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
				arg_280_0:Play425111069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["10159"]) and arg_280_1.var_.actorSpriteComps10159 == nil then
				arg_280_1.var_.actorSpriteComps10159 = arg_280_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_0 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["10159"]) then
				if arg_280_1.var_.actorSpriteComps10159 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								iter_283_1.color = Color.New(Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor1.r, (arg_280_1.time_ - 0) / var_283_0), Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor1.g, (arg_280_1.time_ - 0) / var_283_0), (Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor1.b, (arg_280_1.time_ - 0) / var_283_0)))
							else
								local var_283_1 = Mathf.Lerp(iter_283_1.color.r, 1, (arg_280_1.time_ - 0) / var_283_0)

								iter_283_1.color = Color.New(var_283_1, var_283_1, var_283_1)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["10159"]) and arg_280_1.var_.actorSpriteComps10159 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_283_3 then
						iter_283_3.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_280_1.var_.actorSpriteComps10159 = nil
			end

			local var_283_2 = arg_280_1.actors_["1037"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps1037 == nil then
				arg_280_1.var_.actorSpriteComps1037 = var_283_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_3 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.actorSpriteComps1037 then
					for iter_283_4, iter_283_5 in pairs(arg_280_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_283_5 then
							if arg_280_1.isInRecall_ then
								iter_283_5.color = Color.New(Mathf.Lerp(iter_283_5.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_3), Mathf.Lerp(iter_283_5.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_3), (Mathf.Lerp(iter_283_5.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_3)))
							else
								local var_283_4 = Mathf.Lerp(iter_283_5.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_3)

								iter_283_5.color = Color.New(var_283_4, var_283_4, var_283_4)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps1037 then
				for iter_283_6, iter_283_7 in pairs(arg_280_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_283_7 then
						iter_283_7.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps1037 = nil
			end

			local var_283_5 = arg_280_1.actors_["10159"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10159 = var_283_5.localPosition
				var_283_5.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10159", 4)

				for iter_283_8 = 0, var_283_5.childCount - 1 do
					local var_283_6 = var_283_5:GetChild(iter_283_8)

					if var_283_6.name == "split_1" or not string.find(var_283_6.name, "split") then
						var_283_6.gameObject:SetActive(true)
					else
						var_283_6.gameObject:SetActive(false)
					end
				end
			end

			local var_283_7 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				var_283_5.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10159, Vector3.New(390, -415, -230), (arg_280_1.time_ - 0) / var_283_7)
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				var_283_5.localPosition = Vector3.New(390, -415, -230)
			end

			local var_283_8 = 0
			local var_283_9 = 0.45

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_10 = arg_280_1:GetWordFromCfg(425111068)
				local var_283_11 = arg_280_1:FormatText(var_283_10.content)

				arg_280_1.text_.text = var_283_11

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 18 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 18)

				if (18 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 18)) > 0 and var_283_9 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_11
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111068", "story_v_out_425111.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111068", "story_v_out_425111.awb") / 1000

					if var_283_14 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_8
					end

					if var_283_10.prefab_name ~= "" and arg_280_1.actors_[var_283_10.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_10.prefab_name].transform, "story_v_out_425111", "425111068", "story_v_out_425111.awb")

						arg_280_1:RecordAudio("425111068", var_283_15)
						arg_280_1:RecordAudio("425111068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_425111", "425111068", "story_v_out_425111.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_425111", "425111068", "story_v_out_425111.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_16 and arg_280_1.time_ < var_283_8 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play425111069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 425111069
		arg_284_1.duration_ = 13.07

		local var_284_0 = {
			zh = 10.933,
			ja = 13.066
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
				arg_284_0:Play425111070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if arg_284_1.bgs_.I07a == nil then
				local var_287_0 = Object.Instantiate(arg_284_1.paintGo_)

				var_287_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_287_0.name = "I07a"
				var_287_0.transform.parent = arg_284_1.stage_.transform
				var_287_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_284_1.bgs_.I07a = var_287_0
			end

			if 2 < arg_284_1.time_ and arg_284_1.time_ <= 2 + arg_287_0 then
				local var_287_1 = arg_284_1.bgs_.I07a

				arg_284_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_287_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_287_2 = var_287_1:GetComponent("SpriteRenderer")

				if var_287_2 and var_287_2.sprite then
					local var_287_3 = 2 * (var_287_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_287_1.transform.localScale = Vector3.New(var_287_3 / var_287_2.sprite.bounds.size.y < var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x and var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x or var_287_3 / var_287_2.sprite.bounds.size.y, var_287_3 / var_287_2.sprite.bounds.size.y < var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x and var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x or var_287_3 / var_287_2.sprite.bounds.size.y, 0)
				end

				for iter_287_0, iter_287_1 in pairs(arg_284_1.bgs_) do
					if iter_287_0 ~= "I07a" then
						iter_287_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_287_4 = 4

			if 4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_4 + 0.3 and arg_284_1.time_ < var_287_4 + 0.3 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_5 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_6 = 2

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_6 then
				local var_287_7 = Color.New(0, 0, 0)

				var_287_7.a = Mathf.Lerp(0, 1, (arg_284_1.time_ - var_287_5) / var_287_6)
				arg_284_1.mask_.color = var_287_7
			end

			if arg_284_1.time_ >= var_287_5 + var_287_6 and arg_284_1.time_ < var_287_5 + var_287_6 + arg_287_0 then
				local var_287_8 = Color.New(0, 0, 0)

				var_287_8.a = 1
				arg_284_1.mask_.color = var_287_8
			end

			local var_287_9 = 2

			if 2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_10 = 2

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_10 then
				local var_287_11 = Color.New(0, 0, 0)

				var_287_11.a = Mathf.Lerp(1, 0, (arg_284_1.time_ - var_287_9) / var_287_10)
				arg_284_1.mask_.color = var_287_11
			end

			if arg_284_1.time_ >= var_287_9 + var_287_10 and arg_284_1.time_ < var_287_9 + var_287_10 + arg_287_0 then
				local var_287_12 = Color.New(0, 0, 0)

				arg_284_1.mask_.enabled = false
				var_287_12.a = 0
				arg_284_1.mask_.color = var_287_12
			end

			local var_287_13 = arg_284_1.actors_["10159"].transform

			if 1.96666666666667 < arg_284_1.time_ and arg_284_1.time_ <= 1.96666666666667 + arg_287_0 then
				arg_284_1.var_.moveOldPos10159 = var_287_13.localPosition
				var_287_13.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10159", 7)

				for iter_287_2 = 0, var_287_13.childCount - 1 do
					local var_287_14 = var_287_13:GetChild(iter_287_2)

					if var_287_14.name == "split_1" or not string.find(var_287_14.name, "split") then
						var_287_14.gameObject:SetActive(true)
					else
						var_287_14.gameObject:SetActive(false)
					end
				end
			end

			local var_287_15 = 0.001

			if 1.96666666666667 <= arg_284_1.time_ and arg_284_1.time_ < 1.96666666666667 + var_287_15 then
				var_287_13.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_284_1.time_ - 1.96666666666667) / var_287_15)
			end

			if arg_284_1.time_ >= 1.96666666666667 + var_287_15 and arg_284_1.time_ < 1.96666666666667 + var_287_15 + arg_287_0 then
				var_287_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_287_16 = arg_284_1.actors_["10159"].transform

			if 3.8 < arg_284_1.time_ and arg_284_1.time_ <= 3.8 + arg_287_0 then
				arg_284_1.var_.moveOldPos10159 = var_287_16.localPosition
				var_287_16.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10159", 3)

				for iter_287_3 = 0, var_287_16.childCount - 1 do
					local var_287_17 = var_287_16:GetChild(iter_287_3)

					if var_287_17.name == "split_1" or not string.find(var_287_17.name, "split") then
						var_287_17.gameObject:SetActive(true)
					else
						var_287_17.gameObject:SetActive(false)
					end
				end
			end

			local var_287_18 = 0.001

			if 3.8 <= arg_284_1.time_ and arg_284_1.time_ < 3.8 + var_287_18 then
				var_287_16.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_284_1.time_ - 3.8) / var_287_18)
			end

			if arg_284_1.time_ >= 3.8 + var_287_18 and arg_284_1.time_ < 3.8 + var_287_18 + arg_287_0 then
				var_287_16.localPosition = Vector3.New(0, -415, -230)
			end

			local var_287_19 = arg_284_1.actors_["1037"].transform

			if 1.966 < arg_284_1.time_ and arg_284_1.time_ <= 1.966 + arg_287_0 then
				arg_284_1.var_.moveOldPos1037 = var_287_19.localPosition
				var_287_19.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1037", 7)

				for iter_287_4 = 0, var_287_19.childCount - 1 do
					local var_287_20 = var_287_19:GetChild(iter_287_4)

					if var_287_20.name == "" or not string.find(var_287_20.name, "split") then
						var_287_20.gameObject:SetActive(true)
					else
						var_287_20.gameObject:SetActive(false)
					end
				end
			end

			local var_287_21 = 0.001

			if 1.966 <= arg_284_1.time_ and arg_284_1.time_ < 1.966 + var_287_21 then
				var_287_19.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_284_1.time_ - 1.966) / var_287_21)
			end

			if arg_284_1.time_ >= 1.966 + var_287_21 and arg_284_1.time_ < 1.966 + var_287_21 + arg_287_0 then
				var_287_19.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_287_22 = arg_284_1.actors_["10159"]

			if 3.8 < arg_284_1.time_ and arg_284_1.time_ <= 3.8 + arg_287_0 and not isNil(var_287_22) and arg_284_1.var_.actorSpriteComps10159 == nil then
				arg_284_1.var_.actorSpriteComps10159 = var_287_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_23 = 0.2

			if 3.8 <= arg_284_1.time_ and arg_284_1.time_ < 3.8 + var_287_23 and not isNil(var_287_22) then
				if arg_284_1.var_.actorSpriteComps10159 then
					for iter_287_5, iter_287_6 in pairs(arg_284_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_287_6 then
							if arg_284_1.isInRecall_ then
								iter_287_6.color = Color.New(Mathf.Lerp(iter_287_6.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 3.8) / var_287_23), Mathf.Lerp(iter_287_6.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 3.8) / var_287_23), (Mathf.Lerp(iter_287_6.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 3.8) / var_287_23)))
							else
								local var_287_24 = Mathf.Lerp(iter_287_6.color.r, 1, (arg_284_1.time_ - 3.8) / var_287_23)

								iter_287_6.color = Color.New(var_287_24, var_287_24, var_287_24)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 3.8 + var_287_23 and arg_284_1.time_ < 3.8 + var_287_23 + arg_287_0 and not isNil(var_287_22) and arg_284_1.var_.actorSpriteComps10159 then
				for iter_287_7, iter_287_8 in pairs(arg_284_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_287_8 then
						iter_287_8.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps10159 = nil
			end

			if 0.133333333333333 < arg_284_1.time_ and arg_284_1.time_ <= 0.133333333333333 + arg_287_0 then
				arg_284_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 1.7 < arg_284_1.time_ and arg_284_1.time_ <= 1.7 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_27 = 4
			local var_287_28 = 0.725

			if 4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_27 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_29 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_29:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_30 = arg_284_1:GetWordFromCfg(425111069)
				local var_287_31 = arg_284_1:FormatText(var_287_30.content)

				arg_284_1.text_.text = var_287_31

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_33 = 29 <= 0 and var_287_28 or var_287_28 * (utf8.len(var_287_31) / 29)

				if (29 <= 0 and var_287_28 or var_287_28 * (utf8.len(var_287_31) / 29)) > 0 and var_287_28 < var_287_33 then
					arg_284_1.talkMaxDuration = var_287_33
					var_287_27 = var_287_27 + 0.3

					if var_287_33 + var_287_27 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_33 + var_287_27
					end
				end

				arg_284_1.text_.text = var_287_31
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111069", "story_v_out_425111.awb") ~= 0 then
					local var_287_34 = manager.audio:GetVoiceLength("story_v_out_425111", "425111069", "story_v_out_425111.awb") / 1000

					if var_287_34 + var_287_27 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_34 + var_287_27
					end

					if var_287_30.prefab_name ~= "" and arg_284_1.actors_[var_287_30.prefab_name] ~= nil then
						local var_287_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_30.prefab_name].transform, "story_v_out_425111", "425111069", "story_v_out_425111.awb")

						arg_284_1:RecordAudio("425111069", var_287_35)
						arg_284_1:RecordAudio("425111069", var_287_35)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_425111", "425111069", "story_v_out_425111.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_425111", "425111069", "story_v_out_425111.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_36 = var_287_27 + 0.3
			local var_287_37 = math.max(var_287_28, arg_284_1.talkMaxDuration)

			if var_287_27 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_36 + var_287_37 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_36) / var_287_37

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_36 + var_287_37 and arg_284_1.time_ < var_287_36 + var_287_37 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play425111070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 425111070
		arg_290_1.duration_ = 14.3

		local var_290_0 = {
			zh = 8.9,
			ja = 14.3
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play425111071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 1.05

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:GetWordFromCfg(425111070)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 42 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 42)

				if (42 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 42)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111070", "story_v_out_425111.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111070", "story_v_out_425111.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_425111", "425111070", "story_v_out_425111.awb")

						arg_290_1:RecordAudio("425111070", var_293_6)
						arg_290_1:RecordAudio("425111070", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_425111", "425111070", "story_v_out_425111.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_425111", "425111070", "story_v_out_425111.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play425111071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 425111071
		arg_294_1.duration_ = 9.97

		local var_294_0 = {
			zh = 9.5,
			ja = 9.966
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play425111072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 1.1

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(425111071)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 44)

				if (44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 44)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111071", "story_v_out_425111.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111071", "story_v_out_425111.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_425111", "425111071", "story_v_out_425111.awb")

						arg_294_1:RecordAudio("425111071", var_297_6)
						arg_294_1:RecordAudio("425111071", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_425111", "425111071", "story_v_out_425111.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_425111", "425111071", "story_v_out_425111.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play425111072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 425111072
		arg_298_1.duration_ = 6.93

		local var_298_0 = {
			zh = 4.133,
			ja = 6.933
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play425111073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1037"]) and arg_298_1.var_.actorSpriteComps1037 == nil then
				arg_298_1.var_.actorSpriteComps1037 = arg_298_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1037"]) then
				if arg_298_1.var_.actorSpriteComps1037 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 1, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1037"]) and arg_298_1.var_.actorSpriteComps1037 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps1037 = nil
			end

			local var_301_2 = arg_298_1.actors_["10159"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps10159 == nil then
				arg_298_1.var_.actorSpriteComps10159 = var_301_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_3 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 and not isNil(var_301_2) then
				if arg_298_1.var_.actorSpriteComps10159 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								iter_301_5.color = Color.New(Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor2.r, (arg_298_1.time_ - 0) / var_301_3), Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor2.g, (arg_298_1.time_ - 0) / var_301_3), (Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor2.b, (arg_298_1.time_ - 0) / var_301_3)))
							else
								local var_301_4 = Mathf.Lerp(iter_301_5.color.r, 0.5, (arg_298_1.time_ - 0) / var_301_3)

								iter_301_5.color = Color.New(var_301_4, var_301_4, var_301_4)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps10159 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_301_7 then
						iter_301_7.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_298_1.var_.actorSpriteComps10159 = nil
			end

			local var_301_5 = arg_298_1.actors_["1037"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1037 = var_301_5.localPosition
				var_301_5.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1037", 4)

				for iter_301_8 = 0, var_301_5.childCount - 1 do
					local var_301_6 = var_301_5:GetChild(iter_301_8)

					if var_301_6.name == "split_1" or not string.find(var_301_6.name, "split") then
						var_301_6.gameObject:SetActive(true)
					else
						var_301_6.gameObject:SetActive(false)
					end
				end
			end

			local var_301_7 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				var_301_5.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_298_1.time_ - 0) / var_301_7)
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				var_301_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_301_8 = arg_298_1.actors_["10159"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos10159 = var_301_8.localPosition
				var_301_8.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("10159", 2)

				for iter_301_9 = 0, var_301_8.childCount - 1 do
					local var_301_9 = var_301_8:GetChild(iter_301_9)

					if var_301_9.name == "" or not string.find(var_301_9.name, "split") then
						var_301_9.gameObject:SetActive(true)
					else
						var_301_9.gameObject:SetActive(false)
					end
				end
			end

			local var_301_10 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_10 then
				var_301_8.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_298_1.time_ - 0) / var_301_10)
			end

			if arg_298_1.time_ >= 0 + var_301_10 and arg_298_1.time_ < 0 + var_301_10 + arg_301_0 then
				var_301_8.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_301_11 = 0
			local var_301_12 = 0.35

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_11 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_13 = arg_298_1:GetWordFromCfg(425111072)
				local var_301_14 = arg_298_1:FormatText(var_301_13.content)

				arg_298_1.text_.text = var_301_14

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_16 = 14 <= 0 and var_301_12 or var_301_12 * (utf8.len(var_301_14) / 14)

				if (14 <= 0 and var_301_12 or var_301_12 * (utf8.len(var_301_14) / 14)) > 0 and var_301_12 < var_301_16 then
					arg_298_1.talkMaxDuration = var_301_16

					if var_301_16 + var_301_11 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_16 + var_301_11
					end
				end

				arg_298_1.text_.text = var_301_14
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111072", "story_v_out_425111.awb") ~= 0 then
					local var_301_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111072", "story_v_out_425111.awb") / 1000

					if var_301_17 + var_301_11 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_17 + var_301_11
					end

					if var_301_13.prefab_name ~= "" and arg_298_1.actors_[var_301_13.prefab_name] ~= nil then
						local var_301_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_13.prefab_name].transform, "story_v_out_425111", "425111072", "story_v_out_425111.awb")

						arg_298_1:RecordAudio("425111072", var_301_18)
						arg_298_1:RecordAudio("425111072", var_301_18)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_425111", "425111072", "story_v_out_425111.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_425111", "425111072", "story_v_out_425111.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_19 = math.max(var_301_12, arg_298_1.talkMaxDuration)

			if var_301_11 <= arg_298_1.time_ and arg_298_1.time_ < var_301_11 + var_301_19 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_11) / var_301_19

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_11 + var_301_19 and arg_298_1.time_ < var_301_11 + var_301_19 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play425111073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 425111073
		arg_302_1.duration_ = 13.1

		local var_302_0 = {
			zh = 10.2,
			ja = 13.1
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play425111074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["10159"]) and arg_302_1.var_.actorSpriteComps10159 == nil then
				arg_302_1.var_.actorSpriteComps10159 = arg_302_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["10159"]) then
				if arg_302_1.var_.actorSpriteComps10159 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 1, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["10159"]) and arg_302_1.var_.actorSpriteComps10159 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps10159 = nil
			end

			local var_305_2 = arg_302_1.actors_["1037"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1037 == nil then
				arg_302_1.var_.actorSpriteComps1037 = var_305_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_3 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 and not isNil(var_305_2) then
				if arg_302_1.var_.actorSpriteComps1037 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								iter_305_5.color = Color.New(Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_3), Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_3), (Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_3)))
							else
								local var_305_4 = Mathf.Lerp(iter_305_5.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_3)

								iter_305_5.color = Color.New(var_305_4, var_305_4, var_305_4)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1037 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_305_7 then
						iter_305_7.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps1037 = nil
			end

			local var_305_5 = arg_302_1.actors_["10159"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos10159 = var_305_5.localPosition
				var_305_5.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("10159", 2)

				for iter_305_8 = 0, var_305_5.childCount - 1 do
					local var_305_6 = var_305_5:GetChild(iter_305_8)

					if var_305_6.name == "split_1" or not string.find(var_305_6.name, "split") then
						var_305_6.gameObject:SetActive(true)
					else
						var_305_6.gameObject:SetActive(false)
					end
				end
			end

			local var_305_7 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_302_1.time_ - 0) / var_305_7)
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_305_8 = 0
			local var_305_9 = 1.025

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(425111073)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_13 = 41 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 41)

				if (41 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 41)) > 0 and var_305_9 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111073", "story_v_out_425111.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111073", "story_v_out_425111.awb") / 1000

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end

					if var_305_10.prefab_name ~= "" and arg_302_1.actors_[var_305_10.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_10.prefab_name].transform, "story_v_out_425111", "425111073", "story_v_out_425111.awb")

						arg_302_1:RecordAudio("425111073", var_305_15)
						arg_302_1:RecordAudio("425111073", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_425111", "425111073", "story_v_out_425111.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_425111", "425111073", "story_v_out_425111.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_16 and arg_302_1.time_ < var_305_8 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play425111074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 425111074
		arg_306_1.duration_ = 7.57

		local var_306_0 = {
			zh = 3.633,
			ja = 7.566
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play425111075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["10156"]) and arg_306_1.var_.actorSpriteComps10156 == nil then
				arg_306_1.var_.actorSpriteComps10156 = arg_306_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["10156"]) then
				if arg_306_1.var_.actorSpriteComps10156 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["10156"]) and arg_306_1.var_.actorSpriteComps10156 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps10156 = nil
			end

			local var_309_2 = arg_306_1.actors_["10159"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10159 == nil then
				arg_306_1.var_.actorSpriteComps10159 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps10159 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								iter_309_5.color = Color.New(Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_5.color.r, 0.5, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_5.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10159 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_309_7 then
						iter_309_7.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_306_1.var_.actorSpriteComps10159 = nil
			end

			local var_309_5 = arg_306_1.actors_["10156"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10156 = var_309_5.localPosition
				var_309_5.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10156", 4)

				for iter_309_8 = 0, var_309_5.childCount - 1 do
					local var_309_6 = var_309_5:GetChild(iter_309_8)

					if var_309_6.name == "split_3" or not string.find(var_309_6.name, "split") then
						var_309_6.gameObject:SetActive(true)
					else
						var_309_6.gameObject:SetActive(false)
					end
				end
			end

			local var_309_7 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				var_309_5.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10156, Vector3.New(390, -390, -210), (arg_306_1.time_ - 0) / var_309_7)
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				var_309_5.localPosition = Vector3.New(390, -390, -210)
			end

			local var_309_8 = arg_306_1.actors_["1037"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1037 = var_309_8.localPosition
				var_309_8.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1037", 7)

				for iter_309_9 = 0, var_309_8.childCount - 1 do
					local var_309_9 = var_309_8:GetChild(iter_309_9)

					if var_309_9.name == "" or not string.find(var_309_9.name, "split") then
						var_309_9.gameObject:SetActive(true)
					else
						var_309_9.gameObject:SetActive(false)
					end
				end
			end

			local var_309_10 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_10 then
				var_309_8.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_306_1.time_ - 0) / var_309_10)
			end

			if arg_306_1.time_ >= 0 + var_309_10 and arg_306_1.time_ < 0 + var_309_10 + arg_309_0 then
				var_309_8.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_309_11 = 0
			local var_309_12 = 0.375

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_11 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_13 = arg_306_1:GetWordFromCfg(425111074)
				local var_309_14 = arg_306_1:FormatText(var_309_13.content)

				arg_306_1.text_.text = var_309_14

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_16 = 15 <= 0 and var_309_12 or var_309_12 * (utf8.len(var_309_14) / 15)

				if (15 <= 0 and var_309_12 or var_309_12 * (utf8.len(var_309_14) / 15)) > 0 and var_309_12 < var_309_16 then
					arg_306_1.talkMaxDuration = var_309_16

					if var_309_16 + var_309_11 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_16 + var_309_11
					end
				end

				arg_306_1.text_.text = var_309_14
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111074", "story_v_out_425111.awb") ~= 0 then
					local var_309_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111074", "story_v_out_425111.awb") / 1000

					if var_309_17 + var_309_11 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_17 + var_309_11
					end

					if var_309_13.prefab_name ~= "" and arg_306_1.actors_[var_309_13.prefab_name] ~= nil then
						local var_309_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_13.prefab_name].transform, "story_v_out_425111", "425111074", "story_v_out_425111.awb")

						arg_306_1:RecordAudio("425111074", var_309_18)
						arg_306_1:RecordAudio("425111074", var_309_18)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_425111", "425111074", "story_v_out_425111.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_425111", "425111074", "story_v_out_425111.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_19 = math.max(var_309_12, arg_306_1.talkMaxDuration)

			if var_309_11 <= arg_306_1.time_ and arg_306_1.time_ < var_309_11 + var_309_19 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_11) / var_309_19

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_11 + var_309_19 and arg_306_1.time_ < var_309_11 + var_309_19 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play425111075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 425111075
		arg_310_1.duration_ = 7.07

		local var_310_0 = {
			zh = 5.833,
			ja = 7.066
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play425111076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10159"]) and arg_310_1.var_.actorSpriteComps10159 == nil then
				arg_310_1.var_.actorSpriteComps10159 = arg_310_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10159"]) then
				if arg_310_1.var_.actorSpriteComps10159 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 1, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10159"]) and arg_310_1.var_.actorSpriteComps10159 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps10159 = nil
			end

			local var_313_2 = arg_310_1.actors_["10156"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10156 == nil then
				arg_310_1.var_.actorSpriteComps10156 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps10156 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								iter_313_5.color = Color.New(Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_5.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_5.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10156 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_313_7 then
						iter_313_7.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps10156 = nil
			end

			local var_313_5 = arg_310_1.actors_["10159"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10159 = var_313_5.localPosition
				var_313_5.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10159", 2)

				for iter_313_8 = 0, var_313_5.childCount - 1 do
					local var_313_6 = var_313_5:GetChild(iter_313_8)

					if var_313_6.name == "split_6" then
						var_313_6:SetAsLastSibling()
						var_313_6.gameObject:SetActive(true)

						arg_310_1.var_.actorSpriteSplit10159 = var_313_6.gameObject:GetComponent(typeof(Image))

						arg_310_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_313_7 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				var_313_5.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_310_1.time_ - 0) / var_313_7)

				if arg_310_1.var_.actorSpriteSplit10159 ~= nil then
					arg_310_1.var_.actorSpriteSplit10159:SetAlpha((arg_310_1.time_ - 0) / var_313_7)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				var_313_5.localPosition = Vector3.New(-390, -415, -230)

				if arg_310_1.var_.actorSpriteSplit10159 ~= nil then
					arg_310_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_313_8 = 0
			local var_313_9 = 0.625

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_10 = arg_310_1:GetWordFromCfg(425111075)
				local var_313_11 = arg_310_1:FormatText(var_313_10.content)

				arg_310_1.text_.text = var_313_11

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 25 <= 0 and var_313_9 or var_313_9 * (utf8.len(var_313_11) / 25)

				if (25 <= 0 and var_313_9 or var_313_9 * (utf8.len(var_313_11) / 25)) > 0 and var_313_9 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_8
					end
				end

				arg_310_1.text_.text = var_313_11
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111075", "story_v_out_425111.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111075", "story_v_out_425111.awb") / 1000

					if var_313_14 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_8
					end

					if var_313_10.prefab_name ~= "" and arg_310_1.actors_[var_313_10.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_10.prefab_name].transform, "story_v_out_425111", "425111075", "story_v_out_425111.awb")

						arg_310_1:RecordAudio("425111075", var_313_15)
						arg_310_1:RecordAudio("425111075", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_425111", "425111075", "story_v_out_425111.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_425111", "425111075", "story_v_out_425111.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_9, arg_310_1.talkMaxDuration)

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_8) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_8 + var_313_16 and arg_310_1.time_ < var_313_8 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play425111076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 425111076
		arg_314_1.duration_ = 9.07

		local var_314_0 = {
			zh = 7.433,
			ja = 9.066
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play425111077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.9

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(425111076)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 36 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 36)

				if (36 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 36)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111076", "story_v_out_425111.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111076", "story_v_out_425111.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_425111", "425111076", "story_v_out_425111.awb")

						arg_314_1:RecordAudio("425111076", var_317_6)
						arg_314_1:RecordAudio("425111076", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_425111", "425111076", "story_v_out_425111.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_425111", "425111076", "story_v_out_425111.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play425111077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 425111077
		arg_318_1.duration_ = 10.87

		local var_318_0 = {
			zh = 10.6,
			ja = 10.866
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play425111078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.05

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:GetWordFromCfg(425111077)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 42 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 42)

				if (42 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 42)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111077", "story_v_out_425111.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111077", "story_v_out_425111.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_425111", "425111077", "story_v_out_425111.awb")

						arg_318_1:RecordAudio("425111077", var_321_6)
						arg_318_1:RecordAudio("425111077", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_425111", "425111077", "story_v_out_425111.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_425111", "425111077", "story_v_out_425111.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play425111078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 425111078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play425111079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10159"]) and arg_322_1.var_.actorSpriteComps10159 == nil then
				arg_322_1.var_.actorSpriteComps10159 = arg_322_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10159"]) then
				if arg_322_1.var_.actorSpriteComps10159 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10159"]) and arg_322_1.var_.actorSpriteComps10159 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps10159 = nil
			end

			local var_325_2 = 0
			local var_325_3 = 0.425

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_4 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(425111078).content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 17 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 17)

				if (17 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 17)) > 0 and var_325_3 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_7 and arg_322_1.time_ < var_325_2 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play425111079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 425111079
		arg_326_1.duration_ = 18.33

		local var_326_0 = {
			zh = 14.633,
			ja = 18.333
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play425111080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10159"]) and arg_326_1.var_.actorSpriteComps10159 == nil then
				arg_326_1.var_.actorSpriteComps10159 = arg_326_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10159"]) then
				if arg_326_1.var_.actorSpriteComps10159 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 1, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10159"]) and arg_326_1.var_.actorSpriteComps10159 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_326_1.var_.actorSpriteComps10159 = nil
			end

			local var_329_2 = arg_326_1.actors_["10159"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10159 = var_329_2.localPosition
				var_329_2.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("10159", 2)

				for iter_329_4 = 0, var_329_2.childCount - 1 do
					local var_329_3 = var_329_2:GetChild(iter_329_4)

					if var_329_3.name == "split_6" or not string.find(var_329_3.name, "split") then
						var_329_3.gameObject:SetActive(true)
					else
						var_329_3.gameObject:SetActive(false)
					end
				end
			end

			local var_329_4 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				var_329_2.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_326_1.time_ - 0) / var_329_4)
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				var_329_2.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_329_5 = 0
			local var_329_6 = 1.4

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_7 = arg_326_1:GetWordFromCfg(425111079)
				local var_329_8 = arg_326_1:FormatText(var_329_7.content)

				arg_326_1.text_.text = var_329_8

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_10 = 56 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 56)

				if (56 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 56)) > 0 and var_329_6 < var_329_10 then
					arg_326_1.talkMaxDuration = var_329_10

					if var_329_10 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_5
					end
				end

				arg_326_1.text_.text = var_329_8
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111079", "story_v_out_425111.awb") ~= 0 then
					local var_329_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111079", "story_v_out_425111.awb") / 1000

					if var_329_11 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_5
					end

					if var_329_7.prefab_name ~= "" and arg_326_1.actors_[var_329_7.prefab_name] ~= nil then
						local var_329_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_7.prefab_name].transform, "story_v_out_425111", "425111079", "story_v_out_425111.awb")

						arg_326_1:RecordAudio("425111079", var_329_12)
						arg_326_1:RecordAudio("425111079", var_329_12)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_425111", "425111079", "story_v_out_425111.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_425111", "425111079", "story_v_out_425111.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_6, arg_326_1.talkMaxDuration)

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_5) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_5 + var_329_13 and arg_326_1.time_ < var_329_5 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play425111080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 425111080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play425111081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10159"]) and arg_330_1.var_.actorSpriteComps10159 == nil then
				arg_330_1.var_.actorSpriteComps10159 = arg_330_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10159"]) then
				if arg_330_1.var_.actorSpriteComps10159 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor2.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor2.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor2.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 0.5, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10159"]) and arg_330_1.var_.actorSpriteComps10159 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_330_1.var_.actorSpriteComps10159 = nil
			end

			local var_333_2 = 0
			local var_333_3 = 0.475

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_2 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_4 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(425111080).content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_6 = 19 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_4) / 19)

				if (19 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_4) / 19)) > 0 and var_333_3 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_2
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_3, arg_330_1.talkMaxDuration)

			if var_333_2 <= arg_330_1.time_ and arg_330_1.time_ < var_333_2 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_2) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_2 + var_333_7 and arg_330_1.time_ < var_333_2 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play425111081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 425111081
		arg_334_1.duration_ = 10.67

		local var_334_0 = {
			zh = 8.433,
			ja = 10.666
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play425111082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10156"]) and arg_334_1.var_.actorSpriteComps10156 == nil then
				arg_334_1.var_.actorSpriteComps10156 = arg_334_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10156"]) then
				if arg_334_1.var_.actorSpriteComps10156 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 1, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10156"]) and arg_334_1.var_.actorSpriteComps10156 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps10156 = nil
			end

			local var_337_2 = 0
			local var_337_3 = 0.95

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:GetWordFromCfg(425111081)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_7 = 38 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 38)

				if (38 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 38)) > 0 and var_337_3 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111081", "story_v_out_425111.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_425111", "425111081", "story_v_out_425111.awb") / 1000

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end

					if var_337_4.prefab_name ~= "" and arg_334_1.actors_[var_337_4.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_4.prefab_name].transform, "story_v_out_425111", "425111081", "story_v_out_425111.awb")

						arg_334_1:RecordAudio("425111081", var_337_9)
						arg_334_1:RecordAudio("425111081", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_425111", "425111081", "story_v_out_425111.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_425111", "425111081", "story_v_out_425111.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_10 and arg_334_1.time_ < var_337_2 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play425111082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 425111082
		arg_338_1.duration_ = 8.7

		local var_338_0 = {
			zh = 6.3,
			ja = 8.7
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play425111083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10159"]) and arg_338_1.var_.actorSpriteComps10159 == nil then
				arg_338_1.var_.actorSpriteComps10159 = arg_338_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10159"]) then
				if arg_338_1.var_.actorSpriteComps10159 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10159"]) and arg_338_1.var_.actorSpriteComps10159 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps10159 = nil
			end

			local var_341_2 = arg_338_1.actors_["10156"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.actorSpriteComps10156 == nil then
				arg_338_1.var_.actorSpriteComps10156 = var_341_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_3 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_3 and not isNil(var_341_2) then
				if arg_338_1.var_.actorSpriteComps10156 then
					for iter_341_4, iter_341_5 in pairs(arg_338_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_341_5 then
							if arg_338_1.isInRecall_ then
								iter_341_5.color = Color.New(Mathf.Lerp(iter_341_5.color.r, arg_338_1.hightColor2.r, (arg_338_1.time_ - 0) / var_341_3), Mathf.Lerp(iter_341_5.color.g, arg_338_1.hightColor2.g, (arg_338_1.time_ - 0) / var_341_3), (Mathf.Lerp(iter_341_5.color.b, arg_338_1.hightColor2.b, (arg_338_1.time_ - 0) / var_341_3)))
							else
								local var_341_4 = Mathf.Lerp(iter_341_5.color.r, 0.5, (arg_338_1.time_ - 0) / var_341_3)

								iter_341_5.color = Color.New(var_341_4, var_341_4, var_341_4)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_3 and arg_338_1.time_ < 0 + var_341_3 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.actorSpriteComps10156 then
				for iter_341_6, iter_341_7 in pairs(arg_338_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_341_7 then
						iter_341_7.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_338_1.var_.actorSpriteComps10156 = nil
			end

			local var_341_5 = arg_338_1.actors_["10159"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10159 = var_341_5.localPosition
				var_341_5.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10159", 2)

				for iter_341_8 = 0, var_341_5.childCount - 1 do
					local var_341_6 = var_341_5:GetChild(iter_341_8)

					if var_341_6.name == "" then
						var_341_6:SetAsLastSibling()
						var_341_6.gameObject:SetActive(true)

						arg_338_1.var_.actorSpriteSplit10159 = var_341_6.gameObject:GetComponent(typeof(Image))

						arg_338_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_341_7 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				var_341_5.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_338_1.time_ - 0) / var_341_7)

				if arg_338_1.var_.actorSpriteSplit10159 ~= nil then
					arg_338_1.var_.actorSpriteSplit10159:SetAlpha((arg_338_1.time_ - 0) / var_341_7)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				var_341_5.localPosition = Vector3.New(-390, -415, -230)

				if arg_338_1.var_.actorSpriteSplit10159 ~= nil then
					arg_338_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_341_8 = 0
			local var_341_9 = 0.75

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_8 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_10 = arg_338_1:GetWordFromCfg(425111082)
				local var_341_11 = arg_338_1:FormatText(var_341_10.content)

				arg_338_1.text_.text = var_341_11

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_13 = 30 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 30)

				if (30 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 30)) > 0 and var_341_9 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_8
					end
				end

				arg_338_1.text_.text = var_341_11
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111082", "story_v_out_425111.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111082", "story_v_out_425111.awb") / 1000

					if var_341_14 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_8
					end

					if var_341_10.prefab_name ~= "" and arg_338_1.actors_[var_341_10.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_10.prefab_name].transform, "story_v_out_425111", "425111082", "story_v_out_425111.awb")

						arg_338_1:RecordAudio("425111082", var_341_15)
						arg_338_1:RecordAudio("425111082", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_425111", "425111082", "story_v_out_425111.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_425111", "425111082", "story_v_out_425111.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_9, arg_338_1.talkMaxDuration)

			if var_341_8 <= arg_338_1.time_ and arg_338_1.time_ < var_341_8 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_8) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_8 + var_341_16 and arg_338_1.time_ < var_341_8 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play425111083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 425111083
		arg_342_1.duration_ = 7.97

		local var_342_0 = {
			zh = 7.966,
			ja = 6.1
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play425111084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.725

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(425111083)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 29 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 29)

				if (29 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 29)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111083", "story_v_out_425111.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111083", "story_v_out_425111.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_425111", "425111083", "story_v_out_425111.awb")

						arg_342_1:RecordAudio("425111083", var_345_6)
						arg_342_1:RecordAudio("425111083", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_425111", "425111083", "story_v_out_425111.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_425111", "425111083", "story_v_out_425111.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play425111084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 425111084
		arg_346_1.duration_ = 5.53

		local var_346_0 = {
			zh = 3.6,
			ja = 5.533
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play425111085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1037"]) and arg_346_1.var_.actorSpriteComps1037 == nil then
				arg_346_1.var_.actorSpriteComps1037 = arg_346_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1037"]) then
				if arg_346_1.var_.actorSpriteComps1037 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1037"]) and arg_346_1.var_.actorSpriteComps1037 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1037 = nil
			end

			local var_349_2 = arg_346_1.actors_["10159"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps10159 == nil then
				arg_346_1.var_.actorSpriteComps10159 = var_349_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_3 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 and not isNil(var_349_2) then
				if arg_346_1.var_.actorSpriteComps10159 then
					for iter_349_4, iter_349_5 in pairs(arg_346_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_349_5 then
							if arg_346_1.isInRecall_ then
								iter_349_5.color = Color.New(Mathf.Lerp(iter_349_5.color.r, arg_346_1.hightColor2.r, (arg_346_1.time_ - 0) / var_349_3), Mathf.Lerp(iter_349_5.color.g, arg_346_1.hightColor2.g, (arg_346_1.time_ - 0) / var_349_3), (Mathf.Lerp(iter_349_5.color.b, arg_346_1.hightColor2.b, (arg_346_1.time_ - 0) / var_349_3)))
							else
								local var_349_4 = Mathf.Lerp(iter_349_5.color.r, 0.5, (arg_346_1.time_ - 0) / var_349_3)

								iter_349_5.color = Color.New(var_349_4, var_349_4, var_349_4)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps10159 then
				for iter_349_6, iter_349_7 in pairs(arg_346_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_349_7 then
						iter_349_7.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_346_1.var_.actorSpriteComps10159 = nil
			end

			local var_349_5 = arg_346_1.actors_["1037"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1037 = var_349_5.localPosition
				var_349_5.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1037", 2)

				for iter_349_8 = 0, var_349_5.childCount - 1 do
					local var_349_6 = var_349_5:GetChild(iter_349_8)

					if var_349_6.name == "split_5" or not string.find(var_349_6.name, "split") then
						var_349_6.gameObject:SetActive(true)
					else
						var_349_6.gameObject:SetActive(false)
					end
				end
			end

			local var_349_7 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				var_349_5.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_346_1.time_ - 0) / var_349_7)
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				var_349_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_349_8 = arg_346_1.actors_["10159"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10159 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10159", 7)

				for iter_349_9 = 0, var_349_8.childCount - 1 do
					local var_349_9 = var_349_8:GetChild(iter_349_9)

					if var_349_9.name == "" or not string.find(var_349_9.name, "split") then
						var_349_9.gameObject:SetActive(true)
					else
						var_349_9.gameObject:SetActive(false)
					end
				end
			end

			local var_349_10 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_10 then
				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_346_1.time_ - 0) / var_349_10)
			end

			if arg_346_1.time_ >= 0 + var_349_10 and arg_346_1.time_ < 0 + var_349_10 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_11 = 0
			local var_349_12 = 0.475

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_11 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_13 = arg_346_1:GetWordFromCfg(425111084)
				local var_349_14 = arg_346_1:FormatText(var_349_13.content)

				arg_346_1.text_.text = var_349_14

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_16 = 19 <= 0 and var_349_12 or var_349_12 * (utf8.len(var_349_14) / 19)

				if (19 <= 0 and var_349_12 or var_349_12 * (utf8.len(var_349_14) / 19)) > 0 and var_349_12 < var_349_16 then
					arg_346_1.talkMaxDuration = var_349_16

					if var_349_16 + var_349_11 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_16 + var_349_11
					end
				end

				arg_346_1.text_.text = var_349_14
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111084", "story_v_out_425111.awb") ~= 0 then
					local var_349_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111084", "story_v_out_425111.awb") / 1000

					if var_349_17 + var_349_11 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_17 + var_349_11
					end

					if var_349_13.prefab_name ~= "" and arg_346_1.actors_[var_349_13.prefab_name] ~= nil then
						local var_349_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_13.prefab_name].transform, "story_v_out_425111", "425111084", "story_v_out_425111.awb")

						arg_346_1:RecordAudio("425111084", var_349_18)
						arg_346_1:RecordAudio("425111084", var_349_18)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_425111", "425111084", "story_v_out_425111.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_425111", "425111084", "story_v_out_425111.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_19 = math.max(var_349_12, arg_346_1.talkMaxDuration)

			if var_349_11 <= arg_346_1.time_ and arg_346_1.time_ < var_349_11 + var_349_19 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_11) / var_349_19

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_11 + var_349_19 and arg_346_1.time_ < var_349_11 + var_349_19 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play425111085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 425111085
		arg_350_1.duration_ = 6.57

		local var_350_0 = {
			zh = 6.566,
			ja = 5.433
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
				arg_350_0:Play425111086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10156"]) and arg_350_1.var_.actorSpriteComps10156 == nil then
				arg_350_1.var_.actorSpriteComps10156 = arg_350_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10156"]) then
				if arg_350_1.var_.actorSpriteComps10156 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10156"]) and arg_350_1.var_.actorSpriteComps10156 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps10156 = nil
			end

			local var_353_2 = arg_350_1.actors_["1037"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1037 == nil then
				arg_350_1.var_.actorSpriteComps1037 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps1037 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								iter_353_5.color = Color.New(Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_5.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_5.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1037 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_353_7 then
						iter_353_7.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps1037 = nil
			end

			local var_353_5 = arg_350_1.actors_["10156"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10156 = var_353_5.localPosition
				var_353_5.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10156", 4)

				for iter_353_8 = 0, var_353_5.childCount - 1 do
					local var_353_6 = var_353_5:GetChild(iter_353_8)

					if var_353_6.name == "split_2" then
						var_353_6:SetAsLastSibling()
						var_353_6.gameObject:SetActive(true)

						arg_350_1.var_.actorSpriteSplit10156 = var_353_6.gameObject:GetComponent(typeof(Image))

						arg_350_1.var_.actorSpriteSplit10156:SetAlpha(0)
					end
				end
			end

			local var_353_7 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				var_353_5.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10156, Vector3.New(390, -390, -210), (arg_350_1.time_ - 0) / var_353_7)

				if arg_350_1.var_.actorSpriteSplit10156 ~= nil then
					arg_350_1.var_.actorSpriteSplit10156:SetAlpha((arg_350_1.time_ - 0) / var_353_7)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				var_353_5.localPosition = Vector3.New(390, -390, -210)

				if arg_350_1.var_.actorSpriteSplit10156 ~= nil then
					arg_350_1.var_.actorSpriteSplit10156:SetAlpha(1)
				end
			end

			local var_353_8 = 0
			local var_353_9 = 0.65

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_10 = arg_350_1:GetWordFromCfg(425111085)
				local var_353_11 = arg_350_1:FormatText(var_353_10.content)

				arg_350_1.text_.text = var_353_11

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_13 = 26 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 26)

				if (26 <= 0 and var_353_9 or var_353_9 * (utf8.len(var_353_11) / 26)) > 0 and var_353_9 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_8
					end
				end

				arg_350_1.text_.text = var_353_11
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111085", "story_v_out_425111.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111085", "story_v_out_425111.awb") / 1000

					if var_353_14 + var_353_8 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_8
					end

					if var_353_10.prefab_name ~= "" and arg_350_1.actors_[var_353_10.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_10.prefab_name].transform, "story_v_out_425111", "425111085", "story_v_out_425111.awb")

						arg_350_1:RecordAudio("425111085", var_353_15)
						arg_350_1:RecordAudio("425111085", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_425111", "425111085", "story_v_out_425111.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_425111", "425111085", "story_v_out_425111.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_9, arg_350_1.talkMaxDuration)

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_8) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_8 + var_353_16 and arg_350_1.time_ < var_353_8 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play425111086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 425111086
		arg_354_1.duration_ = 9.87

		local var_354_0 = {
			zh = 9.666,
			ja = 9.866
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
				arg_354_0:Play425111087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10156 = arg_354_1.actors_["10156"].transform.localPosition
				arg_354_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10156", 4)

				for iter_357_0 = 0, arg_354_1.actors_["10156"].transform.childCount - 1 do
					local var_357_0 = arg_354_1.actors_["10156"].transform:GetChild(iter_357_0)

					if var_357_0.name == "" or not string.find(var_357_0.name, "split") then
						var_357_0.gameObject:SetActive(true)
					else
						var_357_0.gameObject:SetActive(false)
					end
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10156, Vector3.New(390, -390, -210), (arg_354_1.time_ - 0) / var_357_1)
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["10156"].transform.localPosition = Vector3.New(390, -390, -210)
			end

			local var_357_2 = 0
			local var_357_3 = 1.125

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(425111086)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 45 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 45)

				if (45 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 45)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111086", "story_v_out_425111.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_425111", "425111086", "story_v_out_425111.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_out_425111", "425111086", "story_v_out_425111.awb")

						arg_354_1:RecordAudio("425111086", var_357_9)
						arg_354_1:RecordAudio("425111086", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_425111", "425111086", "story_v_out_425111.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_425111", "425111086", "story_v_out_425111.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
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
	Play425111087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 425111087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play425111088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10156 = arg_358_1.actors_["10156"].transform.localPosition
				arg_358_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10156", 7)

				for iter_361_0 = 0, arg_358_1.actors_["10156"].transform.childCount - 1 do
					local var_361_0 = arg_358_1.actors_["10156"].transform:GetChild(iter_361_0)

					if var_361_0.name == "" or not string.find(var_361_0.name, "split") then
						var_361_0.gameObject:SetActive(true)
					else
						var_361_0.gameObject:SetActive(false)
					end
				end
			end

			local var_361_1 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_1 then
				arg_358_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_358_1.time_ - 0) / var_361_1)
			end

			if arg_358_1.time_ >= 0 + var_361_1 and arg_358_1.time_ < 0 + var_361_1 + arg_361_0 then
				arg_358_1.actors_["10156"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_361_2 = arg_358_1.actors_["1037"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1037 = var_361_2.localPosition
				var_361_2.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1037", 7)

				for iter_361_1 = 0, var_361_2.childCount - 1 do
					local var_361_3 = var_361_2:GetChild(iter_361_1)

					if var_361_3.name == "" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_2.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_358_1.time_ - 0) / var_361_4)
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.133333333333333 < arg_358_1.time_ and arg_358_1.time_ <= 0.133333333333333 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_147", "se_story_147_synth", "")
			end

			local var_361_6 = 0
			local var_361_7 = 1.15

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_8 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(425111087).content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_10 = 46 <= 0 and var_361_7 or var_361_7 * (utf8.len(var_361_8) / 46)

				if (46 <= 0 and var_361_7 or var_361_7 * (utf8.len(var_361_8) / 46)) > 0 and var_361_7 < var_361_10 then
					arg_358_1.talkMaxDuration = var_361_10

					if var_361_10 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_8
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_11 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_11 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_11

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_11 and arg_358_1.time_ < var_361_6 + var_361_11 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
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
	Play425111088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 425111088
		arg_362_1.duration_ = 9.87

		local var_362_0 = {
			zh = 8.2,
			ja = 9.866
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play425111089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10159"]) and arg_362_1.var_.actorSpriteComps10159 == nil then
				arg_362_1.var_.actorSpriteComps10159 = arg_362_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10159"]) then
				if arg_362_1.var_.actorSpriteComps10159 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10159"]) and arg_362_1.var_.actorSpriteComps10159 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps10159 = nil
			end

			local var_365_2 = arg_362_1.actors_["10159"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos10159 = var_365_2.localPosition
				var_365_2.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10159", 3)

				for iter_365_4 = 0, var_365_2.childCount - 1 do
					local var_365_3 = var_365_2:GetChild(iter_365_4)

					if var_365_3.name == "split_1" or not string.find(var_365_3.name, "split") then
						var_365_3.gameObject:SetActive(true)
					else
						var_365_3.gameObject:SetActive(false)
					end
				end
			end

			local var_365_4 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				var_365_2.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_362_1.time_ - 0) / var_365_4)
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				var_365_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_365_5 = 0
			local var_365_6 = 0.775

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_7 = arg_362_1:GetWordFromCfg(425111088)
				local var_365_8 = arg_362_1:FormatText(var_365_7.content)

				arg_362_1.text_.text = var_365_8

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 31 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 31)

				if (31 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 31)) > 0 and var_365_6 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_8
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111088", "story_v_out_425111.awb") ~= 0 then
					local var_365_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111088", "story_v_out_425111.awb") / 1000

					if var_365_11 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_5
					end

					if var_365_7.prefab_name ~= "" and arg_362_1.actors_[var_365_7.prefab_name] ~= nil then
						local var_365_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_7.prefab_name].transform, "story_v_out_425111", "425111088", "story_v_out_425111.awb")

						arg_362_1:RecordAudio("425111088", var_365_12)
						arg_362_1:RecordAudio("425111088", var_365_12)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_425111", "425111088", "story_v_out_425111.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_425111", "425111088", "story_v_out_425111.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_13 and arg_362_1.time_ < var_365_5 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
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
	Play425111089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 425111089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play425111090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10159"]) and arg_366_1.var_.actorSpriteComps10159 == nil then
				arg_366_1.var_.actorSpriteComps10159 = arg_366_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10159"]) then
				if arg_366_1.var_.actorSpriteComps10159 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10159"]) and arg_366_1.var_.actorSpriteComps10159 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps10159 = nil
			end

			local var_369_2 = 0
			local var_369_3 = 0.275

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_4 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(425111089).content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_6 = 11 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_4) / 11)

				if (11 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_4) / 11)) > 0 and var_369_3 < var_369_6 then
					arg_366_1.talkMaxDuration = var_369_6

					if var_369_6 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_7 and arg_366_1.time_ < var_369_2 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play425111090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 425111090
		arg_370_1.duration_ = 10.87

		local var_370_0 = {
			zh = 8.4,
			ja = 10.866
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play425111091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10159"]) and arg_370_1.var_.actorSpriteComps10159 == nil then
				arg_370_1.var_.actorSpriteComps10159 = arg_370_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10159"]) then
				if arg_370_1.var_.actorSpriteComps10159 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10159"]) and arg_370_1.var_.actorSpriteComps10159 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps10159 = nil
			end

			local var_373_2 = arg_370_1.actors_["10159"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos10159 = var_373_2.localPosition
				var_373_2.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10159", 3)

				for iter_373_4 = 0, var_373_2.childCount - 1 do
					local var_373_3 = var_373_2:GetChild(iter_373_4)

					if var_373_3.name == "" or not string.find(var_373_3.name, "split") then
						var_373_3.gameObject:SetActive(true)
					else
						var_373_3.gameObject:SetActive(false)
					end
				end
			end

			local var_373_4 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				var_373_2.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_370_1.time_ - 0) / var_373_4)
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				var_373_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_373_5 = 0
			local var_373_6 = 0.825

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_7 = arg_370_1:GetWordFromCfg(425111090)
				local var_373_8 = arg_370_1:FormatText(var_373_7.content)

				arg_370_1.text_.text = var_373_8

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_10 = 33 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 33)

				if (33 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 33)) > 0 and var_373_6 < var_373_10 then
					arg_370_1.talkMaxDuration = var_373_10

					if var_373_10 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_5
					end
				end

				arg_370_1.text_.text = var_373_8
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111090", "story_v_out_425111.awb") ~= 0 then
					local var_373_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111090", "story_v_out_425111.awb") / 1000

					if var_373_11 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_11 + var_373_5
					end

					if var_373_7.prefab_name ~= "" and arg_370_1.actors_[var_373_7.prefab_name] ~= nil then
						local var_373_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_7.prefab_name].transform, "story_v_out_425111", "425111090", "story_v_out_425111.awb")

						arg_370_1:RecordAudio("425111090", var_373_12)
						arg_370_1:RecordAudio("425111090", var_373_12)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_425111", "425111090", "story_v_out_425111.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_425111", "425111090", "story_v_out_425111.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_13 = math.max(var_373_6, arg_370_1.talkMaxDuration)

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_13 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_5) / var_373_13

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_5 + var_373_13 and arg_370_1.time_ < var_373_5 + var_373_13 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play425111091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 425111091
		arg_374_1.duration_ = 13

		local var_374_0 = {
			zh = 9.7,
			ja = 13
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play425111092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 1.15

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(425111091)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 46 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 46)

				if (46 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 46)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111091", "story_v_out_425111.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111091", "story_v_out_425111.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_425111", "425111091", "story_v_out_425111.awb")

						arg_374_1:RecordAudio("425111091", var_377_6)
						arg_374_1:RecordAudio("425111091", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_425111", "425111091", "story_v_out_425111.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_425111", "425111091", "story_v_out_425111.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play425111092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 425111092
		arg_378_1.duration_ = 5.03

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play425111093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos10159 = arg_378_1.actors_["10159"].transform.localPosition
				arg_378_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10159", 7)

				for iter_381_0 = 0, arg_378_1.actors_["10159"].transform.childCount - 1 do
					local var_381_0 = arg_378_1.actors_["10159"].transform:GetChild(iter_381_0)

					if var_381_0.name == "" or not string.find(var_381_0.name, "split") then
						var_381_0.gameObject:SetActive(true)
					else
						var_381_0.gameObject:SetActive(false)
					end
				end
			end

			local var_381_1 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_1 then
				arg_378_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_378_1.time_ - 0) / var_381_1)
			end

			if arg_378_1.time_ >= 0 + var_381_1 and arg_378_1.time_ < 0 + var_381_1 + arg_381_0 then
				arg_378_1.actors_["10159"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_378_1.time_ and arg_378_1.time_ <= 0.133333333333333 + arg_381_0 then
				arg_378_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_Portal", "")
			end

			local var_381_3 = 0.034
			local var_381_4 = 1.35

			if 0.034 < arg_378_1.time_ and arg_378_1.time_ <= var_381_3 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_5 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(425111092).content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 54 <= 0 and var_381_4 or var_381_4 * (utf8.len(var_381_5) / 54)

				if (54 <= 0 and var_381_4 or var_381_4 * (utf8.len(var_381_5) / 54)) > 0 and var_381_4 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_3 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_3
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_4, arg_378_1.talkMaxDuration)

			if var_381_3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_3 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_3) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_3 + var_381_8 and arg_378_1.time_ < var_381_3 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play425111093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 425111093
		arg_382_1.duration_ = 7.67

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play425111094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_9000

			if arg_382_1.bgs_.Q02f == nil then
				local var_385_0 = Object.Instantiate(arg_382_1.paintGo_)

				var_385_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "Q02f")
				var_385_0.name = "Q02f"
				var_385_0.transform.parent = arg_382_1.stage_.transform
				var_385_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_382_1.bgs_.Q02f = var_385_0
			end

			if 1.16666666666667 < arg_382_1.time_ and arg_382_1.time_ <= 1.16666666666667 + arg_385_0 then
				local var_385_1 = arg_382_1.bgs_.Q02f

				arg_382_1.bgs_.Q02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_385_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_385_2 = var_385_1:GetComponent("SpriteRenderer")

				if var_385_2 and var_385_2.sprite then
					local var_385_3 = 2 * (var_385_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_385_1.transform.localScale = Vector3.New(var_385_3 / var_385_2.sprite.bounds.size.y < var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x and var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x or var_385_3 / var_385_2.sprite.bounds.size.y, var_385_3 / var_385_2.sprite.bounds.size.y < var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x and var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x or var_385_3 / var_385_2.sprite.bounds.size.y, 0)
				end

				for iter_385_0, iter_385_1 in pairs(arg_382_1.bgs_) do
					if iter_385_0 ~= "Q02f" then
						iter_385_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_385_4 = 2.66666666666667

			if 2.66666666666667 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.allBtn_.enabled = false
			end

			if arg_382_1.time_ >= var_385_4 + 0.3 and arg_382_1.time_ < var_385_4 + 0.3 + arg_385_0 then
				arg_382_1.allBtn_.enabled = true
			end

			local var_385_5 = 0.333333333333333

			if 0.333333333333333 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_6 = 0.833333333333333

			if var_385_5 <= arg_382_1.time_ and arg_382_1.time_ < var_385_5 + var_385_6 then
				local var_385_7 = Color.New(0, 0, 0)

				var_385_7.a = Mathf.Lerp(0, 1, (arg_382_1.time_ - var_385_5) / var_385_6)
				arg_382_1.mask_.color = var_385_7
			end

			if arg_382_1.time_ >= var_385_5 + var_385_6 and arg_382_1.time_ < var_385_5 + var_385_6 + arg_385_0 then
				local var_385_8 = Color.New(0, 0, 0)

				var_385_8.a = 1
				arg_382_1.mask_.color = var_385_8
			end

			local var_385_9 = 1.16666666666667

			if 1.16666666666667 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_10 = 1.5

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_10 then
				local var_385_11 = Color.New(0, 0, 0)

				var_385_11.a = Mathf.Lerp(1, 0, (arg_382_1.time_ - var_385_9) / var_385_10)
				arg_382_1.mask_.color = var_385_11
			end

			if arg_382_1.time_ >= var_385_9 + var_385_10 and arg_382_1.time_ < var_385_9 + var_385_10 + arg_385_0 then
				local var_385_12 = Color.New(0, 0, 0)

				arg_382_1.mask_.enabled = false
				var_385_12.a = 0
				arg_382_1.mask_.color = var_385_12
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				local var_385_13 = arg_382_1.var_.effect1093

				if not arg_382_1.var_.effect1093 then
					var_385_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmaskline_black"), manager.ui.mainCamera.transform)
					var_385_13.name = "1093"
					arg_382_1.var_.effect1093 = var_385_13
				else
					var_385_13.transform:SetParent(var_385_9000)
				end

				var_385_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_385_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_385_13.transform.localScale = Vector3.New(var_385_13.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_385_13.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_385_13.transform.localScale.z)
			end

			if 1.16666666666667 < arg_382_1.time_ and arg_382_1.time_ <= 1.16666666666667 + arg_385_0 then
				if arg_382_1.var_.effect1093 then
					Object.Destroy(arg_382_1.var_.effect1093)

					arg_382_1.var_.effect1093 = nil
				end
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_385_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_382_1.bgmTxt_.text ~= var_385_18 and arg_382_1.bgmTxt_.text ~= "" then
						if arg_382_1.bgmTxt2_.text ~= "" then
							arg_382_1.bgmTxt_.text = arg_382_1.bgmTxt2_.text
						end

						arg_382_1.bgmTxt2_.text = var_385_18

						arg_382_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_382_1.bgmTxt_.text = var_385_18
						arg_382_1.bgmTxt2_.text = var_385_18
					end

					if arg_382_1.bgmTimer then
						arg_382_1.bgmTimer:Stop()

						arg_382_1.bgmTimer = nil
					end

					if arg_382_1.settingData.show_music_name == 1 then
						arg_382_1.musicController:SetSelectedState("show")
						arg_382_1.musicAnimator_:Play("open", 0, 0)

						if arg_382_1.settingData.music_time ~= 0 then
							arg_382_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_382_1.settingData.music_time), function()
								if arg_382_1 == nil or isNil(arg_382_1.bgmTxt_) then
									return
								end

								arg_382_1.musicController:SetSelectedState("hide")
								arg_382_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.833333333333333 < arg_382_1.time_ and arg_382_1.time_ <= 0.833333333333333 + arg_385_0 then
				arg_382_1:AudioAction("play", "music", "bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp.awb")

				local var_385_21 = manager.audio:GetAudioName("bgm_activity_4_7_story_information_swamp", "bgm_activity_4_7_story_information_swamp")

				if "" ~= "" then
					if arg_382_1.bgmTxt_.text ~= var_385_21 and arg_382_1.bgmTxt_.text ~= "" then
						if arg_382_1.bgmTxt2_.text ~= "" then
							arg_382_1.bgmTxt_.text = arg_382_1.bgmTxt2_.text
						end

						arg_382_1.bgmTxt2_.text = var_385_21

						arg_382_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_382_1.bgmTxt_.text = var_385_21
						arg_382_1.bgmTxt2_.text = var_385_21
					end

					if arg_382_1.bgmTimer then
						arg_382_1.bgmTimer:Stop()

						arg_382_1.bgmTimer = nil
					end

					if arg_382_1.settingData.show_music_name == 1 then
						arg_382_1.musicController:SetSelectedState("show")
						arg_382_1.musicAnimator_:Play("open", 0, 0)

						if arg_382_1.settingData.music_time ~= 0 then
							arg_382_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_382_1.settingData.music_time), function()
								if arg_382_1 == nil or isNil(arg_382_1.bgmTxt_) then
									return
								end

								arg_382_1.musicController:SetSelectedState("hide")
								arg_382_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:AudioAction("play", "effect", "se_story_side_1084", "se_story_1084_ui", "")
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_23 = 2.66666666666667
			local var_385_24 = 0.525

			if 2.66666666666667 < arg_382_1.time_ and arg_382_1.time_ <= var_385_23 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_25 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_25:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_382_1.dialogCg_.alpha = arg_388_0
				end))
				var_385_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_26 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(425111093).content)

				arg_382_1.text_.text = var_385_26

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_28 = 21 <= 0 and var_385_24 or var_385_24 * (utf8.len(var_385_26) / 21)

				if (21 <= 0 and var_385_24 or var_385_24 * (utf8.len(var_385_26) / 21)) > 0 and var_385_24 < var_385_28 then
					arg_382_1.talkMaxDuration = var_385_28
					var_385_23 = var_385_23 + 0.3

					if var_385_28 + var_385_23 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_28 + var_385_23
					end
				end

				arg_382_1.text_.text = var_385_26
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_29 = var_385_23 + 0.3
			local var_385_30 = math.max(var_385_24, arg_382_1.talkMaxDuration)

			if var_385_23 + 0.3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_29 + var_385_30 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_29) / var_385_30

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_29 + var_385_30 and arg_382_1.time_ < var_385_29 + var_385_30 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play425111094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 425111094
		arg_390_1.duration_ = 9.47

		local var_390_0 = {
			zh = 9.3,
			ja = 9.466
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
				arg_390_0:Play425111095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10159"]) and arg_390_1.var_.actorSpriteComps10159 == nil then
				arg_390_1.var_.actorSpriteComps10159 = arg_390_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10159"]) then
				if arg_390_1.var_.actorSpriteComps10159 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								iter_393_1.color = Color.New(Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_0), Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_0), (Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_0)))
							else
								local var_393_1 = Mathf.Lerp(iter_393_1.color.r, 1, (arg_390_1.time_ - 0) / var_393_0)

								iter_393_1.color = Color.New(var_393_1, var_393_1, var_393_1)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10159"]) and arg_390_1.var_.actorSpriteComps10159 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps10159 = nil
			end

			local var_393_2 = arg_390_1.actors_["10159"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos10159 = var_393_2.localPosition
				var_393_2.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10159", 3)

				for iter_393_4 = 0, var_393_2.childCount - 1 do
					local var_393_3 = var_393_2:GetChild(iter_393_4)

					if var_393_3.name == "split_1" or not string.find(var_393_3.name, "split") then
						var_393_3.gameObject:SetActive(true)
					else
						var_393_3.gameObject:SetActive(false)
					end
				end
			end

			local var_393_4 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				var_393_2.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_390_1.time_ - 0) / var_393_4)
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				var_393_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_393_5 = 0
			local var_393_6 = 0.85

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:GetWordFromCfg(425111094)
				local var_393_8 = arg_390_1:FormatText(var_393_7.content)

				arg_390_1.text_.text = var_393_8

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_10 = 34 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 34)

				if (34 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 34)) > 0 and var_393_6 < var_393_10 then
					arg_390_1.talkMaxDuration = var_393_10

					if var_393_10 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_8
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111094", "story_v_out_425111.awb") ~= 0 then
					local var_393_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111094", "story_v_out_425111.awb") / 1000

					if var_393_11 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_5
					end

					if var_393_7.prefab_name ~= "" and arg_390_1.actors_[var_393_7.prefab_name] ~= nil then
						local var_393_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_7.prefab_name].transform, "story_v_out_425111", "425111094", "story_v_out_425111.awb")

						arg_390_1:RecordAudio("425111094", var_393_12)
						arg_390_1:RecordAudio("425111094", var_393_12)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_425111", "425111094", "story_v_out_425111.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_425111", "425111094", "story_v_out_425111.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_13 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_13 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_13

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_13 and arg_390_1.time_ < var_393_5 + var_393_13 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play425111095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 425111095
		arg_394_1.duration_ = 5.47

		local var_394_0 = {
			zh = 3.233,
			ja = 5.466
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
				arg_394_0:Play425111096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1037"]) and arg_394_1.var_.actorSpriteComps1037 == nil then
				arg_394_1.var_.actorSpriteComps1037 = arg_394_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1037"]) then
				if arg_394_1.var_.actorSpriteComps1037 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 1, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1037"]) and arg_394_1.var_.actorSpriteComps1037 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_394_1.var_.actorSpriteComps1037 = nil
			end

			local var_397_2 = arg_394_1.actors_["10159"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps10159 == nil then
				arg_394_1.var_.actorSpriteComps10159 = var_397_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_3 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.actorSpriteComps10159 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								iter_397_5.color = Color.New(Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_3), Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_3), (Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_3)))
							else
								local var_397_4 = Mathf.Lerp(iter_397_5.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_3)

								iter_397_5.color = Color.New(var_397_4, var_397_4, var_397_4)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps10159 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_397_7 then
						iter_397_7.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps10159 = nil
			end

			local var_397_5 = arg_394_1.actors_["1037"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1037 = var_397_5.localPosition
				var_397_5.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1037", 4)

				for iter_397_8 = 0, var_397_5.childCount - 1 do
					local var_397_6 = var_397_5:GetChild(iter_397_8)

					if var_397_6.name == "split_5" or not string.find(var_397_6.name, "split") then
						var_397_6.gameObject:SetActive(true)
					else
						var_397_6.gameObject:SetActive(false)
					end
				end
			end

			local var_397_7 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				var_397_5.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_394_1.time_ - 0) / var_397_7)
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				var_397_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_397_8 = arg_394_1.actors_["10159"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10159 = var_397_8.localPosition
				var_397_8.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10159", 2)

				for iter_397_9 = 0, var_397_8.childCount - 1 do
					local var_397_9 = var_397_8:GetChild(iter_397_9)

					if var_397_9.name == "split_1" or not string.find(var_397_9.name, "split") then
						var_397_9.gameObject:SetActive(true)
					else
						var_397_9.gameObject:SetActive(false)
					end
				end
			end

			local var_397_10 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_10 then
				var_397_8.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_394_1.time_ - 0) / var_397_10)
			end

			if arg_394_1.time_ >= 0 + var_397_10 and arg_394_1.time_ < 0 + var_397_10 + arg_397_0 then
				var_397_8.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_397_11 = 0
			local var_397_12 = 0.325

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_11 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_13 = arg_394_1:GetWordFromCfg(425111095)
				local var_397_14 = arg_394_1:FormatText(var_397_13.content)

				arg_394_1.text_.text = var_397_14

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_16 = 13 <= 0 and var_397_12 or var_397_12 * (utf8.len(var_397_14) / 13)

				if (13 <= 0 and var_397_12 or var_397_12 * (utf8.len(var_397_14) / 13)) > 0 and var_397_12 < var_397_16 then
					arg_394_1.talkMaxDuration = var_397_16

					if var_397_16 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_16 + var_397_11
					end
				end

				arg_394_1.text_.text = var_397_14
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111095", "story_v_out_425111.awb") ~= 0 then
					local var_397_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111095", "story_v_out_425111.awb") / 1000

					if var_397_17 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_17 + var_397_11
					end

					if var_397_13.prefab_name ~= "" and arg_394_1.actors_[var_397_13.prefab_name] ~= nil then
						local var_397_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_13.prefab_name].transform, "story_v_out_425111", "425111095", "story_v_out_425111.awb")

						arg_394_1:RecordAudio("425111095", var_397_18)
						arg_394_1:RecordAudio("425111095", var_397_18)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_425111", "425111095", "story_v_out_425111.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_425111", "425111095", "story_v_out_425111.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_19 = math.max(var_397_12, arg_394_1.talkMaxDuration)

			if var_397_11 <= arg_394_1.time_ and arg_394_1.time_ < var_397_11 + var_397_19 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_11) / var_397_19

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_11 + var_397_19 and arg_394_1.time_ < var_397_11 + var_397_19 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
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
	Play425111096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 425111096
		arg_398_1.duration_ = 7.9

		local var_398_0 = {
			zh = 5.833,
			ja = 7.9
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
				arg_398_0:Play425111097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["10159"]) and arg_398_1.var_.actorSpriteComps10159 == nil then
				arg_398_1.var_.actorSpriteComps10159 = arg_398_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_0 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["10159"]) then
				if arg_398_1.var_.actorSpriteComps10159 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								iter_401_1.color = Color.New(Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor1.r, (arg_398_1.time_ - 0) / var_401_0), Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor1.g, (arg_398_1.time_ - 0) / var_401_0), (Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor1.b, (arg_398_1.time_ - 0) / var_401_0)))
							else
								local var_401_1 = Mathf.Lerp(iter_401_1.color.r, 1, (arg_398_1.time_ - 0) / var_401_0)

								iter_401_1.color = Color.New(var_401_1, var_401_1, var_401_1)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["10159"]) and arg_398_1.var_.actorSpriteComps10159 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_401_3 then
						iter_401_3.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_398_1.var_.actorSpriteComps10159 = nil
			end

			local var_401_2 = arg_398_1.actors_["1037"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1037 == nil then
				arg_398_1.var_.actorSpriteComps1037 = var_401_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_3 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_3 and not isNil(var_401_2) then
				if arg_398_1.var_.actorSpriteComps1037 then
					for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_401_5 then
							if arg_398_1.isInRecall_ then
								iter_401_5.color = Color.New(Mathf.Lerp(iter_401_5.color.r, arg_398_1.hightColor2.r, (arg_398_1.time_ - 0) / var_401_3), Mathf.Lerp(iter_401_5.color.g, arg_398_1.hightColor2.g, (arg_398_1.time_ - 0) / var_401_3), (Mathf.Lerp(iter_401_5.color.b, arg_398_1.hightColor2.b, (arg_398_1.time_ - 0) / var_401_3)))
							else
								local var_401_4 = Mathf.Lerp(iter_401_5.color.r, 0.5, (arg_398_1.time_ - 0) / var_401_3)

								iter_401_5.color = Color.New(var_401_4, var_401_4, var_401_4)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_3 and arg_398_1.time_ < 0 + var_401_3 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1037 then
				for iter_401_6, iter_401_7 in pairs(arg_398_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_401_7 then
						iter_401_7.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_398_1.var_.actorSpriteComps1037 = nil
			end

			local var_401_5 = arg_398_1.actors_["10159"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos10159 = var_401_5.localPosition
				var_401_5.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("10159", 2)

				for iter_401_8 = 0, var_401_5.childCount - 1 do
					local var_401_6 = var_401_5:GetChild(iter_401_8)

					if var_401_6.name == "" then
						var_401_6:SetAsLastSibling()
						var_401_6.gameObject:SetActive(true)

						arg_398_1.var_.actorSpriteSplit10159 = var_401_6.gameObject:GetComponent(typeof(Image))

						arg_398_1.var_.actorSpriteSplit10159:SetAlpha(0)
					end
				end
			end

			local var_401_7 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				var_401_5.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_398_1.time_ - 0) / var_401_7)

				if arg_398_1.var_.actorSpriteSplit10159 ~= nil then
					arg_398_1.var_.actorSpriteSplit10159:SetAlpha((arg_398_1.time_ - 0) / var_401_7)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				var_401_5.localPosition = Vector3.New(-390, -415, -230)

				if arg_398_1.var_.actorSpriteSplit10159 ~= nil then
					arg_398_1.var_.actorSpriteSplit10159:SetAlpha(1)
				end
			end

			local var_401_8 = 0
			local var_401_9 = 0.55

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_8 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_10 = arg_398_1:GetWordFromCfg(425111096)
				local var_401_11 = arg_398_1:FormatText(var_401_10.content)

				arg_398_1.text_.text = var_401_11

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_13 = 22 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 22)

				if (22 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 22)) > 0 and var_401_9 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_8
					end
				end

				arg_398_1.text_.text = var_401_11
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111096", "story_v_out_425111.awb") ~= 0 then
					local var_401_14 = manager.audio:GetVoiceLength("story_v_out_425111", "425111096", "story_v_out_425111.awb") / 1000

					if var_401_14 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_14 + var_401_8
					end

					if var_401_10.prefab_name ~= "" and arg_398_1.actors_[var_401_10.prefab_name] ~= nil then
						local var_401_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_10.prefab_name].transform, "story_v_out_425111", "425111096", "story_v_out_425111.awb")

						arg_398_1:RecordAudio("425111096", var_401_15)
						arg_398_1:RecordAudio("425111096", var_401_15)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_425111", "425111096", "story_v_out_425111.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_425111", "425111096", "story_v_out_425111.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_16 = math.max(var_401_9, arg_398_1.talkMaxDuration)

			if var_401_8 <= arg_398_1.time_ and arg_398_1.time_ < var_401_8 + var_401_16 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_8) / var_401_16

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_8 + var_401_16 and arg_398_1.time_ < var_401_8 + var_401_16 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play425111097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 425111097
		arg_402_1.duration_ = 6.33

		local var_402_0 = {
			zh = 5.3,
			ja = 6.333
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
				arg_402_0:Play425111098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.425

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:GetWordFromCfg(425111097)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 17 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 17)

				if (17 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 17)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111097", "story_v_out_425111.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_out_425111", "425111097", "story_v_out_425111.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_out_425111", "425111097", "story_v_out_425111.awb")

						arg_402_1:RecordAudio("425111097", var_405_6)
						arg_402_1:RecordAudio("425111097", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_425111", "425111097", "story_v_out_425111.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_425111", "425111097", "story_v_out_425111.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play425111098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 425111098
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play425111099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos10159 = arg_406_1.actors_["10159"].transform.localPosition
				arg_406_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10159", 7)

				for iter_409_0 = 0, arg_406_1.actors_["10159"].transform.childCount - 1 do
					local var_409_0 = arg_406_1.actors_["10159"].transform:GetChild(iter_409_0)

					if var_409_0.name == "" or not string.find(var_409_0.name, "split") then
						var_409_0.gameObject:SetActive(true)
					else
						var_409_0.gameObject:SetActive(false)
					end
				end
			end

			local var_409_1 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_1 then
				arg_406_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_406_1.time_ - 0) / var_409_1)
			end

			if arg_406_1.time_ >= 0 + var_409_1 and arg_406_1.time_ < 0 + var_409_1 + arg_409_0 then
				arg_406_1.actors_["10159"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_409_2 = arg_406_1.actors_["1037"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1037 = var_409_2.localPosition
				var_409_2.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1037", 7)

				for iter_409_1 = 0, var_409_2.childCount - 1 do
					local var_409_3 = var_409_2:GetChild(iter_409_1)

					if var_409_3.name == "" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				var_409_2.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_406_1.time_ - 0) / var_409_4)
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				var_409_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_409_5 = 0
			local var_409_6 = 0.525

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_7 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(425111098).content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 21 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_7) / 21)

				if (21 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_7) / 21)) > 0 and var_409_6 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_5
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_6, arg_406_1.talkMaxDuration)

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_5) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_5 + var_409_10 and arg_406_1.time_ < var_409_5 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play425111099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 425111099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play425111100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.65

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(425111099).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 26 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 26)

				if (26 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 26)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play425111100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 425111100
		arg_414_1.duration_ = 12.13

		local var_414_0 = {
			zh = 10.1,
			ja = 12.133
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
				arg_414_0:Play425111101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["10159"]) and arg_414_1.var_.actorSpriteComps10159 == nil then
				arg_414_1.var_.actorSpriteComps10159 = arg_414_1.actors_["10159"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["10159"]) then
				if arg_414_1.var_.actorSpriteComps10159 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								iter_417_1.color = Color.New(Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor1.r, (arg_414_1.time_ - 0) / var_417_0), Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor1.g, (arg_414_1.time_ - 0) / var_417_0), (Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor1.b, (arg_414_1.time_ - 0) / var_417_0)))
							else
								local var_417_1 = Mathf.Lerp(iter_417_1.color.r, 1, (arg_414_1.time_ - 0) / var_417_0)

								iter_417_1.color = Color.New(var_417_1, var_417_1, var_417_1)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["10159"]) and arg_414_1.var_.actorSpriteComps10159 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_417_3 then
						iter_417_3.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_414_1.var_.actorSpriteComps10159 = nil
			end

			local var_417_2 = arg_414_1.actors_["10159"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos10159 = var_417_2.localPosition
				var_417_2.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("10159", 3)

				for iter_417_4 = 0, var_417_2.childCount - 1 do
					local var_417_3 = var_417_2:GetChild(iter_417_4)

					if var_417_3.name == "" or not string.find(var_417_3.name, "split") then
						var_417_3.gameObject:SetActive(true)
					else
						var_417_3.gameObject:SetActive(false)
					end
				end
			end

			local var_417_4 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				var_417_2.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_414_1.time_ - 0) / var_417_4)
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				var_417_2.localPosition = Vector3.New(0, -415, -230)
			end

			local var_417_5 = 0
			local var_417_6 = 0.95

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_5 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_7 = arg_414_1:GetWordFromCfg(425111100)
				local var_417_8 = arg_414_1:FormatText(var_417_7.content)

				arg_414_1.text_.text = var_417_8

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_10 = 38 <= 0 and var_417_6 or var_417_6 * (utf8.len(var_417_8) / 38)

				if (38 <= 0 and var_417_6 or var_417_6 * (utf8.len(var_417_8) / 38)) > 0 and var_417_6 < var_417_10 then
					arg_414_1.talkMaxDuration = var_417_10

					if var_417_10 + var_417_5 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_10 + var_417_5
					end
				end

				arg_414_1.text_.text = var_417_8
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111100", "story_v_out_425111.awb") ~= 0 then
					local var_417_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111100", "story_v_out_425111.awb") / 1000

					if var_417_11 + var_417_5 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_11 + var_417_5
					end

					if var_417_7.prefab_name ~= "" and arg_414_1.actors_[var_417_7.prefab_name] ~= nil then
						local var_417_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_7.prefab_name].transform, "story_v_out_425111", "425111100", "story_v_out_425111.awb")

						arg_414_1:RecordAudio("425111100", var_417_12)
						arg_414_1:RecordAudio("425111100", var_417_12)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_425111", "425111100", "story_v_out_425111.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_425111", "425111100", "story_v_out_425111.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_13 = math.max(var_417_6, arg_414_1.talkMaxDuration)

			if var_417_5 <= arg_414_1.time_ and arg_414_1.time_ < var_417_5 + var_417_13 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_5) / var_417_13

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_5 + var_417_13 and arg_414_1.time_ < var_417_5 + var_417_13 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
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
	Play425111101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 425111101
		arg_418_1.duration_ = 4.9

		local var_418_0 = {
			zh = 3.9,
			ja = 4.9
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
				arg_418_0:Play425111102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1037"]) and arg_418_1.var_.actorSpriteComps1037 == nil then
				arg_418_1.var_.actorSpriteComps1037 = arg_418_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1037"]) then
				if arg_418_1.var_.actorSpriteComps1037 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								iter_421_1.color = Color.New(Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, (arg_418_1.time_ - 0) / var_421_0), Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, (arg_418_1.time_ - 0) / var_421_0), (Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, (arg_418_1.time_ - 0) / var_421_0)))
							else
								local var_421_1 = Mathf.Lerp(iter_421_1.color.r, 1, (arg_418_1.time_ - 0) / var_421_0)

								iter_421_1.color = Color.New(var_421_1, var_421_1, var_421_1)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1037"]) and arg_418_1.var_.actorSpriteComps1037 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_421_3 then
						iter_421_3.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_418_1.var_.actorSpriteComps1037 = nil
			end

			local var_421_2 = arg_418_1.actors_["10159"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.actorSpriteComps10159 == nil then
				arg_418_1.var_.actorSpriteComps10159 = var_421_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_3 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_3 and not isNil(var_421_2) then
				if arg_418_1.var_.actorSpriteComps10159 then
					for iter_421_4, iter_421_5 in pairs(arg_418_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_421_5 then
							if arg_418_1.isInRecall_ then
								iter_421_5.color = Color.New(Mathf.Lerp(iter_421_5.color.r, arg_418_1.hightColor2.r, (arg_418_1.time_ - 0) / var_421_3), Mathf.Lerp(iter_421_5.color.g, arg_418_1.hightColor2.g, (arg_418_1.time_ - 0) / var_421_3), (Mathf.Lerp(iter_421_5.color.b, arg_418_1.hightColor2.b, (arg_418_1.time_ - 0) / var_421_3)))
							else
								local var_421_4 = Mathf.Lerp(iter_421_5.color.r, 0.5, (arg_418_1.time_ - 0) / var_421_3)

								iter_421_5.color = Color.New(var_421_4, var_421_4, var_421_4)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_3 and arg_418_1.time_ < 0 + var_421_3 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.actorSpriteComps10159 then
				for iter_421_6, iter_421_7 in pairs(arg_418_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_421_7 then
						iter_421_7.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_418_1.var_.actorSpriteComps10159 = nil
			end

			local var_421_5 = arg_418_1.actors_["1037"].transform

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1037 = var_421_5.localPosition
				var_421_5.localScale = Vector3.New(1, 1, 1)

				arg_418_1:CheckSpriteTmpPos("1037", 4)

				for iter_421_8 = 0, var_421_5.childCount - 1 do
					local var_421_6 = var_421_5:GetChild(iter_421_8)

					if var_421_6.name == "split_4" or not string.find(var_421_6.name, "split") then
						var_421_6.gameObject:SetActive(true)
					else
						var_421_6.gameObject:SetActive(false)
					end
				end
			end

			local var_421_7 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_7 then
				var_421_5.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_418_1.time_ - 0) / var_421_7)
			end

			if arg_418_1.time_ >= 0 + var_421_7 and arg_418_1.time_ < 0 + var_421_7 + arg_421_0 then
				var_421_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_421_8 = arg_418_1.actors_["10159"].transform

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos10159 = var_421_8.localPosition
				var_421_8.localScale = Vector3.New(1, 1, 1)

				arg_418_1:CheckSpriteTmpPos("10159", 2)

				for iter_421_9 = 0, var_421_8.childCount - 1 do
					local var_421_9 = var_421_8:GetChild(iter_421_9)

					if var_421_9.name == "" or not string.find(var_421_9.name, "split") then
						var_421_9.gameObject:SetActive(true)
					else
						var_421_9.gameObject:SetActive(false)
					end
				end
			end

			local var_421_10 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_10 then
				var_421_8.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos10159, Vector3.New(-390, -415, -230), (arg_418_1.time_ - 0) / var_421_10)
			end

			if arg_418_1.time_ >= 0 + var_421_10 and arg_418_1.time_ < 0 + var_421_10 + arg_421_0 then
				var_421_8.localPosition = Vector3.New(-390, -415, -230)
			end

			local var_421_11 = 0
			local var_421_12 = 0.325

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_11 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_13 = arg_418_1:GetWordFromCfg(425111101)
				local var_421_14 = arg_418_1:FormatText(var_421_13.content)

				arg_418_1.text_.text = var_421_14

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_16 = 13 <= 0 and var_421_12 or var_421_12 * (utf8.len(var_421_14) / 13)

				if (13 <= 0 and var_421_12 or var_421_12 * (utf8.len(var_421_14) / 13)) > 0 and var_421_12 < var_421_16 then
					arg_418_1.talkMaxDuration = var_421_16

					if var_421_16 + var_421_11 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_16 + var_421_11
					end
				end

				arg_418_1.text_.text = var_421_14
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111101", "story_v_out_425111.awb") ~= 0 then
					local var_421_17 = manager.audio:GetVoiceLength("story_v_out_425111", "425111101", "story_v_out_425111.awb") / 1000

					if var_421_17 + var_421_11 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_17 + var_421_11
					end

					if var_421_13.prefab_name ~= "" and arg_418_1.actors_[var_421_13.prefab_name] ~= nil then
						local var_421_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_13.prefab_name].transform, "story_v_out_425111", "425111101", "story_v_out_425111.awb")

						arg_418_1:RecordAudio("425111101", var_421_18)
						arg_418_1:RecordAudio("425111101", var_421_18)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_425111", "425111101", "story_v_out_425111.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_425111", "425111101", "story_v_out_425111.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_19 = math.max(var_421_12, arg_418_1.talkMaxDuration)

			if var_421_11 <= arg_418_1.time_ and arg_418_1.time_ < var_421_11 + var_421_19 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_11) / var_421_19

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_11 + var_421_19 and arg_418_1.time_ < var_421_11 + var_421_19 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play425111102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 425111102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play425111103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1037"]) and arg_422_1.var_.actorSpriteComps1037 == nil then
				arg_422_1.var_.actorSpriteComps1037 = arg_422_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1037"]) then
				if arg_422_1.var_.actorSpriteComps1037 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								iter_425_1.color = Color.New(Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor2.r, (arg_422_1.time_ - 0) / var_425_0), Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor2.g, (arg_422_1.time_ - 0) / var_425_0), (Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor2.b, (arg_422_1.time_ - 0) / var_425_0)))
							else
								local var_425_1 = Mathf.Lerp(iter_425_1.color.r, 0.5, (arg_422_1.time_ - 0) / var_425_0)

								iter_425_1.color = Color.New(var_425_1, var_425_1, var_425_1)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1037"]) and arg_422_1.var_.actorSpriteComps1037 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_425_3 then
						iter_425_3.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_422_1.var_.actorSpriteComps1037 = nil
			end

			local var_425_2 = 0
			local var_425_3 = 0.375

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_4 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(425111102).content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_6 = 15 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_4) / 15)

				if (15 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_4) / 15)) > 0 and var_425_3 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_7 and arg_422_1.time_ < var_425_2 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play425111103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 425111103
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play425111104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1037 = arg_426_1.actors_["1037"].transform.localPosition
				arg_426_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("1037", 7)

				for iter_429_0 = 0, arg_426_1.actors_["1037"].transform.childCount - 1 do
					local var_429_0 = arg_426_1.actors_["1037"].transform:GetChild(iter_429_0)

					if var_429_0.name == "" or not string.find(var_429_0.name, "split") then
						var_429_0.gameObject:SetActive(true)
					else
						var_429_0.gameObject:SetActive(false)
					end
				end
			end

			local var_429_1 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_1 then
				arg_426_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_426_1.time_ - 0) / var_429_1)
			end

			if arg_426_1.time_ >= 0 + var_429_1 and arg_426_1.time_ < 0 + var_429_1 + arg_429_0 then
				arg_426_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_429_2 = arg_426_1.actors_["10159"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos10159 = var_429_2.localPosition
				var_429_2.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("10159", 7)

				for iter_429_1 = 0, var_429_2.childCount - 1 do
					local var_429_3 = var_429_2:GetChild(iter_429_1)

					if var_429_3.name == "" or not string.find(var_429_3.name, "split") then
						var_429_3.gameObject:SetActive(true)
					else
						var_429_3.gameObject:SetActive(false)
					end
				end
			end

			local var_429_4 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				var_429_2.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos10159, Vector3.New(0, -2000, 0), (arg_426_1.time_ - 0) / var_429_4)
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				var_429_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_429_5 = 0
			local var_429_6 = 1.05

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_5 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_7 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(425111103).content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 42 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_7) / 42)

				if (42 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_7) / 42)) > 0 and var_429_6 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_5 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_5
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_6, arg_426_1.talkMaxDuration)

			if var_429_5 <= arg_426_1.time_ and arg_426_1.time_ < var_429_5 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_5) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_5 + var_429_10 and arg_426_1.time_ < var_429_5 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play425111104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 425111104
		arg_430_1.duration_ = 3.03

		local var_430_0 = {
			zh = 2.633,
			ja = 3.033
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play425111105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1037 = arg_430_1.actors_["1037"].transform.localPosition
				arg_430_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("1037", 3)

				for iter_433_0 = 0, arg_430_1.actors_["1037"].transform.childCount - 1 do
					local var_433_0 = arg_430_1.actors_["1037"].transform:GetChild(iter_433_0)

					if var_433_0.name == "split_5" or not string.find(var_433_0.name, "split") then
						var_433_0.gameObject:SetActive(true)
					else
						var_433_0.gameObject:SetActive(false)
					end
				end
			end

			local var_433_1 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_1 then
				arg_430_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_430_1.time_ - 0) / var_433_1)
			end

			if arg_430_1.time_ >= 0 + var_433_1 and arg_430_1.time_ < 0 + var_433_1 + arg_433_0 then
				arg_430_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)
			end

			local var_433_2 = arg_430_1.actors_["1037"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1037 == nil then
				arg_430_1.var_.actorSpriteComps1037 = var_433_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_3 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.actorSpriteComps1037 then
					for iter_433_1, iter_433_2 in pairs(arg_430_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_433_2 then
							if arg_430_1.isInRecall_ then
								iter_433_2.color = Color.New(Mathf.Lerp(iter_433_2.color.r, arg_430_1.hightColor1.r, (arg_430_1.time_ - 0) / var_433_3), Mathf.Lerp(iter_433_2.color.g, arg_430_1.hightColor1.g, (arg_430_1.time_ - 0) / var_433_3), (Mathf.Lerp(iter_433_2.color.b, arg_430_1.hightColor1.b, (arg_430_1.time_ - 0) / var_433_3)))
							else
								local var_433_4 = Mathf.Lerp(iter_433_2.color.r, 1, (arg_430_1.time_ - 0) / var_433_3)

								iter_433_2.color = Color.New(var_433_4, var_433_4, var_433_4)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1037 then
				for iter_433_3, iter_433_4 in pairs(arg_430_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_433_4 then
						iter_433_4.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_430_1.var_.actorSpriteComps1037 = nil
			end

			local var_433_5 = 0
			local var_433_6 = 0.175

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_7 = arg_430_1:GetWordFromCfg(425111104)
				local var_433_8 = arg_430_1:FormatText(var_433_7.content)

				arg_430_1.text_.text = var_433_8

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_10 = 7 <= 0 and var_433_6 or var_433_6 * (utf8.len(var_433_8) / 7)

				if (7 <= 0 and var_433_6 or var_433_6 * (utf8.len(var_433_8) / 7)) > 0 and var_433_6 < var_433_10 then
					arg_430_1.talkMaxDuration = var_433_10

					if var_433_10 + var_433_5 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_5
					end
				end

				arg_430_1.text_.text = var_433_8
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111104", "story_v_out_425111.awb") ~= 0 then
					local var_433_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111104", "story_v_out_425111.awb") / 1000

					if var_433_11 + var_433_5 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_11 + var_433_5
					end

					if var_433_7.prefab_name ~= "" and arg_430_1.actors_[var_433_7.prefab_name] ~= nil then
						local var_433_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_7.prefab_name].transform, "story_v_out_425111", "425111104", "story_v_out_425111.awb")

						arg_430_1:RecordAudio("425111104", var_433_12)
						arg_430_1:RecordAudio("425111104", var_433_12)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_425111", "425111104", "story_v_out_425111.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_425111", "425111104", "story_v_out_425111.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_13 = math.max(var_433_6, arg_430_1.talkMaxDuration)

			if var_433_5 <= arg_430_1.time_ and arg_430_1.time_ < var_433_5 + var_433_13 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_5) / var_433_13

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_5 + var_433_13 and arg_430_1.time_ < var_433_5 + var_433_13 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.35,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(5, 5, 0)
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play425111105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 425111105
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play425111106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1037"]) and arg_434_1.var_.actorSpriteComps1037 == nil then
				arg_434_1.var_.actorSpriteComps1037 = arg_434_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_0 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1037"]) then
				if arg_434_1.var_.actorSpriteComps1037 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_437_1 then
							if arg_434_1.isInRecall_ then
								iter_437_1.color = Color.New(Mathf.Lerp(iter_437_1.color.r, arg_434_1.hightColor2.r, (arg_434_1.time_ - 0) / var_437_0), Mathf.Lerp(iter_437_1.color.g, arg_434_1.hightColor2.g, (arg_434_1.time_ - 0) / var_437_0), (Mathf.Lerp(iter_437_1.color.b, arg_434_1.hightColor2.b, (arg_434_1.time_ - 0) / var_437_0)))
							else
								local var_437_1 = Mathf.Lerp(iter_437_1.color.r, 0.5, (arg_434_1.time_ - 0) / var_437_0)

								iter_437_1.color = Color.New(var_437_1, var_437_1, var_437_1)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1037"]) and arg_434_1.var_.actorSpriteComps1037 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_437_3 then
						iter_437_3.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_434_1.var_.actorSpriteComps1037 = nil
			end

			local var_437_2 = 0
			local var_437_3 = 1.025

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_2 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_4 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(425111105).content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_6 = 41 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_4) / 41)

				if (41 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_4) / 41)) > 0 and var_437_3 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_2
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_3, arg_434_1.talkMaxDuration)

			if var_437_2 <= arg_434_1.time_ and arg_434_1.time_ < var_437_2 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_2) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_2 + var_437_7 and arg_434_1.time_ < var_437_2 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play425111106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 425111106
		arg_438_1.duration_ = 3.77

		local var_438_0 = {
			zh = 0.999999999999,
			ja = 3.766
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play425111107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1037"]) and arg_438_1.var_.actorSpriteComps1037 == nil then
				arg_438_1.var_.actorSpriteComps1037 = arg_438_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1037"]) then
				if arg_438_1.var_.actorSpriteComps1037 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								iter_441_1.color = Color.New(Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor1.r, (arg_438_1.time_ - 0) / var_441_0), Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor1.g, (arg_438_1.time_ - 0) / var_441_0), (Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor1.b, (arg_438_1.time_ - 0) / var_441_0)))
							else
								local var_441_1 = Mathf.Lerp(iter_441_1.color.r, 1, (arg_438_1.time_ - 0) / var_441_0)

								iter_441_1.color = Color.New(var_441_1, var_441_1, var_441_1)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1037"]) and arg_438_1.var_.actorSpriteComps1037 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_441_3 then
						iter_441_3.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_438_1.var_.actorSpriteComps1037 = nil
			end

			local var_441_2 = arg_438_1.actors_["1037"].transform

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1037 = var_441_2.localPosition
				var_441_2.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("1037", 3)

				for iter_441_4 = 0, var_441_2.childCount - 1 do
					local var_441_3 = var_441_2:GetChild(iter_441_4)

					if var_441_3.name == "split_2" then
						var_441_3:SetAsLastSibling()
						var_441_3.gameObject:SetActive(true)

						arg_438_1.var_.actorSpriteSplit1037 = var_441_3.gameObject:GetComponent(typeof(Image))

						arg_438_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_441_4 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				var_441_2.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_438_1.time_ - 0) / var_441_4)

				if arg_438_1.var_.actorSpriteSplit1037 ~= nil then
					arg_438_1.var_.actorSpriteSplit1037:SetAlpha((arg_438_1.time_ - 0) / var_441_4)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				var_441_2.localPosition = Vector3.New(0, -430, -55)

				if arg_438_1.var_.actorSpriteSplit1037 ~= nil then
					arg_438_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_441_5 = 0
			local var_441_6 = 0.1

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:GetWordFromCfg(425111106)
				local var_441_8 = arg_438_1:FormatText(var_441_7.content)

				arg_438_1.text_.text = var_441_8

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_10 = 4 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 4)

				if (4 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 4)) > 0 and var_441_6 < var_441_10 then
					arg_438_1.talkMaxDuration = var_441_10

					if var_441_10 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_5
					end
				end

				arg_438_1.text_.text = var_441_8
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111106", "story_v_out_425111.awb") ~= 0 then
					local var_441_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111106", "story_v_out_425111.awb") / 1000

					if var_441_11 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_11 + var_441_5
					end

					if var_441_7.prefab_name ~= "" and arg_438_1.actors_[var_441_7.prefab_name] ~= nil then
						local var_441_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_7.prefab_name].transform, "story_v_out_425111", "425111106", "story_v_out_425111.awb")

						arg_438_1:RecordAudio("425111106", var_441_12)
						arg_438_1:RecordAudio("425111106", var_441_12)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_425111", "425111106", "story_v_out_425111.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_425111", "425111106", "story_v_out_425111.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_13 = math.max(var_441_6, arg_438_1.talkMaxDuration)

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_13 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_5) / var_441_13

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_5 + var_441_13 and arg_438_1.time_ < var_441_5 + var_441_13 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play425111107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 425111107
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
			arg_442_1.auto_ = false
		end

		function arg_442_1.playNext_(arg_444_0)
			arg_442_1.onStoryFinished_()
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1037 = arg_442_1.actors_["1037"].transform.localPosition
				arg_442_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1037", 7)

				for iter_445_0 = 0, arg_442_1.actors_["1037"].transform.childCount - 1 do
					local var_445_0 = arg_442_1.actors_["1037"].transform:GetChild(iter_445_0)

					if var_445_0.name == "split_2" or not string.find(var_445_0.name, "split") then
						var_445_0.gameObject:SetActive(true)
					else
						var_445_0.gameObject:SetActive(false)
					end
				end
			end

			local var_445_1 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_1 then
				arg_442_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_442_1.time_ - 0) / var_445_1)
			end

			if arg_442_1.time_ >= 0 + var_445_1 and arg_442_1.time_ < 0 + var_445_1 + arg_445_0 then
				arg_442_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_445_2 = 0
			local var_445_3 = 0.5

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_4 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(425111107).content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_6 = 20 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_4) / 20)

				if (20 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_4) / 20)) > 0 and var_445_3 < var_445_6 then
					arg_442_1.talkMaxDuration = var_445_6

					if var_445_6 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_7 and arg_442_1.time_ < var_445_2 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play425111060 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 425111060
		arg_446_1.duration_ = 11.5

		local var_446_0 = {
			zh = 8.733,
			ja = 11.5
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play425111061(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos10159 = arg_446_1.actors_["10159"].transform.localPosition
				arg_446_1.actors_["10159"].transform.localScale = Vector3.New(1, 1, 1)

				arg_446_1:CheckSpriteTmpPos("10159", 3)

				for iter_449_0 = 0, arg_446_1.actors_["10159"].transform.childCount - 1 do
					local var_449_0 = arg_446_1.actors_["10159"].transform:GetChild(iter_449_0)

					if var_449_0.name == "split_1" or not string.find(var_449_0.name, "split") then
						var_449_0.gameObject:SetActive(true)
					else
						var_449_0.gameObject:SetActive(false)
					end
				end
			end

			local var_449_1 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_1 then
				arg_446_1.actors_["10159"].transform.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10159, Vector3.New(0, -415, -230), (arg_446_1.time_ - 0) / var_449_1)
			end

			if arg_446_1.time_ >= 0 + var_449_1 and arg_446_1.time_ < 0 + var_449_1 + arg_449_0 then
				arg_446_1.actors_["10159"].transform.localPosition = Vector3.New(0, -415, -230)
			end

			local var_449_2 = arg_446_1.actors_["10159"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps10159 == nil then
				arg_446_1.var_.actorSpriteComps10159 = var_449_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_3 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 and not isNil(var_449_2) then
				if arg_446_1.var_.actorSpriteComps10159 then
					for iter_449_1, iter_449_2 in pairs(arg_446_1.var_.actorSpriteComps10159:ToTable()) do
						if iter_449_2 then
							if arg_446_1.isInRecall_ then
								iter_449_2.color = Color.New(Mathf.Lerp(iter_449_2.color.r, arg_446_1.hightColor1.r, (arg_446_1.time_ - 0) / var_449_3), Mathf.Lerp(iter_449_2.color.g, arg_446_1.hightColor1.g, (arg_446_1.time_ - 0) / var_449_3), (Mathf.Lerp(iter_449_2.color.b, arg_446_1.hightColor1.b, (arg_446_1.time_ - 0) / var_449_3)))
							else
								local var_449_4 = Mathf.Lerp(iter_449_2.color.r, 1, (arg_446_1.time_ - 0) / var_449_3)

								iter_449_2.color = Color.New(var_449_4, var_449_4, var_449_4)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps10159 then
				for iter_449_3, iter_449_4 in pairs(arg_446_1.var_.actorSpriteComps10159:ToTable()) do
					if iter_449_4 then
						iter_449_4.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_446_1.var_.actorSpriteComps10159 = nil
			end

			local var_449_5 = 0
			local var_449_6 = 0.975

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_5 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_7 = arg_446_1:GetWordFromCfg(425111060)
				local var_449_8 = arg_446_1:FormatText(var_449_7.content)

				arg_446_1.text_.text = var_449_8

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_10 = 39 <= 0 and var_449_6 or var_449_6 * (utf8.len(var_449_8) / 39)

				if (39 <= 0 and var_449_6 or var_449_6 * (utf8.len(var_449_8) / 39)) > 0 and var_449_6 < var_449_10 then
					arg_446_1.talkMaxDuration = var_449_10

					if var_449_10 + var_449_5 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_5
					end
				end

				arg_446_1.text_.text = var_449_8
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425111", "425111060", "story_v_out_425111.awb") ~= 0 then
					local var_449_11 = manager.audio:GetVoiceLength("story_v_out_425111", "425111060", "story_v_out_425111.awb") / 1000

					if var_449_11 + var_449_5 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_11 + var_449_5
					end

					if var_449_7.prefab_name ~= "" and arg_446_1.actors_[var_449_7.prefab_name] ~= nil then
						local var_449_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_7.prefab_name].transform, "story_v_out_425111", "425111060", "story_v_out_425111.awb")

						arg_446_1:RecordAudio("425111060", var_449_12)
						arg_446_1:RecordAudio("425111060", var_449_12)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_425111", "425111060", "story_v_out_425111.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_425111", "425111060", "story_v_out_425111.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_13 = math.max(var_449_6, arg_446_1.talkMaxDuration)

			if var_449_5 <= arg_446_1.time_ and arg_446_1.time_ < var_449_5 + var_449_13 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_5) / var_449_13

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_5 + var_449_13 and arg_446_1.time_ < var_449_5 + var_449_13 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10159",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS2501",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2106",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/Q02f"
	},
	voices = {
		"story_v_out_425111.awb"
	}
}
